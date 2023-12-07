package by.latotsky.phonestore.services;

import by.latotsky.phonestore.models.Person;
import by.latotsky.phonestore.models.User;
import by.latotsky.phonestore.models.enums.Role;
import by.latotsky.phonestore.repositories.UserRepository;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ImageService imageService;
    private final EmailService emailService;


    public User getUserById(Long userId){
        return userRepository.getUserById(userId).orElseThrow(() -> new RuntimeException("User not found"));
    }

    public List<User> listUsers(){
        return userRepository.findAll();
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.getUserByEmail(principal.getName()).orElseThrow(() -> new RuntimeException("User not Found"));
    }

    public boolean isEmailFree(String email){
        return userRepository.getUserByEmail(email).isEmpty();
    }
    public User getUserByRegistrationToken(String token){
        return userRepository.findByRegistrationToken(token);
    }


    public boolean registration(User newUser, Person person){

        User user = new User();

        user.setActive(false);
        user.getRoles().add(Role.ROLE_ADMIN);
        user.setEmail(newUser.getEmail());
        user.setPassword(passwordEncoder.encode(newUser.getPassword()));
        user.setPerson(person);


        String registrationToken = UUID.randomUUID().toString();
        System.err.println(registrationToken);
        user.setRegistrationToken(registrationToken);


        userRepository.save(user);

        String message = "<p>Здравствуйте!</p>" +
                "<p>Благодарим вас за регистрацию на нашем веб-сервисе. Чтобы завершить процесс регистрации и активировать ваш аккаунт, пожалуйста, перейдите по следующей ссылке:</p>" +
                "<p><a href=\"http://localhost:8080/confirm-registration?token=" + registrationToken + "\">Подтвердить регистрацию</a></p>" +
                "<p>Если вы не регистрировались на нашем сервисе, пожалуйста, проигнорируйте это сообщение.</p>" +
                "<p>С наилучшими пожеланиями,<br>" +
                "Команда Auto.by</p>";
        try {
            emailService.sendHtmlMessage(user.getEmail(), "Подтверждение регистрации", message);
        } catch (MessagingException e) {
            e.printStackTrace();
            log.error("Error mail send");
        }
        log.info("Saving new user with email: {}", user.getEmail());
        return true;
    }


    public void updateUser( User user, Person person, User existingUser) throws IOException {


        if(!user.getEmail().isEmpty()){
            existingUser.setEmail(user.getEmail());
        }

        if(!user.getPassword().isEmpty()){
            existingUser.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        if(!person.getName().isEmpty()){
            existingUser.getPerson().setName(person.getName());
        }

        if(!person.getSurname().isEmpty()){
            existingUser.getPerson().setSurname(person.getSurname());
        }

        if(!person.getPhoneNumber().isEmpty()){
            existingUser.getPerson().setPhoneNumber((person.getPhoneNumber()));
        }

        userRepository.save(existingUser);
    }

    public void banUser(Long userId) {
        User user = userRepository.getUserById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        System.err.println("Бан пользователя - email - {}" + user.getEmail());
        user.setActive(false);
        userRepository.save(user);
        log.info("Ban user with email = {}", user.getEmail());


    }

    public void unBanUser(Long userId) {
        User user = userRepository.getUserById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        log.info("Разбан пользователя - email - {}" + user.getEmail());
        user.setActive(true);
        userRepository.save(user);
        log.info("Ban user with email = {}", user.getEmail());

    }

    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key: form.keySet()){
            if(roles.contains(key)){
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }
}
