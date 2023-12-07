package by.latotsky.phonestore.config;

import by.latotsky.phonestore.services.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;



@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SpringSecurityConfig {

    private final CustomUserDetailsService userDetailsService;

    @Bean
    public static PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }



    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .authorizeHttpRequests(request -> request
                        .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
                        .requestMatchers("/editor/**").hasAuthority("ROLE_EDITOR")
                        .requestMatchers("/manager/**").hasAuthority("ROLE_MANAGER")
                        .requestMatchers("/", "/type" ,"/phone/**","/images/**", "/registration", "/static/**", "/confirm-registration", "/feedback", "/articles").permitAll()
                        .anyRequest().authenticated())
                .formLogin(formLogin -> formLogin
                        .loginPage("/login")            // Указываем путь к своей странице входа
                        .failureUrl("/login?error")    // Указываем путь для перенаправления при ошибке входа
                        .defaultSuccessUrl("/")        // Указываем путь для перенаправления после успешного входа
                        .usernameParameter("email")    // Указываем имя параметра для имени пользователя
                        .permitAll()                   // Разрешаем доступ к странице входа всем пользователям
                );

        return http.build();
    }




    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }


}