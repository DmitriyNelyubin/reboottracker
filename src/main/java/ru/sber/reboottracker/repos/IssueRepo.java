package ru.sber.reboottracker.repos;

import org.springframework.data.repository.CrudRepository;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.IssueStatus;
import ru.sber.reboottracker.domain.issues.IssueType;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;

import java.util.List;

public interface IssueRepo extends CrudRepository<Issue, Long> {
    List<Issue> findAll();
    Issue findByName(String name);
    List<Issue> findByProject(Project project);
    List<Issue> findByReporter(User user);
    List<Issue> findByExecutor(User user);
    List<Issue> findAllByStatus(IssueStatus status);
    List<Issue> findAllByType(IssueType type);
    List<Issue> findBySuperIssue(Issue issue);

}
