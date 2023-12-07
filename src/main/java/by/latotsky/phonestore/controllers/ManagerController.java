package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.Store;
import by.latotsky.phonestore.services.PhoneService;
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

@Controller
@RequiredArgsConstructor
@RequestMapping("/manager")
public class ManagerController {

    private final UserService userService;

    private final PhoneService phoneService;

    private final StoreService storeService;


    @GetMapping("/create/phone")
    public String getCreatePhone(Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "manager/phone/create";
    }

    @PostMapping("/create/phone")
    public String createPhone(@ModelAttribute Phone phone, @RequestParam int amount, @RequestParam MultipartFile file, RedirectAttributes redirectAttributes) throws IOException {
        phoneService.createPhone(phone, file, amount);
        redirectAttributes.addFlashAttribute("successMessage", "Телефон был успешно добавлен");
        return "redirect:/manager/phones";
    }

    @PostMapping("/delete/phone/{phoneId}")
    public String deletePhone(@PathVariable Long phoneId, RedirectAttributes redirectAttributes){
        phoneService.deletePhone(phoneId);
        redirectAttributes.addFlashAttribute("successMessage", "Телефон был успешно удален");
        return "redirect:/manager/phones";
    }

    @GetMapping("/edit/phone/{phoneId}")
    public String getEditPhone(@PathVariable Long phoneId, Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("phone", phoneService.getPhoneById(phoneId));
        model.addAttribute("amount", phoneService.getPhoneById(phoneId).getInventoryItem().getQuantity());
        return "manager/phone/edit";
    }

    @PostMapping("/edit/phone/{phoneId}")
    public String editPhone(@ModelAttribute Phone phone, @RequestParam(required = false) int amount, @PathVariable Long phoneId, @RequestParam(required = false) MultipartFile file, RedirectAttributes redirectAttributes) throws IOException {
        phoneService.updatePhone(phone, phoneId, amount, file);
        redirectAttributes.addFlashAttribute("successMessage", "Телефон был успешно отредактирован");
        return "redirect:/manager/phones";
    }


    @GetMapping("/phones")
    public String phones(Principal principal, Model model){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("phones", phoneService.listPhones());
        return "manager/phone/list";
    }

    @GetMapping("/stores")
    public String deliveryPoints(Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("stores", storeService.listAllStores());
        return "manager/store/list";
    }

    @GetMapping("/create/store")
    public String getCreateStore(Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "manager/store/create";
    }

    @PostMapping("/create/store")
    public String createStore(@ModelAttribute Store store){
        storeService.createStore(store);
        return "redirect:/manager/stores";
    }

    @GetMapping("/edit/store/{storeId}")
    public String getEditStore(Model model, Principal principal, @PathVariable Long storeId){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("store", storeService.getById(storeId));
        return "manager/store/edit";
    }

    @PostMapping("/edit/store/{storeId}")
    public String editStore(@ModelAttribute Store store, @PathVariable Long storeId){
        storeService.edit(store, storeId);
        return "redirect:/manager/stores";
    }

    @PostMapping("/delete/store/{storeId}")
    public String deleteStore(@PathVariable Long storeId){
        storeService.removeStore(storeId);
        return "redirect:/manager/stores";
    }

    @PostMapping("/calculate/bestseller")
    public String calculateBestSeller(){
        phoneService.updateBestsellerStatus();
        return "redirect:/";
    }


}
