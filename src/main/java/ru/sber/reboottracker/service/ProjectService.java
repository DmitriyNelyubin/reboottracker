package ru.sber.reboottracker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.User;
import ru.sber.reboottracker.repos.ProjectRepo;
import ru.sber.reboottracker.repos.UserRepo;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Service
public class ProjectService {
    @Autowired
    private ProjectRepo projectRepo;

    @Autowired
    private UserRepo userRepo;

    public boolean addProject (Project project) {
        Project projectFromDB = projectRepo.findByName(project.getName());

        if (projectFromDB != null){
            return false;
        }
        project.setActive(true);
        project.setAdmin(null);
        project.setDevelopers(null);
        projectRepo.save(project);
        return true;
    }

    public List<Project> findAll(){
        return projectRepo.findAll();
    }

    public List<Project> findByDevelopers(User user) {
        return projectRepo.findByDevelopers(user);
    }

    public void updateProject(Project project, String name, String description, String department, boolean active, User manager, User admin, List<User> developers) {
        String projectName = project.getName();
        String projectDescription = project.getDescription();
        String projectDepartment = project.getDepartment();
        boolean projectActive = project.isActive();
        User projectManager = project.getManager();
        User projectAdmin = project.getAdmin();
        List<User> projectDevelopers = project.getDevelopers();

        boolean isNameChanged = (name != null && !name.equals(projectName) ||
                (projectName != null && !projectName.equals(name)));

        boolean isDescriptionChanged = (description != null && !description.equals(projectDescription) ||
                (projectDescription != null && !projectDescription.equals(description)));

        boolean isDepartmentChanged = (department != null && !department.equals(projectDepartment)) ||
                (projectDepartment != null && !projectDepartment.equals(department));

        boolean isProjectManagerChanged = (manager != null && !manager.equals(projectManager)) ||
                (projectManager != null && !projectManager.equals(manager));

        boolean isProjectAdminChanged = (admin != null && !admin.equals(projectAdmin)) ||
                (projectAdmin != null && !projectAdmin.equals(admin));

        boolean isActiveChanged = active != projectActive;

        if (isNameChanged) {
            project.setName(name);
        }

        if (isDescriptionChanged) {
            project.setDescription(description);
        }

        if (isDepartmentChanged) {
            project.setDepartment(department);
        }

        if (isProjectManagerChanged) {
            project.setManager(manager);
        }

        if (isProjectAdminChanged) {
            project.setAdmin(admin);
        }

        if (isActiveChanged) {
            project.setActive(active);
        }

        if (isDevelopersChanged(projectDevelopers, developers)) {
            project.setDevelopers(null);
            project.setDevelopers(developers);
        }

        projectRepo.save(project);
    }

    private boolean isDevelopersChanged (List<User> projectDevelopers, List<User> developers){
        developers.removeIf(projectDevelopers::contains);
        return !developers.isEmpty();
        }
}
