package ru.sber.reboottracker.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String login(Model model) {
        return "login";
    }



}