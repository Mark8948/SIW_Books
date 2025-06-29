package siw.books.authentication;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class AuthConfiguration {

    @Autowired
    private DataSource dataSource;

    //@Autowired
    //private CredentialsService credentialsService;

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication()
            .dataSource(dataSource)
            .usersByUsernameQuery(
                "SELECT username, password, TRUE as enabled FROM credentials WHERE username = ?"
            )
            .authoritiesByUsernameQuery(
                "SELECT username, role FROM credentials WHERE username = ?"
            );
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                // pagine pubbliche
                .requestMatchers("/", "/index", "/libri/**", "/autori/**",
                                 "/login", "/register",
                                 "/css/**", "/js/**", "/images/**", "/webjars/**", "/favicon.ico",
                                 "/error").permitAll()
                .requestMatchers("/register", "/login").permitAll()
                // ruoli
                .requestMatchers("/amministratori/**")
                    .hasAuthority("ADMIN")
                .requestMatchers("/utenti/**")
                    .hasAuthority("DEFAULT")
                // tutte le altre richiedono login
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("username")
                .passwordParameter("pwd")
                .defaultSuccessUrl("/", true)   
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
        ;
        return http.build();
    }
}
