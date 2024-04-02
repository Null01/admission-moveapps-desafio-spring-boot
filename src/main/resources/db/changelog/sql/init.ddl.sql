-- liquibase formatted sql

-- changeset andresduran0205:create_auth_schema.0.1 context: dev
CREATE SCHEMA IF NOT EXISTS `auth`;

-- changeset andresduran0205:create_core_schema.0.1 context: dev
CREATE SCHEMA IF NOT EXISTS `core`;

-- changeset andresduran0205:create_table_user.0.1 context: dev
CREATE TABLE IF NOT EXISTS `auth`.`user`
(
    id         UUID                  DEFAULT RANDOM_UUID() PRIMARY KEY,
    firstname  VARCHAR(255) NOT NULL,
    lastname   VARCHAR(255) NOT NULL,
    phone      INTEGER      NOT NULL,
    enable     BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- changeset andresduran0205:create_table_auth_user.0.1 context: dev
CREATE TABLE IF NOT EXISTS `auth`.`auth_user`
(
    id       UUID DEFAULT RANDOM_UUID() PRIMARY KEY,
    user_id  UUID         NOT NULL,
    email    VARCHAR(255) NOT NULL,
    password TEXT         NOT NULL,
    CONSTRAINT auth_user_pkey PRIMARY KEY (id),
    CONSTRAINT user_fkey FOREIGN KEY (user_id) REFERENCES `auth`.`user` (id),
    CONSTRAINT unique_email UNIQUE (email)
);

-- changeset andresduran0205:create_table_status_task.0.1 context: dev
CREATE TABLE IF NOT EXISTS `core`.`status_task`
(
    id     INTEGER AUTO_INCREMENT PRIMARY KEY,
    name   VARCHAR(255) NOT NULL,
    enable BOOLEAN      NOT NULL DEFAULT TRUE
);

-- changeset andresduran0205:create_table_task.0.1 context: dev
CREATE TABLE IF NOT EXISTS `core`.`task`
(
    id          UUID                  DEFAULT RANDOM_UUID() PRIMARY KEY,
    state_id    INTEGER      NOT NULL,
    title       VARCHAR(255) NOT NULL,
    description TEXT         NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT status_task_fkey FOREIGN KEY (state_id) REFERENCES `core`.`status_task` (id)
);