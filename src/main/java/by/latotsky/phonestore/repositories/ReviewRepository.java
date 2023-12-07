package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByPhoneId(Long bookId);

    Optional<Review> getReviewById(Long reviewId);
}
