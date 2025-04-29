-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 01, 2025 at 06:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `safalyatra`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_tokens`
--

CREATE TABLE `access_tokens` (
  `token_id` int(100) NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` int(100) DEFAULT NULL,
  `driver_id` int(100) DEFAULT NULL,
  `admin_id` int(100) DEFAULT NULL,
  `operator_id` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `access_tokens`
--

INSERT INTO `access_tokens` (`token_id`, `token`, `user_id`, `driver_id`, `admin_id`, `operator_id`) VALUES
(1, 'c978b7d03e3c80a1a8c2e8535f58b7a3', NULL, NULL, 1, NULL),
(2, 'cb9fd6cd8c30c2b60e8d1abf74fac109', NULL, NULL, 1, NULL),
(3, 'e0103e368aced3f189edb2f7956b4858', NULL, NULL, NULL, 1),
(4, '37b8dc9e37fffbddf6f3a054b29eb3f8', NULL, NULL, 1, NULL),
(5, '34bc6311e9172b23270a998ba34b821d', NULL, NULL, NULL, 1),
(6, '23d0d20bb2fb0731b8d96e16607c4dbe', 1, NULL, NULL, NULL),
(7, 'f84befd052917cb2710aa5242d3de6ab', NULL, NULL, NULL, 1),
(8, '34ef781df7ebfb2f57c1097a9798acd1', 1, NULL, NULL, NULL),
(9, '2f563e27ead7e05763b6a7d1fc741f8f', NULL, NULL, NULL, 2),
(10, '1b32955b5dc48eab16ed0b3d1fa31007', NULL, NULL, 1, NULL),
(11, '4467b04c2c2908c2e01c6f0f380f397f', NULL, NULL, NULL, 2),
(12, 'faaa911b23c4b675403a9ca6eb426a3c', NULL, NULL, 1, NULL),
(13, 'd8065b6d55ddf1d76e926d0bdc99a19d', NULL, NULL, NULL, 2),
(14, '122e00e6b165bcadf4c01e3aa8266f78', 1, NULL, NULL, NULL),
(15, '2f74caa945a0367ee83273231b253238', 1, NULL, NULL, NULL),
(16, '6eec0154d901e217bf33890995dee767', NULL, NULL, NULL, 1),
(17, '65e040f5d187d14ab495e7737654a321', NULL, NULL, 1, NULL),
(18, '6052980ccbee1b0389895b2b5a343d44', 1, NULL, NULL, NULL),
(19, '991fdea203c33e23a936d518652d5496', NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(100) NOT NULL,
  `admin_name` varchar(35) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `otp` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_name`, `phone_number`, `email`, `password`, `image_url`, `otp`, `created_at`, `status`) VALUES
(1, 'Safal Rana', '9823467895', 'magarsafal16@gmail.com', '$2y$10$YuzNaC9RfUcfdRSRaXD3wegNdtPfnEZmDHpJVzhNaBvAgPe/pgdSK', 'images/67d035d6d4a20.webp', '', '2025-03-10 16:12:29', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `car_id` int(100) NOT NULL,
  `driver_id` int(100) DEFAULT NULL,
  `package_id` int(100) DEFAULT NULL,
  `booking_date` datetime NOT NULL DEFAULT current_timestamp(),
  `location` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `car_id` int(100) NOT NULL,
  `operator_id` int(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `category_id` int(100) NOT NULL,
  `license_plate` varchar(20) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `seating_capacity` int(11) NOT NULL,
  `fuel_type` varchar(50) NOT NULL,
  `luggage_capacity` int(100) NOT NULL,
  `number_of_doors` int(100) NOT NULL,
  `rate_per_hours` decimal(10,2) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp(),
  `rating` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`car_id`, `operator_id`, `name`, `category_id`, `license_plate`, `image_url`, `seating_capacity`, `fuel_type`, `luggage_capacity`, `number_of_doors`, `rate_per_hours`, `added_date`, `rating`) VALUES
(1, 1, 'Audi', 3, 'BA 2351', 'images/67e63ca0deacd.jpg', 2, 'Petrol', 4, 2, 12.00, '2025-03-28 11:52:28', 0),
(2, 1, 'BMW X5', 1, 'BA 6190', 'images/67e689f378bc4.jpg', 4, 'Diesel', 7, 4, 20.00, '2025-03-28 17:22:23', 0),
(3, 1, 'Nissan Altima', 2, 'BA 7190', 'images/67e68ba3c64dd.png', 4, 'Diesel', 8, 4, 34.00, '2025-03-28 17:29:35', 0),
(4, 2, 'Tata Winger', 4, 'GA 0857', 'images/67e6993f26239.jpg', 6, 'Diesel', 4, 4, 22.00, '2025-03-28 18:27:39', 0);

-- --------------------------------------------------------

--
-- Table structure for table `car_operators`
--

CREATE TABLE `car_operators` (
  `operator_id` int(100) NOT NULL,
  `admin_id` int(100) DEFAULT NULL,
  `operator_name` varchar(35) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `registration_number` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `otp` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `location` varchar(255) NOT NULL,
  `signup_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '\r\n',
  `added_date` datetime NOT NULL DEFAULT current_timestamp(),
  `activation_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car_operators`
--

INSERT INTO `car_operators` (`operator_id`, `admin_id`, `operator_name`, `phone_number`, `registration_number`, `email`, `password`, `image_url`, `otp`, `status`, `location`, `signup_time`, `added_date`, `activation_code`) VALUES
(1, 1, 'Swift Drive', '9817189947', '144847316', 'magarsafal61@gmail.com', '$2y$10$sBPAidfZkUCjkvftH1yE2.2fginYZ7SFYHgBvyacUAycVX4CE/8mq', NULL, '', 'Verified', 'Pokhara', '2025-03-28 06:06:44', '2025-03-28 11:44:12', 'up3oi5j24a'),
(2, 1, 'Byte Soft', '9817189947', '110373907', 'bytesoftnepal@gmail.com', '$2y$10$4ERB.nemiQ1AL.iWW49JnODtddcWKuF61sVfZjcdVwN2h3MHKNx7S', NULL, '', 'Verified', 'Kathmandu', '2025-03-28 12:29:09', '2025-03-28 18:11:26', 'ya7wue2fjx');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(100) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp(),
  `isDeleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `added_date`, `isDeleted`) VALUES
(1, 'SUV', '2025-03-18 11:21:22', 0),
(2, 'Sedan', '2025-03-20 11:21:35', 0),
(3, 'Sport', '2025-03-28 11:27:19', 0),
(4, 'Van', '2025-03-28 18:23:42', 0);

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `driver_id` int(100) NOT NULL,
  `operator_id` int(100) NOT NULL,
  `driver_name` varchar(35) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `license_number` varchar(30) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(15) NOT NULL,
  `age` int(11) NOT NULL,
  `experience` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Available',
  `otp` varchar(20) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`driver_id`, `operator_id`, `driver_name`, `phone_number`, `license_number`, `image_url`, `email`, `password`, `gender`, `age`, `experience`, `status`, `otp`, `added_date`) VALUES
(1, 1, 'Ram Krishna', '9840000000', '01-07-00382491', NULL, 'ramkrishna@gmail.com', '$2y$10$xgYN6TFdx83phcVgUbsAqulkw4seJ9bs9x.sZ/Ic.Dz43GoWYocN6', 'Male', 25, 8, 'Available', '', '2025-03-28 11:54:36'),
(2, 1, 'Mohit Gurung', '9889898989', '01-07-62892013', NULL, 'mohit@outlook.com', '$2y$10$P1ZPoSIJdOfIU3AtG8DxGeLpZZwh97rKaa7pDfg4taIlP27kg2cny', 'Male', 30, 7, 'Available', '', '2025-03-28 17:24:00'),
(3, 1, 'Namrata gurung', '0610000000', '01-07-62892726', NULL, 'namrata@gmail.com', '$2y$10$jDoxG5/.MreSuYgRGDNHXeaHooDjZQceby0jQhoqpYKFYuQiKF2SG', 'Female', 25, 3, 'Available', '', '2025-03-28 17:25:46'),
(4, 2, 'Hemanta Gurung', '9836363636', '01-07-8272828', NULL, 'hemanta@gmail.com', '$2y$10$wuEULIhvcIIhXXxnrY3gNuAmW2Y/ypmf6PZrn3p.4NUBo9tbYK6Wa', 'Male', 40, 12, 'Available', '', '2025-03-28 18:15:37'),
(5, 2, 'Biwash Gurung', '9836364328', '02-4567-204847', NULL, 'biwash@gmail.com', '$2y$10$.EsctnNwwhBM.pK2VJnXs.F.Q2vYuKLiXUWG8F31/6gRQEO3Xof1O', 'Male', 45, 12, 'Available', '', '2025-03-28 18:21:35');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(100) NOT NULL,
  `booking_id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `payment_mode` varchar(15) NOT NULL DEFAULT 'khalti',
  `other_details` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `rating_id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `car_id` int(100) NOT NULL,
  `rating` int(11) NOT NULL,
  `comments` varchar(500) NOT NULL,
  `submitted_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tour_packages`
--

CREATE TABLE `tour_packages` (
  `package_id` int(100) NOT NULL,
  `operator_id` int(100) NOT NULL,
  `package_name` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` varchar(11) NOT NULL,
  `car_id` int(100) NOT NULL,
  `driver_id` int(100) NOT NULL,
  `start_location` varchar(150) NOT NULL,
  `destination` varchar(150) NOT NULL,
  `tour_capacity` int(100) NOT NULL,
  `available_capacity` int(100) NOT NULL,
  `image_url` varchar(150) DEFAULT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tour_packages`
--

INSERT INTO `tour_packages` (`package_id`, `operator_id`, `package_name`, `description`, `price`, `duration`, `start_date`, `end_date`, `status`, `car_id`, `driver_id`, `start_location`, `destination`, `tour_capacity`, `available_capacity`, `image_url`, `added_date`) VALUES
(1, 1, 'Muktinath', 'Muktinath is a famous temple dedicated to Lord Vishnu and is holy to both Hindus and Buddhists. Mustang is known more for its adventure and cultural tourism, Muktinath attracts religious tourists. Muktinath Temple is in Mustang, Nepal, near the Thorong La mountain pass. It is 3,710 meters (12,172 feet) above sea level, making it one of the highest temples in the world. It is close to the village of Ranipauwa. It is also a key destination for trekkers on the Annapurna Circuit and offers unique at', 18.00, 4, '2025-04-17 00:00:00', '2025-04-20 00:00:00', '', 2, 2, 'Pokhara ', 'Upper Mustang', 4, 4, 'images/67e69469e9555.jpg', '2025-03-28 18:07:01'),
(2, 1, 'Ghandruk ', 'Ghandruk is a picturesque village in the Annapurna region of Nepal, known for its stunning mountain views and rich Gurung culture. It is a popular destination for both trekkers and cultural tourists. Situated at an altitude of approximately 2,012 meters (6,601 feet), Ghandruk offers breathtaking views of Annapurna South, Hiunchuli, and Machhapuchhre. The village is an important stop on the Annapurna Base Camp and Ghorepani Poon Hill trekking routes. Visitors can explore traditional Gurung houses', 6.00, 6, '2025-04-17 00:00:00', '2025-04-22 00:00:00', '', 1, 1, 'Pokhara ', 'Ghandruk ', 2, 2, 'images/67e694af3bbb7.webp', '2025-03-28 18:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(100) NOT NULL,
  `full_name` varchar(35) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `gender` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(50) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `otp` varchar(20) NOT NULL,
  `signup_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(20) NOT NULL,
  `added_date` datetime NOT NULL DEFAULT current_timestamp(),
  `activation_code` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `phone_number`, `gender`, `address`, `image_url`, `otp`, `signup_time`, `status`, `added_date`, `activation_code`) VALUES
