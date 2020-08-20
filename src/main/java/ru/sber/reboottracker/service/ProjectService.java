package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.ProjectRepo;

import java.util.List;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepo projectRepo;

    public boolean addProject (Project project) {
        Project projectFromDB = projectRepo.findByName(project.getName());

        if (projectFromDB != null){
            return false;
        }
        project.setActive(true);
        project.setDevelopers(null);
        projectRepo.save(project);
        return true;
    }

    public List<Project> findAll(){
        return projectRepo.findAll();
    }



    public void updateProject(Project project, String name, String  description, String department, boolean active, User manager, User admin, List<User> developers) {
        project.setName(name);
        project.setDescription(description);
        project.setDepartment(department);
        project.setActive(active);
        project.setManager(manager);
        project.setAdmin(admin);
        project.setDevelopers(developers);
        projectRepo.save(project);
    }

    private boolean isDevelopersChanged (List<User> projectDevelopers, List<User> developers){
        if (developers == null){
            return true;
        }
        if (projectDevelopers.size() == developers.size()) {
            developers.removeIf(projectDevelopers::contains);
            return !developers.isEmpty();
        }
        return true;
        }
}
