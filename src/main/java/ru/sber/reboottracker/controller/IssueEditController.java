package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
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
import ru.sber.reboottracker.service.UserService;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class IssueEditController {
    @Autowired
    IssueRepo issueRepo;

    @Autowired
    IssueService issueService;

    @Autowired
    UserService userService;

    //    @PreAuthorize("hasAnyAuthority('ADMIN')")
    @PostMapping("/issueEdit/")
    public String updateIssue(
            @AuthenticationPrincipal User user,
            @RequestParam("issueId") Issue issue,
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam("executor") User executor,
            @RequestParam("reporter") User reporter,
            @RequestParam("project") Project project,
            @RequestParam IssueStatus status,
            @RequestParam IssueType type,

            Model model
    ) {
        issueService.updateIssue(issue, name, description, reporter, executor, status, type, project);
        model.addAttribute("project", project);
        model.addAttribute("developers", userService.findDevelopersByProject(project));
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        model.addAttribute("issues", issueRepo.findByProject(project));

        return "redirect:/issueProfile/" + issue.getId();
    }
    @GetMapping("issueEdit/{issue}")
    public String issueEditForm(
            @AuthenticationPrincipal User user,
            @PathVariable Issue issue,
            Model model){
        model.addAttribute("issue", issue);
        model.addAttribute("project", issue.getProject());
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        model.addAttribute("issues", issueRepo.findByProject(issue.getProject()));
        model.addAttribute("developers", userService.findDevelopersByProject(issue.getProject()));
        model.addAttribute("subIssues", issue.getSubIssues());
        return "/issueEdit";
    }

    @GetMapping("issueProfile/{issue}")
    public String issueProfile(
            @AuthenticationPrincipal User user,
            @PathVariable Issue issue,
            Model model){
        model.addAttribute("issue", issue);

        return "/issueProfile";
    }
}
