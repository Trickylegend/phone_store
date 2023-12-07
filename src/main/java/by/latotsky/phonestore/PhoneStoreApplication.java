package by.latotsky.phonestore;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class PhoneStoreApplication {

    public static void main(String[] args) {
        SpringApplication.run(PhoneStoreApplication.class, args);
    }

}
