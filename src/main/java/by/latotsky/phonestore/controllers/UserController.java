package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.Person;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.repositories.UserRepository;
import by.latotsky.phonestore.services.OrderService;
import by.latotsky.phonestore.services.PhoneService;
import by.latotsky.phonestore.services.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class UserController {
    private final UserRepository userRepository;


    private final UserService userService;
    private final PhoneService phoneService;

    private final OrderService orderService;

    @GetMapping("/login")
    public String login(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("page", "login");
        return "user/login";
    }

    @GetMapping("/registration")
    public String registration(Principal principal, Model model) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("page", "registration");
        return "user/registration";
    }

    @PostMapping("/registration")
    public String registration(@ModelAttribute("user") @Valid User user,
                               @ModelAttribute("person") @Valid Person person,
                               RedirectAttributes redirectAttributes) {

        if (!userService.isEmailFree(user.getEmail())) {
            redirectAttributes.addFlashAttribute("errorMessage", user.getEmail() + " уже занят");
            return "redirect:/registration";
        } else {
            userService.registration(user, person);
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно зарегистрировались, на вашу почту было отправлено сообщение о подтверждении регистрации");
            return "redirect:/login";
        }
    }

    @GetMapping("/user/orders")
    public String getOrders(Principal principal, Model model){
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("oldOrders", orderService.getOldOrders(user));
        return "user/orders";
    }


    @GetMapping("/user/edit")
    public String getEditUser(Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("page", "edit-user");
        return "user/edit";
    }

    @PostMapping("/user/edit")
    public String editUser(@ModelAttribute("user") @Valid User user,
                           @ModelAttribute("person") @Valid Person person,
                           Principal principal,
                           RedirectAttributes redirectAttributes) throws IOException {

        userService.updateUser(user, person, userService.getUserByPrincipal(principal));
        redirectAttributes.addFlashAttribute("successMessage", "Изменения успешно сохранены");
        return "redirect:/main";
    }


    @GetMapping("/confirm-registration")
    public String confirmRegistration(@RequestParam("token") String token, RedirectAttributes redirectAttributes) {
        User user = userService.getUserByRegistrationToken(token);
        if (user != null) {
            log.info("User - " + user.getEmail() + " successfully confirm account ");
            user.setActive(true);
            user.setRegistrationToken(null);
            userRepository.save(user);
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно активировали свой аккаунт");
            return "redirect:/login";
        }
        else{
            return "redirect:/error";
        }
    }


    @GetMapping("/user/purchases")
    public String getUserPurchases(Model model, Principal principal){

        User user = userService.getUserByPrincipal(principal);

        List<Phone> purchasedPhones = orderService.getPurchasedPhones(user.getId());

        List<Boolean> isFavoriteList = new ArrayList<>();
        if (principal != null) {
            for (Phone phone : purchasedPhones) {
                boolean isFavorite = phoneService.isPhoneInFavorites(phone.getId(), user.getId());
                isFavoriteList.add(isFavorite);
            }
        }

        model.addAttribute("user", user);
        model.addAttribute("phones", purchasedPhones);
        model.addAttribute("isFavoriteList", isFavoriteList);

        return "user/phones";
    }

}
