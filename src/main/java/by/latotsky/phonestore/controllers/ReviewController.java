package by.latotsky.phonestore.controllers;

import by.latotsky.phonestore.services.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @PostMapping("/phone/{phoneId}/review/create")
    public String createDiscussion(@PathVariable Long phoneId, @RequestParam String message, @RequestParam int rating, Principal principal) {
        reviewService.createReview(principal, phoneId, message, rating);
        return "redirect:/phone/" + phoneId;
    }

    @PostMapping("/admin/delete/review/{phoneId}/{reviewId}")
    public String deleteDiscussion(@PathVariable Long phoneId, @PathVariable Long reviewId) {
        reviewService.deleteReview(reviewId,phoneId);
        return "redirect:/admin/reviews";
    }
}

