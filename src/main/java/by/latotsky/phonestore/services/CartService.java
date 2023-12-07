package by.latotsky.phonestore.services;

import by.latotsky.phonestore.models.Cart;
import by.latotsky.phonestore.models.CartItem;
import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.repositories.CartItemRepository;
import by.latotsky.phonestore.repositories.CartRepository;
import by.latotsky.phonestore.repositories.PhoneRepository;
import by.latotsky.phonestore.repositories.UserRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.Optional;


@Service
@Slf4j
@RequiredArgsConstructor
public class CartService {

    private final UserRepository userRepository;

    private final CartItemRepository cartItemRepository;

    private final PhoneRepository phoneRepository;

    private final CartRepository cartRepository;
    private final UserService userService;

    @PersistenceContext
    private EntityManager entityManager;


    //СДЕЛАТЬ КРАСИВО
    @Transactional
    public boolean addToCart(Principal principal, Long phoneId, int quantity) {
        User user = userService.getUserByPrincipal(principal);
        Phone phone = phoneRepository.findById(phoneId)
                .orElseThrow(() -> new RuntimeException("Phone not found"));

        Cart cart = user.getCart();
        if (cart != null) {
            Optional<CartItem> existingCartItem = cart.getCartItems().stream()
                    .filter(cartItem -> cartItem.getPhone().getId().equals(phoneId))
                    .findFirst();

            if (existingCartItem.isPresent()) {
                // Обновление количества, если товар уже в корзине
                CartItem cartItem = existingCartItem.get();
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                cartItemRepository.save(cartItem);
            } else {
                // Добавление нового товара в корзину
                CartItem cartItem = new CartItem();
                cartItem.setPhone(phone);
                cartItem.setQuantity(quantity);
                cartItem.setCart(cart);
                cartItemRepository.save(cartItem);
            }
        } else {
            // Создание новой корзины, если у пользователя её нет
            cart = new Cart();
            cart.setUser(user);
            user.setCart(cart);
            cartRepository.save(cart);

            CartItem cartItem = new CartItem();
            cartItem.setPhone(phone);
            cartItem.setQuantity(quantity);
            cartItem.setCart(cart);
            cartItemRepository.save(cartItem);
        }
        return true;
    }

    @Transactional
    public void removeFromCart(Principal principal, Long phoneId) {

        User user = userService.getUserByPrincipal(principal);
        if (user.getCart() == null) {
            log.error("No cart found for user");
        } else {
            CartItem item = cartItemRepository.findByPhoneId(phoneId).orElseThrow(() -> new RuntimeException("CartItem not Found"));
            user.getCart().delete(item);
            userRepository.save(user);
        }
    }

    @Transactional
    public void selectCartItem(Principal principal, Long itemId) {
        CartItem item = cartItemRepository.findById(itemId).orElseThrow(() -> new RuntimeException("Item not found"));
        item.setSelected(true);
        cartItemRepository.save(item);
    }

    @Transactional
    public void deselectCartItem(Principal principal, Long itemId) {
        CartItem item = cartItemRepository.findById(itemId).orElseThrow(() -> new RuntimeException("Item not found"));
        item.setSelected(false);
        cartItemRepository.save(item);
    }


    @Transactional
    public void updateCartItemQuantity(Principal principal, Long phoneId, int quantity) {
        User user = userService.getUserByPrincipal(principal);
        if (quantity <= 0) {
            removeFromCart(principal, phoneId);
            log.error("quantity = 0");
            return;
        }

        if (user.getCart() == null) {
            log.error("No cart found for user");
            return;
        }

        Optional<CartItem> existingCartItem = user.getCart().getCartItems().stream()
                .filter(cartItem -> cartItem.getPhone().getId().equals(phoneId))
                .findFirst();

        if (existingCartItem.isPresent()) {
            CartItem cartItem = existingCartItem.get();
            cartItem.setQuantity(quantity);
            user.getCart().add(cartItem);
            userRepository.save(user);
        } else {
            log.error("Phone not found in cart");
        }
    }


    @Transactional
    public Cart getCartByUserId(Long userId) {
        return cartRepository.findCartWithCartItemsAndPhonesByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found for user with id: " + userId));
    }

    @Transactional
    public void updateItemSelection(Principal principal, Long itemId, boolean selected) {
        CartItem item = cartItemRepository.findById(itemId)
                .orElseThrow(() -> new RuntimeException("Item not found"));
        item.setSelected(selected);
        cartItemRepository.save(item);
    }

    public BigDecimal calculateTotalPrice(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        return user.getCart().getCartItems().stream()
                .filter(CartItem::getSelected)
                .map(cartItem -> {
                    BigDecimal itemPrice = cartItem.getPhone().getPrice();
                    return itemPrice.multiply(BigDecimal.valueOf(cartItem.getQuantity()));
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }


}
