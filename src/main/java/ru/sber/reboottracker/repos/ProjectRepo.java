package ru.sber.reboottracker.repos;


import org.springframework.data.repository.CrudRepository;
import ru.sber.reboottracker.domain.project.Project;

import java.util.List;

public interface ProjectRepo extends CrudRepository<Project, Long> {
    List<Project> findAll();
    Project findByName(String name);
}
