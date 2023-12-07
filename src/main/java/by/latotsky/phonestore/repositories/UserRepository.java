package by.latotsky.phonestore.repositories;


import by.latotsky.phonestore.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> getUserByEmail(String email);

    UserDetails findUserByEmail(String email);

    Optional<User> getUserById(Long id);

    User findByRegistrationToken(String token);
}
