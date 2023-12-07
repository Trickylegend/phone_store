package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    void deleteByUserIdAndPhoneId(Long phoneId, Long userId);

    Optional<Favorite> findByPhoneIdAndUserId(Long phoneId, Long userId);

}
