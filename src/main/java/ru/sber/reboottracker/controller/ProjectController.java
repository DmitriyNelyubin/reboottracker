//package ru.sber.reboottracker.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.access.prepost.PreAuthorize;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import ru.sber.reboottracker.domain.project.Project;
//import ru.sber.reboottracker.domain.user.Role;
//import ru.sber.reboottracker.domain.user.User;
//import ru.sber.reboottracker.repos.ProjectRepo;
//import ru.sber.reboottracker.service.ProjectServise;
//
//@Controller
//@RequestMapping("/project")
//public class ProjectController {
//    @Autowired
//    private ProjectServise projectServise;
//
//    @Autowired
//    private ProjectRepo projectRepo;
//
//    @PreAuthorize("hasAnyAuthority('ADMIN')")
//    @GetMapping
//    public String projectList(Model model){
//        model.addAttribute("projects", projectServise.findAll());
//        return "projectList";
//    }
//
//    @PreAuthorize("hasAnyAuthority('ADMIN')")
//    @GetMapping
//    public String projectSave(@PathVariable Project project, Model model){
//        model.addAttribute("project", project);
//        model.addAttribute("description", project.getDescription());
//        model.addAttribute("department", project.getDepartment());
//        model.addAttribute("manager", project.getManager().getUsername());
//        model.addAttribute("admin", project.getAdmin().getUsername());
//        model.addAttribute("active", project.isActive() ? "active" : "inactive");
//        return "projectProfile";
//    }
//
//
//
//
//}
