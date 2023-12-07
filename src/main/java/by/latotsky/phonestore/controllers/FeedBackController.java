package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.models.FeedBack;
import by.latotsky.phonestore.services.FeedBackService;
import by.latotsky.phonestore.services.UserService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class FeedBackController {

    private final FeedBackService feedBackService;
    private final UserService userService;

    @GetMapping("/feedback")
    public String feedback(Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "feedback";
    }

    @PostMapping("/feedback/create")
    public String createFeedBack(@ModelAttribute FeedBack feedBack){
        feedBackService.create(feedBack);
        return "redirect:/";
    }

    @PostMapping("/admin/feedback/delete/{feedbackId}")
    public String deleteFeedBack(@PathVariable Long feedbackId){
        feedBackService.delete(feedbackId);
        return "redirect:/";
    }

    @GetMapping("/admin/feedback")
    public String listFeedBack(Model model, Principal principal){
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        model.addAttribute("feedBacks", feedBackService.findAll());
        return "admin/feedback";
    }
}
