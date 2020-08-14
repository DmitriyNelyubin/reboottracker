package ru.sber.reboottracker.repos;

import org.springframework.data.repository.CrudRepository;
import ru.sber.reboottracker.domain.issues.Issue;

public interface IssueRepo extends CrudRepository<Issue, Long> {

}
