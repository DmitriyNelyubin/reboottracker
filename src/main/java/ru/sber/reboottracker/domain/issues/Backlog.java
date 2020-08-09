package ru.sber.reboottracker.domain.issues;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "backlog")
public class Backlog implements IssueLog{
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    public Backlog() {
    }

    @Override
    public boolean addIssue(Issue issue) {
        return false;
    }

    @Override
    public boolean removeIssue(Issue issue) {
        return false;
    }

    @Override
    public Set<Issue> getIssues() {
        return null;
    }
}
