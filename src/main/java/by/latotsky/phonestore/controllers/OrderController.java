package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.services.OrderService;
import by.latotsky.phonestore.services.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@Slf4j
@RequiredArgsConstructor
public class OrderController {

    private final UserService userService;

    private final OrderService orderService;

    @PostMapping("/order/create")
    public String createOrder(Principal principal, @RequestParam Long storeId){
        orderService.createOrderFromCart(userService.getUserByPrincipal(principal).getId(), storeId);
        return "redirect:/cart";
    }
}
