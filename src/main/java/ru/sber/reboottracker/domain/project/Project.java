package ru.sber.reboottracker.domain.project;

import ru.sber.reboottracker.domain.user.User;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Entity
@Table(name = "project")
public class Project {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    @NotBlank(message = "Project name can't be empty")
    private String name;
    @NotBlank(message = "Project description can't be empty")
    private String description;
    @NotBlank(message = "Department can't be empty")
    private String department;
    @ManyToOne(fetch = FetchType.EAGER)
    private User manager;
    @ManyToOne(fetch = FetchType.EAGER)
    private User admin;
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    private List<User> developers;
    private boolean active;

    public Project() {
    }

    public Project(String name, String description, String department) {
        this.name = name;
        this.description = description;
        this.department = department;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public User getManager() {
        return manager;
    }

    public void setManager(User manager) {
        this.manager = manager;
    }

    public User getAdmin() {
        return admin;
    }

    public void setAdmin(User admin) {
        this.admin = admin;
    }

    public List<User> getDevelopers() {
        if (developers == null) {
            return null;
        }
        return developers.stream().distinct().collect(Collectors.toList());
    }

    public void setDevelopers(List<User> developers) {
        if (developers != null && this.developers != null) {
            this.developers.clear();
        }
        this.developers = developers;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
