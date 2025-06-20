CREATE DATABASE IF NOT EXISTS complaint_management_system;
USE complaint_management_system;

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(100),
                       email VARCHAR(100) UNIQUE,
                       password VARCHAR(255),
                       role ENUM('employee', 'admin') NOT NULL
);

CREATE TABLE complaints (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            user_id INT,
                            subject VARCHAR(255),
                            description TEXT,
                            status ENUM('Pending', 'In Progress', 'Resolved') DEFAULT 'Pending',
                            remarks TEXT,
                            date_submitted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (user_id) REFERENCES users(id)
);