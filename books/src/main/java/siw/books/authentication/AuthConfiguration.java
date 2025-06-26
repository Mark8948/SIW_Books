package siw.books.authentication;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import siw.books.model.Credentials;
import siw.books.services.CredentialsService;

@Configuration
@EnableWebSecurity
public class AuthConfiguration {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private CredentialsService credentialsService;

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
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            // disable CSRF/CORS if not needed (e.g., API-only)
            .csrf().disable()
            .cors().disable()

            .authorizeHttpRequests()
                // endpoints open to all
                .requestMatchers(HttpMethod.GET,
                        "/", "/index", "/libri", "/libri/**",
                        "/autori", "/autori/**",
                        "/login", "/register",
                        "/css/**", "/js/**", "/images/**", "/webjars/**", "/favicon.ico",
                        "/error"
                ).permitAll()
                .requestMatchers(HttpMethod.POST, "/register", "/login").permitAll()

                // ADMIN only
                .requestMatchers("/amministratori/**").hasAuthority(Credentials.ADMIN_ROLE)
                // DEFAULT only
                .requestMatchers("/utenti/**").hasAuthority(Credentials.DEFAULT_ROLE)

                // all other requests require authentication
                .anyRequest().authenticated()
            .and()
                .formLogin()
                    .loginPage("/login")
                    .loginProcessingUrl("/login")
                    .usernameParameter("username")
                    .passwordParameter("pwd")
                    .successHandler((request, response, auth) -> {
                        var userDetails = (org.springframework.security.core.userdetails.User) auth.getPrincipal();
                        var creds = credentialsService.getCredentialsByUsername(userDetails.getUsername());
                        Long id = creds.getUtente().getId();
                        String redirectUrl = creds.getRole().equals(Credentials.ADMIN_ROLE)
                            ? "/amministratori/" + id
                            : "/utente/" + id;
                        response.sendRedirect(redirectUrl);
                    })
                    .failureUrl("/login?error=true")
                    .permitAll()
            .and()
                .logout()
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/")
                    .invalidateHttpSession(true)
                    .deleteCookies("JSESSIONID")
                    .permitAll();

        return http.build();
    }
}
