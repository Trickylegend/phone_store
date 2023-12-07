package by.latotsky.phonestore;



import by.latotsky.phonestore.models.Cart;
import by.latotsky.phonestore.models.CartItem;
import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.repositories.CartItemRepository;
import by.latotsky.phonestore.repositories.CartRepository;
import by.latotsky.phonestore.repositories.PhoneRepository;
import by.latotsky.phonestore.repositories.UserRepository;
import by.latotsky.phonestore.services.CartService;
import by.latotsky.phonestore.services.UserService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.core.parameters.P;

import java.security.Principal;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class CartServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private CartItemRepository cartItemRepository;

    @Mock
    private PhoneRepository phoneRepository;

    @Mock
    private CartRepository cartRepository;

    @Mock
    private UserService userService;

    @InjectMocks
    private CartService cartService;

    @Test
    void addToCartTest() {
        Principal principal = mock(Principal.class);
        Long phoneId = 1L;
        int quantity = 1;
        User user = new User();
        Cart cart = new Cart();
        user.setCart(cart);
        Phone phone = new Phone();
        phone.setId(phoneId);

        when(principal.getName()).thenReturn("username");
        when(userService.getUserByPrincipal(principal)).thenReturn(user);
        when(phoneRepository.findById(phoneId)).thenReturn(Optional.of(phone));

        boolean result = cartService.addToCart(principal, phoneId, quantity);
        assertTrue(result);

        verify(cartItemRepository, times(1)).save(any(CartItem.class));
    }

    // ... другие тесты ...

    @Test
    void removeFromCartTest() {
        Principal principal = mock(Principal.class);
        Long bookId = 1L;
        User user = new User();
        Cart cart = new Cart();
        CartItem cartItem = new CartItem();
        user.setCart(cart);
        cart.getCartItems().add(cartItem);

        when(principal.getName()).thenReturn("username");
        when(userService.getUserByPrincipal(principal)).thenReturn(user);
        when(cartItemRepository.findByPhoneId(bookId)).thenReturn(Optional.of(cartItem));

        cartService.removeFromCart(principal, bookId);
        assertTrue(user.getCart().getCartItems().isEmpty());

        verify(userRepository, times(1)).save(user);
    }


    @Test
    void updateCartItemQuantityTest() {
        Principal principal = mock(Principal.class);
        Long phoneId = 1L;
        int quantity = 2;
        User user = new User();
        Cart cart = new Cart();
        CartItem cartItem = new CartItem();
        cartItem.setPhone(new Phone());
        cartItem.getPhone().setId(phoneId);
        cart.getCartItems().add(cartItem);
        user.setCart(cart);

        when(principal.getName()).thenReturn("username");
        when(userService.getUserByPrincipal(principal)).thenReturn(user);

        cartService.updateCartItemQuantity(principal, phoneId, quantity);
        assertEquals(quantity, cartItem.getQuantity());

        verify(userRepository, times(1)).save(user);
    }


    @Test
    void getCartByUserIdTest() {
        Long userId = 1L;
        Cart cart = new Cart();
        when(cartRepository.findCartWithCartItemsAndPhonesByUserId(userId)).thenReturn(Optional.of(cart));

        Cart foundCart = cartService.getCartByUserId(userId);
        assertNotNull(foundCart);
        assertEquals(cart, foundCart);
    }




}

