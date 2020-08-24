package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.repos.IssueRepo;
import ru.sber.reboottracker.repos.SprintRepo;

import javax.validation.Valid;
import java.util.List;

@Service
public class SprintService{

    @Autowired
    private SprintRepo sprintRepo;

    public void addSprint(@Valid Sprint sprint, Project project, List<Issue> sprintIssues){
        sprint.setProject(project);
        sprint.setIssues(sprintIssues);
        project.removeIssue(sprintIssues);
        sprintRepo.save(sprint);
    }

    public List<Issue> getSprintIssues(Sprint sprint) {
        return sprint.getIssues();
    }

    public List<Sprint> getProjectSprints(Project project) {
        return sprintRepo.findByProject(project);
    }
}
