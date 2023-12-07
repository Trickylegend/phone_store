package by.latotsky.phonestore.services;

import by.latotsky.phonestore.models.*;
import by.latotsky.phonestore.repositories.CartRepository;
import by.latotsky.phonestore.repositories.OrderRepository;
import by.latotsky.phonestore.repositories.PhoneRepository;
import by.latotsky.phonestore.repositories.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


@Service
@Slf4j
@RequiredArgsConstructor
public class OrderService {

    private final CartRepository cartRepository;
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final PhoneRepository phoneRepository;
    private final StoreService storeService;

    @Transactional
    public Order createOrderFromCart(Long userId, Long storeId) {

        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Cart cart = cartRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found"));

        Order order = new Order();
        order.setUser(user);
        order.setStore(storeService.getById(storeId));
        order.setOrderTime(LocalDateTime.now());
        order.setTotalPrice(BigDecimal.ZERO);
        order.setConfirmed(false);

        List<CartItem> itemsToRemove = new ArrayList<>();
        BigDecimal totalPrice = BigDecimal.ZERO;


        for (CartItem cartItem : cart.getCartItems()) {
            if (cartItem.getSelected()){
                Phone phone = cartItem.getPhone();
                int quantity = cartItem.getQuantity();

                if (!phone.getInventoryItem().isAvailable(quantity)) {
                    throw new RuntimeException("Not enough stock for phone: " + phone.getBrand() + phone.getModel());
                }

                BigDecimal price = phone.getPrice().multiply(BigDecimal.valueOf(quantity));
                totalPrice = totalPrice.add(price);

                OrderItem orderItem = new OrderItem();
                orderItem.setOrder(order);
                orderItem.setPhone(phone);
                orderItem.setQuantity(quantity);
                orderItem.setPrice(price);

                order.getOrderItems().add(orderItem);

                phone.getInventoryItem().decrementQuantity(quantity);
                phoneRepository.save(phone);
                itemsToRemove.add(cartItem);

            }
        }


        order.setTotalPrice(totalPrice);
        order.setConfirmed(true);
        orderRepository.save(order);

        cart.getCartItems().removeAll(itemsToRemove);
        cartRepository.save(cart);
        return order;
    }

    public List<Order> getActiveOrders(User user) {
        return orderRepository.getOrdersByUserIdAndConfirmed(user.getId(), false);
    }

    public List<Order> getOldOrders(User user) {
        return orderRepository.getOrdersByUserIdAndConfirmed(user.getId(), true);
    }

    public List<Phone> getPurchasedPhones(Long userId) {
        List<Order> userOrders = orderRepository.findByUserId(userId);

        return userOrders.stream()
                .flatMap(order -> order.getOrderItems().stream())
                .map(OrderItem::getPhone)
                .distinct()
                .collect(Collectors.toList());
    }

}