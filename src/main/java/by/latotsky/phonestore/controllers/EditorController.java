package by.latotsky.phonestore.controllers;


import by.latotsky.phonestore.models.Article;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.services.ArticleService;
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
public class EditorController {

    private final ArticleService articleService;

    private final UserService userService;




    @GetMapping("/editor/create/article")
    public String getCreateArticle(Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "editor/create";
    }
    @PostMapping("/editor/create/article")
    public String createArticle(@ModelAttribute Article article, @RequestParam MultipartFile file, Principal principal, RedirectAttributes redirectAttributes){

        User user = userService.getUserByPrincipal(principal);
        if(articleService.create(article, file, user)){
            redirectAttributes.addFlashAttribute("successMessage", "Вы успешно добавили новость!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при создании поста!");
        }
        return "redirect:/";
    }
    @GetMapping("/editor/edit/article/{articleId}")
    public String getEditArticle(@PathVariable Long articleId,Model model, Principal principal){
        model.addAttribute("article", articleService.getById(articleId).orElseThrow(() -> new RuntimeException("Article not found")));
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "editor/edit";
    }


    @PostMapping("/editor/edit/article/{articleId}")
    public String editArticle(@PathVariable Long articleId, @ModelAttribute Article article, @RequestParam(required = false) MultipartFile file, RedirectAttributes redirectAttributes) throws IOException {
        if(articleService.update(articleId, article, file)) {
            redirectAttributes.addFlashAttribute("successMessage", "Успешно обновили новость");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при изменении новости");
        }
        return "redirect:/";
    }


    @PostMapping("/editor/delete/article/{articleId}")
    public String deleteArticle(@PathVariable Long articleId, RedirectAttributes redirectAttributes){
        if(articleService.delete(articleId)){
            redirectAttributes.addFlashAttribute("successMessage", "Пост успешно удален");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка при удалении поста!");
        }
        return "redirect:/";
    }

    @GetMapping("/editor/articles")
    public String getArticles(Principal principal, Model model){
        model.addAttribute("articles", articleService.findAll());
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "editor/list";
    }

    @GetMapping("/articles")
    public String articles(Principal principal, Model model){
        model.addAttribute("articles", articleService.findAll());
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "articles";
    }
}
