package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.repos.IssueRepo;

import java.util.Date;

@Service
public class IssueService {
    @Autowired
    IssueRepo issueRepo;

    public boolean addIssue(Issue issue){
        Issue issueFromDB = issueRepo.findByName(issue.getName());

        if(issueFromDB != null){
            return false;
        }
        issue.setCreationDate(new Date());
        issueRepo.save(issue);
        return true;
    }

}
