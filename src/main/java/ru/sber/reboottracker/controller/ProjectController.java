package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.service.ProjectService;
import ru.sber.reboottracker.service.UserService;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class ProjectController {
    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;

    @PostMapping("/project")
    public String addProject(
            @AuthenticationPrincipal User user,
            @Valid Project project,
            BindingResult bindingResult,
            Model model
    ) {
        project.setManager(user);
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            return "project";
        } if (!projectService.addProject(project)) {
            model.addAttribute("nameError", "Project exists!");
            return "project";
        }

        Iterable<Project> projects = projectService.findAll();

        model.addAttribute("projects", projects);
        return "project";
    }
    @GetMapping("/project")
    public String projectList(Model model){
        model.addAttribute("projects", projectService.findAll());
        return "project";
    }

//    @GetMapping("{project}")
//    public String projectEditForm(Project project, Model model){
//        model.addAttribute("project", project);
//        model.addAttribute("managers", userService.findManagers());
//        model.addAttribute("admins", userService.findAdmins());
//        model.addAttribute("developers", userService.findDevelopers());
//        return "projectEdit";
//    }
}
