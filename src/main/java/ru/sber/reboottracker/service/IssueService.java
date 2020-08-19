package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.IssueStatus;
import ru.sber.reboottracker.domain.issues.IssueType;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.IssueRepo;

import java.util.Date;

@Service
public class IssueService {
    @Autowired
    IssueRepo issueRepo;

    public boolean addIssue(Issue issue, User reporter, User executor, Project project){
        Issue issueFromDB = getIssueFromDB(issue, project);

        if(issueFromDB != null){
            return false;
        }
        issue.setCreationDate(new Date());
        issue.setProject(project);
        issue.setReporter(reporter);
        issue.setExecutor(executor);

        issueRepo.save(issue);
        return true;
    }

    public boolean addSubIssue(Issue issue, User reporter, User executor, Project project, Issue superIssue) {
        Issue subIssueFromDB = getIssueFromDB(issue, project);

        if(subIssueFromDB != null){
            return false;
        }
        issue.setCreationDate(new Date());
        issue.setProject(project);
        issue.setReporter(reporter);
        issue.setExecutor(executor);
        issue.setSuperIssue(superIssue);
        issue.setHasSubIssues(true);
        superIssue.addSubIssue(issue);

        issueRepo.save(issue);
        return true;
    }

    public boolean updateIssue(Issue issue, String name, String description, User reporter, User executor, Project project) {
        Issue issueFromDB = getIssueFromDB(issue, project);

        if(issueFromDB != null){
            return false;
        }

        issue.setName(name);
        issue.setDescription(description);
        issue.setExecutor(executor);
        issueRepo.save(issue);

        return true;
    }

    Issue getIssueFromDB(Issue issue, Project project){
        return issueRepo.findByNameAndProject(issue.getName(), project);
    }
}
