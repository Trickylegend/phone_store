package by.latotsky.phonestore.services;

import by.latotsky.phonestore.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;


    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        System.err.println("email - " + email);
        UserDetails user = userRepository.findUserByEmail(email);
        if (user == null) {
            System.err.println("user == null - UserDetailsService");
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
        return user;
    }

}
