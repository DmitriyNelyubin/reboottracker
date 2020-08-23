package ru.sber.reboottracker.domain.issues;

import org.springframework.format.annotation.DateTimeFormat;
import ru.sber.reboottracker.domain.project.Project;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;


@Entity
@Table(name = "sprint")
public class Sprint implements IssueLog{
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    @NotBlank(message = "Sprint name can't be empty")
    private String name;
    @NotBlank(message = "Sprint description can't be empty")
    private String description;
    @OneToMany(targetEntity = Issue.class)
    @JoinColumn(name = "sprint_id")
    private List<Issue> issues;
    @NotNull(message = "Set start date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    @NotNull(message = "Set finish date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date finishDate;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    private Project project;

    public Sprint() {
    }

    public Sprint(@NotBlank(message = "Sprint name can't be empty") String name, @NotBlank(message = "Sprint description can't be empty") String description, @NotNull(message = "Set start date") Date startDate, @NotNull(message = "Set finish date") Date finishDate) {
        this.name = name;
        this.description = description;
        this.startDate = startDate;
        this.finishDate = finishDate;
    }

    @Override
    public boolean addIssue(Issue issue) {
        return issues.add(issue);
    }

    @Override
    public boolean removeIssue(Issue issue) {
        return false;
    }

    @Override
    public List<Issue> getIssues() {
        return issues;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public void setIssues(List<Issue> issues) {
        this.issues = issues;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date creationDate) {
        this.startDate = creationDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date closeDate) {
        this.finishDate = closeDate;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
}
