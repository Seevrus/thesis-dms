-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Nov 28. 22:09
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
-- Tábla szerkezet ehhez a táblához `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_id` bigint(10) UNSIGNED NOT NULL,
  `company_name` varchar(45) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `company`
--

INSERT INTO `company` (`company_id`, `company_name`) VALUES
(1, 'Balázs és Tsa Bt.'),
(2, 'Jónás Nyrt.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `document`
--

DROP TABLE IF EXISTS `document`;
CREATE TABLE `document` (
  `document_id` bigint(10) UNSIGNED NOT NULL,
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `document_name` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `category_id` bigint(10) UNSIGNED NOT NULL,
  `document_added` datetime NOT NULL DEFAULT current_timestamp(),
  `document_visible` smallint(1) UNSIGNED NOT NULL DEFAULT 1,
  `document_valid` datetime DEFAULT NULL,
  `document_downloaded` datetime DEFAULT NULL,
  `document_path` varchar(250) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `document`
--

INSERT INTO `document` (`document_id`, `user_tax_number`, `document_name`, `category_id`, `document_added`, `document_visible`, `document_valid`, `document_downloaded`, `document_path`) VALUES
(1, 8994312129, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-03 05:09:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_15QGzOZj.pdf'),
(2, 8994312129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-25 17:30:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_ur6wTyjD.pdf'),
(3, 8994312129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-07 09:03:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_Uq7OChGJ.pdf'),
(4, 8994312129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_qFPYtSx2.pdf'),
(5, 8275722602, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-15 17:53:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_ZTKPV8OI.pdf'),
(6, 8275722602, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-09 21:13:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_WqKwu8Rl.pdf'),
(7, 8275722602, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-06 22:20:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_CMM6PlJS.pdf'),
(8, 8309873253, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-08 15:39:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_fzm1Gk1y.pdf'),
(9, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-09 09:43:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_YQmsSj8u.pdf'),
(10, 8309873253, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-08 02:16:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210458_DMKYJqdM.pdf'),
(11, 8309873253, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_bq6nZyol.pdf'),
(12, 8369057129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-13 11:11:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_ULkTxVSU.pdf'),
(13, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-21 18:09:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_X5uOfP7i.pdf'),
(14, 8369057129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 01:20:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_3oxnD6VB.pdf'),
(15, 8382868263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-10 01:36:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_vJZdgLPT.pdf'),
(16, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-10 00:50:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_QXGVZZ24.pdf'),
(17, 8382868263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_8qXTsQYS.pdf'),
(18, 8383860650, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-18 13:03:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_CTcANGTx.pdf'),
(19, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-10 02:59:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_BOrYofpr.pdf'),
(20, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-13 16:04:19', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_CJBVdPar.pdf'),
(21, 8383860650, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_k3RSF0Wa.pdf'),
(22, 8386666957, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_2cGv2f1h.pdf'),
(23, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-29 04:55:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_Fp7jSmwq.pdf'),
(24, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-10 16:43:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_QI8WMId3.pdf'),
(25, 8386666957, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-10 12:08:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_u5vX6pJC.pdf'),
(26, 8418214554, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-22 17:41:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_1siKk7sp.pdf'),
(27, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-04 08:21:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_IuiidOv6.pdf'),
(28, 8418214554, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_IMD47YFG.pdf'),
(29, 8427540745, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-26 07:03:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_ylCAMk09.pdf'),
(30, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-18 15:47:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_YkNm4jy6.pdf'),
(31, 8427540745, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-08 20:40:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_ELpLAFFT.pdf'),
(32, 8241472968, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-22 02:16:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_PI79PDXg.pdf'),
(33, 8241472968, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-15 08:57:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_n6eyZGrT.pdf'),
(34, 8241472968, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_D0VIpwDy.pdf'),
(35, 8241472968, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_IGVnaj55.pdf'),
(36, 8241472968, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-05 08:36:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_CWpnLYJL.pdf'),
(37, 8238546587, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-25 09:02:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_CkAtB3qO.pdf'),
(38, 8238546587, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-10 16:41:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_rNwbIJgO.pdf'),
(39, 8238546587, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 12:47:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_WJeuaYiF.pdf'),
(40, 8195150263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-22 07:26:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_G2HapzvE.pdf'),
(41, 8195150263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-15 20:56:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_CSx7n5iU.pdf'),
(42, 8195150263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-04 12:50:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_diHp7huH.pdf'),
(43, 8994312129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_2beWdCnn.pdf'),
(44, 8994312129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-27 08:42:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_BlJOHtdm.pdf'),
(45, 8994312129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-06 22:54:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_UfYC5hg4.pdf'),
(46, 8086995111, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-20 12:43:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_52F5mE53.pdf'),
(47, 8086995111, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-10 17:15:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_TndLAX6E.pdf'),
(48, 8086995111, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-27 23:15:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_Y1TRHy2s.pdf'),
(49, 8086995111, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 18:09:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_xXYmZQs0.pdf'),
(50, 8105558067, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-27 15:15:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_yMt1nQs4.pdf'),
(51, 8105558067, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-30 17:26:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_Pf3BhIMD.pdf'),
(52, 8105558067, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-06 13:53:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_3ZZzWUPW.pdf'),
(53, 8105558067, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_lzjI47QE.pdf'),
(54, 8107274724, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-25 20:23:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_vX6Fr7eS.pdf'),
(55, 8107274724, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-08 22:46:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_e79pLAUo.pdf'),
(56, 8107274724, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-06 18:44:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_NdF0zSPY.pdf'),
(57, 8107274724, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-02 15:43:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_aPYCiTl9.pdf'),
(58, 8127428528, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-28 03:44:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_mLUUlOU1.pdf'),
(59, 8127428528, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-05 20:15:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_KWSowByU.pdf'),
(60, 8127428528, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-07 15:16:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_rlqvXkK0.pdf'),
(61, 8127428528, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-06 10:52:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_cD7pMmO3.pdf'),
(62, 8156208679, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-04 10:56:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_1h0nUlfc.pdf'),
(63, 8156208679, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-29 11:21:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_JkiqNfbQ.pdf'),
(64, 8156208679, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-03 08:26:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_LOJQGoUx.pdf'),
(65, 8156208679, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 14:31:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_UK6ZpBAH.pdf'),
(66, 8162150523, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-07 13:50:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_bvm4yFAQ.pdf'),
(67, 8162150523, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-07 00:09:48', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_QjmIP9Gm.pdf'),
(68, 8162150523, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_eDcUgV9o.pdf'),
(69, 8162150523, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-07 03:35:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_1gu936pv.pdf'),
(70, 8168355683, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-14 06:51:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_f7u3zIVI.pdf'),
(71, 8168355683, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-23 18:40:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_ulfNBWVr.pdf'),
(72, 8168355683, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-21 23:11:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_adEMRRIo.pdf'),
(73, 8168355683, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_4Y7jIC58.pdf'),
(74, 8170798183, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-02 12:48:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_RxdrId9D.pdf'),
(75, 8170798183, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-08 00:09:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_txsmfl2Z.pdf'),
(76, 8170798183, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-01 16:30:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_f9d4wp5n.pdf'),
(77, 8173716802, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_Mb6FWag3.pdf'),
(78, 8173716802, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-10 14:20:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_fSaerxTz.pdf'),
(79, 8173716802, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-08 05:32:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_lFGDrooa.pdf'),
(80, 8173716802, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 11:18:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_ldv1qLpE.pdf'),
(81, 8173716802, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-07 05:46:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_1ktAooTJ.pdf'),
(82, 8677212078, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-02 15:27:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_lAy3na79.pdf'),
(83, 8677212078, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-05 19:32:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_2QHjfiH5.pdf'),
(84, 8677212078, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-10 00:16:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_KPTpoteI.pdf'),
(85, 8499728780, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_A32PTmcD.pdf'),
(86, 8499728780, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-08 09:14:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_KwsupgDA.pdf'),
(87, 8499728780, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-03 11:00:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_fybDeT67.pdf'),
(88, 8445403392, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-01 18:25:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_oTGQ8B9w.pdf'),
(89, 8445403392, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-28 08:26:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_zogae6T4.pdf'),
(90, 8445403392, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_zJ6thPsV.pdf'),
(91, 8445403392, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-09 05:29:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_9JQcdylB.pdf'),
(92, 8195150263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-03 08:27:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_wtWEMvfh.pdf'),
(93, 8195150263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-06 02:19:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_eHZVT95J.pdf'),
(94, 8195150263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-01 07:25:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_FcbmsAlT.pdf'),
(95, 8173716802, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-14 15:09:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210459_otyxtmcJ.pdf'),
(96, 8173716802, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_NJX6OD61.pdf'),
(97, 8173716802, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-25 07:42:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_7t6kSC2U.pdf'),
(98, 8173716802, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 14:12:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_bH1fPrfx.pdf'),
(99, 8170798183, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-14 01:51:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_IZqMCT4m.pdf'),
(100, 8170798183, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-11 12:13:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_vReuqrZk.pdf'),
(101, 8170798183, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 09:33:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_fiEZG5aT.pdf'),
(102, 8168355683, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-02 05:12:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Aa3pRnUf.pdf'),
(103, 8168355683, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-05 22:29:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_EVxaiECd.pdf'),
(104, 8168355683, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-10 00:30:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_4Cmd6Fny.pdf'),
(105, 8168355683, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 16:10:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_359JWCFU.pdf'),
(106, 8162150523, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-06 09:34:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_jo0JMNfm.pdf'),
(107, 8162150523, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_1MVXxpy3.pdf'),
(108, 8162150523, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-30 18:40:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_lyR7yI4z.pdf'),
(109, 8162150523, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 11:50:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_dPTmUXsG.pdf'),
(110, 8156208679, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-29 04:19:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_QICZL8Qz.pdf'),
(111, 8156208679, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-08 16:59:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_iZ9LFTdv.pdf'),
(112, 8156208679, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-22 15:01:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_zT4CBpIf.pdf'),
(113, 8156208679, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-06 09:10:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_e20jSBkM.pdf'),
(114, 8127428528, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_PZY4jnEM.pdf'),
(115, 8127428528, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-12 12:54:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Zc5vf8lW.pdf'),
(116, 8127428528, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-10 13:24:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_LPlf2gz9.pdf'),
(117, 8127428528, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_h1wcTR0s.pdf'),
(118, 8107274724, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-21 20:07:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_dDDqn65w.pdf'),
(119, 8107274724, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-14 07:47:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_3Toz5NLe.pdf'),
(120, 8107274724, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_SnBD7jnD.pdf'),
(121, 8107274724, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_dWNj9Fdg.pdf'),
(122, 8105558067, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-04 14:14:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_BjyeaZPN.pdf'),
(123, 8105558067, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_acTgBQ4d.pdf'),
(124, 8105558067, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-10 06:45:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_JZifiimS.pdf'),
(125, 8086995111, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-11 16:28:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_d8oOjUgE.pdf'),
(126, 8086995111, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-09 18:24:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_oQnSOxWb.pdf'),
(127, 8086995111, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_iQbIsVXC.pdf'),
(128, 8086995111, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-07 02:22:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_yK80TxIg.pdf'),
(129, 8238546587, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-18 12:01:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_fD7g7TJL.pdf'),
(130, 8238546587, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-19 02:03:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_BUnvSZeM.pdf'),
(131, 8238546587, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 11:52:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_SzmQbOcv.pdf'),
(132, 8241472968, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-25 21:46:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_2Rllr4zp.pdf'),
(133, 8241472968, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-22 10:15:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_aLmlWee9.pdf'),
(134, 8241472968, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-16 17:44:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_X3Xd4rSs.pdf'),
(135, 8241472968, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-10 07:56:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_fylWzNXw.pdf'),
(136, 8429127128, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-14 17:36:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_oPoYoaij.pdf'),
(137, 8429127128, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-05 17:48:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_ErDb6j49.pdf'),
(138, 8429127128, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-10 06:13:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Yi17AYYF.pdf'),
(139, 8429127128, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-09 23:07:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_QfTXi9Uf.pdf'),
(140, 8427540745, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-01 06:26:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_gy8rdyDt.pdf'),
(141, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-16 22:15:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_CbNKjZl6.pdf'),
(142, 8427540745, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_OkfzNnjE.pdf'),
(143, 8418214554, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-04 00:47:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_0Heigw7I.pdf'),
(144, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_LjHmpTyA.pdf'),
(145, 8418214554, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 16:57:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_bxmvtGNF.pdf'),
(146, 8386666957, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-16 13:26:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_HR6CrXud.pdf'),
(147, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-29 22:05:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Zg6TRRoJ.pdf'),
(148, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-01 14:33:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_4I0wG9oH.pdf'),
(149, 8386666957, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 06:07:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_8Dj4Gtrv.pdf'),
(150, 8383860650, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_pSgPdfOa.pdf'),
(151, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_3mknAYlQ.pdf'),
(152, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-10 15:18:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_agur3ahG.pdf'),
(153, 8383860650, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-10 15:41:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_CHrC18S1.pdf'),
(154, 8383860650, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-07 12:32:19', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_z5IS5LrL.pdf'),
(155, 8382868263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-12 09:31:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_QeahLvhr.pdf'),
(156, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-09 13:33:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_A75Lch4n.pdf'),
(157, 8382868263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 06:10:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_O2dmiPXd.pdf'),
(158, 8369057129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-24 17:42:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_aknlxzBj.pdf'),
(159, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_JXZzGCoP.pdf'),
(160, 8369057129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-03 18:31:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_jcqbBZfO.pdf'),
(161, 8309873253, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_fB0zS7gt.pdf'),
(162, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-03 03:25:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_hYTpqwVG.pdf'),
(163, 8309873253, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_TkG9YpFa.pdf'),
(164, 8309873253, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-08 03:12:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_F1IIqOix.pdf'),
(165, 8275722602, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_tesxCyf7.pdf'),
(166, 8275722602, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-25 04:28:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_RFE7yWZS.pdf'),
(167, 8275722602, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 08:13:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Q3oNKvHx.pdf'),
(168, 8253819115, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-12 09:16:48', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_bWFUHO5l.pdf'),
(169, 8253819115, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_u6gabtFK.pdf'),
(170, 8253819115, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-26 00:24:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_V4FqqrBb.pdf'),
(171, 8253819115, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 15:00:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_gMj9ieJ6.pdf'),
(172, 8445403392, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-15 18:26:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_PSuYBI3j.pdf'),
(173, 8445403392, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-13 03:33:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_hbP6nhIn.pdf'),
(174, 8445403392, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-05 22:28:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Nc0Vw9SJ.pdf'),
(175, 8445403392, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 20:08:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_64QNUgBe.pdf'),
(176, 8429127128, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-11 08:40:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_ZhOGGic8.pdf'),
(177, 8429127128, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_OYjgJRW7.pdf'),
(178, 8429127128, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_xm0OftXG.pdf'),
(179, 8429127128, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-01 10:28:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_U5bgdsQN.pdf'),
(180, 8427540745, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-26 18:41:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_mlsZDK5M.pdf'),
(181, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-04 20:13:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210500_Fq4bnyjb.pdf'),
(182, 8427540745, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_rUnIFbXK.pdf'),
(183, 8418214554, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-01 08:54:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_dlPzQlWo.pdf'),
(184, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-12 10:03:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_1zIDUQRa.pdf'),
(185, 8418214554, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_cy63J88F.pdf'),
(186, 8386666957, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-24 07:41:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_6AvjgSdv.pdf'),
(187, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-04 03:10:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_m4ZVDGzT.pdf'),
(188, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-06 16:11:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_tK85hyLf.pdf'),
(189, 8386666957, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-10 02:29:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_KC8YDLoL.pdf'),
(190, 8386666957, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-08 04:02:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_adlLKChq.pdf'),
(191, 8383860650, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-19 19:27:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_iwRVCBfD.pdf'),
(192, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_iEVn398T.pdf'),
(193, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-07 17:45:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_SOhbTxtY.pdf'),
(194, 8383860650, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 18:08:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_iHRfJr4T.pdf'),
(195, 8382868263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-16 01:34:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_1SL9zkut.pdf'),
(196, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-01 00:52:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_ICdnIowV.pdf'),
(197, 8382868263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-07 18:37:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_VAqIIRd2.pdf'),
(198, 8369057129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-23 13:22:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_9Ta1NhDM.pdf'),
(199, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-13 12:15:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_NUIqcASM.pdf'),
(200, 8369057129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-03 18:52:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_Wsj6U3Gh.pdf'),
(201, 8309873253, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-01 22:29:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_B4rIG6GO.pdf'),
(202, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-14 11:01:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_8Lvkqepa.pdf'),
(203, 8309873253, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_ThkYPSgL.pdf'),
(204, 8050006918, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_mvmNFtxO.pdf'),
(205, 8050006918, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-15 05:28:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_5opy0ndj.pdf'),
(206, 8050006918, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_7YklipuK.pdf'),
(207, 8050006918, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-06 22:51:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211128210501_eOowrPIE.pdf');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `document_category`
--

DROP TABLE IF EXISTS `document_category`;
CREATE TABLE `document_category` (
  `category_id` bigint(10) UNSIGNED NOT NULL,
  `category_name` varchar(250) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `document_category`
--

INSERT INTO `document_category` (`category_id`, `category_name`) VALUES
(1, 'Bérjegyzék'),
(2, 'Tájékoztató');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `company_code` bigint(10) UNSIGNED NOT NULL,
  `user_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `user_real_name` varchar(45) COLLATE utf8_hungarian_ci NOT NULL,
  `user_email` varchar(45) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `email_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `user_password` varchar(100) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `user_login_attempt` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `user_last_login_attempt` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`user_tax_number`, `company_code`, `user_status`, `user_real_name`, `user_email`, `email_status`, `user_password`, `user_login_attempt`, `user_last_login_attempt`) VALUES
(8050006918, 2, 1, 'Pintér Jarmilla', 'dhrakar@me.com', 2, '$2y$10$brA9EER3ZenhdllqlBhBBei5nbmjW2LSzhRS7DYdES94szbsAGkDe', 2, '2020-10-11 17:38:47'),
(8083605219, 1, 1, 'Szilágyi Szörénke', 'microfab@comcast.net', 2, '$2y$10$ImR3RdxbPWPv5CqpRo5nU.kFswsx69zSVB7i9bZJzp9fPk18hLAGG', 4, '2020-10-23 22:20:29'),
(8086995111, 2, 1, 'Ruzsinszki Deodát', 'oechslin@comcast.net', 2, '$2y$10$E.EJk36ey66fa9sZ.zXVSeUafXr/1H.pmuYddoInRgBlNX9oCOOlO', 2, '2021-01-04 09:06:58'),
(8094707763, 2, 0, 'Szilágyi Szilamér', NULL, 0, NULL, 0, '2021-04-21 23:38:08'),
(8105558067, 1, 1, 'Szilágyi Pintyőke', NULL, 0, '$2y$10$mFPFnkmZVLuRmpOHKtLiaezoeDAM5Mazy6fDef2ofmGxBWs9wgcDS', 2, '2021-03-26 00:09:09'),
(8107274724, 2, 1, 'Pintér Allegra', NULL, 0, '$2y$10$NgYBqQS7dgkCCYVlHlOdIeblDg6xzafzvXW6r7W5hNMm2.x1uc6c.', 0, '2021-04-08 12:20:04'),
(8127428528, 2, 1, 'Sárközi Lizander', 'monkeydo@att.net', 2, '$2y$10$Mjw5mPl8ZwpMKqPQVlpn6.0/pv/lrIE3FlFt66RYKTot05cFG436a', 2, '2021-01-16 16:55:37'),
(8156208679, 2, 1, 'Ruzsinszki Lizander', 'valdez@gmail.com', 2, '$2y$10$l9WcfhIKPlChzOTvtv8tU.go46tetY7.iL1MkHR7IfBXTpLqqExbG', 3, '2020-11-06 16:27:06'),
(8162150523, 2, 1, 'Németh Celesztin', 'jgoerzen@outlook.com', 2, '$2y$10$jdkD/sVcQK93ziGzV7HZYeMtLpR.FrwfRyO6o/3f//CGaxneexiD.', 3, '2020-12-08 22:50:19'),
(8168355683, 2, 1, 'Németh Maximilián', 'bartak@yahoo.com', 2, '$2y$10$/Bs0luBc.oo88WClkKkslOkM5SDkSO8nBfvWvjrCdavcYtUuDSbhy', 3, '2021-04-16 03:53:19'),
(8170798183, 1, 1, 'Rácz Szörénke', 'gbacon@yahoo.com', 2, '$2y$10$SZlE.sMa7UAwDVelYejmtewMvZzE/gQJ1ST0CDwDYvAdl62gvcOUK', 4, '2020-10-28 22:53:32'),
(8173716802, 2, 1, 'Felföldi Allegra', 'rafasgj@att.net', 2, '$2y$10$CjEmW881qZQ894thKxzNJ.6jwtoaW5syHKYxYKLUXgZIUdxG.OOdq', 2, '2020-12-31 15:56:05'),
(8195150263, 1, 1, 'Ruzsinszki Jarmilla', 'johndo@hotmail.com', 2, '$2y$10$HERRq3rxKwOMmKkDt/PMBu//kackg9yWRB5PIWKcN3ICizf5N93gy', 0, '2020-11-10 08:11:58'),
(8238546587, 1, 1, 'Gózon Elina', 'agapow@gmail.com', 2, '$2y$10$n0Wbou16mFbS/69A7oqFS.fjBbgx9ILslz2fsmLsPRDwxgLuHh5MS', 4, '2020-10-31 23:07:02'),
(8241472968, 2, 1, 'Ruzsinszki Ninett', 'rfisher@optonline.net', 2, '$2y$10$wXIq8Cq7Quj7Ldss8dcWrez17y9kRM6.5Vo2Wxk1TNLP/QQWYGG4O', 4, '2021-04-25 01:45:15'),
(8253819115, 2, 1, 'Sárközi Melodi', 'trygstad@yahoo.com', 2, '$2y$10$iWAHFXpt1pGMVJ1QusAsduBTdZItT.mkR0WWa2QLZ1UgpZEJCi4g2', 4, '2021-01-24 21:11:25'),
(8275722602, 1, 1, 'Németh Szilamér', 'skippy@sbcglobal.net', 2, '$2y$10$nfPkUaL1G.YadQ2.tG3PV.waw7/Le5X8sjB3vyeweX1V2kDbeXqG6', 1, '2021-01-11 16:59:46'),
(8309873253, 1, 1, 'Felföldi Bereniké', 'syncnine@yahoo.com', 2, '$2y$10$Z04kKFAkZZhd981b4fjWXOuYf899SV8d2d7YVxj7j/lZxi7BVRgVu', 4, '2020-12-26 08:44:24'),
(8369057129, 1, 1, 'Gózon Szörénke', 'mcmillan@live.com', 2, '$2y$10$A3jMStQuRsfFUACqcu3LYOYRKtrUxkj2boU/s0ZSEC3Rslv00CpqS', 2, '2020-11-18 11:24:41'),
(8382868263, 1, 1, 'Németh Pintyőke', 'tbmaddux@outlook.com', 2, '$2y$10$f1ZqrKGvF07US5flD3rXQ.KPSJtFd1XLXh8izGo.8FU0bJaNC3InK', 3, '2020-09-01 19:03:06'),
(8383860650, 2, 1, 'Pintér Elina', 'gomor@me.com', 1, '$2y$10$qyV0Gi8uGDeVcqadYBf8YO7d2mihoL3QV333NI9xCRihL4KKH0iTG', 3, '2021-03-27 11:07:57'),
(8386666957, 2, 1, 'Sárközi Allegra', 'smallpaul@verizon.net', 2, '$2y$10$qp3P48hpUpnd96BwWMTNeuXl1hJRQsj26ervO6zDEvvyPQTcagMXu', 3, '2021-02-21 10:30:44'),
(8403042350, 1, 0, 'Felföldi Pintyőke', 'quinn@sbcglobal.net', 0, NULL, 0, '2021-02-20 00:03:18'),
(8418214554, 1, 1, 'Rácz Bereniké', 'wonderkid@gmail.com', 2, '$2y$10$WI.Vf0R67egKD83Z1blZ4eTk1MU7vDachVpDIq74wIhsmgzSTjnhi', 1, '2021-02-28 13:18:48'),
(8427540745, 1, 1, 'Ruzsinszki Zengő', 'pemungkah@mac.com', 2, '$2y$10$Ky6tHhKTgt75S/2g0zSQ0.rLC58W6ssjYVhzaPCl3gtEp8Dqhus.S', 1, '2021-01-29 06:25:15'),
(8429127128, 2, 1, 'Ruzsinszki Bereniké', 'gbacon@aol.com', 2, '$2y$10$RjvvXF81De5vEDZ8uQOWHe.ADtYz1ba1tXGQXiRiVV/ONdizj/qSS', 4, '2020-11-20 18:57:55'),
(8445403392, 2, 1, 'Rácz Surd', 'storerm@optonline.net', 2, '$2y$10$htuGcqStTWbwu3UBw7jBqOZXAChihaIGYdJsMOBvRv5mFXRWc8U0q', 3, '2021-01-28 05:04:38'),
(8499728780, 1, 1, 'Vincziczki Celesztin', 'petersen@aol.com', 2, '$2y$10$FrmgEaafskZjGK4ov.AFOO3B47k00MMHQ6cta0cLJ/JuMBW.IRHli', 2, '2021-01-05 05:07:15'),
(8507797079, 2, 1, 'Sárközi Kökény', 'drolsky@outlook.com', 2, '$2y$10$EvHfpLv/Tccb1EEv80pc..jgxgIl6Op7DAzosHsIDduFYLZ8TKieq', 3, '2020-12-06 12:01:09'),
(8509139779, 1, 1, 'Sárközi Celesztin', 'eegsa@verizon.net', 1, '$2y$10$KGPLTpJSsEToXDJdSym7.e9zFoQNlfktMvqEbTmk9j5LqL1wk7AO6', 3, '2021-03-08 15:09:24'),
(8513212045, 1, 1, 'Felföldi Maximilián', 'goresky@att.net', 2, '$2y$10$DkquVbS35dv3Ccl8pI3e4uqFFQQQjTJTuvv1K/hI/kz66F9sxoQVW', 4, '2021-02-09 20:26:05'),
(8544267350, 2, 1, 'Szilágyi Zengő', 'oechslin@gmail.com', 2, '$2y$10$nufWkSv6ltVQCNZW4vVtY.cefAYOS4A73Z8lhvTNamV1w9EElY3Tq', 1, '2020-11-21 20:47:00'),
(8546146995, 2, 1, 'Sárközi Terestyén', 'arandal@verizon.net', 2, '$2y$10$ZNWoNGYBy.hNxUDRJ2brWOYEYXbP3QJ791DF5ODbfXth97wD3Rwzu', 4, '2021-03-01 00:33:41'),
(8546195037, 1, 1, 'Németh Lizander', 'hyper@hotmail.com', 2, '$2y$10$RXoQ/.p9E2NI5iQuRwp/NeqtWvUPC6fgitWzIKhQ66VmQIEe0wdp.', 3, '2021-01-17 20:01:44'),
(8552816098, 1, 1, 'Rácz Celesztin', 'trygstad@sbcglobal.net', 2, '$2y$10$b6WMXsORYSRTOTWUbDCe3edn9A5GDfMWci5Y6rcMUQqX86DPMv6Pa', 4, '2020-11-17 10:12:50'),
(8576434309, 2, 1, 'Felföldi Lizander', 'jeteve@msn.com', 2, '$2y$10$6Pu49SkdcMF0Q.lnBBV4ge9MqLq/ol3yaB20a6R0iWumlPxDuhCV.', 0, '2020-09-09 17:40:17'),
(8594964216, 1, 1, 'Berényi Allegra', 'nimaclea@outlook.com', 2, '$2y$10$yy2hedj9tDpf1VhBE2fXRuEvG/3Hy/duENevmHv5UIVbXa6mYcGVS', 0, '2021-05-04 01:27:13'),
(8612304115, 2, 1, 'Szilágyi Elina', 'nweaver@att.net', 2, '$2y$10$MglnBVuCjdiJ6FGZtvbWWOvBQ7RRrbP4Dk7oJTzh2tUwRQ.nE466S', 1, '2021-02-06 02:31:58'),
(8617122087, 2, 1, 'Gózon Szilamér', 'tedrlord@aol.com', 2, '$2y$10$bOvqys4h.aXOZwe1cAWbg.DhkA.bcYfjkRasdUKD190KhfVYGjmE.', 1, '2021-03-22 04:16:55'),
(8671205675, 1, 1, 'Ruzsinszki Vilibald', NULL, 0, '$2y$10$qCrKvxJ3GCEPSrcDWHKII.pzfE21FmHj/kyhQCcxxMgr9n5O.GsjW', 3, '2021-02-22 22:30:45'),
(8677212078, 1, 1, 'Felföldi Vilibald', 'danneng@verizon.net', 2, '$2y$10$4jpUGbrtvLg31Tozeq3AsOIaKVGimn0enQIM4Ru.m1mkKVSgGXjCC', 3, '2021-05-06 11:45:32'),
(8679637651, 2, 1, 'Pintér Deodát', 'library@live.com', 1, '$2y$10$nl9FJGFWoYOARNV9alBWvObrCFicGn9LYBB0e4QjpXXpT8IBe7v7S', 3, '2020-10-24 17:28:22'),
(8685332332, 2, 1, 'Gózon Deodát', 'scarlet@hotmail.com', 2, '$2y$10$RdXlY9qEEvicdZKOB4ucpOcxXaG5lKyG6glvdum.0U8MtjenPCjGW', 0, '2020-12-08 01:37:47'),
(8690062661, 2, 1, 'Berényi Zengő', 'malin@verizon.net', 2, '$2y$10$q.7EslaUCfZdjnQyjCP5uOo3Zs7igXcDsjtdBn.N7QV307/tRdOa.', 0, '2021-01-02 10:04:27'),
(8696550988, 1, 1, 'Vincziczki Elina', 'djupedal@msn.com', 2, '$2y$10$TGeQTi73fwfvKr4E5IQ0Jum/Kn8OMIrNHP4.C71TuemW94AOKP0wW', 3, '2021-04-01 19:56:43'),
(8698266191, 2, 1, 'Pintér Zengő', 'jschauma@hotmail.com', 1, '$2y$10$C/JZLxDtrzzZrNnmnoiLs.Hn9AUCXFM8nQX3tguA1y2nHlHLTd/.2', 1, '2020-12-01 01:34:59'),
(8713053299, 1, 1, 'Gózon Terestyén', 'draper@icloud.com', 2, '$2y$10$Co11kAM5qfgvK/ILY0pQhuTSI9SnBvxLHI/t4EFatnAjspsW/wwDe', 0, '2021-11-28 19:46:44'),
(8757596739, 1, 1, 'Szilágyi Celesztin', 'evans@verizon.net', 2, '$2y$10$K24poktmIpHaeXZQzbhLHeSZ2KmnS.oh8DFTLITaDh4QKdCLUe4H.', 1, '2021-02-13 21:59:45'),
(8777090819, 1, 1, 'Vincziczki Szilamér', 'jmmuller@yahoo.com', 2, '$2y$10$rVlEQCJBSz3s/GrDHh5G0uGU2XSeEEKU3HPTyTuU3FDENAKWoJnkK', 4, '2020-12-14 14:11:05'),
(8785725024, 1, 1, 'Rácz Terestyén', 'chrwin@live.com', 2, '$2y$10$1tiWX8UkzyLkqfQQ4sRgTOwxRMPqTPPxdkiRJvXIrTW0xEKuNKZj2', 1, '2021-01-28 21:53:48'),
(8787269676, 1, 1, 'Gózon Kökény', 'quinn@verizon.net', 2, '$2y$10$uKp9/0uIZekiCmlXeRNrAuah8iPnQMRTQ/E/q4jf0lPsL6UV4/dp2', 4, '2020-12-09 17:17:20'),
(8805011634, 2, 0, 'Vincziczki Jarmilla', 'ateniese@optonline.net', 0, NULL, 0, '2021-01-03 03:56:54'),
(8842743809, 2, 1, 'Berényi Deodát', 'jaesenj@hotmail.com', 2, '$2y$10$XVjLCewdFrnED0RFVjIJtu/IhnFrRgXQmsoZgG6ocSGe9nhUFnBl.', 0, '2021-03-03 23:28:23'),
(8855859093, 2, 1, 'Németh Elina', 'nullchar@hotmail.com', 2, '$2y$10$pKpMQK7UoexSnFW40PxaZuUFNlyRGN6DCg30Lra/vzj/7QhMNmkpm', 3, '2020-12-22 23:01:51'),
(8901252746, 2, 1, 'Pintér Lizander', 'rjones@comcast.net', 2, '$2y$10$Gr9lqYy6ThN4j6k3QHIZ1uc84sg9ipLr6ibq8xFPjDCHBiIi.Mm2G', 0, '2021-05-27 19:21:09'),
(8951823211, 2, 1, 'Rácz Deodát', 'luvirini@gmail.com', 2, '$2y$10$dFSH/uKPpL7PpcjdRN.epuZHxz5V7x6DFN8fvhiVJZ4ZZkxK2MmTm', 4, '2021-02-15 08:00:14'),
(8958135330, 1, 1, 'Sárközi Pintyőke', 'bester@aol.com', 2, '$2y$10$5tlSxor4ThgoR0aLGJLTMOr9mn8nQcNAUITPdsuAb71dOJK6KgyY6', 3, '2021-02-20 11:15:38'),
(8973182757, 2, 1, 'Felföldi Celesztin', 'heroine@hotmail.com', 2, '$2y$10$XdTskkeID2Win6JWuegmzesMAyyqnuZGCohApnvUlGHh3X5T9vUqC', 4, '2021-04-05 00:33:19'),
(8990386597, 1, 1, 'Pintér Ninett', 'adhere@comcast.net', 2, '$2y$10$8b7Tnznn9LXekVOFAyCUlOg7jA7kdQKVYvi077LSe5IXL1Eu/bZrm', 2, '2020-12-27 01:55:18'),
(8994312129, 1, 1, 'Berényi Vilibald', 'ournews@yahoo.com', 2, '$2y$10$kHn84zMkEl9veXnGaXCAjuCvcz73APSV1c1NpWYVmwCMGDlGrhape', 3, '2020-11-06 10:10:30');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_activity_filter`
--

DROP TABLE IF EXISTS `user_activity_filter`;
CREATE TABLE `user_activity_filter` (
  `filter_id` int(10) UNSIGNED NOT NULL,
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `filter_name` varchar(250) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `ufilter` varchar(2000) COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_email_code`
--

DROP TABLE IF EXISTS `user_email_code`;
CREATE TABLE `user_email_code` (
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `email_code` varchar(100) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_permissions`
--

DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE `user_permissions` (
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `user_permission` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_permissions`
--

INSERT INTO `user_permissions` (`user_tax_number`, `user_permission`) VALUES
(8050006918, 0),
(8083605219, 0),
(8083605219, 3),
(8086995111, 0),
(8105558067, 0),
(8105558067, 2),
(8107274724, 0),
(8107274724, 1),
(8107274724, 2),
(8127428528, 0),
(8156208679, 0),
(8162150523, 0),
(8168355683, 0),
(8168355683, 1),
(8170798183, 0),
(8173716802, 0),
(8195150263, 0),
(8195150263, 1),
(8238546587, 0),
(8241472968, 0),
(8253819115, 0),
(8275722602, 0),
(8309873253, 0),
(8369057129, 0),
(8382868263, 0),
(8383860650, 0),
(8386666957, 0),
(8418214554, 0),
(8427540745, 0),
(8429127128, 0),
(8429127128, 1),
(8445403392, 0),
(8445403392, 1),
(8499728780, 0),
(8507797079, 0),
(8509139779, 0),
(8509139779, 1),
(8513212045, 0),
(8544267350, 0),
(8546146995, 0),
(8546195037, 0),
(8552816098, 0),
(8576434309, 0),
(8594964216, 0),
(8612304115, 0),
(8617122087, 0),
(8671205675, 0),
(8677212078, 0),
(8679637651, 0),
(8685332332, 0),
(8690062661, 0),
(8696550988, 0),
(8698266191, 0),
(8698266191, 2),
(8713053299, 0),
(8713053299, 1),
(8713053299, 2),
(8713053299, 3),
(8757596739, 0),
(8757596739, 1),
(8777090819, 0),
(8777090819, 2),
(8785725024, 0),
(8785725024, 1),
(8787269676, 0),
(8842743809, 0),
(8855859093, 0),
(8901252746, 0),
(8951823211, 0),
(8951823211, 1),
(8958135330, 0),
(8973182757, 0),
(8990386597, 0),
(8994312129, 0);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `company_name` (`company_name`);

--
-- A tábla indexei `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `felhasznalo_adoazonosito` (`user_tax_number`),
  ADD KEY `category_id` (`category_id`);

--
-- A tábla indexei `document_category`
--
ALTER TABLE `document_category`
  ADD PRIMARY KEY (`category_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_tax_number`),
  ADD KEY `company_code` (`company_code`);

--
-- A tábla indexei `user_activity_filter`
--
ALTER TABLE `user_activity_filter`
  ADD PRIMARY KEY (`filter_id`),
  ADD KEY `user_id` (`user_tax_number`);

--
-- A tábla indexei `user_email_code`
--
ALTER TABLE `user_email_code`
  ADD PRIMARY KEY (`user_tax_number`);

--
-- A tábla indexei `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`user_tax_number`,`user_permission`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `document`
--
ALTER TABLE `document`
  MODIFY `document_id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT a táblához `document_category`
--
ALTER TABLE `document_category`
  MODIFY `category_id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `user_activity_filter`
--
ALTER TABLE `user_activity_filter`
  MODIFY `filter_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `document_category` (`category_id`),
  ADD CONSTRAINT `document_ibfk_2` FOREIGN KEY (`user_tax_number`) REFERENCES `user` (`user_tax_number`);

--
-- Megkötések a táblához `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_id`);

--
-- Megkötések a táblához `user_activity_filter`
--
ALTER TABLE `user_activity_filter`
  ADD CONSTRAINT `user_activity_filter_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `user` (`user_tax_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `user_email_code`
--
ALTER TABLE `user_email_code`
  ADD CONSTRAINT `user_email_code_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `user` (`user_tax_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `user` (`user_tax_number`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
