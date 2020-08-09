package ru.sber.reboottracker.domain.issues;

import java.util.Set;

public interface IssueLog {
    public boolean addIssue(Issue issue);
    public boolean removeIssue(Issue issue);
    public Set<Issue> getIssues();
}
