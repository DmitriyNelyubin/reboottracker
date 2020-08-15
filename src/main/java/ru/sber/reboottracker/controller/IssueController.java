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
import ru.sber.reboottracker.repos.UserRepo;
import ru.sber.reboottracker.service.IssueService;
import ru.sber.reboottracker.service.UserService;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class IssueController {
    @Autowired
    IssueRepo issueRepo;

    @Autowired
    IssueService issueService;

    @Autowired
    UserService userService;

    @PreAuthorize("hasAnyAuthority('ADMIN')")
    @PostMapping("/issue/{project}")
    public String addIssue(
            @AuthenticationPrincipal User user,
            @PathVariable Project project,
            @Valid Issue issue,
            BindingResult bindingResult,
            Model model
    ) {
        issue.setReporter(user);
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            return "issue";
        }
        if (!issueService.addIssue(issue)) {
            model.addAttribute("nameError", "Issue exists!");
            return "/issue";
        }

        Iterable<Issue> issues = issueRepo.findAll();

        model.addAttribute("issues", issues);
        return "issue";
    }

    @GetMapping("issue/{project}")
    public String issueList(
            @AuthenticationPrincipal User user,
            @PathVariable Project project,
            Model model){
        model.addAttribute("user", user);
        model.addAttribute("project", project);
        model.addAttribute("issues", issueRepo.findAll());
        model.addAttribute("developers", userService.findDevelopersByProject(project));
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        return "issue";
    }
}
