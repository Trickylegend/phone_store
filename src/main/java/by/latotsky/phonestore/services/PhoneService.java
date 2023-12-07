package by.latotsky.phonestore.services;


import by.latotsky.phonestore.models.*;
import by.latotsky.phonestore.repositories.PhoneRepository;
import by.latotsky.phonestore.repositories.FavoriteRepository;
import by.latotsky.phonestore.repositories.ReviewRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Pageable;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class PhoneService {
    private final ReviewRepository reviewRepository;


    private final FavoriteRepository favoriteRepository;
    private final PhoneRepository phoneRepository;
    private final ImageService imageService;
    private final UserService userService;


    public List<Phone> listPhones(){
        return phoneRepository.findAll();
    }
    public Phone getPhoneById(Long phoneId) {
        return phoneRepository.findById(phoneId).orElseThrow(() -> new RuntimeException("Phone not found"));
    }


    public void createPhone(Phone phone, MultipartFile image, int amount) throws IOException {
        phone.setImage(imageService.toImageEntity(image));
        InventoryItem inventoryItem = new InventoryItem();
        inventoryItem.setQuantity(amount);
        phone.setInventoryItem(inventoryItem);
        phoneRepository.save(phone);
        log.info("Saving new phone - " + phone.getBrand() + " " + phone.getModel());
    }


    public void deletePhone(Long phoneId) {
        phoneRepository.findById(phoneId).ifPresent(phoneRepository::delete);
    }

    public void updatePhone(Phone newPhone, Long phoneId, int amount, MultipartFile image) throws IOException {
        Phone existingPhone = phoneRepository.findById(phoneId).orElseThrow(() -> new RuntimeException("Phone not found"));

        if (!image.isEmpty()) {
            existingPhone.setImage(imageService.toImageEntity(image));
        }

        if(!newPhone.getBrand().isEmpty()){
            existingPhone.setBrand(newPhone.getBrand());
        }

        if(!newPhone.getModel().isEmpty()){
            existingPhone.setModel(newPhone.getModel());
        }

        if(!newPhone.getDescription().isEmpty()){
            existingPhone.setDescription(newPhone.getDescription());
        }

        if(newPhone.getRam() != 0){
            existingPhone.setRam(newPhone.getRam());
        }

        if(!newPhone.getType().isEmpty()){
            existingPhone.setType(newPhone.getType());
        }

        if(newPhone.getPrice() != null){
            existingPhone.setPrice(newPhone.getPrice());
        }

        if(amount != 0){
            existingPhone.getInventoryItem().setQuantity(amount);
        }

        phoneRepository.save(existingPhone);
    }


    public List<Phone> getPhonesByType(String type) {
        return phoneRepository.getPhoneByType(type);
    }


    public boolean isPhoneInFavorites(Long phoneId, Long userId) {
        Optional<Favorite> favorite = favoriteRepository.findByPhoneIdAndUserId(phoneId, userId);
        return favorite.isPresent();
    }


    public void updateAverageRating(Phone phone) {
        List<Review> reviews = reviewRepository.findByPhoneId(phone.getId());
        double average = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);

        phone.setAverageRating(average);
        phoneRepository.save(phone);
    }


    public void updateAverageRatingByReviewId(Long reviewId) {
        Review review = reviewRepository.getReviewById(reviewId).orElseThrow(() -> new RuntimeException("Review not found"));
        updateAverageRating(review.getPhone());
    }

    public void updateBestsellerStatus() {
        List<Phone> bestsellers = getTopSellingPhones(5);


        phoneRepository.findAll().forEach(phone -> {
            phone.setBestseller(false);
            phoneRepository.save(phone);
        });


        bestsellers.forEach(phone -> {
            phone.setBestseller(true);
            phoneRepository.save(phone);
        });
    }


    public List<Phone> getTopSellingPhones(int limit) {
        Pageable topPhones = PageRequest.of(0, limit);

        List<PhoneSalesDTO> topSellingPhonesDTOs = phoneRepository.findTopSellingPhones(topPhones);

        return topSellingPhonesDTOs.stream()
                .map(dto -> phoneRepository.findById(dto.getPhoneId()).orElse(null))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }


//    second, minute, hour, day of month, month, day(s) of week

//    @Scheduled(cron = "0 19 17 * * *")
//    public void scheduleBestsellerUpdate() {
//        log.info("Updating bestseller status...");
//        updateBestsellerStatus();
//        log.info("Bestseller status update completed.");
//    }



}
