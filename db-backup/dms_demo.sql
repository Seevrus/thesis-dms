-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Sze 02. 23:01
-- Kiszolgáló verziója: 10.4.20-MariaDB
-- PHP verzió: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `dms_demo`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ceg`
--

DROP TABLE IF EXISTS `ceg`;
CREATE TABLE `ceg` (
  `cegkod` int(10) UNSIGNED NOT NULL,
  `cegnev` varchar(45) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- A tábla adatainak kiíratása `ceg`
--

INSERT INTO `ceg` (`cegkod`, `cegnev`) VALUES
(1, 'Balázs és Tsa Bt.'),
(2, 'Jónás Nyrt.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cegnel_dolgozik`
--

DROP TABLE IF EXISTS `cegnel_dolgozik`;
CREATE TABLE `cegnel_dolgozik` (
  `ceg_cegkod` int(10) UNSIGNED NOT NULL,
  `dolgozo_adoazonosito` int(10) UNSIGNED NOT NULL,
  `aktiv` tinyint(1) NOT NULL DEFAULT 1,
  `akt_admin` tinyint(1) NOT NULL DEFAULT 0,
  `user_admin` tinyint(1) NOT NULL DEFAULT 0,
  `creator` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- A tábla adatainak kiíratása `cegnel_dolgozik`
--

INSERT INTO `cegnel_dolgozik` (`ceg_cegkod`, `dolgozo_adoazonosito`, `aktiv`, `akt_admin`, `user_admin`, `creator`) VALUES
(1, 1002477194, 1, 0, 0, 0),
(1, 1315760217, 1, 0, 0, 1),
(1, 2316039994, 1, 0, 0, 0),
(1, 2656686847, 1, 0, 0, 0),
(1, 2909536725, 1, 0, 0, 0),
(1, 3635528484, 1, 0, 0, 0),
(2, 1234567890, 1, 0, 0, 0),
(2, 1315760217, 1, 1, 0, 1),
(2, 1443062569, 1, 0, 0, 0),
(2, 1567276835, 1, 0, 0, 0),
(2, 3672948044, 1, 0, 0, 0),
(2, 4283164402, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dokumentum`
--

DROP TABLE IF EXISTS `dokumentum`;
CREATE TABLE `dokumentum` (
  `azon` int(10) UNSIGNED NOT NULL,
  `ceg_cegkod` int(10) UNSIGNED NOT NULL,
  `dolgozo_adoazonosito` int(10) UNSIGNED NOT NULL,
  `dokumentum_nev` varchar(100) COLLATE latin2_hungarian_ci NOT NULL,
  `kategoria` int(10) UNSIGNED NOT NULL,
  `hozzaadva` datetime NOT NULL DEFAULT current_timestamp(),
  `lathato` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `ervenyes` datetime DEFAULT NULL,
  `letoltve` datetime DEFAULT NULL,
  `utvonal` varchar(250) COLLATE latin2_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- A tábla adatainak kiíratása `dokumentum`
--

INSERT INTO `dokumentum` (`azon`, `ceg_cegkod`, `dolgozo_adoazonosito`, `dokumentum_nev`, `kategoria`, `hozzaadva`, `lathato`, `ervenyes`, `letoltve`, `utvonal`) VALUES
(166, 1, 1002477194, 'Adatszerkezetek 01', 1, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_4K7dm9V9.pdf'),
(167, 1, 1002477194, 'Adatszerkezetek 02', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_Ww3zn6Y1.pdf'),
(168, 1, 1002477194, 'Adatszerkezetek 03', 1, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_0R4Di2qV.pdf'),
(169, 1, 1002477194, 'Adatszerkezetek 04', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_uXKH115c.pdf'),
(170, 1, 1002477194, 'Adatszerkezetek 05', 1, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_oSIeugUE.pdf'),
(171, 1, 1002477194, 'Adatszerkezetek 06', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_CRaGJAMC.pdf'),
(172, 1, 1002477194, 'Adatszerkezetek 07', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_89ek5nBH.pdf'),
(173, 1, 1002477194, 'Adatszerkezetek 08', 1, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_t2Zs11xN.pdf'),
(174, 1, 1002477194, 'Adatszerkezetek 09', 1, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_bguu4wDi.pdf'),
(175, 1, 1002477194, 'Adatszerkezetek 10', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_6wzgEFIE.pdf'),
(176, 1, 1002477194, 'Adatszerkezetek 11', 1, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_dQoJTMhc.pdf'),
(177, 1, 1002477194, 'Adatszerkezetek 12', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_8YhW8ghH.pdf'),
(178, 1, 1002477194, 'Adatszerkezetek 13', 2, '2021-09-02 20:14:30', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201430_XNeLd2ji.pdf'),
(179, 2, 1234567890, 'Adatszerkezetek 01', 1, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_0wYDL9cj.pdf'),
(180, 2, 1234567890, 'Adatszerkezetek 02', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_xKdab3Vm.pdf'),
(181, 2, 1234567890, 'Adatszerkezetek 03', 1, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_bOA6gs1z.pdf'),
(182, 2, 1234567890, 'Adatszerkezetek 04', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_RlRX42z8.pdf'),
(183, 2, 1234567890, 'Adatszerkezetek 05', 1, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_dSnenrRN.pdf'),
(184, 2, 1234567890, 'Adatszerkezetek 06', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_kX1WXjJs.pdf'),
(185, 2, 1234567890, 'Adatszerkezetek 07', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_562x6VAg.pdf'),
(186, 2, 1234567890, 'Adatszerkezetek 08', 1, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_jdkMH3sq.pdf'),
(187, 2, 1234567890, 'Adatszerkezetek 09', 1, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_qFgQNRpy.pdf'),
(188, 2, 1234567890, 'Adatszerkezetek 10', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_mQpKmqLE.pdf'),
(189, 2, 1234567890, 'Adatszerkezetek 11', 1, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_psFM02ov.pdf'),
(190, 2, 1234567890, 'Adatszerkezetek 12', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_ddl0aKI0.pdf'),
(191, 2, 1234567890, 'Adatszerkezetek 13', 2, '2021-09-02 20:16:03', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201603_AWiFTXGe.pdf'),
(192, 2, 1315760217, 'Adatszerkezetek 01', 1, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_cxoB7vJI.pdf'),
(193, 2, 1315760217, 'Adatszerkezetek 02', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_Gp3Opfs2.pdf'),
(194, 2, 1315760217, 'Adatszerkezetek 03', 1, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_iNU2L161.pdf'),
(195, 2, 1315760217, 'Adatszerkezetek 04', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_4MVnnSRh.pdf'),
(196, 2, 1315760217, 'Adatszerkezetek 05', 1, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_RMeLpQos.pdf'),
(197, 2, 1315760217, 'Adatszerkezetek 06', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_EYJo8AwK.pdf'),
(198, 1, 1315760217, 'Adatszerkezetek 07', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_kp9T2y23.pdf'),
(199, 1, 1315760217, 'Adatszerkezetek 08', 1, '2021-09-02 20:16:56', 0, NULL, '2021-09-02 22:48:40', NULL),
(200, 1, 1315760217, 'Adatszerkezetek 09', 1, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_4YPpxfHC.pdf'),
(201, 1, 1315760217, 'Adatszerkezetek 10', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_lHOcseP5.pdf'),
(202, 1, 1315760217, 'Adatszerkezetek 11', 1, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_v6rGjqhe.pdf'),
(203, 1, 1315760217, 'Adatszerkezetek 12', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_i46uMsyJ.pdf'),
(204, 1, 1315760217, 'Adatszerkezetek 13', 2, '2021-09-02 20:16:56', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201656_xM5NDKqP.pdf'),
(205, 2, 1443062569, 'Adatszerkezetek 01', 1, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_513xOLds.pdf'),
(206, 2, 1443062569, 'Adatszerkezetek 02', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_iKPey3sJ.pdf'),
(207, 2, 1443062569, 'Adatszerkezetek 03', 1, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_B8jt67PW.pdf'),
(208, 2, 1443062569, 'Adatszerkezetek 04', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_jUY5srNg.pdf'),
(209, 2, 1443062569, 'Adatszerkezetek 05', 1, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_dRJGI9tD.pdf'),
(210, 2, 1443062569, 'Adatszerkezetek 06', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_IAe5hufm.pdf'),
(211, 2, 1443062569, 'Adatszerkezetek 07', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_nxk1ZGhb.pdf'),
(212, 2, 1443062569, 'Adatszerkezetek 08', 1, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_4ITYjjeW.pdf'),
(213, 2, 1443062569, 'Adatszerkezetek 09', 1, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_V1dka0E4.pdf'),
(214, 2, 1443062569, 'Adatszerkezetek 10', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_3LDeJFX2.pdf'),
(215, 2, 1443062569, 'Adatszerkezetek 11', 1, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_Mw2xJhaS.pdf'),
(216, 2, 1443062569, 'Adatszerkezetek 12', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_yy9kZajV.pdf'),
(217, 2, 1443062569, 'Adatszerkezetek 13', 2, '2021-09-02 20:18:55', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201855_0yH58zEZ.pdf'),
(218, 2, 1567276835, 'Adatszerkezetek 01', 1, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_285ttNaU.pdf'),
(219, 2, 1567276835, 'Adatszerkezetek 02', 2, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_oJtNgBhQ.pdf'),
(220, 2, 1567276835, 'Adatszerkezetek 03', 1, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_HZeaHcKo.pdf'),
(221, 2, 1567276835, 'Adatszerkezetek 04', 2, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_ZFWrItmm.pdf'),
(222, 2, 1567276835, 'Adatszerkezetek 05', 1, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_1Oy1cn45.pdf'),
(223, 2, 1567276835, 'Adatszerkezetek 06', 2, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_d78GUIS9.pdf'),
(224, 2, 1567276835, 'Adatszerkezetek 07', 2, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_Aj4pIBWg.pdf'),
(225, 2, 1567276835, 'Adatszerkezetek 08', 1, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_T73XxLWk.pdf'),
(226, 2, 1567276835, 'Adatszerkezetek 09', 1, '2021-09-02 20:19:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_tofyM8IB.pdf'),
(227, 2, 1567276835, 'Adatszerkezetek 10', 2, '2021-09-02 20:19:25', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201924_YeuSfFY3.pdf'),
(228, 2, 1567276835, 'Adatszerkezetek 11', 1, '2021-09-02 20:19:25', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201925_Wb6BxhfG.pdf'),
(229, 2, 1567276835, 'Adatszerkezetek 12', 2, '2021-09-02 20:19:25', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201925_gbSHoinG.pdf'),
(230, 2, 1567276835, 'Adatszerkezetek 13', 2, '2021-09-02 20:19:25', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902201925_CssQVXf1.pdf'),
(231, 1, 2316039994, 'Adatszerkezetek 01', 1, '2021-09-02 20:20:14', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202014_MfP1sJdR.pdf'),
(232, 1, 2316039994, 'Adatszerkezetek 02', 2, '2021-09-02 20:20:14', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202014_pQjJqxvo.pdf'),
(233, 1, 2316039994, 'Adatszerkezetek 03', 1, '2021-09-02 20:20:14', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202014_8E6z0Yzn.pdf'),
(234, 1, 2316039994, 'Adatszerkezetek 04', 2, '2021-09-02 20:20:14', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202014_WUUImBqS.pdf'),
(235, 1, 2316039994, 'Adatszerkezetek 05', 1, '2021-09-02 20:20:14', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202014_fQ0aTEwX.pdf'),
(236, 1, 2316039994, 'Adatszerkezetek 06', 1, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202014_HT1NE8ob.pdf'),
(237, 1, 2316039994, 'Adatszerkezetek 07', 2, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_WCJSTPhF.pdf'),
(238, 1, 2316039994, 'Adatszerkezetek 08', 1, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_xkSPKUoG.pdf'),
(239, 1, 2316039994, 'Adatszerkezetek 09', 1, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_SM9IcIRH.pdf'),
(240, 1, 2316039994, 'Adatszerkezetek 10', 2, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_OpAi5zaJ.pdf'),
(241, 1, 2316039994, 'Adatszerkezetek 11', 1, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_n4j1EUYT.pdf'),
(242, 1, 2316039994, 'Adatszerkezetek 12', 2, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_NQaYUBPE.pdf'),
(243, 1, 2316039994, 'Adatszerkezetek 13', 2, '2021-09-02 20:20:15', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202015_izLRr2JI.pdf'),
(244, 1, 2656686847, 'Adatszerkezetek 01', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_zv18zxh2.pdf'),
(245, 1, 2656686847, 'Adatszerkezetek 02', 2, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_sWCkknrg.pdf'),
(246, 1, 2656686847, 'Adatszerkezetek 03', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_P1jbEExu.pdf'),
(247, 1, 2656686847, 'Adatszerkezetek 04', 2, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_NN8zETqo.pdf'),
(248, 1, 2656686847, 'Adatszerkezetek 05', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_FwPmXfbT.pdf'),
(249, 1, 2656686847, 'Adatszerkezetek 06', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_bfUKO5yP.pdf'),
(250, 1, 2656686847, 'Adatszerkezetek 07', 2, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_LJ5MplLN.pdf'),
(251, 1, 2656686847, 'Adatszerkezetek 08', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_PpFcsox9.pdf'),
(252, 1, 2656686847, 'Adatszerkezetek 09', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_HGNP1yZZ.pdf'),
(253, 1, 2656686847, 'Adatszerkezetek 10', 2, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_J0xdh4Cb.pdf'),
(254, 1, 2656686847, 'Adatszerkezetek 11', 1, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_foA59Rry.pdf'),
(255, 1, 2656686847, 'Adatszerkezetek 12', 2, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_64sOVHxB.pdf'),
(256, 1, 2656686847, 'Adatszerkezetek 13', 2, '2021-09-02 20:20:42', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202042_W9DIGpDZ.pdf'),
(257, 1, 2909536725, 'Adatszerkezetek 01', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_iQNvXxS6.pdf'),
(258, 1, 2909536725, 'Adatszerkezetek 02', 2, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_rjG6McBG.pdf'),
(259, 1, 2909536725, 'Adatszerkezetek 03', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_wG5LxsIi.pdf'),
(260, 1, 2909536725, 'Adatszerkezetek 04', 2, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_ruQvyDzP.pdf'),
(261, 1, 2909536725, 'Adatszerkezetek 05', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_uifcRHgc.pdf'),
(262, 1, 2909536725, 'Adatszerkezetek 06', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_FM4rcLPN.pdf'),
(263, 1, 2909536725, 'Adatszerkezetek 07', 2, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_4CtfYLq8.pdf'),
(264, 1, 2909536725, 'Adatszerkezetek 08', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_g3rKWpB9.pdf'),
(265, 1, 2909536725, 'Adatszerkezetek 09', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_SIFdpLQ0.pdf'),
(266, 1, 2909536725, 'Adatszerkezetek 10', 2, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_WJUEoTeQ.pdf'),
(267, 1, 2909536725, 'Adatszerkezetek 11', 1, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_WZXrWIQh.pdf'),
(268, 1, 2909536725, 'Adatszerkezetek 12', 2, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_Rd92cF62.pdf'),
(269, 1, 2909536725, 'Adatszerkezetek 13', 2, '2021-09-02 20:21:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202111_QT83H2oY.pdf'),
(270, 1, 3635528484, 'Adatszerkezetek 01', 1, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_QHFye99w.pdf'),
(271, 1, 3635528484, 'Adatszerkezetek 02', 2, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_PJuQuXFN.pdf'),
(272, 1, 3635528484, 'Adatszerkezetek 03', 1, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_F0xjlJNQ.pdf'),
(273, 1, 3635528484, 'Adatszerkezetek 04', 2, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_gKQ9Tti3.pdf'),
(274, 1, 3635528484, 'Adatszerkezetek 05', 1, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_rkN1dJ4g.pdf'),
(275, 1, 3635528484, 'Adatszerkezetek 06', 1, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_Xjik3U4f.pdf'),
(276, 1, 3635528484, 'Adatszerkezetek 07', 2, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_fVIMx77o.pdf'),
(277, 1, 3635528484, 'Adatszerkezetek 08', 1, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_jwNZeise.pdf'),
(278, 1, 3635528484, 'Adatszerkezetek 09', 1, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_gcYUym7u.pdf'),
(279, 1, 3635528484, 'Adatszerkezetek 10', 2, '2021-09-02 20:21:34', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202134_NyJAdNJO.pdf'),
(280, 1, 3635528484, 'Adatszerkezetek 11', 1, '2021-09-02 20:21:35', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202135_L3Y3ZKVR.pdf'),
(281, 1, 3635528484, 'Adatszerkezetek 12', 2, '2021-09-02 20:21:35', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202135_EVwxhAFV.pdf'),
(282, 1, 3635528484, 'Adatszerkezetek 13', 2, '2021-09-02 20:21:35', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202135_aSF1q1K7.pdf'),
(283, 2, 3672948044, 'Adatszerkezetek 01', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_uoXTWlxT.pdf'),
(284, 2, 3672948044, 'Adatszerkezetek 02', 2, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_NUQPhawV.pdf'),
(285, 2, 3672948044, 'Adatszerkezetek 03', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_vjsUHHbt.pdf'),
(286, 2, 3672948044, 'Adatszerkezetek 04', 2, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_KgC7rocC.pdf'),
(287, 2, 3672948044, 'Adatszerkezetek 05', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_mS4VZgVN.pdf'),
(288, 2, 3672948044, 'Adatszerkezetek 06', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_1g23UBME.pdf'),
(289, 2, 3672948044, 'Adatszerkezetek 07', 2, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_PoYT8IKN.pdf'),
(290, 2, 3672948044, 'Adatszerkezetek 08', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_m9td0qGc.pdf'),
(291, 2, 3672948044, 'Adatszerkezetek 09', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_lgdYkSeX.pdf'),
(292, 2, 3672948044, 'Adatszerkezetek 10', 2, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_8V0YrU8f.pdf'),
(293, 2, 3672948044, 'Adatszerkezetek 11', 1, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_1Fl4jvUu.pdf'),
(294, 2, 3672948044, 'Adatszerkezetek 12', 2, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_mjhXpk7R.pdf'),
(295, 2, 3672948044, 'Adatszerkezetek 13', 2, '2021-09-02 20:22:21', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202221_4VG95c7X.pdf'),
(296, 2, 4283164402, 'Adatszerkezetek 01', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_kH19NnGP.pdf'),
(297, 2, 4283164402, 'Adatszerkezetek 02', 2, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_BQrzZl8j.pdf'),
(298, 2, 4283164402, 'Adatszerkezetek 03', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_Rv725EI9.pdf'),
(299, 2, 4283164402, 'Adatszerkezetek 04', 2, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_lheC5yz2.pdf'),
(300, 2, 4283164402, 'Adatszerkezetek 05', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_K9HaofTZ.pdf'),
(301, 2, 4283164402, 'Adatszerkezetek 06', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_BpRmiqzH.pdf'),
(302, 2, 4283164402, 'Adatszerkezetek 07', 2, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_FYmK9COq.pdf'),
(303, 2, 4283164402, 'Adatszerkezetek 08', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_qedXZCzC.pdf'),
(304, 2, 4283164402, 'Adatszerkezetek 09', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_hg1WhEXU.pdf'),
(305, 2, 4283164402, 'Adatszerkezetek 10', 2, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_oBf2Z8G2.pdf'),
(306, 2, 4283164402, 'Adatszerkezetek 11', 1, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_Era7Jree.pdf'),
(307, 2, 4283164402, 'Adatszerkezetek 12', 2, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_tOPFbFRS.pdf'),
(308, 2, 4283164402, 'Adatszerkezetek 13', 2, '2021-09-02 20:22:48', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210902202248_DmWbLvIp.pdf');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dokumentum_feltoltokod`
--

DROP TABLE IF EXISTS `dokumentum_feltoltokod`;
CREATE TABLE `dokumentum_feltoltokod` (
  `dokumentum_azon` int(10) UNSIGNED NOT NULL,
  `feltoltokod` char(60) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dokumentum_kategoria`
--

DROP TABLE IF EXISTS `dokumentum_kategoria`;
CREATE TABLE `dokumentum_kategoria` (
  `azon` int(10) UNSIGNED NOT NULL,
  `kategoria_nev` varchar(250) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `dokumentum_kategoria`
--

INSERT INTO `dokumentum_kategoria` (`azon`, `kategoria_nev`) VALUES
(1, 'Bérjegyzék'),
(2, 'Tájékoztató');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dolgozo`
--

DROP TABLE IF EXISTS `dolgozo`;
CREATE TABLE `dolgozo` (
  `adoazonosito` int(10) UNSIGNED NOT NULL,
  `felhasznalo_statusz` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `nev` varchar(45) COLLATE latin2_hungarian_ci NOT NULL,
  `email` varchar(45) COLLATE latin2_hungarian_ci DEFAULT NULL,
  `email_statusz` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `jelszo` varchar(100) COLLATE latin2_hungarian_ci NOT NULL,
  `probalkozas` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `utolso_probalkozas` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- A tábla adatainak kiíratása `dolgozo`
--

INSERT INTO `dolgozo` (`adoazonosito`, `felhasznalo_statusz`, `nev`, `email`, `email_statusz`, `jelszo`, `probalkozas`, `utolso_probalkozas`) VALUES
(1002477194, 0, 'Példa Dolgozó3', NULL, 0, '$2y$10$A56yqTRZWAkX/LRtY4Rv9./EvRv9rRemkC2YAS8X4i0q1vPRZm2sq', 0, '2021-08-21 20:06:21'),
(1234567890, 1, 'Példa Dolgozó', 'tiller2004@gmail.com', 2, '$2y$10$oKPCgs20auDNcSe/cxpn4.dsV30OFp8o.Jm9031yZtyhMu9i.MpMK', 0, '2021-08-21 20:06:21'),
(1315760217, 1, 'Példa Dolgozó1', 'till.zoltan90@gmail.com', 2, '$2y$10$KKCcggSasmR3kCRaumaoqubiOSm.OKkTAGxWLBdSsfTdpNEysW9U6', 0, '2021-09-01 20:56:24'),
(1443062569, 1, 'Példa Dolgozó5', NULL, 0, '$2y$10$VqSPGO52dB6K2D8lipp1z.0TjVCIagFsIrVj.urB2TUGqx6PpTRD2', 0, '2021-08-21 20:06:21'),
(1567276835, 1, 'Példa Dolgozó2', NULL, 0, '$2y$10$AKbc8hbK1ElpFvUa1BehM.6I9kr/CY6IbJRUQFZ5L7DeufMWldHhW', 0, '2021-08-21 20:06:21'),
(2316039994, 1, 'Példa Dolgozó6', NULL, 0, '$2y$10$iBjVuUdwFSA8QAAEGa/ITeGfS8LCn/zHETab2nohUonjAde958JSu', 0, '2021-08-21 20:06:21'),
(2656686847, 1, 'Példa Dolgozó10', NULL, 0, '$2y$10$9YWTOAyXIpWreqaDQvYQqu6b.jcDaALxGIGWNYei2N2pL6iNmCnWe', 0, '2021-08-21 20:06:21'),
(2909536725, 1, 'Példa Dolgozó9', NULL, 0, '$2y$10$GYHmoLJ63yl6xamb/4REk.sKhB1Rg5QuK7vCSiQVVacD6X3QNW07m', 0, '2021-08-21 20:06:21'),
(3635528484, 1, 'Példa Dolgozó7', NULL, 0, '$2y$10$B0SesV.UTavivjkbi/ze6eY2ShbB31CZnZa25IDd043Kw31EbLMf.', 0, '2021-08-21 20:06:21'),
(3672948044, 1, 'Példa Dolgozó4', NULL, 0, '$2y$10$XB9Hm5PcK/YvxqYR8Ihf6esvam5RGuQ9RF4JfoM25sKISZFV6QZlO', 0, '2021-08-21 20:06:21'),
(4283164402, 1, 'Példa Dolgozó8', NULL, 0, '$2y$10$xkPgtlcN7FbVuxOQirLiUegAq7G3.Q4GOposoXVNQWWJ50nT0Z2UC', 0, '2021-08-21 20:06:21');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dolgozo_emailkod`
--

DROP TABLE IF EXISTS `dolgozo_emailkod`;
CREATE TABLE `dolgozo_emailkod` (
  `dolgozo_azon` int(10) UNSIGNED NOT NULL,
  `emailkod` varchar(100) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `ceg`
--
ALTER TABLE `ceg`
  ADD PRIMARY KEY (`cegkod`);

--
-- A tábla indexei `cegnel_dolgozik`
--
ALTER TABLE `cegnel_dolgozik`
  ADD PRIMARY KEY (`ceg_cegkod`,`dolgozo_adoazonosito`),
  ADD KEY `ceg_cegkod` (`ceg_cegkod`,`dolgozo_adoazonosito`),
  ADD KEY `cegnel_dolgozik_ibfk_3` (`dolgozo_adoazonosito`);

--
-- A tábla indexei `dokumentum`
--
ALTER TABLE `dokumentum`
  ADD PRIMARY KEY (`azon`),
  ADD KEY `felhasznalo_adoazonosito` (`dolgozo_adoazonosito`),
  ADD KEY `kategoria` (`kategoria`),
  ADD KEY `ceg_cegkod` (`ceg_cegkod`);

--
-- A tábla indexei `dokumentum_feltoltokod`
--
ALTER TABLE `dokumentum_feltoltokod`
  ADD KEY `dokumentum_azon` (`dokumentum_azon`);

--
-- A tábla indexei `dokumentum_kategoria`
--
ALTER TABLE `dokumentum_kategoria`
  ADD PRIMARY KEY (`azon`);

--
-- A tábla indexei `dolgozo`
--
ALTER TABLE `dolgozo`
  ADD PRIMARY KEY (`adoazonosito`);

--
-- A tábla indexei `dolgozo_emailkod`
--
ALTER TABLE `dolgozo_emailkod`
  ADD PRIMARY KEY (`dolgozo_azon`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `dokumentum`
--
ALTER TABLE `dokumentum`
  MODIFY `azon` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=309;

--
-- AUTO_INCREMENT a táblához `dokumentum_kategoria`
--
ALTER TABLE `dokumentum_kategoria`
  MODIFY `azon` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `cegnel_dolgozik`
--
ALTER TABLE `cegnel_dolgozik`
  ADD CONSTRAINT `cegnel_dolgozik_ibfk_2` FOREIGN KEY (`ceg_cegkod`) REFERENCES `ceg` (`cegkod`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cegnel_dolgozik_ibfk_3` FOREIGN KEY (`dolgozo_adoazonosito`) REFERENCES `dolgozo` (`adoazonosito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `dokumentum`
--
ALTER TABLE `dokumentum`
  ADD CONSTRAINT `dokumentum_ibfk_1` FOREIGN KEY (`dolgozo_adoazonosito`) REFERENCES `dolgozo` (`adoazonosito`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dokumentum_ibfk_2` FOREIGN KEY (`kategoria`) REFERENCES `dokumentum_kategoria` (`azon`),
  ADD CONSTRAINT `dokumentum_ibfk_3` FOREIGN KEY (`ceg_cegkod`) REFERENCES `ceg` (`cegkod`);

--
-- Megkötések a táblához `dokumentum_feltoltokod`
--
ALTER TABLE `dokumentum_feltoltokod`
  ADD CONSTRAINT `dokumentum_feltoltokod_ibfk_1` FOREIGN KEY (`dokumentum_azon`) REFERENCES `dokumentum` (`azon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `dolgozo_emailkod`
--
ALTER TABLE `dolgozo_emailkod`
  ADD CONSTRAINT `dolgozo_emailkod_ibfk_1` FOREIGN KEY (`dolgozo_azon`) REFERENCES `dolgozo` (`adoazonosito`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
