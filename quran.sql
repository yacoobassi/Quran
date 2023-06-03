-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2023 at 02:37 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quran`
--

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `num` int(10) NOT NULL,
  `instituteNum` int(10) NOT NULL,
  `regimentNum` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `institutes`
--

CREATE TABLE `institutes` (
  `num` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `regimentNum` int(10) NOT NULL,
  `teacherNum` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `regiment`
--

CREATE TABLE `regiment` (
  `num` int(10) NOT NULL,
  `instituteNum` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `regiment`
--

INSERT INTO `regiment` (`num`, `instituteNum`) VALUES
(1, 18),
(19, 1);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `num` varchar(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `instituteNum` int(10) NOT NULL,
  `reginmentNum` int(10) NOT NULL,
  `groupNum` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studentsdata`
--

CREATE TABLE `studentsdata` (
  `num` varchar(10) NOT NULL,
  `currentPart` varchar(20) NOT NULL,
  `mark` double NOT NULL,
  `nextExam` varchar(20) NOT NULL,
  `lastExamMark` varchar(20) NOT NULL,
  `grade` varchar(10) NOT NULL,
  `birth` varchar(20) NOT NULL,
  `fatherPhone` varchar(10) NOT NULL,
  `motherPhone` varchar(10) NOT NULL,
  `house` varchar(20) NOT NULL,
  `instituteName` varchar(20) NOT NULL,
  `instituteNum` int(10) NOT NULL,
  `finishedParts` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teacherdata`
--

CREATE TABLE `teacherdata` (
  `name` varchar(20) NOT NULL,
  `id` varchar(12) NOT NULL,
  `country` varchar(15) NOT NULL,
  `birth` varchar(15) NOT NULL,
  `social` varchar(10) NOT NULL,
  `currentJob` varchar(20) NOT NULL,
  `lastJob` varchar(20) NOT NULL,
  `study` varchar(20) NOT NULL,
  `university` varchar(20) NOT NULL,
  `certificate` varchar(20) NOT NULL,
  `tajoeedLevel` varchar(20) NOT NULL,
  `tajoeedYear` varchar(15) NOT NULL,
  `mosque` varchar(20) NOT NULL,
  `personTeachYou` varchar(20) NOT NULL,
  `region` varchar(20) NOT NULL,
  `Yourphone` varchar(10) NOT NULL,
  `housePhone` varchar(10) NOT NULL,
  `remark` varchar(100) NOT NULL,
  `num` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `num` int(10) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`num`,`instituteNum`,`regimentNum`),
  ADD KEY `instituteNum` (`instituteNum`),
  ADD KEY `regimentNum` (`regimentNum`);

--
-- Indexes for table `institutes`
--
ALTER TABLE `institutes`
  ADD PRIMARY KEY (`num`,`regimentNum`),
  ADD KEY `regimentNum` (`regimentNum`),
  ADD KEY `num` (`num`),
  ADD KEY `teacherNum` (`teacherNum`);

--
-- Indexes for table `regiment`
--
ALTER TABLE `regiment`
  ADD PRIMARY KEY (`num`,`instituteNum`),
  ADD KEY `num` (`num`),
  ADD KEY `instituteNum` (`instituteNum`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`num`),
  ADD KEY `groupNum` (`groupNum`),
  ADD KEY `instituteNum` (`instituteNum`),
  ADD KEY `reginmentNum` (`reginmentNum`);

--
-- Indexes for table `studentsdata`
--
ALTER TABLE `studentsdata`
  ADD PRIMARY KEY (`num`),
  ADD KEY `instituteNum` (`instituteNum`);

--
-- Indexes for table `teacherdata`
--
ALTER TABLE `teacherdata`
  ADD PRIMARY KEY (`num`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`num`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `group_ibfk_1` FOREIGN KEY (`instituteNum`) REFERENCES `institutes` (`num`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_ibfk_2` FOREIGN KEY (`regimentNum`) REFERENCES `institutes` (`regimentNum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `institutes`
--
ALTER TABLE `institutes`
  ADD CONSTRAINT `institutes_ibfk_1` FOREIGN KEY (`regimentNum`) REFERENCES `regiment` (`num`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `institutes_ibfk_2` FOREIGN KEY (`num`) REFERENCES `regiment` (`instituteNum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`groupNum`) REFERENCES `group` (`num`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_ibfk_2` FOREIGN KEY (`instituteNum`) REFERENCES `group` (`instituteNum`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `student_ibfk_3` FOREIGN KEY (`reginmentNum`) REFERENCES `group` (`regimentNum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `studentsdata`
--
ALTER TABLE `studentsdata`
  ADD CONSTRAINT `studentsdata_ibfk_2` FOREIGN KEY (`instituteNum`) REFERENCES `institutes` (`num`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `studentsdata_ibfk_3` FOREIGN KEY (`num`) REFERENCES `student` (`num`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacherdata`
--
ALTER TABLE `teacherdata`
  ADD CONSTRAINT `teacherdata_ibfk_1` FOREIGN KEY (`num`) REFERENCES `teachers` (`num`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`num`) REFERENCES `institutes` (`teacherNum`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
