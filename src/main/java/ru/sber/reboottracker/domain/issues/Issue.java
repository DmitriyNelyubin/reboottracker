package ru.sber.reboottracker.domain.issues;

import org.springframework.format.annotation.DateTimeFormat;
import ru.sber.reboottracker.domain.project.Project;
import ru.sber.reboottracker.domain.user.Role;
import ru.sber.reboottracker.domain.user.User;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "issue")
public class Issue {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;
    @NotBlank(message = "Issue name can't be empty")
    private String name;
    @NotBlank(message = "Issue description can't be empty")
    private String description;
    @NotNull(message = "Set reporter")
    @ManyToOne(fetch = FetchType.EAGER)
    private User reporter;
    @NotNull(message = "Set executor")
    @ManyToOne(fetch = FetchType.EAGER)
    private User executor;
    @NotNull(message = "Set issue status")
    @Enumerated(EnumType.STRING)
    private IssueStatus status;
    @NotNull(message = "Set issue type")
    @Enumerated(EnumType.STRING)
    private IssueType type;
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date creationDate = new Date();
    @DateTimeFormat(pattern = "dd.MM.yyyy")
    private Date closeDate;
    @OneToMany(targetEntity = Issue.class)
    @JoinColumn(name = "issue_id")
    private Set<Issue> subIssues;
    private boolean hasSubIssues;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "issue_id")
    private Issue superIssue;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id")
    private Project project;

    public Issue() {
    }

    public Issue(String name, String description, User reporter, User executor, IssueStatus status, IssueType type, Project project){
        this.name = name;
        this.description = description;
        this.reporter = reporter;
        this.executor = executor;
        this.status = status;
        this.type = type;
        this.project = project;
    }

    public Issue getSuperIssue() {
        return superIssue;
    }

    public void setSuperIssue(Issue superissue) {
        this.superIssue = superissue;
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

    public User getReporter() {
        return reporter;
    }

    public void setReporter(User reporter) {
        this.reporter = reporter;
    }

    public User getExecutor() {
        return executor;
    }

    public void setExecutor(User executor) {
        this.executor = executor;
    }

    public IssueStatus getStatus() {
        return status;
    }

    public void setStatus(IssueStatus status) {
        if (status == IssueStatus.CLOSE_ISSUE) {
            closeDate = new Date();
        }
        this.status = status;
    }

    public IssueType getType() {
        return type;
    }

    public void setType(IssueType type) {
        this.type = type;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getCloseDate() {
        return closeDate;
    }

    public Set<Issue> getSubIssues() {
        return subIssues;
    }

    public void setSubIssues(Set<Issue> subIssues) {
        this.subIssues = subIssues;
    }

    public boolean isHasSubIssues() {
        return hasSubIssues;
    }

    public void setHasSubIssues(boolean hasSubIssues) {
        this.hasSubIssues = hasSubIssues;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
}
