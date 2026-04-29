DROP DATABASE IF EXISTS `edugreen`;
CREATE DATABASE `edugreen`;
USE `edugreen`;


DROP TABLE IF EXISTS `user`;    
CREATE TABLE `user`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `lastname` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `role`enum('admin','teacher','student') NOT NULL DEFAULT 'student',
    `points` INT NOT NULL DEFAULT 0,
    `password` VARCHAR(255) NOT NULL,
    `old_password` VARCHAR(255),
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `tutor_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`tutor_id`) REFERENCES `user`(`id`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `challenge`;
CREATE TABLE `challenge`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `image` BLOB,
    `class_id` INT NOT NULL,
    `reward` INT NOT NULL,
    `opened_at` DATETIME NOT NULL,
    `closed_at` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`class_id`) REFERENCES `class`(`id`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `enrollment`;
CREATE TABLE `enrollment`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `student_id` INT NOT NULL,
    `challenge_id` INT NOT NULL,
    `status` ENUM('pending','completed','failed') NOT NULL DEFAULT 'pending',
    `enrolled_at` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_enrollment_student_challenge` (`student_id`, `challenge_id`),
    FOREIGN KEY (`student_id`) REFERENCES `user`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`challenge_id`) REFERENCES `challenge`(`id`) ON DELETE CASCADE
);


INSERT INTO `user` (`name`, `lastname`, `email`, `role`, `points`, `password`, `old_password`) VALUES
('Laura', 'Gomez', 'laura.gomez@example.com', 'admin', 100, 'pass123', NULL),
('Pedro', 'Lopez', 'pedro.lopez@example.com', 'teacher', 50, 'pass456', NULL),
('Maria', 'Hernandez', 'maria.hernandez@example.com', 'student', 20, 'pass789', NULL),
('Carlos', 'Martinez', 'carlos.martinez@example.com', 'student', 10, 'pass321', NULL),
('Lucia', 'Ramirez', 'lucia.ramirez@example.com', 'student', 30, 'pass654', NULL);


INSERT INTO `class` (`name`, `description`, `tutor_id`) VALUES
('Green Warriors', 'Environmental awareness and eco-friendly actions', 2),
('Nature Protectors', 'Learn how to protect forests and wildlife', 2),
('Recycle Masters', 'Master the art of recycling and waste reduction', 2),
('Water Guardians', 'Water care and pollution prevention', 2),
('Eco Innovators', 'Innovation and sustainability challenges', 2);

INSERT INTO `challenge` (`title`, `description`, `image`, `class_id`, `reward`, `opened_at`, `closed_at`) VALUES
('Recycle 10 bottles', 'Collect and recycle 10 plastic bottles', NULL, 1, 20, '2025-01-01 09:00:00', '2025-01-10 18:00:00'),
('Plant a tree', 'Plant a tree in your community', NULL, 2, 30, '2025-02-01 09:00:00', '2025-02-15 18:00:00'),
('Reduce water use', 'Track and reduce water usage for 1 week', NULL, 3, 25, '2025-03-01 09:00:00', '2025-03-10 18:00:00'),
('Create eco poster', 'Design a poster promoting recycling', NULL, 4, 15, '2025-04-01 09:00:00', '2025-04-07 18:00:00'),
('No plastic week', 'Go 7 days without using plastic products', NULL, 5, 40, '2025-05-01 09:00:00', '2025-05-20 18:00:00');

INSERT INTO `enrollment` (`student_id`, `challenge_id`, `status`, `enrolled_at`) VALUES
(3, 1, 'pending', '2025-01-02 10:00:00'),
(4, 1, 'completed', '2025-01-02 14:00:00'),
(5, 2, 'pending', '2025-02-02 11:30:00'),
(3, 3, 'failed', '2025-03-02 08:45:00'),
(4, 5, 'completed', '2025-05-03 09:20:00');
