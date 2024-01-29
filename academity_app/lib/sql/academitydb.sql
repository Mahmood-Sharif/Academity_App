-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 29, 2024 at 03:18 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `academitydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `academies`
--

CREATE TABLE `academies` (
  `academy_id` int(50) NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` int(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `owner_id` int(50) NOT NULL,
  `sports_id` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `academies`
--

INSERT INTO `academies` (`academy_id`, `location`, `name`, `phone`, `description`, `image_url`, `owner_id`, `sports_id`) VALUES
(1, 'Los Angeles', 'Sports Excellence Academy', 555, 'Training champions in various sports disciplines', 'Academity_App/Academity/images/Academy.jpg', 3, 13),
(2, 'Barcelona', 'Barca Soccer Academy', 333, 'Developing future soccer stars with Barca style', 'Academity_App/Academity/images/Academy.jpg', 3, 13),
(3, 'Melbourne', 'Grand Slam Tennis Center', 777, 'Unleashing the potential of tennis enthusiasts', 'Academity_App/Academity/images/Academy.jpg', 3, 15),
(4, 'Los Angeles', 'Sports Excellence Academy', 101010, 'Training champions in various sports disciplines', 'Academity_App/Academity/images/Academy.jpg', 3, 13);

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `class_id` int(50) NOT NULL,
  `class_name` varchar(50) DEFAULT NULL,
  `day_of_week` varchar(50) DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `instructor` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `min_age` int(5) NOT NULL,
  `max_age` int(5) NOT NULL,
  `academy_id` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `class_name`, `day_of_week`, `end_time`, `instructor`, `price`, `start_time`, `min_age`, `max_age`, `academy_id`) VALUES
(1, 'Male U8', 'Sunday, Tuesday', '06:00:00', 'John Doe', 40.00, '04:30:00', 3, 8, 1),
(2, 'Male U12', 'Monday, Wednesday', '05:30:00', 'John Joe', 100.00, '04:00:00', 9, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `coaches`
--

CREATE TABLE `coaches` (
  `coach_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

CREATE TABLE `owners` (
  `owner_id` int(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `academy_id` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `owners`
--

INSERT INTO `owners` (`owner_id`, `email`, `name`, `password`, `academy_id`) VALUES
(3, 'a', 'a', '1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sports`
--

CREATE TABLE `sports` (
  `sports_id` int(50) NOT NULL,
  `sport_name` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sports`
--

INSERT INTO `sports` (`sports_id`, `sport_name`, `image_url`) VALUES
(13, 'Football', 'Academity_App/Academity/images/Football.jpg'),
(14, 'Basketball', 'Academity_App/Academity/images/Basketball.jpg'),
(15, 'Tennis', 'Academity_App/Academity/images/Tennis.jpg'),
(16, 'Fencing', 'Academity_App/Academity/images/Fencing.jpg'),
(17, 'Taekwondo', 'Academity_App/Academity/images/Taekwondo.jpg'),
(18, 'Boxing', 'Academity_App/Academity/images/Boxing.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `studentenrollments`
--

CREATE TABLE `studentenrollments` (
  `enrollment_id` int(50) NOT NULL,
  `enrollment_end` date DEFAULT NULL,
  `enrollment_start` date DEFAULT NULL,
  `fees` decimal(10,2) DEFAULT NULL,
  `student_id` int(50) DEFAULT NULL,
  `class_id` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(50) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `emergency_contact` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `medical_condition` text DEFAULT NULL,
  `phone` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(50) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `age`, `email`, `password`, `first_name`, `last_name`) VALUES
(1, 16, 'm', '1', 'Mahmood', 'Fareed');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academies`
--
ALTER TABLE `academies`
  ADD PRIMARY KEY (`academy_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `sports_id` (`sports_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `academy_id` (`academy_id`);

--
-- Indexes for table `coaches`
--
ALTER TABLE `coaches`
  ADD PRIMARY KEY (`coach_id`);

--
-- Indexes for table `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`owner_id`),
  ADD KEY `academy_id` (`academy_id`);

--
-- Indexes for table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`sports_id`) USING BTREE;

--
-- Indexes for table `studentenrollments`
--
ALTER TABLE `studentenrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academies`
--
ALTER TABLE `academies`
  MODIFY `academy_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `coaches`
--
ALTER TABLE `coaches`
  MODIFY `coach_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `owners`
--
ALTER TABLE `owners`
  MODIFY `owner_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `sports_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `studentenrollments`
--
ALTER TABLE `studentenrollments`
  MODIFY `enrollment_id` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `academies`
--
ALTER TABLE `academies`
  ADD CONSTRAINT `academies_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`);

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`academy_id`) REFERENCES `academies` (`academy_id`);

--
-- Constraints for table `owners`
--
ALTER TABLE `owners`
  ADD CONSTRAINT `owners_ibfk_1` FOREIGN KEY (`academy_id`) REFERENCES `academies` (`academy_id`);

--
-- Constraints for table `studentenrollments`
--
ALTER TABLE `studentenrollments`
  ADD CONSTRAINT `studentenrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `studentenrollments_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
