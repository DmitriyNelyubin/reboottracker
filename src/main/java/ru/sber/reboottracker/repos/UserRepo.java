package ru.sber.reboottracker.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.Role;
import ru.sber.reboottracker.domain.user.User;

import java.util.List;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findByActivationCode(String code);
    List<User> findByRoles(Role role);
}
