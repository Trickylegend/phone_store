package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.models.enums.Role;
import by.latotsky.phonestore.services.PhoneService;
import by.latotsky.phonestore.services.ReviewService;
import by.latotsky.phonestore.services.StoreService;
import by.latotsky.phonestore.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.util.Map;


@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;

    private final PhoneService phoneService;

    private final ReviewService reviewService;

    private final StoreService storeService;



    @GetMapping("/reviews")
    public String reviews(Principal principal, Model model){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("reviews", reviewService.listReviews());
        return "admin/reviews";
    }

    @GetMapping("/users")
    public String users(Principal principal, Model model){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("users", userService.listUsers());
        return "admin/user/list";
    }
    @GetMapping("/edit/user/{userId}")
    public String editUser(@PathVariable Long userId, Model model, Principal principal) {
        User user = userService.getUserById(userId);
        User admin = userService.getUserByPrincipal(principal);
        model.addAttribute("user", admin);
        model.addAttribute("usr", user);
        model.addAttribute("roles", Role.values());
        return "admin/user/edit";
    }

    @PostMapping("/edit/user")
    public String editUser(@RequestParam("userId") User user, @RequestParam Map<String, String> form){
        userService.changeUserRoles(user, form);
        return "redirect:/admin/users";
    }

    @PostMapping("/user/ban/{userId}")
    public String banUser(@PathVariable Long userId, Principal principal, RedirectAttributes redirectAttributes) {
        User admin = userService.getUserByPrincipal(principal);
        if (admin.getId().equals(userId)){
           redirectAttributes.addFlashAttribute("errorMessage", "Вы не можете забанить себя!");
            return "redirect:/admin/users";
        } else {
            userService.banUser(userId);
            return "redirect:/admin/users";
        }
    }

    @PostMapping("/user/unban/{userId}")
    public String unBanUser(@PathVariable Long userId) {
        userService.unBanUser(userId);
        return "redirect:/admin/users";
    }



}
