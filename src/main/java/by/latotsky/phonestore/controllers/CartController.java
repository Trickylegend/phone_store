package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.Cart;
import by.latotsky.phonestore.models.CartItem;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.services.CartService;
import by.latotsky.phonestore.services.StoreService;
import by.latotsky.phonestore.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    private final UserService userService;

    private final StoreService storeService;


    @GetMapping("/cart")
    public String getCart(Principal principal, Model model) {
        User user = userService.getUserByPrincipal(principal);
        Cart cart = cartService.getCartByUserId(userService.getUserByPrincipal(principal).getId());
        BigDecimal price = cart.getCartItems().stream()
                .filter(CartItem::getSelected) // Фильтрация только выбранных товаров
                .map(cartItem -> cartItem.getPhone().getPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add); // Суммирование цен

        model.addAttribute("cart", cart);
        model.addAttribute("stores", storeService.getActiveStores());
        model.addAttribute("user", user);
        model.addAttribute("totalPrice", price);
        return "user/cart";
    }

    @PostMapping("/cart/add/{phoneId}")
    public String addPhoneToCart(Principal principal, @PathVariable Long phoneId, RedirectAttributes redirectAttributes) {
        cartService.addToCart(principal, phoneId, 1);
        redirectAttributes.addFlashAttribute("successMessage", "Телефон успешно добавлен в корзину");
        return "redirect:/cart";
    }

    @PostMapping("/cart/delete/{phoneId}")
    public String deletePhoneFromCart(Principal principal, @PathVariable Long phoneId, RedirectAttributes redirectAttributes) {
        cartService.removeFromCart(principal, phoneId);
        return "redirect:/cart";
    }

    @PostMapping("/cart/select/{itemId}")
    public String selectCartItem(Principal principal, @PathVariable Long itemId, RedirectAttributes redirectAttributes) {
        cartService.selectCartItem(principal, itemId);
        return "redirect:/cart";
    }

    @PostMapping("/cart/deselect/{itemId}")
    public String deselectCartItem(Principal principal, @PathVariable Long itemId, RedirectAttributes redirectAttributes) {
        cartService.deselectCartItem(principal, itemId);
        return "redirect:/cart";
    }


    // Пересмотреть передачу amount
    @PostMapping("/cart/update/{phoneId}/{amount}")
    public String updateAmountOfBookInCart(Principal principal,
                                           @PathVariable Long phoneId,
                                           @PathVariable int amount,
                                           RedirectAttributes redirectAttributes) {

        cartService.updateCartItemQuantity(principal, phoneId, amount);
        return "redirect:/cart";
    }

    @PostMapping("/cart/update-selection/{itemId}/{selected}")
    @ResponseBody
    public Map<String, String> updateCartItemSelection(Principal principal,
                                                       @PathVariable Long itemId,
                                                       @PathVariable Boolean selected) {
        cartService.updateItemSelection(principal, itemId, selected);
        BigDecimal newTotalPrice = cartService.calculateTotalPrice(userService.getUserByPrincipal(principal).getId());
        Map<String, String> response = new HashMap<>();
        response.put("totalPrice", newTotalPrice.toString());
        return response;
    }

}