(1, 'Safal Rana', 'magarsafal16@gmail.com', '$2y$10$wn9TccbMjlZqBAwH80MZh.fCrqkJ2wlYPUEsH978aVfSN3q9ekx22', '9817189947', 'Male', 'Pokhara - 10', 'images/67e69bb2cedc6.jpg', '', '2025-03-28 12:53:06', 'active', '2025-03-28 11:34:37', 'y07pgrjvhq');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access_tokens`
--
ALTER TABLE `access_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `operator_id` (`operator_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `car_id` (`car_id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `package_id` (`package_id`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`car_id`),
  ADD KEY `operator_id` (`operator_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `car_operators`
--
ALTER TABLE `car_operators`
  ADD PRIMARY KEY (`operator_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`driver_id`),
  ADD KEY `operator_id` (`operator_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `car_id` (`car_id`);

--
-- Indexes for table `tour_packages`
--
ALTER TABLE `tour_packages`
  ADD PRIMARY KEY (`package_id`),
  ADD KEY `operator_id` (`operator_id`),
  ADD KEY `car_id` (`car_id`),
  ADD KEY `driver_id` (`driver_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `access_tokens`
--
ALTER TABLE `access_tokens`
  MODIFY `token_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `car_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `car_operators`
--
ALTER TABLE `car_operators`
  MODIFY `operator_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `driver_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `rating_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tour_packages`
--
ALTER TABLE `tour_packages`
  MODIFY `package_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `access_tokens`
--
ALTER TABLE `access_tokens`
  ADD CONSTRAINT `access_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `access_tokens_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`),
  ADD CONSTRAINT `access_tokens_ibfk_3` FOREIGN KEY (`operator_id`) REFERENCES `car_operators` (`operator_id`),
  ADD CONSTRAINT `access_tokens_ibfk_4` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`);

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`),
  ADD CONSTRAINT `bookings_ibfk_4` FOREIGN KEY (`package_id`) REFERENCES `tour_packages` (`package_id`);

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `car_operators` (`operator_id`),
  ADD CONSTRAINT `cars_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `car_operators`
--
ALTER TABLE `car_operators`
  ADD CONSTRAINT `car_operators_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`);

--
-- Constraints for table `drivers`
--
ALTER TABLE `drivers`
  ADD CONSTRAINT `drivers_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `car_operators` (`operator_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`);

--
-- Constraints for table `tour_packages`
--
ALTER TABLE `tour_packages`
  ADD CONSTRAINT `tour_packages_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `car_operators` (`operator_id`),
  ADD CONSTRAINT `tour_packages_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`),
  ADD CONSTRAINT `tour_packages_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
