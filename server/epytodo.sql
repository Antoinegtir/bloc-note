CREATE DATABASE epytodo;

USE epytodo;

CREATE TABLE user
(
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  firstname VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE TABLE todo
(
  id INT NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  description text NOT NULL,
  created_at datetime NOT NULL DEFAULT NOW(),
  due_time datetime NOT NULL,
  status varchar(255) NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (id)
);