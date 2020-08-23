package ru.sber.reboottracker.domain.issues;

import java.util.List;

public interface IssueLog {
    public boolean addIssue(Issue issue);
    public boolean removeIssue(Issue issue);
    public List<Issue> getIssues();
}
