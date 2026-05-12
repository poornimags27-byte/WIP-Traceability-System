-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2026 at 08:11 AM
-- Server version: 10.6.7-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wiptrace_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `acitm`
--

CREATE TABLE `acitm` (
  `nacitmid` int(11) NOT NULL COMMENT 'ID',
  `nacitlock` int(11) NOT NULL COMMENT 'User Lock',
  `dacitstamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Time Stamp',
  `cacitpgm` varchar(50) NOT NULL COMMENT 'Program File',
  `cacitmcd` varchar(20) NOT NULL COMMENT 'Item Code',
  `cacitmnm` varchar(50) NOT NULL COMMENT 'Item Name'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `acitm`
--

INSERT INTO `acitm` (`nacitmid`, `nacitlock`, `dacitstamp`, `cacitpgm`, `cacitmcd`, `cacitmnm`) VALUES
(1, 0, '2026-05-11 05:35:14', '', 'item1 ', 'Aircraft Windscreen Sensors	'),
(2, 0, '2026-05-11 05:35:39', '', 'item2 ', 'Smart Thermostats'),
(3, 0, '2026-05-11 05:35:58', '', 'item3', 'Temperature Compensation Sensor');

-- --------------------------------------------------------

--
-- Table structure for table `acsto`
--

CREATE TABLE `acsto` (
  `nacstoid` int(11) NOT NULL COMMENT 'ID',
  `nacstlock` int(11) NOT NULL COMMENT 'User Lock',
  `dacststamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Time Stamp',
  `cacstpgm` varchar(50) NOT NULL COMMENT 'Program File',
  `cacstbarcd` varchar(20) NOT NULL COMMENT 'Barcode',
  `cacstgrnno` varchar(20) NOT NULL COMMENT 'GRN No',
  `nacstitmid` int(11) NOT NULL COMMENT 'Item ID',
  `nacstqty` int(11) NOT NULL COMMENT 'Quatity'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `acsto`
--

INSERT INTO `acsto` (`nacstoid`, `nacstlock`, `dacststamp`, `cacstpgm`, `cacstbarcd`, `cacstgrnno`, `nacstitmid`, `nacstqty`) VALUES
(1, 0, '2026-05-11 05:49:08', '', 'B1233456', 'grnno', 1, 7),
(2, 0, '2026-05-11 05:55:06', 'store.php -11/5/26', 'B987765', 'grnno1', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `acwip`
--

CREATE TABLE `acwip` (
  `nacwipid` int(11) NOT NULL COMMENT 'ID',
  `nacwilock` int(11) NOT NULL COMMENT 'User Lock',
  `dacwistamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Time Stamp',
  `cacwipgm` int(11) NOT NULL COMMENT 'Program File',
  `nacwiitmid` int(11) NOT NULL COMMENT 'Item ID',
  `cacwiitmcd` varchar(20) NOT NULL COMMENT 'Item Code',
  `cacwistat` char(1) NOT NULL COMMENT 'Status'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `acwtr`
--

CREATE TABLE `acwtr` (
  `nacwtrid` int(11) NOT NULL COMMENT 'ID',
  `nacwtlock` int(11) NOT NULL COMMENT 'User Lock',
  `dacwtstamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Time Stamp',
  `cacwtpgm` varchar(50) NOT NULL COMMENT 'Program File',
  `nacwtwipid` int(11) NOT NULL COMMENT 'WIP ID',
  `nacwtitmid` int(11) NOT NULL COMMENT 'Item ID',
  `cacwtbarcd` varchar(50) NOT NULL COMMENT 'Barcode',
  `cacwtgrnno` varchar(50) NOT NULL COMMENT 'GRN No',
  `nacwtnqty` int(11) NOT NULL COMMENT 'Number of quantity',
  `nacwtiqty` int(11) NOT NULL COMMENT 'Issue Quantity'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acitm`
--
ALTER TABLE `acitm`
  ADD PRIMARY KEY (`nacitmid`);

--
-- Indexes for table `acsto`
--
ALTER TABLE `acsto`
  ADD PRIMARY KEY (`nacstoid`);

--
-- Indexes for table `acwip`
--
ALTER TABLE `acwip`
  ADD PRIMARY KEY (`nacwipid`);

--
-- Indexes for table `acwtr`
--
ALTER TABLE `acwtr`
  ADD PRIMARY KEY (`nacwtrid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `acitm`
--
ALTER TABLE `acitm`
  MODIFY `nacitmid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `acsto`
--
ALTER TABLE `acsto`
  MODIFY `nacstoid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `acwip`
--
ALTER TABLE `acwip`
  MODIFY `nacwipid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- AUTO_INCREMENT for table `acwtr`
--
ALTER TABLE `acwtr`
  MODIFY `nacwtrid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
