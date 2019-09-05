-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2017 at 12:29 AM
-- Server version: 10.1.26-MariaDB
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `burgersbydesign`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `AddressID` varchar(20) NOT NULL,
  `street` varchar(30) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zip` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `allergens`
--

CREATE TABLE `allergens` (
  `allergenName` varchar(35) NOT NULL,
  `percentAffected` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `burgers`
--

CREATE TABLE `burgers` (
  `OrderNum` int(6) NOT NULL,
  `total` double(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryName` varchar(30) NOT NULL,
  `onlyOne` varchar(10) DEFAULT NULL,
  `isRequired` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `contains`
--

CREATE TABLE `contains` (
  `doesOrMay` int(5) NOT NULL,
  `itemName` varchar(35) NOT NULL,
  `AllergenName` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `lname` varchar(20) DEFAULT NULL,
  `fname` varchar(20) DEFAULT NULL,
  `phoneNum` int(10) NOT NULL,
  `birthYear` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `itemName` varchar(30) NOT NULL,
  `cost` double(2,2) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `is_in`
--

CREATE TABLE `is_in` (
  `itemName` varchar(30) DEFAULT NULL,
  `categoryName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lives_at`
--

CREATE TABLE `lives_at` (
  `PhoneNum` int(10) NOT NULL,
  `AddressID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `made_of`
--

CREATE TABLE `made_of` (
  `OrderNumMade` int(6) NOT NULL,
  `itemName` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `time` int(4) NOT NULL,
  `OrderNum` int(6) NOT NULL,
  `phoneNum` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`AddressID`);

--
-- Indexes for table `allergens`
--
ALTER TABLE `allergens`
  ADD PRIMARY KEY (`allergenName`);

--
-- Indexes for table `burgers`
--
ALTER TABLE `burgers`
  ADD PRIMARY KEY (`OrderNum`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryName`);

--
-- Indexes for table `contains`
--
ALTER TABLE `contains`
  ADD PRIMARY KEY (`itemName`),
  ADD KEY `AllergenName` (`AllergenName`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`phoneNum`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`itemName`);

--
-- Indexes for table `is_in`
--
ALTER TABLE `is_in`
  ADD KEY `itemName` (`itemName`),
  ADD KEY `categoryName` (`categoryName`);

--
-- Indexes for table `lives_at`
--
ALTER TABLE `lives_at`
  ADD PRIMARY KEY (`PhoneNum`,`AddressID`),
  ADD KEY `AddressID` (`AddressID`);

--
-- Indexes for table `made_of`
--
ALTER TABLE `made_of`
  ADD KEY `made_of_ibfk_1` (`OrderNumMade`),
  ADD KEY `made_of_ibfk_2` (`itemName`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderNum`),
  ADD KEY `phoneNum` (`phoneNum`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allergens`
--
ALTER TABLE `allergens`
  ADD CONSTRAINT `allergens_ibfk_1` FOREIGN KEY (`allergenName`) REFERENCES `ingredients` (`itemName`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `burgers`
--
ALTER TABLE `burgers`
  ADD CONSTRAINT `burgers_ibfk_1` FOREIGN KEY (`OrderNum`) REFERENCES `orders` (`OrderNum`);

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`categoryName`) REFERENCES `is_in` (`categoryName`);

--
-- Constraints for table `contains`
--
ALTER TABLE `contains`
  ADD CONSTRAINT `contains_ibfk_1` FOREIGN KEY (`itemName`) REFERENCES `ingredients` (`itemName`),
  ADD CONSTRAINT `contains_ibfk_2` FOREIGN KEY (`AllergenName`) REFERENCES `allergens` (`allergenName`);

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`itemName`) REFERENCES `contains` (`itemName`);

--
-- Constraints for table `is_in`
--
ALTER TABLE `is_in`
  ADD CONSTRAINT `is_in_ibfk_1` FOREIGN KEY (`itemName`) REFERENCES `ingredients` (`itemName`),
  ADD CONSTRAINT `is_in_ibfk_2` FOREIGN KEY (`categoryName`) REFERENCES `category` (`categoryName`);

--
-- Constraints for table `lives_at`
--
ALTER TABLE `lives_at`
  ADD CONSTRAINT `lives_at_ibfk_1` FOREIGN KEY (`PhoneNum`) REFERENCES `customers` (`phoneNum`),
  ADD CONSTRAINT `lives_at_ibfk_2` FOREIGN KEY (`AddressID`) REFERENCES `addresses` (`AddressID`);

--
-- Constraints for table `made_of`
--
ALTER TABLE `made_of`
  ADD CONSTRAINT `made_of_ibfk_1` FOREIGN KEY (`OrderNumMade`) REFERENCES `burgers` (`OrderNum`),
  ADD CONSTRAINT `made_of_ibfk_2` FOREIGN KEY (`itemName`) REFERENCES `ingredients` (`itemName`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`OrderNum`) REFERENCES `burgers` (`OrderNum`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`phoneNum`) REFERENCES `customers` (`phoneNum`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
