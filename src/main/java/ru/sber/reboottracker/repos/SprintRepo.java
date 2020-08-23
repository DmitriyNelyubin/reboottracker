package ru.sber.reboottracker.repos;

import org.springframework.data.repository.CrudRepository;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;

import java.util.List;

public interface SprintRepo extends CrudRepository<Sprint, Long> {
    List<Sprint> findByProject(Project project);

}
