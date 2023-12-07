package by.latotsky.phonestore.repositories;


import by.latotsky.phonestore.models.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StoreRepository extends JpaRepository<Store, Long> {


    List<Store> findAllByActive(boolean b);
}
