package by.latotsky.phonestore.repositories;

import by.latotsky.phonestore.models.Phone;
import by.latotsky.phonestore.models.PhoneSalesDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

@Repository
public interface PhoneRepository extends JpaRepository<Phone, Long> {

    Optional<Phone> getPhoneById(Long phoneId);

    List<Phone> getPhoneByType(String type);

    @Query("SELECT new by.latotsky.phonestore.models.PhoneSalesDTO(oi.phone.id, SUM(oi.quantity)) " +
            "FROM OrderItem oi " +
            "GROUP BY oi.phone.id " +
            "ORDER BY SUM(oi.quantity) DESC")
    List<PhoneSalesDTO> findTopSellingPhones(Pageable pageable);

}
