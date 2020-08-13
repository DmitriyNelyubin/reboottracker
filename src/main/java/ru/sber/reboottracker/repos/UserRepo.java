package ru.sber.reboottracker.repos;

import ru.sber.reboottracker.domain.user.Role;
import ru.sber.reboottracker.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findByActivationCode(String code);
    List<User> findByRoles(Role role);
}
