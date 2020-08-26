insert into usr (id, username, password, active)
    values (2, 'manager', 'pass', true);

insert into user_role (user_id, roles)
    values (2, 'USER'), (2, 'ADMIN'), (2, 'MANAGER')