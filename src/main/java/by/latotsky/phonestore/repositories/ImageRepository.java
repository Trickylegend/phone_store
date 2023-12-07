package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
