package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.IssueStatus;
import ru.sber.reboottracker.domain.issues.IssueType;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.service.IssueService;
import ru.sber.reboottracker.service.SprintService;
import ru.sber.reboottracker.service.UserService;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping
public class SprintEditController {

    @Autowired
    private SprintService sprintService;

    @Autowired
    private IssueService issueService;

    @Autowired
    private UserService userService;

    @PostMapping("/sprintEdit/")
    public String updateSprint(
            @AuthenticationPrincipal User user,
            @RequestParam("sprint") Sprint sprint,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam("project") Project project,
            @RequestParam("startDate") String startDate,
            @RequestParam("finishDate") String finishDate,

            @RequestParam(value = "backlog", required = false) List<Issue> backlog,
            @RequestParam(value = "sprintIssues", required = false) List<Issue> sprintIssues,

            Model model
    ) {
        if(backlog == null) {
            backlog = Collections.emptyList();
        }

        if(sprintIssues == null) {
            sprintIssues = Collections.emptyList();
        }

        sprintService.updateSprint(sprint, name, description, project, startDate, finishDate, backlog, sprintIssues);
        model.addAttribute("sprint", sprint);
        model.addAttribute("project", sprint.getProject());
        model.addAttribute("backlog", issueService.getProjectBacklog(sprint.getProject()));
        model.addAttribute("startDate", new SimpleDateFormat("yyyy-MM-dd").format(sprint.getStartDate()));
        model.addAttribute("finishDate", new SimpleDateFormat("yyyy-MM-dd").format(sprint.getFinishDate()));
        model.addAttribute("sprintIssues", sprintService.getSprintIssues(sprint));

        return "redirect:/sprintEdit/" + sprint.getId();
    }
    @GetMapping("sprintEdit/{sprint}")
    public String sprint(
            @AuthenticationPrincipal User user,
            @PathVariable Sprint sprint,
            Model model){
        model.addAttribute("sprint", sprint);
        model.addAttribute("project", sprint.getProject());
        model.addAttribute("backlog", issueService.getProjectBacklog(sprint.getProject()));
        model.addAttribute("startDate", new SimpleDateFormat("yyyy-MM-dd").format(sprint.getStartDate()));
        model.addAttribute("finishDate", new SimpleDateFormat("yyyy-MM-dd").format(sprint.getFinishDate()));
        model.addAttribute("sprintIssues", sprintService.getSprintIssues(sprint));
        return "/sprintEdit";
    }

    @GetMapping("/sprintProfile/{sprint}")
    public String sprintProfile(
            @AuthenticationPrincipal User user,
            @PathVariable Sprint sprint,
            @RequestParam(required = false) String filterName,
            @RequestParam(required = false) String filterDescription,
            @RequestParam(name = "filterReporter", required = false) User reporter,
            @RequestParam(name = "filterExecutor", required = false) User executor,
            @RequestParam(name = "filterDate", required = false) String creationDate,
            @RequestParam(name = "filterStatus", required = false) IssueStatus status,
            @RequestParam(name = "filterType", required = false) IssueType type,
            @RequestParam(name = "filterSubIssues", required = false) String hasSubIssue,
            Model model){
        List<Issue> issues = issueService.getProjectBacklog(sprint.getProject());
        issues = issueService.issueFilter(issues, filterName, filterDescription, reporter, executor, creationDate, status, type, hasSubIssue);
        model.addAttribute("developers", userService.findDevelopersByProject(sprint.getProject()));
        model.addAttribute("users", userService.findAll());
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        model.addAttribute("sprints", sprintService.getProjectSprints(sprint.getProject()));
        model.addAttribute("sprint", sprint);
        model.addAttribute("backlog", issues);

        return "/sprintProfile";
    }
}
