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
        project.setAdmin(null);
        project.setDevelopers(null);
        projectRepo.save(project);
        return true;
    }

    public List<Project> findAll(){
        return projectRepo.findAll();
    }

    public void updateProject(Project project, String description, String department, User manager, User admin, boolean active) {
        String projectDescription = project.getDescription();
        String projectDepartment = project.getDepartment();
        User projectManager = project.getManager();
        User projectAdmin = project.getAdmin();
        boolean projectActive = project.isActive();

        boolean isDescriptionChanged = (description != null && !description.equals(projectDescription) ||
                (projectDescription != null && !projectDescription.equals(description)));

        boolean isDepartmentChanged = (department != null && !department.equals(projectDepartment)) ||
                (projectDepartment != null && !projectDepartment.equals(department));

        boolean isProjectManagerChanged = (projectManager != null && !manager.equals(projectManager)) ||
                (projectManager != null && !projectManager.equals(manager));

        boolean isProjectAdminChanged = (projectAdmin != null && !admin.equals(projectAdmin)) ||
                (projectAdmin != null && !projectAdmin.equals(admin));

        boolean isActiveChanged = active != projectActive;

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

        projectRepo.save(project);
    }


}
