DROP TABLE IF EXISTS member_role;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS team_category;
DROP TABLE IF EXISTS playing_position;

CREATE TABLE playing_position (
                                  position_id   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
                                  name          VARCHAR(50) NOT NULL,
                                  CONSTRAINT pk_playing_position PRIMARY KEY (position_id),
                                  CONSTRAINT uq_playing_position_name UNIQUE (name)
) ENGINE=InnoDB;

CREATE TABLE team_category (
                               category_id   SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
                               name          VARCHAR(50) NOT NULL,
                               CONSTRAINT pk_team_category PRIMARY KEY (category_id),
                               CONSTRAINT uq_team_category_name UNIQUE (name)
) ENGINE=InnoDB;

CREATE TABLE department (
                            department_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
                            name          VARCHAR(100) NOT NULL,
                            CONSTRAINT pk_department PRIMARY KEY (department_id),
                            CONSTRAINT uq_department_name UNIQUE (name)
) ENGINE=InnoDB;

-- Un rol pertenece a un departamento (ej. "Assistant Coach" en "U-12 Academy")
CREATE TABLE role (
                      role_id       INT UNSIGNED NOT NULL AUTO_INCREMENT,
                      role_name     VARCHAR(100) NOT NULL,
                      department_id SMALLINT UNSIGNED NOT NULL,
                      CONSTRAINT pk_role PRIMARY KEY (role_id),
                      CONSTRAINT uq_role_name_department UNIQUE (role_name, department_id),
                      CONSTRAINT fk_role_department FOREIGN KEY (department_id)
                          REFERENCES department (department_id)
                          ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Socios
-- ---------------------------------------------------------

CREATE TABLE member (
                        member_id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
                        first_name   VARCHAR(100) NOT NULL,
                        last_name    VARCHAR(150) NOT NULL,
                        birth_year   SMALLINT UNSIGNED NOT NULL,
                        join_date    DATE NOT NULL,
                        leave_date   DATE NULL,
                        position_id  SMALLINT UNSIGNED NULL,
                        category_id  SMALLINT UNSIGNED NULL,
                        CONSTRAINT pk_member PRIMARY KEY (member_id),
                        CONSTRAINT fk_member_position FOREIGN KEY (position_id)
                            REFERENCES playing_position (position_id)
                            ON UPDATE CASCADE ON DELETE SET NULL,
                        CONSTRAINT fk_member_category FOREIGN KEY (category_id)
                            REFERENCES team_category (category_id)
                            ON UPDATE CASCADE ON DELETE SET NULL,
                        CONSTRAINT ck_member_dates CHECK (leave_date IS NULL OR leave_date >= join_date),
                        CONSTRAINT ck_member_birth_year CHECK (birth_year BETWEEN 1900 AND 2100),
                        INDEX idx_member_name (last_name, first_name),
                        INDEX idx_member_category (category_id)
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Asignación de roles a socios (histórico)
-- ---------------------------------------------------------

CREATE TABLE member_role (
                             member_role_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                             member_id      INT UNSIGNED NOT NULL,
                             role_id        INT UNSIGNED NOT NULL,
                             start_date     DATE NOT NULL,
                             end_date       DATE NULL,
                             CONSTRAINT pk_member_role PRIMARY KEY (member_role_id),
                             CONSTRAINT uq_member_role_start UNIQUE (member_id, role_id, start_date),
                             CONSTRAINT fk_member_role_member FOREIGN KEY (member_id)
                                 REFERENCES member (member_id)
                                 ON UPDATE CASCADE ON DELETE CASCADE,
                             CONSTRAINT fk_member_role_role FOREIGN KEY (role_id)
                                 REFERENCES role (role_id)
                                 ON UPDATE CASCADE ON DELETE RESTRICT,
                             CONSTRAINT ck_member_role_dates CHECK (end_date IS NULL OR end_date >= start_date),
                             INDEX idx_member_role_role (role_id)
) ENGINE=InnoDB;