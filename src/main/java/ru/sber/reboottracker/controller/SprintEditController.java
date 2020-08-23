package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.IssueStatus;
import ru.sber.reboottracker.domain.issues.IssueType;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.service.SprintService;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

public class SprintEditController {

    @Autowired
    private SprintService sprintService;

//    @PostMapping("/issueEdit/")
//    public String updateIssue(
//            @AuthenticationPrincipal User user,
//            @RequestParam("issueId") Issue issue,
//            @RequestParam String name,
//            @RequestParam String description,
//            @RequestParam("executor") User executor,
//            @RequestParam("reporter") User reporter,
//            @RequestParam("project") Project project,
//            @RequestParam IssueStatus status,
//            @RequestParam IssueType type,
//
//            Model model
//    ) {
//        issueService.updateIssue(issue, name, description, reporter, executor, status, type, project);
//        model.addAttribute("project", project);
//        model.addAttribute("developers", userService.findDevelopersByProject(project));
//        model.addAttribute("statuses", IssueStatus.values());
//        model.addAttribute("types" , IssueType.values());
//        model.addAttribute("issues", issueRepo.findByProject(project));
//
//        return "redirect:/issueProfile/" + issue.getId();
//    }
//    @GetMapping("issueEdit/{issue}")
//    public String issueEditForm(
//            @AuthenticationPrincipal User user,
//            @PathVariable Issue issue,
//            Model model){
//        model.addAttribute("issue", issue);
//        model.addAttribute("project", issue.getProject());
//        model.addAttribute("statuses", IssueStatus.values());
//        model.addAttribute("types" , IssueType.values());
//        model.addAttribute("issues", issueRepo.findByProject(issue.getProject()));
//        model.addAttribute("developers", userService.findDevelopersByProject(issue.getProject()));
//        model.addAttribute("subIssues", issue.getSubIssues());
//        return "/issueEdit";
//    }

    @GetMapping("sprintProfile/{sprint}")
    public String sprintProfile(
            @AuthenticationPrincipal User user,
            @PathVariable Sprint sprint,
            Model model){
        model.addAttribute("sprint", sprint);
        model.addAttribute("issues", sprintService.getSprintIssues(sprint));

        return "/sprintProfile";
    }
}
