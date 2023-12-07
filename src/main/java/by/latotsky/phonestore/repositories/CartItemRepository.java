package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    Optional<CartItem> findByPhoneId(Long phoneId);

    @Modifying
    @Query("DELETE FROM CartItem c WHERE c.phone.id = :phoneId AND c.cart.id =:cartId")
    void deleteByPhoneIdAndCartId(Long phoneId, Long cartId);

    Optional<CartItem> findByPhoneIdAndCartId(Long phoneId, Long id);
}
