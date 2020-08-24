package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.repos.ProjectRepo;
import ru.sber.reboottracker.repos.SprintRepo;

import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class SprintService{

    @Autowired
    private SprintRepo sprintRepo;

    @Autowired
    private ProjectRepo projectRepo;

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

    public void updateSprint(Sprint sprint, String name, String description, Project project, String startDateString, String finishDateString, List<Issue> backlog, List<Issue> sprintIssues) {

        if(name != null && !sprint.getName().equals(name)){
            sprint.setName(name);
        }

        if(description != null && !sprint.getDescription().equals(description)){
            sprint.setDescription(description);
        }

        Date startDate = parseDate(startDateString);

        if(startDate != null && !sprint.getStartDate().equals(startDate)){
            sprint.setStartDate((startDate));
        }

        Date finishDate = parseDate(finishDateString);

        if(finishDate != null && !sprint.getFinishDate().equals(finishDate)){
            sprint.setFinishDate((finishDate));
        }

        if(!backlog.isEmpty()) {
            sprint.addIssue(backlog);
            project.removeIssue(backlog);
        }

        if(!sprintIssues.isEmpty()) {
            project.addToBacklog(sprintIssues);
            sprint.removeIssue(sprintIssues);
        }

        sprintRepo.save(sprint);
        projectRepo.save(project);
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
}
