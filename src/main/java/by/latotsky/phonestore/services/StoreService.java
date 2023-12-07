package by.latotsky.phonestore.services;

import by.latotsky.phonestore.models.Store;
import by.latotsky.phonestore.repositories.StoreRepository; // Changed from DeliveryPointRepository
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class StoreService {

    private final StoreRepository storeRepository; // Changed from DeliveryPointRepository

    public List<Store> listAllStores(){
        return storeRepository.findAll();
    }

    public List<Store> getActiveStores() { // Changed from getActiveDeliveryPoints
        return storeRepository.findAllByActive(true);
    }

    public Store getById(Long storeId){ // Changed parameter name
        return storeRepository.findById(storeId).orElseThrow(() -> new EntityNotFoundException("Store Not Found")); // Changed the exception message
    }

    public void createStore(Store store){ // Changed from createDeliveryPoint
        store.setActive(true);
        storeRepository.save(store);
    }

    @Transactional
    public boolean removeStore(Long storeId) { // Changed method name and parameter
        storeRepository.deleteById(storeId);
        return true;
    }

    @Transactional
    public boolean edit(Store store, Long storeId) { // Changed parameters

        Store exStore = storeRepository.findById(storeId).orElseThrow(() -> new EntityNotFoundException("Store not Found")); // Changed the exception message

        if(!store.getName().isEmpty()){
            exStore.setName(store.getName());
        }

        if(!store.getAddress().isEmpty()){
            exStore.setAddress(store.getAddress());
        }

        storeRepository.save(exStore);
        return true;
    }

    @Transactional
    public boolean activate(Long storeId) { // Changed parameter
        Store exStore = storeRepository.findById(storeId).orElseThrow(() -> new EntityNotFoundException("Store not Found")); // Changed the exception message
        exStore.setActive(true);
        storeRepository.save(exStore);
        return true;
    }

    @Transactional
    public boolean deactivate(Long storeId) { // Changed parameter
        Store exStore = storeRepository.findById(storeId).orElseThrow(() -> new EntityNotFoundException("Store not Found")); // Changed the exception message
        exStore.setActive(false);
        storeRepository.save(exStore);
        return true;
    }

}
