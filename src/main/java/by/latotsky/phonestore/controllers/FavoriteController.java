package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.services.FavoriteService;
import by.latotsky.phonestore.services.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@Slf4j
@RequiredArgsConstructor
public class FavoriteController {

    private final UserService userService;

    private final FavoriteService favoriteService;


    @PostMapping("/favorites/add/{phoneId}")
    public String addToFavorites(@PathVariable Long phoneId, Principal principal) {
        favoriteService.addToFavorites(phoneId, userService.getUserByPrincipal(principal));
        return "redirect:/";
    }

    @PostMapping("/favorites/delete/{phoneId}")
    public String removeFromFavorites(@PathVariable Long phoneId, Principal principal) {
        favoriteService.removeFromFavorites(phoneId, principal);
        return "redirect:/";
    }


    @GetMapping("/favorites")
    public String viewFavorites(Model model, Principal principal) {

        User user = userService.getUserByPrincipal(principal);
        if (user != null) {

            model.addAttribute("user", user);
            model.addAttribute("favorites", user.getFavorites());
            model.addAttribute("page", "favorites");
            return "user/favorites";

        } else {
            log.error("Такой пользователь не найден - " + principal.getName());
            return "error";
        }
    }
}