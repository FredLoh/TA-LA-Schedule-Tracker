-- phpMyAdmin SQL Dump
-- version 4.0.10.10
-- http://www.phpmyadmin.net
--
-- Host: 127.8.111.2:3306
-- Generation Time: Nov 29, 2015 at 05:46 PM
-- Server version: 5.5.45
-- PHP Version: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `myfirstphpapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `Classes`
--

CREATE TABLE IF NOT EXISTS `Classes` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `Classname` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `Classes`
--

INSERT INTO `Classes` (`ID`, `Classname`) VALUES
(1, 'CSCI 1300: Computer Science 1: Starting Computing'),
(2, 'CSCI 1310: Computer Science 1: Starting Computing - Experienced'),
(3, 'CSCI 1320: Computer Science 1: Starting Computing - Engineering Applications'),
(4, 'CSCI 2270: Computer Science 2: Data Structures'),
(5, 'CSCI 2400: Computer Systems'),
(6, 'CSCI 3104: Algorithms'),
(7, 'CSCI 3155: Principles of Programming Languages'),
(8, 'CSCI 3308: Software Development Methods and Tools'),
(9, 'CSCI 3753: Operating Systems');

-- --------------------------------------------------------

--
-- Table structure for table `Sessions`
--

CREATE TABLE IF NOT EXISTS `Sessions` (
  `ID` int(1) NOT NULL AUTO_INCREMENT,
  `TAID` int(1) NOT NULL,
  `ClassID` int(1) NOT NULL,
  `Day` varchar(10) NOT NULL,
  `Time` varchar(100) NOT NULL,
  `Location` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `Sessions`
--

INSERT INTO `Sessions` (`ID`, `TAID`, `ClassID`, `Day`, `Time`, `Location`) VALUES
(1, 4, 4, 'M,F', '11:00 AM - 1:00 PM', 'ECCS 112'),
(2, 4, 5, 'M,F', '11:00 AM - 1:00 PM', 'ECCS 112'),
(3, 4, 6, 'M,F', '11:00 AM - 1:00 PM', 'ECCS 112'),
(4, 4, 7, 'M,F', '11:00 AM - 1:00 PM', 'ECCS 112'),
(5, 4, 8, 'M,F', '11:00 AM - 1:00 PM', 'ECCS 112'),
(6, 4, 9, 'M,F', '11:00 AM - 1:00 PM', 'ECCS 112'),
(7, 4, 4, 'Tu', '10:00 AM - 11:00 AM', 'ECCS 112'),
(8, 4, 5, 'Tu', '10:00 AM - 11:00 AM', 'ECCS 112'),
(9, 4, 6, 'Tu', '10:00 AM - 11:00 AM', 'ECCS 112'),
(10, 4, 7, 'Tu', '10:00 AM - 11:00 AM', 'ECCS 112'),
(11, 4, 8, 'Tu', '10:00 AM - 11:00 AM', 'ECCS 112'),
(12, 4, 9, 'Tu', '10:00 AM - 11:00 AM', 'ECCS 112'),
(13, 3, 4, 'M,Th', '1:00 PM - 3:00 PM', 'ECCS 112'),
(14, 3, 5, 'M,Th', '1:00 PM - 3:00 PM', 'ECCS 112'),
(15, 3, 6, 'M,Th', '1:00 PM - 3:00 PM', 'ECCS 112'),
(16, 3, 7, 'M,Th', '1:00 PM - 3:00 PM', 'ECCS 112'),
(17, 3, 8, 'M,Th', '1:00 PM - 3:00 PM', 'ECCS 112'),
(18, 3, 9, 'M,Th', '1:00 PM - 3:00 PM', 'ECCS 112'),
(19, 3, 4, 'W', '11:30 AM - 5:00 PM', 'ECCS 112'),
(20, 3, 5, 'W', '11:30 AM - 5:00 PM', 'ECCS 112'),
(21, 3, 6, 'W', '11:30 AM - 5:00 PM', 'ECCS 112'),
(22, 3, 7, 'W', '11:30 AM - 5:00 PM', 'ECCS 112'),
(23, 3, 8, 'W', '11:30 AM - 5:00 PM', 'ECCS 112'),
(24, 3, 9, 'W', '11:30 AM - 5:00 PM', 'ECCS 112'),
(25, 1, 4, 'M', '3:00 PM - 5:00 PM', 'ECCS 112'),
(26, 1, 5, 'M', '3:00 PM - 5:00 PM', 'ECCS 112'),
(27, 1, 6, 'M', '3:00 PM - 5:00 PM', 'ECCS 112'),
(28, 1, 7, 'M', '3:00 PM - 5:00 PM', 'ECCS 112'),
(29, 1, 8, 'M', '3:00 PM - 5:00 PM', 'ECCS 112'),
(30, 1, 9, 'M', '3:00 PM - 5:00 PM', 'ECCS 112'),
(31, 1, 4, 'Tu,Th', '11:00 AM - 2:00 PM', 'ECCS 112'),
(32, 1, 5, 'Tu,Th', '11:00 AM - 2:00 PM', 'ECCS 112'),
(33, 1, 6, 'Tu,Th', '11:00 AM - 2:00 PM', 'ECCS 112'),
(34, 1, 7, 'Tu,Th', '11:00 AM - 2:00 PM', 'ECCS 112'),
(35, 1, 8, 'Tu,Th', '11:00 AM - 2:00 PM', 'ECCS 112'),
(36, 1, 9, 'Tu,Th', '11:00 AM - 2:00 PM', 'ECCS 112'),
(37, 1, 4, 'F', '3:00 PM - 4:30 PM', 'ECCS 112'),
(38, 1, 5, 'F', '3:00 PM - 4:30 PM', 'ECCS 112'),
(39, 1, 6, 'F', '3:00 PM - 4:30 PM', 'ECCS 112'),
(40, 1, 7, 'F', '3:00 PM - 4:30 PM', 'ECCS 112'),
(41, 1, 8, 'F', '3:00 PM - 4:30 PM', 'ECCS 112'),
(42, 1, 9, 'F', '3:00 PM - 4:30 PM', 'ECCS 112'),
(43, 2, 4, 'Tu,Th', '2:00 PM - 3:00 PM', 'ECCS 112'),
(44, 2, 5, 'Tu,Th', '2:00 PM - 3:00 PM', 'ECCS 112'),
(45, 2, 6, 'Tu,Th', '2:00 PM - 3:00 PM', 'ECCS 112'),
(46, 2, 7, 'Tu,Th', '2:00 PM - 3:00 PM', 'ECCS 112'),
(47, 2, 8, 'Tu,Th', '2:00 PM - 3:00 PM', 'ECCS 112'),
(48, 2, 9, 'Tu,Th', '2:00 PM - 3:00 PM', 'ECCS 112'),
(49, 2, 4, 'Tu', '5:00 PM - 7:00 PM', 'ECCS 112'),
(50, 2, 5, 'Tu', '5:00 PM - 7:00 PM', 'ECCS 112'),
(51, 2, 6, 'Tu', '5:00 PM - 7:00 PM', 'ECCS 112'),
(52, 2, 7, 'Tu', '5:00 PM - 7:00 PM', 'ECCS 112'),
(53, 2, 8, 'Tu', '5:00 PM - 7:00 PM', 'ECCS 112'),
(54, 2, 9, 'Tu', '5:00 PM - 7:00 PM', 'ECCS 112'),
(55, 2, 4, 'W', '10:00 AM - 11:00 AM', 'ECCS 112'),
(56, 2, 5, 'W', '10:00 AM - 11:00 AM', 'ECCS 112'),
(57, 2, 6, 'W', '10:00 AM - 11:00 AM', 'ECCS 112'),
(58, 2, 7, 'W', '10:00 AM - 11:00 AM', 'ECCS 112'),
(59, 2, 8, 'W', '10:00 AM - 11:00 AM', 'ECCS 112'),
(60, 2, 9, 'W', '10:00 AM - 11:00 AM', 'ECCS 112');

-- --------------------------------------------------------

--
-- Table structure for table `TAs`
--

CREATE TABLE IF NOT EXISTS `TAs` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `TAs`
--

INSERT INTO `TAs` (`ID`, `Name`) VALUES
(1, 'Kade C'),
(2, 'Taylor A'),
(3, 'Sam H'),
(4, 'Brennan M'),
(5, 'Spencer W'),
(6, 'Sam Molnar'),
(7, 'Corin Sandford'),
(8, 'Erin'),
(9, 'Phil'),
(10, 'Jesus'),
(11, 'Phu Dang'),
(12, 'Nick'),
(13, 'Madhu'),
(14, 'Christine'),
(15, 'Jesus'),
(16, 'Amber'),
(17, 'Nathan'),
(18, 'Brooke'),
(19, 'Alex'),
(20, 'Lauren'),
(21, 'Sebastian'),
(22, 'Jason'),
(23, 'Shirly'),
(24, 'Ian');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
