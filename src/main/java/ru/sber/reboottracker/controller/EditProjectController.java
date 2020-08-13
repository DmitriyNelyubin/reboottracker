package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.annotation.Id;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.service.ProjectService;
import ru.sber.reboottracker.service.UserService;

import java.util.List;

@Controller
@RequestMapping("/projectList")
public class EditProjectController {
    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserService userService;

    @GetMapping
    public String projectList(Model model){
        model.addAttribute("projects", projectService.findAll());
        return "projectList";
    }

    @GetMapping("{project}")
    public String projectEditForm(@PathVariable Project project, Model model){
        model.addAttribute("project", project);
        model.addAttribute("managers", userService.findManagers());
        model.addAttribute("admins", userService.findAdmins());
        model.addAttribute("developers", userService.findDevelopers());
        model.addAttribute("active", project.isActive());
        return "projectEdit";
    }


    @PreAuthorize("hasAnyAuthority('MANAGER')")
    @PostMapping
    public String updateProject(@RequestParam ("projectId") Project project,
                                @RequestParam String name,
                                @RequestParam String description,
                                @RequestParam String department,
                                @RequestParam boolean active,
                                @RequestParam ("manager")User manager,
                                @RequestParam ("admin")User admin,
                                @RequestParam List<User> developer
    ) {
        projectService.updateProject(project, name, description, department, active, manager, admin, developer);

        return "redirect:/projectList";
    }
}
