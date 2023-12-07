package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.Store; // Изменено с DeliveryPoint на Store
import by.latotsky.phonestore.services.StoreService; // Изменено с DeliveryPointService на StoreService
import by.latotsky.phonestore.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class StoreController {

    private final StoreService storeService;
    private final UserService userService;

    @GetMapping("/create/store")
    public String getCreateStore(Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "manager/store/create";
    }

    @PostMapping("/create/store")
    public String createStore(@ModelAttribute Store store, RedirectAttributes redirectAttributes) {
        storeService.createStore(store);
        redirectAttributes.addFlashAttribute("successMessage", "Новый магазин успешно добавлен");
        return "redirect:/";
    }

    @PostMapping("/delete/store/{storeId}")
    public String deleteStore(@PathVariable Long storeId, RedirectAttributes redirectAttributes) {
        if (storeService.removeStore(storeId)) {
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно удалили магазин");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при удалении");
        }
        return "redirect:/";
    }

    @GetMapping("/edit/store/{storeId}")
    public String getEditStore(Model model, Principal principal, @PathVariable Long storeId) {
        model.addAttribute("store", storeService.getById(storeId));
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "manager/store/edit";
    }

    @PostMapping("/edit/store/{storeId}")
    public String editStore(@ModelAttribute Store store, @PathVariable Long storeId, RedirectAttributes redirectAttributes) {
        if (storeService.edit(store, storeId)) {
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно отредактировали магазин");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при редактировании");
        }
        return "redirect:/";
    }

    @PostMapping("/activate/store/{storeId}")
    public String activateStore(@PathVariable Long storeId, RedirectAttributes redirectAttributes){
        if(storeService.activate(storeId)){
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно активировали магазин");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при активации");
        }
        return "redirect:/";
    }

    @PostMapping("/deactivate/store/{storeId}")
    public String deactivateStore(@PathVariable Long storeId, RedirectAttributes redirectAttributes){
        if(storeService.deactivate(storeId)){
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно деактивировали магазин");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при деактивации");
        }
        return "redirect:/";
    }
}
