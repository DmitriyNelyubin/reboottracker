package ru.sber.reboottracker.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ProjectCreationController {
    @GetMapping("/createProject")
    public String createProject () {
        return "createProject";
    }

//    @PostMapping("/createProject")
//    public String addProject(
//
//    )
}
