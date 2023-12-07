package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.services.PhoneService; // Изменено с BookService на PhoneService
import by.latotsky.phonestore.services.ReviewService;
import by.latotsky.phonestore.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class PhoneController {

    private final PhoneService phoneService;
    private final UserService userService;

    private final ReviewService reviewService;

    @GetMapping("/phone/{phoneId}")
    public String getPhone(@PathVariable Long phoneId, Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("phone", phoneService.getPhoneById(phoneId));
        model.addAttribute("reviews", reviewService.listReviewsForPhone(phoneId));
        return "phone";
    }

    @GetMapping("/type")
    public String getType(@RequestParam String type, Principal principal, Model model) {
        System.err.println(type);
        List<Phone> phones = phoneService.getPhonesByType(type);

        User user = userService.getUserByPrincipal(principal);
        List<Boolean> isFavoriteList = new ArrayList<>();
        if (principal != null) {
            for (Phone phone : phones) {
                boolean isFavorite = phoneService.isPhoneInFavorites(phone.getId(), user.getId());
                System.err.println(isFavorite);
                isFavoriteList.add(isFavorite);
            }
        }

        model.addAttribute("phones", phones);
        model.addAttribute("user", user);
        model.addAttribute("isFavoriteList", isFavoriteList);

        return "main";
    }

    @GetMapping("/")
    public String mainPage(Model model, Principal principal, @RequestParam(required = false, defaultValue = "") String type) {
        List<Phone> phones;

        if (!type.isEmpty()){
            System.err.println(type);
            phones = phoneService.getPhonesByType(type);
        } else {
            phones = phoneService.listPhones();
        }

        User user = userService.getUserByPrincipal(principal);
        List<Boolean> isFavoriteList = new ArrayList<>();
        if (principal != null) {
            for (Phone phone : phones) {
                boolean isFavorite = phoneService.isPhoneInFavorites(phone.getId(), user.getId());
                System.err.println(isFavorite);
                isFavoriteList.add(isFavorite);
            }
        }

        model.addAttribute("phones", phones);
        model.addAttribute("user", user);
        model.addAttribute("isFavoriteList", isFavoriteList);
        return "main";
    }



}
