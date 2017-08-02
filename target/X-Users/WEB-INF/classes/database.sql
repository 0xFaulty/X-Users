-- Table: users
CREATE TABLE users (
  id                   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username             VARCHAR(255) NOT NULL,
  password             VARCHAR(255) NOT NULL,
  firstname            VARCHAR(255) NOT NULL,
  lastname             VARCHAR(255) NOT NULL,
  email                VARCHAR(255) NOT NULL,
  active               TINYINT      NOT NULL,
  birthday             DATE         NOT NULL,
  createdTimestamp     TIMESTAMP    NOT NULL,
  lastUpdatedTimestamp TIMESTAMP    NOT NULL
)
  ENGINE = InnoDB;

-- Table: roles
CREATE TABLE roles (
  id   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
)
  ENGINE = InnoDB;

-- Table for mapping user and roles: user_roles
CREATE TABLE user_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (role_id) REFERENCES roles (id),

  UNIQUE (user_id, role_id)
)
  ENGINE = InnoDB;

-- Table: addresses
CREATE TABLE addresses (
  id       INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
  zip      INT          NOT NULL,
  country  VARCHAR(100) NOT NULL,
  city     VARCHAR(100) NOT NULL,
  district VARCHAR(100) NOT NULL,
  street   VARCHAR(100) NOT NULL
)
  ENGINE = InnoDB;

-- Table for mapping user and addresses: user_addresses
CREATE TABLE user_addresses (
  user_id    INT NOT NULL,
  address_id INT NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (address_id) REFERENCES addresses (id),

  UNIQUE (user_id, address_id)
)
  ENGINE = InnoDB;

-- Insert data

INSERT INTO users VALUES
  (1, 'guest',
   '$2a$11$uSXS6rLJ91WjgOHhEGDx..VGs7MkKZV68Lv5r1uwFu7HgtRn3dcXG',
   'Nameless',
   'Guest',
   '',
   1,
   '2012-12-13',
   '2012-12-13 14:54:30',
   '2012-12-13 14:54:30'
  );

INSERT INTO users VALUES
  (2, 'admin',
   '$2a$11$uSXS6rLJ91WjgOHhEGDx..VGs7MkKZV68Lv5r1uwFu7HgtRn3dcXG',
   'Scrooge',
   'McDuck',
   'admin@web.ru',
   1,
   '2012-12-12',
   '2012-12-12 14:54:30',
   '2012-12-12 14:54:30'
  );

INSERT INTO roles VALUES (1, 'ROLE_USER');
INSERT INTO roles VALUES (2, 'ROLE_ADMIN');

INSERT INTO user_roles VALUES (1, 1);
INSERT INTO user_roles VALUES (2, 2);

INSERT INTO addresses VALUES (1, 0, '', '', '', '');
INSERT INTO addresses VALUES (2, 188777, 'Russia', 'Saint Petersburg', 'Saint Petersburg', 'New Street');

INSERT INTO user_addresses VALUES (1, 1);
INSERT INTO user_addresses VALUES (2, 2);