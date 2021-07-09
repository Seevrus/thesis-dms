-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2021 at 05:10 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dms_demo`
--
CREATE DATABASE IF NOT EXISTS `dms_demo` DEFAULT CHARACTER SET latin2 COLLATE latin2_hungarian_ci;
USE `dms_demo`;

-- --------------------------------------------------------

--
-- Table structure for table `ceg`
--

DROP TABLE IF EXISTS `ceg`;
CREATE TABLE `ceg` (
  `cegkod` int(10) UNSIGNED NOT NULL,
  `cegnev` varchar(45) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- Dumping data for table `ceg`
--

INSERT INTO `ceg` (`cegkod`, `cegnev`) VALUES
(100, 'Szentistváni Mezőgazdasági Zrt.');

-- --------------------------------------------------------

--
-- Table structure for table `cegnel_dolgozik`
--

DROP TABLE IF EXISTS `cegnel_dolgozik`;
CREATE TABLE `cegnel_dolgozik` (
  `ceg_cegkod` int(10) UNSIGNED NOT NULL,
  `dolgozo_adoazonosito` int(10) UNSIGNED NOT NULL,
  `aktiv` tinyint(1) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dokumentum`
--

DROP TABLE IF EXISTS `dokumentum`;
CREATE TABLE `dokumentum` (
  `azon` int(10) UNSIGNED NOT NULL,
  `dolgozo_adoazonosito` int(10) UNSIGNED NOT NULL,
  `dokumentum_nev` varchar(100) COLLATE latin2_hungarian_ci NOT NULL,
  `hozzaadva` datetime NOT NULL DEFAULT current_timestamp(),
  `ervenyes` datetime DEFAULT NULL,
  `adat` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dolgozo`
--

DROP TABLE IF EXISTS `dolgozo`;
CREATE TABLE `dolgozo` (
  `adoazonosito` int(10) UNSIGNED NOT NULL,
  `felhasznalo_statusz` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `nev` varchar(45) COLLATE latin2_hungarian_ci NOT NULL,
  `email` varchar(45) COLLATE latin2_hungarian_ci DEFAULT NULL,
  `email_statusz` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `jelszo` varchar(100) COLLATE latin2_hungarian_ci NOT NULL,
  `email_kod` varchar(100) COLLATE latin2_hungarian_ci DEFAULT NULL,
  `probalkozas` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `utolso_probalkozas` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- Dumping data for table `dolgozo`
--

INSERT INTO `dolgozo` (`adoazonosito`, `felhasznalo_statusz`, `nev`, `email`, `email_statusz`, `jelszo`, `email_kod`, `probalkozas`, `utolso_probalkozas`) VALUES
(1002477194, 0, 'Példa Dolgozó3', NULL, 0, '$2y$10$A56yqTRZWAkX/LRtY4Rv9./EvRv9rRemkC2YAS8X4i0q1vPRZm2sq', NULL, 0, '2021-07-09 11:30:24'),
(1234567890, 1, 'Példa Dolgozó', 'tiller2004@gmail.com', 2, '$2y$10$oKPCgs20auDNcSe/cxpn4.dsV30OFp8o.Jm9031yZtyhMu9i.MpMK', NULL, 0, '2021-07-09 09:53:32'),
(1315760217, 1, 'Példa Dolgozó1', NULL, 0, '$2y$10$woxJnR97l2uqYWlxvzjm2uqil8ZGypPM4oTlwtrvxpCVYCVMpDcKi', NULL, 0, '2021-07-09 13:16:12'),
(1443062569, 1, 'Példa Dolgozó5', NULL, 0, '$2y$10$VqSPGO52dB6K2D8lipp1z.0TjVCIagFsIrVj.urB2TUGqx6PpTRD2', NULL, 0, '2021-07-09 10:53:32'),
(1567276835, 1, 'Példa Dolgozó2', NULL, 0, '$2y$10$AKbc8hbK1ElpFvUa1BehM.6I9kr/CY6IbJRUQFZ5L7DeufMWldHhW', NULL, 0, '2021-07-09 10:53:32'),
(2316039994, 1, 'Példa Dolgozó6', NULL, 0, '$2y$10$iBjVuUdwFSA8QAAEGa/ITeGfS8LCn/zHETab2nohUonjAde958JSu', NULL, 0, '2021-07-09 10:53:32'),
(2656686847, 1, 'Példa Dolgozó10', NULL, 0, '$2y$10$9YWTOAyXIpWreqaDQvYQqu6b.jcDaALxGIGWNYei2N2pL6iNmCnWe', NULL, 0, '2021-07-09 10:53:32'),
(2909536725, 1, 'Példa Dolgozó9', NULL, 0, '$2y$10$GYHmoLJ63yl6xamb/4REk.sKhB1Rg5QuK7vCSiQVVacD6X3QNW07m', NULL, 0, '2021-07-09 10:53:32'),
(3635528484, 1, 'Példa Dolgozó7', NULL, 0, '$2y$10$B0SesV.UTavivjkbi/ze6eY2ShbB31CZnZa25IDd043Kw31EbLMf.', NULL, 0, '2021-07-09 10:53:32'),
(3672948044, 1, 'Példa Dolgozó4', NULL, 0, '$2y$10$XB9Hm5PcK/YvxqYR8Ihf6esvam5RGuQ9RF4JfoM25sKISZFV6QZlO', NULL, 0, '2021-07-09 10:53:32'),
(4283164402, 1, 'Példa Dolgozó8', NULL, 0, '$2y$10$xkPgtlcN7FbVuxOQirLiUegAq7G3.Q4GOposoXVNQWWJ50nT0Z2UC', NULL, 0, '2021-07-09 10:53:32');

-- --------------------------------------------------------

--
-- Table structure for table `dolgozo_dokumentumot`
--

DROP TABLE IF EXISTS `dolgozo_dokumentumot`;
CREATE TABLE `dolgozo_dokumentumot` (
  `azon` int(10) UNSIGNED NOT NULL,
  `dolgozo_adoazonosito` int(10) UNSIGNED NOT NULL,
  `dokumentum_azon` int(10) UNSIGNED NOT NULL,
  `mikor` datetime NOT NULL DEFAULT current_timestamp(),
  `mit_csinalt` varchar(10) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ceg`
--
ALTER TABLE `ceg`
  ADD PRIMARY KEY (`cegkod`);

--
-- Indexes for table `cegnel_dolgozik`
--
ALTER TABLE `cegnel_dolgozik`
  ADD PRIMARY KEY (`ceg_cegkod`,`dolgozo_adoazonosito`),
  ADD KEY `ceg_cegkod` (`ceg_cegkod`,`dolgozo_adoazonosito`),
  ADD KEY `cegnel_dolgozik_ibfk_3` (`dolgozo_adoazonosito`);

--
-- Indexes for table `dokumentum`
--
ALTER TABLE `dokumentum`
  ADD PRIMARY KEY (`azon`),
  ADD KEY `felhasznalo_adoazonosito` (`dolgozo_adoazonosito`);

--
-- Indexes for table `dolgozo`
--
ALTER TABLE `dolgozo`
  ADD PRIMARY KEY (`adoazonosito`);

--
-- Indexes for table `dolgozo_dokumentumot`
--
ALTER TABLE `dolgozo_dokumentumot`
  ADD PRIMARY KEY (`azon`),
  ADD KEY `dolgozo_adoazonosito` (`dolgozo_adoazonosito`,`dokumentum_azon`),
  ADD KEY `dokumentum_azon` (`dokumentum_azon`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dokumentum`
--
ALTER TABLE `dokumentum`
  MODIFY `azon` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dolgozo_dokumentumot`
--
ALTER TABLE `dolgozo_dokumentumot`
  MODIFY `azon` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cegnel_dolgozik`
--
ALTER TABLE `cegnel_dolgozik`
  ADD CONSTRAINT `cegnel_dolgozik_ibfk_2` FOREIGN KEY (`ceg_cegkod`) REFERENCES `ceg` (`cegkod`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cegnel_dolgozik_ibfk_3` FOREIGN KEY (`dolgozo_adoazonosito`) REFERENCES `dolgozo` (`adoazonosito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dokumentum`
--
ALTER TABLE `dokumentum`
  ADD CONSTRAINT `dokumentum_ibfk_1` FOREIGN KEY (`dolgozo_adoazonosito`) REFERENCES `dolgozo` (`adoazonosito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dolgozo_dokumentumot`
--
ALTER TABLE `dolgozo_dokumentumot`
  ADD CONSTRAINT `dolgozo_dokumentumot_ibfk_1` FOREIGN KEY (`dolgozo_adoazonosito`) REFERENCES `dolgozo` (`adoazonosito`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dolgozo_dokumentumot_ibfk_2` FOREIGN KEY (`dokumentum_azon`) REFERENCES `dokumentum` (`azon`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
