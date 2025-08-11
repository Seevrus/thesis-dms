-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2022. Feb 23. 20:08
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

DROP TABLE IF EXISTS `wp_company`;
CREATE TABLE `wp_company` (
  `company_id` bigint(10) UNSIGNED NOT NULL,
  `company_name` varchar(45) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `wp_company`
--

INSERT INTO `wp_company` (`company_id`, `company_name`) VALUES
(1, 'Balázs és Tsa Bt.'),
(2, 'Jónás Nyrt.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wp_document`
--

DROP TABLE IF EXISTS `wp_document`;
CREATE TABLE `wp_document` (
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
-- A tábla adatainak kiíratása `wp_document`
--

INSERT INTO `wp_document` (`document_id`, `user_tax_number`, `document_name`, `category_id`, `document_added`, `document_visible`, `document_valid`, `document_downloaded`, `document_path`) VALUES
(1, 8994312129, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-02 01:54:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_zTVtnQvM.pdf'),
(2, 8994312129, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-12 02:59:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_wgWywRF9.pdf'),
(3, 8994312129, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-08 06:40:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_jmZE4o5u.pdf'),
(4, 8994312129, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_uzj3ebVT.pdf'),
(5, 8275722602, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-14 14:06:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_L90xUVmz.pdf'),
(6, 8275722602, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-05 22:29:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_nRTwyMgF.pdf'),
(7, 8275722602, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-05 15:36:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_GBv7mgYF.pdf'),
(8, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2022-01-06 18:57:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_OcNYTHxD.pdf'),
(9, 8309873253, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-12 16:38:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_wDVcgyN8.pdf'),
(10, 8309873253, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 12:28:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_FPFoZoxt.pdf'),
(11, 8309873253, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_oI5hxXnR.pdf'),
(12, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-04 06:02:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_7LBonp52.pdf'),
(13, 8369057129, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_ey92hl3x.pdf'),
(14, 8369057129, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-12 09:30:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_SG0xKwY8.pdf'),
(15, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-08 10:51:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_7aRChrTF.pdf'),
(16, 8382868263, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-21 16:46:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_NR9bAqCt.pdf'),
(17, 8382868263, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-14 06:14:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_ymdejM5W.pdf'),
(18, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-10-17 06:07:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_hcH8cvrK.pdf'),
(19, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-02 05:37:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_JXkgmbPs.pdf'),
(20, 8383860650, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-30 00:19:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_bQ6pJHos.pdf'),
(21, 8383860650, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-08 15:01:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_w2rEjyLW.pdf'),
(22, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-10-05 19:10:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_ZcbgbzVt.pdf'),
(23, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-01 20:30:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_MjwIXBsU.pdf'),
(24, 8386666957, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-14 12:00:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_KVJNCtlK.pdf'),
(25, 8386666957, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-06 16:45:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_wXdNbXN6.pdf'),
(26, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2022-01-12 19:58:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_9GUOJlPf.pdf'),
(27, 8418214554, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-10 09:53:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_Ps0zUsF2.pdf'),
(28, 8418214554, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-06 19:53:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_hUoe8xrS.pdf'),
(29, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2022-01-09 14:44:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_Z7ZEp2pE.pdf'),
(30, 8427540745, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_2M3ckF3b.pdf'),
(31, 8427540745, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-12 15:15:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_ANKqSXqT.pdf'),
(32, 8241472968, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-19 18:45:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_pVJvW4ml.pdf'),
(33, 8241472968, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_PDfivQ6Q.pdf'),
(34, 8241472968, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-06 19:39:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_Fw2VhT2F.pdf'),
(35, 8241472968, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 06:28:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_Y8V5vT7f.pdf'),
(36, 8241472968, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-14 03:33:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_mxQ9o4DO.pdf'),
(37, 8238546587, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2022-01-01 20:19:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_zynoipJK.pdf'),
(38, 8238546587, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-14 04:46:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195821_t9O6fTBT.pdf'),
(39, 8238546587, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-12 06:08:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_Y4gG7WcM.pdf'),
(40, 8195150263, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-14 16:26:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_gDp3eA5P.pdf'),
(41, 8195150263, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-07 05:47:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_o8lCeg3u.pdf'),
(42, 8195150263, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_DFNlWHta.pdf'),
(43, 8994312129, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2022-01-03 22:06:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_0zbKZB7p.pdf'),
(44, 8994312129, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_pJfKCDVx.pdf'),
(45, 8994312129, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-10 10:47:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_cjye8VTm.pdf'),
(46, 8086995111, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-06 07:31:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_fq4DJTjN.pdf'),
(47, 8086995111, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-07 19:53:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_nP36SK4S.pdf'),
(48, 8086995111, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_wf9vp3Uq.pdf'),
(49, 8086995111, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-05 14:10:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_94t7Y1pv.pdf'),
(50, 8105558067, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-08 21:14:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_KwX4AE4U.pdf'),
(51, 8105558067, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-05 08:28:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_8yau7uCd.pdf'),
(52, 8105558067, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-09 07:00:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_UtcjZ9qa.pdf'),
(53, 8105558067, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-05 22:12:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_nISBQSI0.pdf'),
(54, 8107274724, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-12 02:08:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_xsX364HU.pdf'),
(55, 8107274724, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-08 12:09:19', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_uWpvOUMb.pdf'),
(56, 8107274724, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-25 11:12:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_go3Qdqm3.pdf'),
(57, 8107274724, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-12 19:02:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_Go6x7UzW.pdf'),
(58, 8127428528, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-01 19:22:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_HeL4YISs.pdf'),
(59, 8127428528, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_RSniGfJ2.pdf'),
(60, 8127428528, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-06 18:52:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_ZABhn7bi.pdf'),
(61, 8127428528, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-08 02:07:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_yzX8UPDg.pdf'),
(62, 8156208679, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-14 15:14:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_jdQUJLQc.pdf'),
(63, 8156208679, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-12 05:32:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_oxxc9Ekw.pdf'),
(64, 8156208679, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_D0hDjmOJ.pdf'),
(65, 8156208679, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-05 13:02:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_SGbXVLAE.pdf'),
(66, 8156208679, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-09 19:12:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_RBQ2fALA.pdf'),
(67, 8162150523, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-11 21:49:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_yTkOObHD.pdf'),
(68, 8162150523, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_XXBx2dmB.pdf'),
(69, 8162150523, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_bP8qhON4.pdf'),
(70, 8162150523, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_rcryGsiD.pdf'),
(71, 8168355683, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-14 07:37:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_M4tiQjDQ.pdf'),
(72, 8168355683, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-23 16:36:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_Qm6zePgN.pdf'),
(73, 8168355683, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-13 01:21:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_erlrZs5L.pdf'),
(74, 8168355683, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-08 07:03:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_4oItAYt9.pdf'),
(75, 8170798183, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_eJ2Q1tkP.pdf'),
(76, 8170798183, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-04 09:40:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_GWqgKIJ9.pdf'),
(77, 8170798183, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-13 01:21:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_rr2GWs7W.pdf'),
(78, 8173716802, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-22 18:20:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_MKrfkinc.pdf'),
(79, 8173716802, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_i2c3yPyZ.pdf'),
(80, 8173716802, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_iJX1guRh.pdf'),
(81, 8173716802, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-09 13:37:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_ok3kWvXt.pdf'),
(82, 8173716802, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-11 13:01:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_vLgJEHNc.pdf'),
(83, 8544267350, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_KvgwiWyA.pdf'),
(84, 8544267350, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-12 15:30:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_PM776LTl.pdf'),
(85, 8544267350, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-15 23:17:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_5wPrLMbO.pdf'),
(86, 8544267350, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 01:11:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_ZgUAgxMW.pdf'),
(87, 8546146995, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-02 22:43:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_BLm7dYgs.pdf'),
(88, 8546146995, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_loE6AfeX.pdf'),
(89, 8546146995, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-04 15:00:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_G6JmC71a.pdf'),
(90, 8546146995, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-13 01:35:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_4rGshIBK.pdf'),
(91, 8546146995, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-05 21:43:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_Je5Os4wp.pdf'),
(92, 8677212078, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_hqCFhad6.pdf'),
(93, 8677212078, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-24 01:05:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_ex89PhC3.pdf'),
(94, 8677212078, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-08 09:48:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_hhbcqnKE.pdf'),
(95, 8552816098, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-31 03:36:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_CfwZjpiX.pdf'),
(96, 8552816098, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-17 06:24:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_AlSmRqp7.pdf'),
(97, 8552816098, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-08 20:15:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_pYC5ozhD.pdf'),
(98, 8546195037, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-14 22:34:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_BwkyVcrX.pdf'),
(99, 8546195037, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-16 03:29:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_Z3gvwcog.pdf'),
(100, 8546195037, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-08 09:15:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_6Pc1H3By.pdf'),
(101, 8499728780, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-18 00:23:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_WHYT9q1J.pdf'),
(102, 8499728780, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-24 04:50:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_lTmIvp5y.pdf'),
(103, 8499728780, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-10 07:03:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_K04rVAZx.pdf'),
(104, 8594964216, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-27 12:21:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_O9k4z3Rz.pdf'),
(105, 8594964216, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-11 08:16:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_8rh2PSB4.pdf'),
(106, 8594964216, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-08 04:50:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_R2IkVlr2.pdf'),
(107, 8594964216, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-10 12:47:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_WaiBVIld.pdf'),
(108, 8445403392, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-19 07:47:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_QuOeiJbZ.pdf'),
(109, 8445403392, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_BUZ47F8N.pdf'),
(110, 8445403392, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-18 06:17:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_3jzKuPwV.pdf'),
(111, 8445403392, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-09 07:30:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_mHgwSRpv.pdf'),
(112, 8576434309, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-01 00:13:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_p35jEDiz.pdf'),
(113, 8576434309, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-10 17:06:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_Rc8lzbyP.pdf'),
(114, 8576434309, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_HWZIpfIa.pdf'),
(115, 8576434309, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-13 06:38:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_RYpusrin.pdf'),
(116, 8507797079, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-10-11 23:53:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_8bn970p2.pdf'),
(117, 8507797079, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_NI7LFmR8.pdf'),
(118, 8507797079, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-11 07:43:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_N8VCFqxE.pdf'),
(119, 8507797079, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 20:13:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_8Y3TLD7V.pdf'),
(120, 8195150263, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-12 21:06:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_zw7cNuSj.pdf'),
(121, 8195150263, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-15 21:32:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_RfwEjnWF.pdf'),
(122, 8195150263, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-07 04:21:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_g2RQolBV.pdf'),
(123, 8195150263, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-08 06:28:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_bmFzJqRH.pdf'),
(124, 8509139779, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-23 07:06:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195822_IqLFBEz4.pdf'),
(125, 8509139779, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-31 20:34:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_oyaSd32A.pdf'),
(126, 8509139779, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-05 18:52:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_sodg8AE7.pdf'),
(127, 8513212045, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_1tpWUl2J.pdf'),
(128, 8513212045, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_XRo09siX.pdf'),
(129, 8513212045, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-13 14:38:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_i9O048cL.pdf'),
(130, 8173716802, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-26 01:49:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_OVDMzEhF.pdf'),
(131, 8173716802, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-08 00:24:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_8df0wU7O.pdf'),
(132, 8173716802, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-17 18:30:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_G5FeGqvY.pdf'),
(133, 8173716802, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 15:31:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_0zcE3sSM.pdf'),
(134, 8170798183, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-14 04:32:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_Oh3dCtFF.pdf'),
(135, 8170798183, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-25 11:05:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_HbJXEIia.pdf'),
(136, 8170798183, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-09 14:25:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_UeerFkfr.pdf'),
(137, 8168355683, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-11 01:29:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_JWVHClr6.pdf'),
(138, 8168355683, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-10 01:23:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_SL4tTPkC.pdf'),
(139, 8168355683, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_4TgX9qs0.pdf'),
(140, 8168355683, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_e8e9rnA9.pdf'),
(141, 8162150523, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-29 08:37:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_CWXs5jwY.pdf'),
(142, 8162150523, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-07 21:47:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_Y4ETb8Rb.pdf'),
(143, 8162150523, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_h083PzXL.pdf'),
(144, 8162150523, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-11 08:27:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_EJko6qh0.pdf'),
(145, 8156208679, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-26 13:41:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_Jiwc8WL5.pdf'),
(146, 8156208679, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-23 03:44:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_ncYJ9GEM.pdf'),
(147, 8156208679, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-13 18:57:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_eR0QZtzy.pdf'),
(148, 8156208679, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-06 02:13:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_2BAK94Fb.pdf'),
(149, 8127428528, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-18 05:44:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_FaMOAyYc.pdf'),
(150, 8127428528, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-22 14:48:48', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_jAq1vwKg.pdf'),
(151, 8127428528, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-24 20:43:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_r2PZmrl9.pdf'),
(152, 8127428528, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-13 05:24:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_PbGzRSsP.pdf'),
(153, 8107274724, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_zxiJzxWJ.pdf'),
(154, 8107274724, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_iSREQo3Z.pdf'),
(155, 8107274724, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-09 21:30:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_mLqZ26Hh.pdf'),
(156, 8107274724, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-14 10:36:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_Y8aNvGsO.pdf'),
(157, 8105558067, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-10 16:20:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_GzKjdyyJ.pdf'),
(158, 8105558067, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-02 19:42:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_ei8uZnYU.pdf'),
(159, 8105558067, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-09 04:10:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_zASyGifp.pdf'),
(160, 8086995111, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-25 10:05:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_zy7mEwJe.pdf'),
(161, 8086995111, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-06 01:09:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_8dDfc5vs.pdf'),
(162, 8086995111, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-02 12:37:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_QuRONtWz.pdf'),
(163, 8086995111, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-13 18:31:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_VDz15xto.pdf'),
(164, 8238546587, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2022-01-08 08:06:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_RVoICXKI.pdf'),
(165, 8238546587, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-04 02:49:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_UIVRZucs.pdf'),
(166, 8238546587, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 03:00:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_0XEo9i2x.pdf'),
(167, 8241472968, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_5XUzgCg2.pdf'),
(168, 8241472968, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-13 15:28:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_KiUDIrPU.pdf'),
(169, 8241472968, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-23 09:45:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_515bdvaH.pdf'),
(170, 8241472968, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-06 11:37:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_JpIyQrRd.pdf'),
(171, 8429127128, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_FwVAqLKs.pdf'),
(172, 8429127128, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-29 22:00:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_on35Dcg7.pdf'),
(173, 8429127128, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-06 14:22:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_QihY61Wy.pdf'),
(174, 8429127128, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_3sfF8ZTs.pdf'),
(175, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_7I7rSI7B.pdf'),
(176, 8427540745, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-13 07:48:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_oQvguwJf.pdf'),
(177, 8427540745, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 09:54:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_QHZK8XJt.pdf'),
(178, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-13 02:28:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_ZoEagXey.pdf'),
(179, 8418214554, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-19 14:32:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_VnwjEteU.pdf'),
(180, 8418214554, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_15sAimJT.pdf'),
(181, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_17gjuvgC.pdf'),
(182, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-26 09:00:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_p3jHUFcw.pdf'),
(183, 8386666957, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-16 13:10:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_qaepreBI.pdf'),
(184, 8386666957, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-11 19:56:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_8ck1jEJM.pdf'),
(185, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-14 06:51:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_ZsVkeK8Q.pdf'),
(186, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_Lte5IWez.pdf'),
(187, 8383860650, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_sniNy0DU.pdf'),
(188, 8383860650, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-06 04:37:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_CAb6I6un.pdf'),
(189, 8383860650, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_a1CNnsF5.pdf'),
(190, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-16 20:12:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_QaFY08IB.pdf'),
(191, 8382868263, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-27 07:34:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_fW895trj.pdf'),
(192, 8382868263, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-10 10:20:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195823_S68C6Wzn.pdf'),
(193, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-04 14:00:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_9oDumdbR.pdf'),
(194, 8369057129, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-04 15:16:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_NKXxrXIQ.pdf'),
(195, 8369057129, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_rAJIiL69.pdf'),
(196, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-26 05:38:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_9jt5oexp.pdf'),
(197, 8309873253, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-19 01:01:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_bo2xSQxd.pdf'),
(198, 8309873253, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 23:52:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_TbNs5uK9.pdf'),
(199, 8309873253, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-08 02:55:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_GHOXADtQ.pdf'),
(200, 8275722602, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_nIB41fYF.pdf'),
(201, 8275722602, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_RFh6fzpu.pdf'),
(202, 8275722602, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-13 03:24:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_FMPPKI4i.pdf'),
(203, 8253819115, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-12 20:18:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_AsWeZsXC.pdf'),
(204, 8253819115, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-08 13:58:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_oVavC8Xk.pdf'),
(205, 8253819115, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-13 18:48:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_jC2LA1kP.pdf'),
(206, 8253819115, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-11 20:35:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_5C2ZJxPR.pdf'),
(207, 8445403392, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-13 17:07:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_c0HApnip.pdf'),
(208, 8445403392, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-05 15:18:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_IrfASTAm.pdf'),
(209, 8445403392, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-03 02:07:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_8VJOEDz2.pdf'),
(210, 8445403392, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-08 20:39:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Br207PBz.pdf'),
(211, 8429127128, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-10-20 20:27:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_kKxMeprz.pdf'),
(212, 8429127128, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_uDlWhn0Z.pdf'),
(213, 8429127128, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-20 07:44:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_YCONwyxl.pdf'),
(214, 8429127128, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-11 08:19:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_7FLOI0Zb.pdf'),
(215, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_M6HUyp0w.pdf'),
(216, 8427540745, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-03 01:12:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_L4CB0j3b.pdf'),
(217, 8427540745, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-05 19:04:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_bELttJdH.pdf'),
(218, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-16 16:22:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_vqbWlK9S.pdf'),
(219, 8418214554, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_cmtsUEAP.pdf'),
(220, 8418214554, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_wKhSsBwy.pdf'),
(221, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_30ZT6Tz2.pdf'),
(222, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-23 06:16:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_YvarBjAL.pdf'),
(223, 8386666957, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-05 12:34:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_8WJK6xty.pdf'),
(224, 8386666957, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_xNI7XZhS.pdf'),
(225, 8386666957, 'Túlóra tájékoztató', 2, '2022-01-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-14 17:33:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_iflJ7rrJ.pdf'),
(226, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-20 07:05:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_LcKQWXkC.pdf'),
(227, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-21 07:09:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_jDITnzs7.pdf'),
(228, 8383860650, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-24 10:56:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_XCBh6DaH.pdf'),
(229, 8383860650, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-12 15:37:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_15OCAEvk.pdf'),
(230, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-02 23:08:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Tjbwu2R1.pdf'),
(231, 8382868263, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-31 03:21:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_wro0GjD3.pdf'),
(232, 8382868263, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 10:44:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_tejjEETk.pdf'),
(233, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-15 06:35:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_ilTJzlI3.pdf'),
(234, 8369057129, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-08 08:33:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_boRcXvgP.pdf'),
(235, 8369057129, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 04:35:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_c8ACuSuF.pdf'),
(236, 8083605219, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-23 12:57:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_yMrIvTRl.pdf'),
(237, 8083605219, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-13 20:51:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_y3vxxNAB.pdf'),
(238, 8083605219, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-09 23:06:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_X9RorLSD.pdf'),
(239, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-13 14:20:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Sb1ieNJD.pdf'),
(240, 8309873253, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-24 19:51:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_qSb1swdT.pdf'),
(241, 8309873253, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-08 06:27:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_jYtqO9Ft.pdf'),
(242, 8050006918, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_vXMxol3P.pdf'),
(243, 8050006918, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-10 17:05:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_XNv6joY5.pdf'),
(244, 8050006918, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-12 22:23:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_QU0Ltfi1.pdf'),
(245, 8050006918, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-12 23:17:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_M9T7tNFN.pdf'),
(246, 8612304115, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_QqxZTniQ.pdf'),
(247, 8612304115, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-10 03:11:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_UrfvpbgC.pdf'),
(248, 8612304115, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_0soQZQsv.pdf'),
(249, 8612304115, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-11 11:21:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_ivU1iDcE.pdf'),
(250, 8617122087, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-23 20:43:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_2z40nHp1.pdf'),
(251, 8617122087, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-28 15:37:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_KF66K3mI.pdf'),
(252, 8617122087, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-14 02:31:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Et7afiBt.pdf'),
(253, 8617122087, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-14 05:36:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_oljm4WeL.pdf'),
(254, 8671205675, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-20 06:22:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_7X7bPBcw.pdf'),
(255, 8671205675, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-16 11:33:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Zhnlh1ms.pdf'),
(256, 8671205675, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-11 00:54:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_A2hq1w1p.pdf'),
(257, 8679637651, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-29 21:34:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_E3TF5rSE.pdf'),
(258, 8679637651, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_NmJwMZU7.pdf'),
(259, 8679637651, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_dL1ySXdQ.pdf'),
(260, 8679637651, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-14 13:41:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_DYGdnsbM.pdf'),
(261, 8685332332, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-18 18:42:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Kj5kTnXb.pdf'),
(262, 8685332332, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-10 22:21:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_jEHb3246.pdf'),
(263, 8685332332, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-01 00:15:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_gKej7C9h.pdf'),
(264, 8685332332, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-14 12:06:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_c4d14awF.pdf'),
(265, 8690062661, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-10-16 11:25:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_ZdFV2E4a.pdf'),
(266, 8690062661, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-08 23:26:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_5kos3yqY.pdf'),
(267, 8690062661, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-26 02:33:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_cxj9IQB7.pdf'),
(268, 8690062661, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 10:37:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_YWDRq7ai.pdf'),
(269, 8696550988, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-29 12:22:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_jEsXSqLO.pdf'),
(270, 8696550988, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-06 22:45:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_rStDn3Hr.pdf'),
(271, 8696550988, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-12 07:22:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_YdRW6doy.pdf'),
(272, 8698266191, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2022-01-09 05:58:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_5bymqU25.pdf'),
(273, 8698266191, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-01 02:36:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_GUvLqcqb.pdf'),
(274, 8698266191, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_qna1iGgY.pdf'),
(275, 8698266191, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 16:46:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_Wv0ppmnh.pdf'),
(276, 8757596739, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-11-21 21:00:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_99JPJt2l.pdf'),
(277, 8757596739, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-30 19:25:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_OT7oWjHK.pdf'),
(278, 8757596739, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-13 08:50:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_xq9cScrJ.pdf'),
(279, 8777090819, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_gry5omh2.pdf'),
(280, 8777090819, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-10 09:51:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_WhQZzuhC.pdf'),
(281, 8777090819, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-09 03:19:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_VHsCTnL3.pdf'),
(282, 8785725024, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-10 01:17:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_akJPBW6a.pdf'),
(283, 8785725024, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-27 02:50:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_ZbG0d4af.pdf'),
(284, 8785725024, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_0zy1pCAP.pdf');
INSERT INTO `wp_document` (`document_id`, `user_tax_number`, `document_name`, `category_id`, `document_added`, `document_visible`, `document_valid`, `document_downloaded`, `document_path`) VALUES
(285, 8787269676, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195824_eNeTnSE8.pdf'),
(286, 8787269676, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-15 05:11:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_8PS1Phan.pdf'),
(287, 8787269676, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-06 02:43:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_WZJZJ1Dn.pdf'),
(288, 8842743809, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_sKkBtBwk.pdf'),
(289, 8842743809, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2022-01-05 00:50:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_kWwZytsb.pdf'),
(290, 8842743809, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-21 05:25:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_zxVcHq3R.pdf'),
(291, 8842743809, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-12 20:28:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_TLYqxfGS.pdf'),
(292, 8855859093, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-05 02:22:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_Zx7CnUrQ.pdf'),
(293, 8855859093, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_JdNsVNtu.pdf'),
(294, 8855859093, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-18 16:24:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_VmDfekL4.pdf'),
(295, 8855859093, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-07 16:55:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_z2E0xRAP.pdf'),
(296, 8901252746, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-06 04:42:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_ZwHMu1ZN.pdf'),
(297, 8901252746, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-25 03:10:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_nd7dpqYz.pdf'),
(298, 8901252746, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-06 18:44:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_WkUHLHMn.pdf'),
(299, 8901252746, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_rIgmwypZ.pdf'),
(300, 8951823211, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-12-09 20:07:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_ZMgHzwyW.pdf'),
(301, 8951823211, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-11-25 10:20:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_tlLh34QW.pdf'),
(302, 8951823211, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2021-12-17 11:25:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_a4VZoVe0.pdf'),
(303, 8951823211, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-06 20:43:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_ZEkVaUb0.pdf'),
(304, 8958135330, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-09 03:24:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_WWt4oLjo.pdf'),
(305, 8958135330, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2022-01-02 10:49:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_khsBI6YM.pdf'),
(306, 8958135330, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-12 06:04:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_qlGptQcI.pdf'),
(307, 8973182757, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, NULL, '2021-11-12 16:26:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_fnyP5S7x.pdf'),
(308, 8973182757, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, NULL, '2021-12-03 14:30:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_QuuYoDvW.pdf'),
(309, 8973182757, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, NULL, '2022-01-11 15:10:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_NfLl87kj.pdf'),
(310, 8973182757, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, '2022-01-11 12:09:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_5lwY4iJc.pdf'),
(311, 8990386597, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', '2021-12-16 18:03:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_P3OOeffL.pdf'),
(312, 8990386597, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', '2021-12-18 14:45:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_ZxRnO3zv.pdf'),
(313, 8990386597, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-13 04:13:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_ViOpQEYr.pdf'),
(314, 8973182757, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_aXD64l2G.pdf'),
(315, 8713053299, 'Munkabér 2021. október', 1, '2021-11-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_7DghTqq2.pdf'),
(316, 8713053299, 'Munkabér 2021. november', 1, '2021-12-05 11:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_5lSori6s.pdf'),
(317, 8713053299, 'Munkabér 2021. december', 1, '2022-01-05 11:00:00', 1, '2026-11-30 23:59:59', '2022-01-08 08:50:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_k2BUo6HL.pdf'),
(318, 8713053299, 'Munkabér 2021. szeptember', 1, '2021-10-05 11:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_0qnn70pe.pdf'),
(319, 8713053299, 'Túlóra tájékoztató', 2, '2021-10-05 11:00:00', 1, '2022-12-31 23:59:59', '2022-01-03 15:47:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20220114195825_qlsYLyH7.pdf');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wp_document_category`
--

DROP TABLE IF EXISTS `wp_document_category`;
CREATE TABLE `wp_document_category` (
  `category_id` bigint(10) UNSIGNED NOT NULL,
  `category_name` varchar(250) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `wp_document_category`
--

INSERT INTO `wp_document_category` (`category_id`, `category_name`) VALUES
(1, 'Bérjegyzék'),
(2, 'Tájékoztató');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wp_user`
--

DROP TABLE IF EXISTS `wp_user`;
CREATE TABLE `wp_user` (
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
-- A tábla adatainak kiíratása `wp_user`
--

INSERT INTO `wp_user` (`user_tax_number`, `company_code`, `user_status`, `user_real_name`, `user_email`, `email_status`, `user_password`, `user_login_attempt`, `user_last_login_attempt`) VALUES
(8050006918, 2, 1, 'Pintér Jarmilla', 'dhrakar@me.com', 2, '$2y$10$6dXBt/3Yv4PfXOkeI.GVWOqE6xQYKSiUbQ5JpzhjsviJ4DPYGjM32', 2, '2021-11-01 21:19:41'),
(8083605219, 1, 1, 'Szilágyi Szörénke', 'microfab@comcast.net', 2, '$2y$10$GkUgPgfVReZmLv3x9KhMc..pLWEoiLoN5Dqnsm1sM1wslqgBZxURq', 4, '2021-10-03 17:15:31'),
(8086995111, 2, 1, 'Ruzsinszki Deodát', 'oechslin@comcast.net', 2, '$2y$10$C1P8ZEMoqsO2G68zI7aRV.u.VVtI.o1JQhap2Zn5FpDGMNOCF7B82', 2, '2021-11-13 07:14:42'),
(8094707763, 2, 0, 'Szilágyi Szilamér', NULL, 0, NULL, 0, '2021-11-21 22:44:44'),
(8105558067, 1, 1, 'Szilágyi Pintyőke', NULL, 0, '$2y$10$sOZ1ijQMOSDFyDo/cKqGp.x1310r67k5kDL9qFyE9lOTtNpmaLu8.', 2, '2021-10-16 23:22:58'),
(8107274724, 2, 1, 'Pintér Allegra', NULL, 0, '$2y$10$v1FmvKDc6RMGgxY9mW8vAe0unWI7FISbMcg2NaJ6hxXbwO9SlEnV6', 0, '2021-11-01 06:50:19'),
(8127428528, 2, 1, 'Sárközi Lizander', 'monkeydo@att.net', 2, '$2y$10$Equw1TDmpmBhElW0tQIH1uZ4GRhQPVhlWaGl73bychAm4g07JUupK', 2, '2021-10-07 06:59:40'),
(8156208679, 2, 1, 'Ruzsinszki Lizander', 'valdez@gmail.com', 2, '$2y$10$xdRho53uJsLz6xIKB7JhPORe/ra0wQB.MP.r/l3x8v9tQqdETDcl6', 3, '2021-10-08 08:34:16'),
(8162150523, 2, 1, 'Németh Celesztin', 'jgoerzen@outlook.com', 2, '$2y$10$jIfyEoS7zSrIffVyRei1u.SJ7p.6atHmnT7sGPa/91hVDp9OF9yNe', 3, '2021-11-03 13:29:11'),
(8168355683, 2, 1, 'Németh Maximilián', 'bartak@yahoo.com', 2, '$2y$10$Rd3aVw9ew.XkwVOPU45w8Op1AudAO.vXUgo62iupf1Vyosc9mjj4C', 3, '2021-11-27 16:15:59'),
(8170798183, 1, 1, 'Rácz Szörénke', 'gbacon@yahoo.com', 2, '$2y$10$Kgow8K//8ck1fibrK31oYe//1jWAXJvdeXFaVj95FF68iYi5PieaS', 4, '2021-10-25 03:49:26'),
(8173716802, 2, 1, 'Felföldi Allegra', 'rafasgj@att.net', 2, '$2y$10$YebSj3wVVDw9PqTEhyE14.fZecuReaVybClqAOPZOOdtkviBpP.We', 2, '2021-10-20 18:45:56'),
(8195150263, 1, 1, 'Ruzsinszki Jarmilla', 'johndo@hotmail.com', 2, '$2y$10$TDSKxHAJ2ISVy4zMLk4.AO5q5Nd4woo/y6lSxMDyjYu4jdw51pWIO', 0, '2021-10-15 07:37:27'),
(8238546587, 1, 1, 'Gózon Elina', 'agapow@gmail.com', 2, '$2y$10$j97VoYROgQmr9u1Kdryh.eRXtlv0QwJx3a.ri3ex.i6Rge0.ZURm2', 4, '2021-12-03 06:46:49'),
(8241472968, 2, 1, 'Ruzsinszki Ninett', 'rfisher@optonline.net', 2, '$2y$10$KHgYWuuZ1udeweMXslMLQuFhgqLKgA0sOot5pZ3iySP4/oOFgivdq', 4, '2021-12-01 01:23:30'),
(8253819115, 2, 1, 'Sárközi Melodi', 'trygstad@yahoo.com', 2, '$2y$10$FMoFkikh666K6ZC/bd9YFOj99lYRDgCQQoBzvHFi/7cZJKEleZ3zW', 4, '2021-10-22 00:56:13'),
(8275722602, 1, 1, 'Németh Szilamér', 'skippy@sbcglobal.net', 2, '$2y$10$DWb9yNIzi19PHigkd3ER7e3qPOmN2e3GBvIRLn2QnTyyY8LaFUZ8K', 1, '2021-10-11 11:40:57'),
(8309873253, 1, 1, 'Felföldi Bereniké', 'syncnine@yahoo.com', 2, '$2y$10$qmnEBV.u/gwkQNBBzJa5/..fv9Xl7U42yU3UiSjZ5fEBxmfk0zyzq', 4, '2021-10-27 15:50:26'),
(8369057129, 1, 1, 'Gózon Szörénke', 'mcmillan@live.com', 2, '$2y$10$7oQ/PepIyKRsKcviSGQ/Ae.M63Rv8zXDPxTlUzyvTwT7XLgn.Gxp2', 2, '2021-10-27 19:35:57'),
(8382868263, 1, 1, 'Németh Pintyőke', 'tbmaddux@outlook.com', 2, '$2y$10$gjrk9nysUAiKmmKdrzUT2OW1aJ0VxbFYboVA1JKTZ69d78vtL4ma2', 3, '2021-10-02 08:48:50'),
(8383860650, 2, 1, 'Pintér Elina', 'gomor@me.com', 1, '$2y$10$3mJoeLwG00twEZ4BWBwrYO7a04lXeqOzTAtWVMnwjJz7p4QxCAVEK', 3, '2021-10-12 08:27:34'),
(8386666957, 2, 1, 'Sárközi Allegra', 'smallpaul@verizon.net', 2, '$2y$10$eCjgv0eclQuP4yfXqOHeHuY8CBCmBrOiZ.8o8mGVKsX1St/YR1TtC', 3, '2021-11-20 14:48:22'),
(8403042350, 1, 0, 'Felföldi Pintyőke', 'quinn@sbcglobal.net', 0, NULL, 0, '2021-10-26 08:57:42'),
(8418214554, 1, 1, 'Rácz Bereniké', 'wonderkid@gmail.com', 2, '$2y$10$oQL690P.ZW7t1/u/ELPy4ucwjq/uiqGGfaDaDl0JKYLuc10pyJnO.', 1, '2021-12-01 06:20:46'),
(8427540745, 1, 1, 'Ruzsinszki Zengő', 'pemungkah@mac.com', 2, '$2y$10$.fzFbOXX.sVTr0XEVsjZNelFhsKFPmOrRnu4Wm32TWNOf48dVv2VW', 1, '2021-11-04 01:01:08'),
(8429127128, 2, 1, 'Ruzsinszki Bereniké', 'gbacon@aol.com', 2, '$2y$10$DoBe4R/u/gU/dfKs1RuwjevYQ/BR0mnWc.xPGKsYCQ3S5fQ6jT2Ay', 4, '2021-11-18 11:37:39'),
(8445403392, 2, 1, 'Rácz Surd', 'storerm@optonline.net', 2, '$2y$10$8p/mTwJwp9lXpPLfXbvEjekNhssh9gvF7r5pc3SPwa6Gd8yDIsVze', 3, '2021-10-07 09:55:35'),
(8499728780, 1, 1, 'Vincziczki Celesztin', 'petersen@aol.com', 2, '$2y$10$bPirOiFnzruSEggfoKzO3eXbl1xJQHpvrOfLyq.9n9YQ4DVJtFDiS', 2, '2021-10-01 14:02:17'),
(8507797079, 2, 1, 'Sárközi Kökény', 'drolsky@outlook.com', 2, '$2y$10$tplJd3WJzdRazjcDNiYSXORM1EA0.qC.wYPDGG/3OARKpRQU8.Hte', 3, '2021-10-18 17:07:09'),
(8509139779, 1, 1, 'Sárközi Celesztin', 'eegsa@verizon.net', 1, '$2y$10$.y4R0TRVnJxls81Ii6bHSO5bWqvxeFn3ps.uXFG9GwLwOjTiu6Jyy', 3, '2021-10-09 17:37:26'),
(8513212045, 1, 1, 'Felföldi Maximilián', 'goresky@att.net', 2, '$2y$10$UCi1/do9yeIfYE4EobhFJOwWEvNy534Cl66npdMzVcas16SBjT74q', 4, '2021-11-02 19:51:02'),
(8544267350, 2, 1, 'Szilágyi Zengő', 'oechslin@gmail.com', 2, '$2y$10$AC4yAIGoojlK0lvOKBM6.uaw298DdC18ZR6EYS6N6kjY3DY4lTfSi', 1, '2021-11-09 20:41:21'),
(8546146995, 2, 1, 'Sárközi Terestyén', 'arandal@verizon.net', 2, '$2y$10$mvM2KO88xN.FFp4oehdfVeAw9yAEWUefe5XCe9chsDgTeZNEq4Lnu', 4, '2021-10-13 09:09:18'),
(8546195037, 1, 1, 'Németh Lizander', 'hyper@hotmail.com', 2, '$2y$10$bTuXyB6ynNEGbd2s/0wAWenGESXEa35sBN.cK7N8PnlyLzX0Wc8qy', 3, '2021-10-02 18:16:50'),
(8552816098, 1, 1, 'Rácz Celesztin', 'trygstad@sbcglobal.net', 2, '$2y$10$RvLKdzxUgK04NYTfjAgv/OhdAgrL08hTYvtQ2BjIfonB7RWqGpftW', 4, '2021-11-23 07:24:06'),
(8576434309, 2, 1, 'Felföldi Lizander', 'jeteve@msn.com', 2, '$2y$10$.7cjtrEvN1T.nlf/8YRaMuuaWqkGdWlaLfV6PSKiq0bnzjHAIKtgK', 0, '2021-11-04 16:20:44'),
(8594964216, 1, 1, 'Berényi Allegra', 'nimaclea@outlook.com', 2, '$2y$10$ZfT8S30at/57JG3uCLCNPeRPgVATKf6yUHQFSQeTGBz08o5OdFyTK', 0, '2021-10-29 04:30:08'),
(8612304115, 2, 1, 'Szilágyi Elina', 'nweaver@att.net', 2, '$2y$10$SU/MGE6LK/wkSOb9ZP4ofukV88r8IaRGLwlbWB/LXN6ox7hMGBe9S', 1, '2021-10-18 05:22:04'),
(8617122087, 2, 1, 'Gózon Szilamér', 'tedrlord@aol.com', 2, '$2y$10$7m4u0iCV3j2OQMiWklmka.wZ1btv4yAI6h39eBdMPQMdkH0TWZAnW', 1, '2021-10-18 05:53:04'),
(8671205675, 1, 1, 'Ruzsinszki Vilibald', NULL, 0, '$2y$10$DAxFTnIv4ytMyM5eT7nvzeQzWYbrs1z8uMglQpvQ79e.DedTwdtkW', 3, '2021-11-02 07:59:37'),
(8677212078, 1, 1, 'Felföldi Vilibald', 'danneng@verizon.net', 2, '$2y$10$8uYnnBjQqeXZIyzobIcGnOVAkeegvgpxUNltWSUvxwXoqEk4hzR.m', 3, '2021-12-03 22:39:21'),
(8679637651, 2, 1, 'Pintér Deodát', 'library@live.com', 1, '$2y$10$DyDXQSKhRo0aZkeizYPPBeHkqtYKlaUR0zML5DGfboeMyaGY1Gq5G', 3, '2021-10-19 16:43:07'),
(8685332332, 2, 1, 'Gózon Deodát', 'scarlet@hotmail.com', 2, '$2y$10$pebgE8KGp53Wo8HiITxgOurMKT98FBurJZ1I0jv/qaGSoJ08CUZta', 0, '2021-11-27 00:40:39'),
(8690062661, 2, 1, 'Berényi Zengő', 'malin@verizon.net', 2, '$2y$10$hswdQToe2wOlsN7XoqPQrOu5oJPgOWar5qt5UAHj2qP6wBPskxrKy', 0, '2021-11-21 14:26:38'),
(8696550988, 1, 1, 'Vincziczki Elina', 'djupedal@msn.com', 2, '$2y$10$BI1SYoiOWD.LRjrXV9sTuOFHRy0x2b7OpaK2sZILmytEEnirMuhJO', 3, '2021-10-22 06:27:23'),
(8698266191, 2, 1, 'Pintér Zengő', 'jschauma@hotmail.com', 1, '$2y$10$o544znF9wusXpowVtbKTxOEk0n9OfXVjR47IUd3TvAXAR/nHuL4U.', 1, '2021-11-10 16:13:41'),
(8713053299, 1, 1, 'Gózon Terestyén', 'draper@icloud.com', 2, '$2y$10$EcXLE/2cn9n6JTd8EE1LCOnINWLjeVQfVT.RKyeXUSVhzSXzUF4Vq', 0, '2022-01-22 19:26:51'),
(8757596739, 1, 1, 'Szilágyi Celesztin', 'evans@verizon.net', 2, '$2y$10$rhPTm4r1DWADURBU097t6.YaSeI/VoE/F1cfuiOGi/kQds2dVlt3m', 1, '2021-11-21 12:09:34'),
(8777090819, 1, 1, 'Vincziczki Szilamér', 'jmmuller@yahoo.com', 2, '$2y$10$gWa3Evrz9siCYiv8SEC.7ekRdK/X.i9Y7OYzf4pW5PsI1h6wvV5eO', 4, '2021-11-12 02:15:56'),
(8785725024, 1, 1, 'Rácz Terestyén', 'chrwin@live.com', 2, '$2y$10$runpPiTz65BErYBg/thH7u19dC6vibJi32Kr4rMZ96CmbL7laoBsW', 1, '2021-10-31 19:22:58'),
(8787269676, 1, 1, 'Gózon Kökény', 'quinn@verizon.net', 2, '$2y$10$rklCSihJ82zQjIWFJ7KKX.drBD2P1TbzGfp9ctGcPQ1yU4gjIAkru', 4, '2021-10-29 02:06:42'),
(8805011634, 2, 0, 'Vincziczki Jarmilla', 'ateniese@optonline.net', 0, NULL, 0, '2021-10-15 23:49:24'),
(8842743809, 2, 1, 'Berényi Deodát', 'jaesenj@hotmail.com', 2, '$2y$10$UkzY9q2t9D.hKTzdIQ7IOe.Bq5Lvq6lIp3EWmQg5.RDaiLDsdM6pi', 0, '2021-10-13 18:29:39'),
(8855859093, 2, 1, 'Németh Elina', 'nullchar@hotmail.com', 2, '$2y$10$NGluyjHxzZCivWJ/gmHIR.iNbXHtVjxiQ5TuVih4BGL0wx993dIXa', 3, '2021-10-03 23:25:34'),
(8901252746, 2, 1, 'Pintér Lizander', 'rjones@comcast.net', 2, '$2y$10$jJyNifalYFrY5Ter65hMaee1Pjl309qooDSR7DejJjZIQtWVhvyCm', 0, '2021-12-02 18:48:11'),
(8951823211, 2, 1, 'Rácz Deodát', 'luvirini@gmail.com', 2, '$2y$10$4arfbPEm3BZFrvnPDZAV4uLe4DjK7p8KwZd/uQlMBBf9T0eE4itF6', 4, '2021-11-23 08:24:33'),
(8958135330, 1, 1, 'Sárközi Pintyőke', 'bester@aol.com', 2, '$2y$10$ZCZLu/FgyNJ8UZ4oG0dBNeuZ6kB6igEgXA7.umgswKtjEd3dwhu/W', 3, '2021-10-04 07:00:02'),
(8973182757, 2, 1, 'Felföldi Celesztin', 'heroine@hotmail.com', 2, '$2y$10$YaPlK3HhdCzzkMq2JJWVIeReAVhnp1VIe3hJz1D7lAaBnUztt94HS', 4, '2021-10-06 06:48:07'),
(8990386597, 1, 1, 'Pintér Ninett', 'adhere@comcast.net', 2, '$2y$10$jRjt1RX5zHTGQeSAoKThJODxmvoqDNqHofZlco3rhHgOrZ/9xcouS', 2, '2021-10-06 22:09:51'),
(8994312129, 1, 1, 'Berényi Vilibald', 'ournews@yahoo.com', 2, '$2y$10$lpkLWROA2iZzpf8mLP5jluRamNHyxNn7VSjl1rmj7dwtoG/ZZKa0q', 3, '2021-11-26 16:54:23');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wp_user_activity_filter`
--

DROP TABLE IF EXISTS `wp_user_activity_filter`;
CREATE TABLE `wp_user_activity_filter` (
  `filter_id` int(10) UNSIGNED NOT NULL,
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `filter_name` varchar(250) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `ufilter` varchar(2000) COLLATE utf8mb4_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `wp_user_activity_filter`
--

INSERT INTO `wp_user_activity_filter` (`filter_id`, `user_tax_number`, `filter_name`, `ufilter`) VALUES
(1, 8713053299, 'Jónás Nyrt. dolgozói', '{\"companyName\":[\"J\\u00f3n\\u00e1s Nyrt.\"],\"userRealName\":[],\"categoryName\":[],\"documentName\":[],\"added\":{},\"validUntil\":{\"checked\":true},\"downloaded\":{\"checked\":false}}'),
(2, 8713053299, 'Balázs Nyrt. Dolgozói', '{\"companyName\":[\"Bal\\u00e1zs \\u00e9s Tsa Bt.\"],\"userRealName\":[],\"categoryName\":[],\"documentName\":[],\"added\":{},\"validUntil\":{\"checked\":true},\"downloaded\":{\"checked\":false}}');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wp_user_email_code`
--

DROP TABLE IF EXISTS `wp_user_email_code`;
CREATE TABLE `wp_user_email_code` (
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `email_code` varchar(100) CHARACTER SET latin2 COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `wp_user_permissions`
--

DROP TABLE IF EXISTS `wp_user_permissions`;
CREATE TABLE `wp_user_permissions` (
  `user_tax_number` bigint(10) UNSIGNED NOT NULL,
  `user_permission` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `wp_user_permissions`
--

INSERT INTO `wp_user_permissions` (`user_tax_number`, `user_permission`) VALUES
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
-- A tábla indexei `wp_company`
--
ALTER TABLE `wp_company`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `company_name` (`company_name`);

--
-- A tábla indexei `wp_document`
--
ALTER TABLE `wp_document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `felhasznalo_adoazonosito` (`user_tax_number`),
  ADD KEY `category_id` (`category_id`);

--
-- A tábla indexei `wp_document_category`
--
ALTER TABLE `wp_document_category`
  ADD PRIMARY KEY (`category_id`);

--
-- A tábla indexei `wp_user`
--
ALTER TABLE `wp_user`
  ADD PRIMARY KEY (`user_tax_number`),
  ADD KEY `company_code` (`company_code`);

--
-- A tábla indexei `wp_user_activity_filter`
--
ALTER TABLE `wp_user_activity_filter`
  ADD PRIMARY KEY (`filter_id`),
  ADD KEY `user_id` (`user_tax_number`);

--
-- A tábla indexei `wp_user_email_code`
--
ALTER TABLE `wp_user_email_code`
  ADD PRIMARY KEY (`user_tax_number`);

--
-- A tábla indexei `wp_user_permissions`
--
ALTER TABLE `wp_user_permissions`
  ADD PRIMARY KEY (`user_tax_number`,`user_permission`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `wp_document`
--
ALTER TABLE `wp_document`
  MODIFY `document_id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

--
-- AUTO_INCREMENT a táblához `wp_document_category`
--
ALTER TABLE `wp_document_category`
  MODIFY `category_id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `wp_user_activity_filter`
--
ALTER TABLE `wp_user_activity_filter`
  MODIFY `filter_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `wp_document`
--
ALTER TABLE `wp_document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `wp_document_category` (`category_id`),
  ADD CONSTRAINT `document_ibfk_2` FOREIGN KEY (`user_tax_number`) REFERENCES `wp_user` (`user_tax_number`);

--
-- Megkötések a táblához `wp_user`
--
ALTER TABLE `wp_user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`company_code`) REFERENCES `wp_company` (`company_id`);

--
-- Megkötések a táblához `user_activity_filter`
--
ALTER TABLE `wp_user_activity_filter`
  ADD CONSTRAINT `user_activity_filter_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `wp_user` (`user_tax_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `wp_user_email_code`
--
ALTER TABLE `wp_user_email_code`
  ADD CONSTRAINT `user_email_code_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `wp_user` (`user_tax_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `wp_user_permissions`
--
ALTER TABLE `wp_user_permissions`
  ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `wp_user` (`user_tax_number`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
