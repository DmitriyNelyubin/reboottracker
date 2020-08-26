create sequence hibernate_sequence start 1 increment 1;

create table issue (
    id int8 not null,
    close_date timestamp,
    creation_date timestamp,
    description varchar(255),
    has_sub_issues boolean not null,
    name varchar(255),
    status varchar(255) not null,
    type varchar(255) not null,
    executor_id int8 not null,
    project_id int8,
    reporter_id int8 not null,
    sub_issues_id int8,
    sprint_id int8,
    issue_id int8,
    primary key (id)
);

create table project (
    id int8 not null,
    active boolean not null,
    department varchar(255),
    description varchar(255),
    name varchar(255),
    admin_id int8,
    manager_id int8,
    primary key (id)
);

create table project_backlog (
    project_id int8 not null,
    backlog_id int8 not null
);

create table project_developers (
    project_id int8 not null,
    developers_id int8 not null
);

create table sprint (
    id int8 not null,
    description varchar(255),
    finish_date timestamp not null,
    name varchar(255),
    start_date timestamp not null,
    project_id int8,
    primary key (id)
);

create table user_role (
    user_id int8 not null,
    roles varchar(255)
);

create table usr (
    id int8 not null,
    activation_code varchar(255),
    active boolean not null,
    email varchar(255),
    password varchar(255),
    username varchar(255),
    primary key (id)
);

alter table if exists project_backlog
    add constraint uk_backlog_id
    unique (backlog_id);

alter table if exists issue
    add constraint issue_executor_fk
    foreign key (executor_id)
    references usr;

alter table if exists issue
    add constraint issue_project_fk
    foreign key (project_id)
    references project;

alter table if exists issue
    add constraint issue_reporter_fk
    foreign key (reporter_id)
    references usr;

alter table if exists issue
    add constraint issue_sub_issue_fk
    foreign key (sub_issues_id)
    references issue;

alter table if exists issue
    add constraint issue_sprint_fk
    foreign key (sprint_id)
    references sprint;

alter table if exists issue
    add constraint issue_super_issue_fk
    foreign key (issue_id)
    references issue;

alter table if exists project
    add constraint project_admin_fk
    foreign key (admin_id)
    references usr;

alter table if exists project
    add constraint project_manager_fk
    foreign key (manager_id)
    references usr;

alter table if exists project_backlog
    add constraint backlog_issue_fk
    foreign key (backlog_id)
    references issue;

alter table if exists project_backlog
    add constraint backlog_project_fk
    foreign key (project_id)
    references project;

alter table if exists project_developers
    add constraint developers_user_fk
    foreign key (developers_id)
    references usr;

alter table if exists project_developers
    add constraint developers_project_fk
    foreign key (project_id)
    references project;

alter table if exists sprint
    add constraint sprint_project_fk
    foreign key (project_id)
    references project;

alter table if exists user_role
    add constraint user_role_user_fk
    foreign key (user_id)
    references usr;