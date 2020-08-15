package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.service.ProjectService;
import ru.sber.reboottracker.service.UserService;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class ProjectEditController {
    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;


    @PreAuthorize("hasAnyAuthority('ADMIN')")
    @PostMapping("/projectList")
    public String addProject(
            @AuthenticationPrincipal User user,
            @Valid Project project,
            BindingResult bindingResult,
            Model model
    ) {
        project.setManager(user);
        project.setAdmin(user);
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            return "createProject_d";
        } if (!projectService.addProject(project)) {
            model.addAttribute("nameError", "Project exists!");
            return "createProject_d";
        }

        Iterable<Project> projects = projectService.findAll();

        model.addAttribute("projects", projects);
        return "projectList";
    }

    @GetMapping("/projectList")
    public String projectList(Model model){
        model.addAttribute("projects", projectService.findAll());
        return "projectList";
    }

    @GetMapping("/projectList/{project}")
    public String getProfile(
            @PathVariable Project project,
            Model model) {
        model.addAttribute("project", project);
        model.addAttribute("developers", project.getDevelopers());

        return "projectProfile";
    }

    @PreAuthorize("hasAnyAuthority('MANAGER')")
    @GetMapping("/projectEdit/{project}")
    public String projectEditForm(@PathVariable Project project, Model model){
        model.addAttribute("project", project);
        model.addAttribute("managers", userService.findManagers());
        model.addAttribute("admins", userService.findAdmins());
        model.addAttribute("developers", userService.findDevelopers());
        model.addAttribute("active", project.isActive());
        return "projectEdit";
    }



    @PostMapping("/projectEdit")
    public String updateProject(@RequestParam ("projectId") Project project,
                                @RequestParam String name,
                                @RequestParam String description,
                                @RequestParam String department,
                                @RequestParam boolean active,
                                @RequestParam ("manager")User manager,
                                @RequestParam ("admin")User admin,
                                @RequestParam(required = false) List<User> developer
    ) {
        projectService.updateProject(project, name, description, department, active, manager, admin, developer);

        return "redirect:/projectList/" + project.getId().toString();
    }
}
