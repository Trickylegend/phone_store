package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Arrays;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> getOrdersByUserIdAndConfirmed(Long userId, boolean isConfirmed);

    List<Order> findByUserId(Long userId);

    List<Order> findAllByUserIdAndConfirmed(Long id, boolean b);

    Arrays findAllByUserId(Long userId);
}