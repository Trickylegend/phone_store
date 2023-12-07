package by.latotsky.phonestore.services;

import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.Review;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.repositories.ReviewRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewService {

    private final UserService userService;

    private final PhoneService phoneService;

    private final ReviewRepository reviewRepository;

    public void createReview(Principal principal, Long phoneId, String message, int rating){
        User user = userService.getUserByPrincipal(principal);
        Phone phone = phoneService.getPhoneById(phoneId);

        Review review = new Review();
        review.setMessage(message);
        review.setRating(rating);
        review.setPhone(phone);
        review.setUser(user);
        review.setValid(true);
        review.setDateOfCreated(LocalDateTime.now());
        reviewRepository.save(review);
        phoneService.updateAverageRating(phone);

    }

    public void deleteReview(Long reviewId, Long phoneId) {
        Phone phone = phoneService.getPhoneById(phoneId);
        reviewRepository.deleteById(reviewId);
        phoneService.updateAverageRating(phone);
    }


    public List<Review> listReviewsForPhone(Long phoneId){
        return reviewRepository.findByPhoneId(phoneId);
    }

    public List<Review> listReviews() {
        return reviewRepository.findAll();
    }

    public Review getReviewById(Long reviewId){
        return reviewRepository.getReviewById(reviewId).orElseThrow(() -> new RuntimeException("Review not found"));
    }
}
