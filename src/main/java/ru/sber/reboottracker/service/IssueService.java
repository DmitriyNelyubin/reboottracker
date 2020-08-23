package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.IssueStatus;
import ru.sber.reboottracker.domain.issues.IssueType;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.IssueRepo;

import java.util.Date;
import java.util.List;

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

    public boolean addSubIssue(Issue subIssue, User reporter, User executor, Project project, Issue superIssue) {

        if(superIssue.getSubIssues().contains(subIssue)){
            return false;
        }

        subIssue.setCreationDate(new Date());
        subIssue.setProject(project);
        subIssue.setReporter(reporter);
        subIssue.setExecutor(executor);
        subIssue.setSuperIssue(superIssue);
        superIssue.addSubIssue(subIssue);

        issueRepo.save(subIssue);
        return true;
    }

    public boolean updateIssue(Issue issue, String name, String description, User reporter, User executor, IssueStatus status, IssueType type, Project project) {

        if(status != IssueStatus.CLOSE_ISSUE){
            issue.setCloseDate(null);
        }
        issue.setName(name);
        issue.setDescription(description);
        issue.setReporter(reporter);
        issue.setExecutor(executor);
        issue.setStatus(status);
        issue.setType(type);
        issueRepo.save(issue);

        return true;
    }

    private Issue getIssueFromDB(Issue issue, Project project){
        return issueRepo.findByNameAndProject(issue.getName(), project);
    }

    public List<Issue> getProjectBacklog(Project project){
        return issueRepo.findByProject(project);
    }

    public List<Issue> getSprintIssue(Sprint sprint){
        return sprint.getIssues();
    }

    public List<Issue> getIssuesByExecutor(User executor) {
        return issueRepo.findByExecutor(executor);
    }

}
