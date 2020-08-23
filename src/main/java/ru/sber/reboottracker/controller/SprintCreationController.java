package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import ru.sber.reboottracker.domain.issues.Issue;
import ru.sber.reboottracker.domain.issues.Sprint;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.SprintRepo;
import ru.sber.reboottracker.service.IssueService;
import ru.sber.reboottracker.service.SprintService;

import javax.validation.Valid;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sprint")
public class SprintCreationController {

    @Autowired
    private IssueService issueService;

    @Autowired
    private SprintRepo sprintRepo;

    @Autowired
    private SprintService sprintService;

    @PostMapping
    public String addSprint(
            @AuthenticationPrincipal User user,
            @Valid Sprint sprint,
            BindingResult bindingResult,
            @RequestParam("project") Project project,
            @RequestParam("sprintIssues") List<Issue>  sprintIssues,

            Model model
    ) {
        model.addAttribute("project", project);
        model.addAttribute("backlog", issueService.getProjectBacklog(project));

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            return "/sprint";
        }

        sprint.setProject(project);
        sprint.setIssues(sprintIssues);
        sprintRepo.save(sprint);

        return "redirect:/sprint/" + sprint.getId();
    }

    @GetMapping("{project}")
    public String issueList(
            @AuthenticationPrincipal User user,
            @PathVariable Project project,
            Model model){
        model.addAttribute("project", project);
        model.addAttribute("backlog", issueService.getProjectBacklog(project));
        model.addAttribute("currentDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date())).toString();
        model.addAttribute("sprints", sprintService.getProjectSprints(project));
        return "/sprint";
    }
}

