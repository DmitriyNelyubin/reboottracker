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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
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
        if(executor == null) {
            issue.setExecutor(null);
        }
        issue.setExecutor(executor);
        project.addToBacklog(issue);
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
        return project.getBacklog();
    }

    public List<Issue> getSprintIssue(Sprint sprint){
        return sprint.getIssues();
    }

    public List<Issue> getIssuesByExecutor(User executor) {
        return issueRepo.findByExecutor(executor);
    }

    public List<Issue> issueFilter(List<Issue> issues, String filterName, String filterDescription, User reporter, User executor, String creationDate, IssueStatus status, IssueType type, String hasSubIssue) {

        if(issues != null && filterName != null && !filterName.equals("")) {
            issues.removeIf(issue -> !issue.getName().contains(filterName));
        }

        if(issues != null && filterDescription != null && !filterDescription.equals("")) {
            issues.removeIf(issue -> !issue.getDescription().contains(filterDescription));
        }

        if(issues != null && reporter != null) {
            issues.removeIf(issue -> !issue.getReporter().equals(reporter));
        }

        if(issues != null && executor != null) {
            issues.removeIf(issue -> !issue.getExecutor().equals(executor));
        }

        if(issues != null && creationDate != null && !creationDate.equals("")) {
            issues.removeIf(issue -> !issue.getCreationDate().equals(parseDate(creationDate)));
        }

        if(issues != null && status != null) {
            issues.removeIf(issue -> !(issue.getStatus() == status));
        }

        if(issues != null && type != null) {
            issues.removeIf(issue -> !(issue.getType() == type));
        }

        if(issues != null && hasSubIssue != null && hasSubIssue != "") {
            issues.removeIf(issue -> !(issue.isHasSubIssues() == parseBool(hasSubIssue)));
        }

        return issues;
    }

    private Date parseDate(String date){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parsedDate = new Date();
        try {
            parsedDate = simpleDateFormat.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return parsedDate;
    }

    private boolean parseBool(String bool){
        if(bool.equals("true")){
            return true;
        }
        return false;
    }
}
