package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {


    @Query("SELECT c FROM Cart c " +
            "LEFT JOIN FETCH c.cartItems ci " +
            "LEFT JOIN FETCH ci.phone p " +
            "WHERE c.user.id = :userId")
    Optional<Cart> findCartWithCartItemsAndPhonesByUserId(@Param("userId") Long userId);

    Optional<Cart> findByUserId(Long userId);
}
