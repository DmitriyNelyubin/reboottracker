package ru.sber.reboottracker.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.StringUtils;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.Role;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender mailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);

        if (user == null){
            throw  new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public boolean addUser(User user){
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if (userFromDb != null){
            return false;
        }

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userRepo.save(user);

        sendActivationCode(user);

        return true;
    }

    private void sendActivationCode(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Hello, %s \n" +
                            "You input this Email in RebootTracker.\n" +
                            "To confirm it go to next link: http://localhost:8080/activate/%s\n" +
                            "If you need special role create issue in \"Сбердруг\".",
                    user.getUsername(),
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(),"Confirm email in RebootTracker", message);
        }
    }

    public boolean activateCode(String code) {
        User user = userRepo.findByActivationCode(code);

        if (user == null) {
            return false;
        }
        user.setActivationCode(null);

        userRepo.save(user);

        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public List<User> findManagers(){
        return userRepo.findByRoles(Role.MANAGER);
    }

    public List<User> findAdmins(){
        return userRepo.findByRoles(Role.ADMIN);
    }

    public List<User> findDevelopers(){
        List<User> developers = userRepo.findAll();
        userRepo.findAll().removeIf(user -> user.getRoles().contains(Role.ADMIN) || user.getRoles().contains(Role.MANAGER));
        return developers;
    }

    public List<User> findByFindByRoles(Role role){
        return userRepo.findByRoles(role);
    }

    public void saveUser(User user, String username, Map<String, String> form) {
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();
        for (String key : form.keySet()){
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(userEmail) ||
                (userEmail != null && !userEmail.equals(email)));

        if (isEmailChanged){
            user.setEmail(email);

            if(!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        userRepo.save(user);

        if(isEmailChanged){
            sendActivationCode(user);
        }

    }
}
