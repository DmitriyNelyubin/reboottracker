package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.IssueStatus;
import ru.sber.reboottracker.domain.issues.IssueType;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.IssueRepo;
import ru.sber.reboottracker.service.IssueService;
import ru.sber.reboottracker.service.SprintService;
import ru.sber.reboottracker.service.UserService;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/issue")
public class IssueController {
    @Autowired
    IssueRepo issueRepo;

    @Autowired
    IssueService issueService;

    @Autowired
    UserService userService;

    @Autowired
    SprintService sprintService;

//    @PreAuthorize("hasAnyAuthority('ADMIN')")
    @PostMapping
    public String addIssue(
            @AuthenticationPrincipal User user,
            @Valid Issue issue,
            BindingResult bindingResult,
            @RequestParam(value = "executor", required = false) User executor,
            @RequestParam("reporter") User reporter,
            @RequestParam("project") Project project,

            Model model
    ) {
        model.addAttribute("project", project);
        model.addAttribute("developers", userService.findDevelopersByProject(project));
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        model.addAttribute("backlog", issueService.getProjectBacklog(project));

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            return "/issue";
        }

        if (!issueService.addIssue(issue, reporter, executor, project)) {
            model.addAttribute("nameError", "Issue exists!");
            return "/issue";
        }

        Iterable<Issue> issues = issueRepo.findAll();

        model.addAttribute("backlog", issues);
        return "redirect:/issue/" + project.getId();
    }

    @GetMapping("{project}")
    public String issueList(
            @AuthenticationPrincipal User user,
            @PathVariable Project project,
            @RequestParam(required = false) String filterName,
            @RequestParam(required = false) String filterDescription,
            @RequestParam(name = "filterReporter", required = false) User reporter,
            @RequestParam(name = "filterExecutor", required = false) User executor,
            @RequestParam(name = "filterDate", required = false) String creationDate,
            @RequestParam(name = "filterStatus", required = false) IssueStatus status,
            @RequestParam(name = "filterType", required = false) IssueType type,
            @RequestParam(name = "filterSubIssues", required = false) String hasSubIssue,
            Model model){
        List<Issue> issues = issueService.getProjectBacklog(project);
        issues = issueService.issueFilter(issues, filterName, filterDescription, reporter, executor, creationDate, status, type, hasSubIssue);
        model.addAttribute("backlog", issues);
        model.addAttribute("user", user);
        model.addAttribute("project", project);
        model.addAttribute("developers", userService.findDevelopersByProject(project));
        model.addAttribute("users", userService.findAll());
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        model.addAttribute("sprints", sprintService.getProjectSprints(project));
        return "/issue";
    }
}
