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
@RequestMapping("/subIssue")
public class SubIssueController {
    @Autowired
    IssueRepo issueRepo;

    @Autowired
    IssueService issueService;

    @Autowired
    UserService userService;

    @PostMapping
    public String addSubIssue(
            @AuthenticationPrincipal User user,
            @Valid Issue subIssue,
            BindingResult bindingResult,
            @RequestParam("executor") User executor,
            @RequestParam("reporter") User reporter,
            @RequestParam("project") Project project,
            @RequestParam("superIssue") Issue superIssue,
            Model model
    ) {
        model.addAttribute("project", project);
        model.addAttribute("developers", userService.findDevelopersByProject(project));
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        model.addAttribute("issues", issueRepo.findByProject(project));

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            return "/subIssue";
        }

        if (!issueService.addSubIssue(subIssue, reporter, executor, project, superIssue)) {
            model.addAttribute("nameError", "Issue exists!");
            return "/subIssue";
        }

        return "redirect:/issueProfile/" + superIssue.getId();

    }

    @GetMapping("{issue}")
    public String subIssue(
            @AuthenticationPrincipal User user,
            @PathVariable Issue issue,
            Model model){
        model.addAttribute("superIssue", issue);
        model.addAttribute("user", user);
        model.addAttribute("project", issue.getProject());
        model.addAttribute("developers", userService.findDevelopersByProject(issue.getProject()));
        model.addAttribute("statuses", IssueStatus.values());
        model.addAttribute("types" , IssueType.values());
        return "/subIssue";
    }
}
