package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.sber.reboottracker.domain.Message;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.ProjectRepo;
import ru.sber.reboottracker.service.ProjectService;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@Controller
public class ProjectCreationController {
    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private ProjectService projectService;

    @GetMapping("/createProject")
    public String createProject () {
        return "createProject";
    }

    @PostMapping("/createProject")
    public String addProject(
            @AuthenticationPrincipal User user,
            @Valid Project project,
            BindingResult bindingResult,
            Model model
    ) throws IOException {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute("project", project);
        } else {
            model.addAttribute("project", null);
            projectService.addProject(project);
        }
        return "redirect:/projectList";
    }
    @GetMapping("projectList")
    public String projectList(Model model){
        model.addAttribute("projects", projectRepo.findAll());
        return "projectList";
    }
}
