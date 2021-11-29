-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Nov 29. 21:16
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
(1, 8994312129, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_5lvay3MX.pdf'),
(2, 8994312129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_7BSg39rt.pdf'),
(3, 8994312129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-06 22:20:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_8A5hxTqV.pdf'),
(4, 8994312129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_mW4YiBR9.pdf'),
(5, 8275722602, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-05 10:26:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_CrLxNrR5.pdf'),
(6, 8275722602, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-18 09:37:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_JveD7kCI.pdf'),
(7, 8275722602, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-07 02:28:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_91HWhZVq.pdf'),
(8, 8309873253, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-28 12:26:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_JZawLu8x.pdf'),
(9, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-20 20:28:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_3fkK45BF.pdf'),
(10, 8309873253, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_yJNGKw0C.pdf'),
(11, 8309873253, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-08 00:34:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_xCiIxiEP.pdf'),
(12, 8369057129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_vkM74GDW.pdf'),
(13, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-11 00:39:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_vXiBnUtI.pdf'),
(14, 8369057129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-08 10:54:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_jqmqZaeS.pdf'),
(15, 8382868263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-25 23:05:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_petS6OTF.pdf'),
(16, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_9QbPM45T.pdf'),
(17, 8382868263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-04 06:45:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_AoEkDqbo.pdf'),
(18, 8383860650, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-30 23:35:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_ihFZaXQ9.pdf'),
(19, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-10 14:28:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_YrMFG3wN.pdf'),
(20, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-09 08:37:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_aCQujZd6.pdf'),
(21, 8383860650, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-09 15:58:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_VvrbRS6s.pdf'),
(22, 8386666957, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-15 18:04:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_ePj5ZAb5.pdf'),
(23, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-01 01:03:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_KuSV8Mk8.pdf'),
(24, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-20 10:15:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_zRDZmHnU.pdf'),
(25, 8386666957, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 17:41:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_imm8Svxq.pdf'),
(26, 8418214554, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-12 17:35:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_Nd7iUHDv.pdf'),
(27, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_2U5bjABM.pdf'),
(28, 8418214554, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 20:17:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_77m3IqHq.pdf'),
(29, 8427540745, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-30 06:35:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_L9YJ4qmK.pdf'),
(30, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-08 02:25:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_oAeBDT9X.pdf'),
(31, 8427540745, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_jU6gSVf4.pdf'),
(32, 8241472968, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_M1Tm01Oc.pdf'),
(33, 8241472968, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-16 10:26:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_x3de2X4a.pdf'),
(34, 8241472968, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-08 18:53:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_bhTDRq5p.pdf'),
(35, 8241472968, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-02 22:26:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_RKWWNjgD.pdf'),
(36, 8241472968, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-01 10:29:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_KBSuOXRu.pdf'),
(37, 8238546587, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-23 07:33:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_t4HdH4YN.pdf'),
(38, 8238546587, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_6sW4BOVy.pdf'),
(39, 8238546587, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 11:50:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_FUrpiRfB.pdf'),
(40, 8195150263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-04 12:23:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_O9DJWO12.pdf'),
(41, 8195150263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-04 11:44:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_uihPaAmf.pdf'),
(42, 8195150263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 02:45:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_b98cHTkC.pdf'),
(43, 8994312129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-07 11:32:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_bsBY4baa.pdf'),
(44, 8994312129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_YvVODS4a.pdf'),
(45, 8994312129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_Dukd6iA8.pdf'),
(46, 8086995111, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-01 22:19:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_wXL97uJo.pdf'),
(47, 8086995111, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-16 09:04:19', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_LwKUIcTa.pdf'),
(48, 8086995111, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-21 05:00:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_OelsCfsy.pdf'),
(49, 8086995111, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-02 14:35:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_Uu6xF65n.pdf'),
(50, 8105558067, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-31 20:22:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_p0cSHK2j.pdf'),
(51, 8105558067, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-05 11:38:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_kL0AHMhP.pdf'),
(52, 8105558067, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-08 01:41:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_M0NlpvB2.pdf'),
(53, 8105558067, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_nDq5XhwC.pdf'),
(54, 8107274724, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-08 23:55:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211445_wpyVncQb.pdf'),
(55, 8107274724, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-22 09:28:48', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_T3XzSEqe.pdf'),
(56, 8107274724, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-06 07:36:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_N2dyW1hz.pdf'),
(57, 8107274724, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-07 05:36:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_AK1Hn3HP.pdf'),
(58, 8127428528, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_m7HaR56U.pdf'),
(59, 8127428528, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-22 18:18:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_SiLNaS08.pdf'),
(60, 8127428528, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-21 12:29:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_D6ubH8il.pdf'),
(61, 8127428528, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-07 00:12:48', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ZIAsDOXo.pdf'),
(62, 8156208679, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-08 19:27:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_WpNjheSq.pdf'),
(63, 8156208679, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-19 10:36:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_SpBnrqAM.pdf'),
(64, 8156208679, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-10 16:46:25', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_EzzIKbWd.pdf'),
(65, 8156208679, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 21:05:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_8I0Nk47K.pdf'),
(66, 8156208679, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_gHDNEoy8.pdf'),
(67, 8162150523, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-31 16:53:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_q9pxX0Ol.pdf'),
(68, 8162150523, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-07 17:23:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_kD3EcCkx.pdf'),
(69, 8162150523, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-12 01:21:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_U6BG65kp.pdf'),
(70, 8162150523, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_Q4wIrVMg.pdf'),
(71, 8168355683, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-26 07:40:31', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_RwoYZchu.pdf'),
(72, 8168355683, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-25 10:59:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_cOR5jZFE.pdf'),
(73, 8168355683, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-28 19:51:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ndeS3OhW.pdf'),
(74, 8168355683, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 03:32:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_30Xa36GZ.pdf'),
(75, 8170798183, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-10 22:23:01', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_QX2ximiB.pdf'),
(76, 8170798183, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_MqeexS6J.pdf'),
(77, 8170798183, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_llrCuFwP.pdf'),
(78, 8173716802, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-08 17:26:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_aLn0KAAZ.pdf'),
(79, 8173716802, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-09 03:07:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ckRgdqJe.pdf'),
(80, 8173716802, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_KCpe6nR7.pdf'),
(81, 8173716802, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-01 14:44:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_KycrbZv8.pdf'),
(82, 8173716802, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-09 04:57:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_uD4WKttg.pdf'),
(83, 8544267350, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_3V09YAG2.pdf'),
(84, 8544267350, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_QVxepayO.pdf'),
(85, 8544267350, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-22 15:08:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_Hhr9Khaz.pdf'),
(86, 8544267350, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 12:59:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_8k8bGplH.pdf'),
(87, 8546146995, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-01 13:05:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_sqpHKYFg.pdf'),
(88, 8546146995, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-19 00:40:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_lfwbmPu9.pdf'),
(89, 8546146995, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-07 23:05:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_pEfIMLAI.pdf'),
(90, 8546146995, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 12:33:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_GJEof7oO.pdf'),
(91, 8546146995, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-06 14:06:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_dgFBQMnv.pdf'),
(92, 8677212078, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-06 08:36:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_oEPDKVbI.pdf'),
(93, 8677212078, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-17 05:09:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_47aa55R5.pdf'),
(94, 8677212078, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-07 13:54:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ETj1Ya4n.pdf'),
(95, 8552816098, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_rSgZEcLf.pdf'),
(96, 8552816098, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-01 21:30:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_Xl0E9VZs.pdf'),
(97, 8552816098, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 21:02:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_0ZaQdvdK.pdf'),
(98, 8546195037, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-05 13:06:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_e5cTacpH.pdf'),
(99, 8546195037, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-29 08:22:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_dNnHTdrx.pdf'),
(100, 8546195037, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-01 18:22:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_WqgoJzIa.pdf'),
(101, 8499728780, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-29 17:24:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_lmNzqRzZ.pdf'),
(102, 8499728780, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-05 21:43:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_dAtWxHOU.pdf'),
(103, 8499728780, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-03 21:31:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ju92fqqO.pdf'),
(104, 8594964216, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-31 07:16:40', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_33NaW8jd.pdf'),
(105, 8594964216, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-12 05:58:36', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_SBXivsXM.pdf'),
(106, 8594964216, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-06 03:21:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_zpgDJfiE.pdf'),
(107, 8594964216, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-03 17:52:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_YWfjAina.pdf'),
(108, 8445403392, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-28 05:54:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_whBH9lGH.pdf'),
(109, 8445403392, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_fMTbeQBS.pdf'),
(110, 8445403392, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-08 19:59:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ty9Gy2kJ.pdf'),
(111, 8445403392, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-06 04:38:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_KyIhVdZZ.pdf'),
(112, 8576434309, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-02 09:45:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_ojPlBDcd.pdf'),
(113, 8576434309, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-30 05:29:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_TOisz44O.pdf'),
(114, 8576434309, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-10 09:57:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_x92DfmJ5.pdf'),
(115, 8576434309, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_j59NjYg0.pdf'),
(116, 8507797079, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-14 02:55:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_zOJ2mkZu.pdf'),
(117, 8507797079, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-28 06:18:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_RAZgEg6l.pdf'),
(118, 8507797079, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-15 03:53:26', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211446_NnYZj4N8.pdf'),
(119, 8507797079, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 17:11:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_nCo4rKj9.pdf'),
(120, 8195150263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-08 15:41:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_beMcIt1v.pdf'),
(121, 8195150263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-20 21:59:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_2V8xzw1u.pdf'),
(122, 8195150263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-04 08:19:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_wr97ymMl.pdf'),
(123, 8195150263, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-02 20:04:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_gVYrXKCS.pdf'),
(124, 8509139779, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_pgW3yo7J.pdf'),
(125, 8509139779, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-02 18:25:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_O9CKm8uz.pdf'),
(126, 8509139779, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_WrV7zDPx.pdf'),
(127, 8513212045, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-02 10:08:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_Wq9xpX0s.pdf'),
(128, 8513212045, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_KpBIoNV8.pdf'),
(129, 8513212045, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_NYigvhPw.pdf'),
(130, 8173716802, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-07 04:36:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_TOrsANM4.pdf'),
(131, 8173716802, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_wO3wwYIC.pdf'),
(132, 8173716802, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-12 22:50:06', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_T6sXZ6Lv.pdf'),
(133, 8173716802, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 09:43:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_iHiI69dW.pdf'),
(134, 8170798183, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_96ZGgRfZ.pdf'),
(135, 8170798183, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-19 05:45:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_ENE8MTXN.pdf'),
(136, 8170798183, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-04 08:11:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_6V1qVh4Q.pdf'),
(137, 8168355683, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-25 18:00:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_xs5xCJSY.pdf'),
(138, 8168355683, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-09 00:44:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_LjMOdfRP.pdf'),
(139, 8168355683, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-21 14:52:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_FIRZIJzy.pdf'),
(140, 8168355683, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 14:27:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_ijD4Ws9i.pdf'),
(141, 8162150523, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-28 07:06:19', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_rEsY5rqs.pdf'),
(142, 8162150523, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-26 10:03:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_OQ8FwTql.pdf'),
(143, 8162150523, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-27 06:34:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_Y9mxtPjM.pdf'),
(144, 8162150523, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-01 08:57:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_lmtXoYnU.pdf'),
(145, 8156208679, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-08 21:11:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_XiL42KUl.pdf'),
(146, 8156208679, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-22 23:14:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_FR2e6xoE.pdf'),
(147, 8156208679, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-09 16:38:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_uu9ISROV.pdf'),
(148, 8156208679, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 01:01:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_eKs75OLe.pdf'),
(149, 8127428528, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-13 12:53:57', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_q8oxzEXY.pdf'),
(150, 8127428528, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-27 12:44:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_tNNBz5jm.pdf'),
(151, 8127428528, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-15 21:46:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_XYSLW1hr.pdf'),
(152, 8127428528, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-10 05:00:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_0Ifimmxc.pdf'),
(153, 8107274724, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-16 04:25:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_B4fQwUYr.pdf'),
(154, 8107274724, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-09 18:28:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_b7opiTAx.pdf'),
(155, 8107274724, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-07 07:24:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_SG7pKTmn.pdf'),
(156, 8107274724, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_HicA9fj2.pdf'),
(157, 8105558067, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-18 18:05:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_G2hVtOql.pdf'),
(158, 8105558067, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-19 17:29:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_BzPtPiRY.pdf'),
(159, 8105558067, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-01 13:40:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_6L9sdwfZ.pdf'),
(160, 8086995111, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-21 12:21:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_JH5ojLlf.pdf'),
(161, 8086995111, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-29 22:26:17', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_jMioenym.pdf'),
(162, 8086995111, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-06 21:03:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_xwTnt6B4.pdf'),
(163, 8086995111, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 22:17:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_gOanL0wC.pdf'),
(164, 8238546587, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-19 09:32:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_A7Ff9GTq.pdf'),
(165, 8238546587, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-29 01:45:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_WFhsF7v2.pdf'),
(166, 8238546587, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 07:41:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_CFopVU7v.pdf'),
(167, 8241472968, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-14 23:39:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_rD0QzFRj.pdf'),
(168, 8241472968, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-10 18:07:19', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_VguicTfI.pdf'),
(169, 8241472968, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_6cgUoURw.pdf'),
(170, 8241472968, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 07:44:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_crKG4EkO.pdf'),
(171, 8429127128, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-09 23:16:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_lzdFwX8i.pdf'),
(172, 8429127128, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-08 08:30:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_atfrF9CH.pdf'),
(173, 8429127128, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_UJ4LpqSi.pdf'),
(174, 8429127128, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-05 14:31:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_dQ6MfVYW.pdf'),
(175, 8427540745, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-10 12:43:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_VDEHzLDg.pdf'),
(176, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-07 14:02:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_HoITjzGN.pdf'),
(177, 8427540745, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 11:51:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_RR9vrmtN.pdf'),
(178, 8418214554, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_y7FoU1bp.pdf'),
(179, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-09 13:15:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_YLJsvFvf.pdf'),
(180, 8418214554, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_uOIUUz6c.pdf'),
(181, 8386666957, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-27 14:28:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_MxeMJ5S2.pdf'),
(182, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-30 08:50:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_oFNW5FK5.pdf'),
(183, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-01 00:11:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_tzywG5vb.pdf'),
(184, 8386666957, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_1mWqT44w.pdf'),
(185, 8383860650, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_Vvm2RYKs.pdf'),
(186, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_2TmIJekz.pdf'),
(187, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-08 18:59:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_hQJ5s8bb.pdf'),
(188, 8383860650, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 18:15:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_nDfUYluZ.pdf'),
(189, 8383860650, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-06 10:59:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_16g1tbwS.pdf'),
(190, 8382868263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_QZowOJ3w.pdf'),
(191, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-21 14:24:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_YSXHN7Ps.pdf'),
(192, 8382868263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 16:14:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_3m0wJ4ko.pdf'),
(193, 8369057129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-14 04:31:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_3zY1YdHl.pdf'),
(194, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_DbB7CxSt.pdf'),
(195, 8369057129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-07 00:19:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_jzGUp5gp.pdf'),
(196, 8309873253, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-24 00:25:16', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_NDKmMLrD.pdf'),
(197, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-19 10:48:30', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_TuXyXo21.pdf'),
(198, 8309873253, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 11:30:45', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_gZumlmd4.pdf'),
(199, 8309873253, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-10 13:32:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_YJnOmwRO.pdf'),
(200, 8275722602, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-30 21:10:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211447_o2pKpiRH.pdf'),
(201, 8275722602, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_G28nkYhd.pdf'),
(202, 8275722602, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 04:51:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_VS7dx6Lp.pdf'),
(203, 8253819115, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-09 15:28:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_YOZcabnr.pdf'),
(204, 8253819115, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-31 02:18:24', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_2EuxsUoi.pdf'),
(205, 8253819115, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-12 10:29:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_TnorSQiR.pdf'),
(206, 8253819115, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 20:15:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_L4N2SgQ5.pdf'),
(207, 8445403392, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-19 04:37:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_kvBvQFqR.pdf'),
(208, 8445403392, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-13 10:16:50', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_qT78TT1W.pdf'),
(209, 8445403392, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-23 07:09:11', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_BdXCZtoh.pdf'),
(210, 8445403392, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-06 10:01:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_ImKaX62X.pdf'),
(211, 8429127128, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-05 17:57:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_ZeSkc5A4.pdf'),
(212, 8429127128, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-11 12:42:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_YciYgLA5.pdf'),
(213, 8429127128, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_yz7vqW8Q.pdf'),
(214, 8429127128, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 00:46:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_u9BUTIPB.pdf'),
(215, 8427540745, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-09 15:32:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_zXOOkcpu.pdf'),
(216, 8427540745, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-30 03:25:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_Y4uGLhEy.pdf'),
(217, 8427540745, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-01 14:27:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_EKU2H9GG.pdf'),
(218, 8418214554, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_JriKXK0c.pdf'),
(219, 8418214554, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-20 03:23:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_NN6SnyJs.pdf'),
(220, 8418214554, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_sJZfamyb.pdf'),
(221, 8386666957, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-25 15:26:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_5qIa26SI.pdf'),
(222, 8386666957, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-30 15:16:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_vAE7xekT.pdf'),
(223, 8386666957, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-12 00:50:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_CCNh3cem.pdf'),
(224, 8386666957, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 11:45:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_AAYlU9FX.pdf'),
(225, 8386666957, 'Túlóra tájékoztató', 2, '2021-12-01 04:00:00', 1, '2022-12-31 23:59:59', '2021-12-03 12:11:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_ijEJP02R.pdf'),
(226, 8383860650, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-10 06:53:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_qrygFmbv.pdf'),
(227, 8383860650, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-29 10:50:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_PNOQAPI8.pdf'),
(228, 8383860650, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-24 17:16:20', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_uXkvyCsW.pdf'),
(229, 8383860650, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 21:12:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_QdrjZcV0.pdf'),
(230, 8382868263, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-01 03:19:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_YIEB47pW.pdf'),
(231, 8382868263, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-24 02:52:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_f30q2NrN.pdf'),
(232, 8382868263, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 21:40:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_Ff0TWi46.pdf'),
(233, 8369057129, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-09 20:34:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_31wE6SoN.pdf'),
(234, 8369057129, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-06 20:15:48', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_8FQKa2Kg.pdf'),
(235, 8369057129, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-01 13:18:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_nZxakMNw.pdf'),
(236, 8083605219, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-08 09:48:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_WjjYznTy.pdf'),
(237, 8083605219, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_nPZNUWc9.pdf'),
(238, 8083605219, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-07 02:24:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_BaYh4KPB.pdf'),
(239, 8309873253, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-03 20:58:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_EhYLAXz9.pdf'),
(240, 8309873253, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-06 07:56:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_1vKj8iKg.pdf'),
(241, 8309873253, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-03 02:36:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_yimLqADQ.pdf'),
(242, 8050006918, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-26 18:13:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_3uI5mHor.pdf'),
(243, 8050006918, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-26 02:16:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_NgxZMQCJ.pdf'),
(244, 8050006918, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-07 18:15:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_AQeAfQzM.pdf'),
(245, 8050006918, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_gglnnZqO.pdf'),
(246, 8612304115, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-07 15:55:04', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_9QqkyJA7.pdf'),
(247, 8612304115, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-24 04:33:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_5lN7yS5v.pdf'),
(248, 8612304115, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-28 06:51:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_55ny03jA.pdf'),
(249, 8612304115, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 16:06:09', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_FikNhhX8.pdf'),
(250, 8617122087, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_a4Cf9ZTG.pdf'),
(251, 8617122087, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-06 04:23:23', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_uKhC3ZIK.pdf'),
(252, 8617122087, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-22 03:45:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_igxp4KSP.pdf'),
(253, 8617122087, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-09 13:40:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_raKJ8C6B.pdf'),
(254, 8671205675, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-11-11 18:17:00', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_9QdlGXZ5.pdf'),
(255, 8671205675, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-16 22:58:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_58hOHZ2H.pdf'),
(256, 8671205675, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-03 02:16:34', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_UsfTKzoP.pdf'),
(257, 8679637651, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-16 10:58:22', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_OrOr8kcq.pdf'),
(258, 8679637651, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-02 14:43:39', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_BCPiLPQ5.pdf'),
(259, 8679637651, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_JYuzMOZJ.pdf'),
(260, 8679637651, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-02 11:18:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_RKe0Xeuu.pdf'),
(261, 8685332332, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-10-16 18:01:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_xqtwiMTs.pdf'),
(262, 8685332332, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-21 13:47:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_CszXG6ud.pdf'),
(263, 8685332332, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-10 17:34:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_lz1lhrxZ.pdf'),
(264, 8685332332, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-01 17:08:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_mvmyPxPH.pdf'),
(265, 8690062661, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_CYCfF1iC.pdf'),
(266, 8690062661, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-20 20:57:18', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_R44oJkxJ.pdf'),
(267, 8690062661, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-27 23:21:03', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_x769ByAI.pdf'),
(268, 8690062661, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 16:29:08', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_P0l4mOJ3.pdf'),
(269, 8696550988, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-07 00:13:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_B94rEWXF.pdf'),
(270, 8696550988, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-15 17:12:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_SIR03fDF.pdf'),
(271, 8696550988, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-05 21:08:05', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_owdv6HwS.pdf'),
(272, 8698266191, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-21 03:49:59', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_q3wMcGLK.pdf'),
(273, 8698266191, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_wcXIXVJH.pdf'),
(274, 8698266191, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-23 20:29:07', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_Ac7nCumR.pdf'),
(275, 8698266191, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_yhcQm8si.pdf'),
(276, 8757596739, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-05 14:56:02', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_j98KXWCY.pdf'),
(277, 8757596739, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-29 21:03:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_GJ2WxuNx.pdf'),
(278, 8757596739, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-10 00:51:32', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_loLLEI8d.pdf'),
(279, 8777090819, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_FjTSVIEa.pdf'),
(280, 8777090819, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-06 10:31:15', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_IkDcM4aB.pdf'),
(281, 8777090819, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_7F7edKsV.pdf'),
(282, 8785725024, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-02 16:41:46', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_s9FDdliY.pdf'),
(283, 8785725024, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-25 23:01:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_t5EpJK7m.pdf'),
(284, 8785725024, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 00:31:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_6tC9qVXm.pdf');
INSERT INTO `document` (`document_id`, `user_tax_number`, `document_name`, `category_id`, `document_added`, `document_visible`, `document_valid`, `document_downloaded`, `document_path`) VALUES
(285, 8787269676, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-28 02:00:27', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_BS2leTEf.pdf'),
(286, 8787269676, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-12-06 13:53:47', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_VuaoXNG8.pdf'),
(287, 8787269676, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-09 06:57:55', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_4qGSIY9x.pdf'),
(288, 8842743809, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-12-05 19:01:53', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_Azaef04T.pdf'),
(289, 8842743809, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-10-25 19:14:28', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_v55wzbnS.pdf'),
(290, 8842743809, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-12 11:00:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211448_BfzmLtoB.pdf'),
(291, 8842743809, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-03 11:54:41', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_lukE0zjQ.pdf'),
(292, 8855859093, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-09 00:55:21', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_znOxupnA.pdf'),
(293, 8855859093, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-10 12:28:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_oWYOkgvT.pdf'),
(294, 8855859093, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-08 03:14:54', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_mGGUxdUQ.pdf'),
(295, 8855859093, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-06 16:11:13', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_TaaGNik1.pdf'),
(296, 8901252746, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-11-22 22:53:58', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_IHvqb4fg.pdf'),
(297, 8901252746, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-24 19:53:14', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_0Sd6wpis.pdf'),
(298, 8901252746, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-12-01 16:20:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_pb6Ht61E.pdf'),
(299, 8901252746, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 14:32:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_f97oIX6T.pdf'),
(300, 8951823211, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_eUFDiCyW.pdf'),
(301, 8951823211, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-11-29 14:08:56', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_furKb4Wi.pdf'),
(302, 8951823211, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_RxwtxJMV.pdf'),
(303, 8951823211, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_lBDYj8iR.pdf'),
(304, 8958135330, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-06 01:14:10', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_NTXVQP8D.pdf'),
(305, 8958135330, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-11 06:41:33', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_kc6Ssc4l.pdf'),
(306, 8958135330, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-07 11:41:51', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_09NSbKUx.pdf'),
(307, 8973182757, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, NULL, '2021-09-15 05:06:12', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_5U4P3So5.pdf'),
(308, 8973182757, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, NULL, '2021-12-02 04:51:38', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_yRu7Yojb.pdf'),
(309, 8973182757, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, NULL, '2021-11-24 08:33:37', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_MYEgAc4u.pdf'),
(310, 8973182757, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-08 04:36:42', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_fe182AeL.pdf'),
(311, 8990386597, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_iCOuWoiy.pdf'),
(312, 8990386597, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_HNUUrwNd.pdf'),
(313, 8990386597, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 23:19:44', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_oNjLrEh6.pdf'),
(314, 8973182757, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, NULL, '2021-12-04 18:27:49', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_BVSgfXFN.pdf'),
(315, 8713053299, 'Munkabér 2021. szeptember', 1, '2021-10-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-12-02 16:42:29', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_rBjfqRnk.pdf'),
(316, 8713053299, 'Munkabér 2021. október', 1, '2021-11-05 04:00:00', 1, '2026-10-31 23:59:59', '2021-11-09 09:23:43', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_8y6jHeFv.pdf'),
(317, 8713053299, 'Munkabér 2021. november', 1, '2021-12-01 04:00:00', 1, '2026-11-30 23:59:59', '2021-12-02 09:43:52', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_VHCzch3Z.pdf'),
(318, 8713053299, 'Munkabér 2021. augusztus', 1, '2021-09-05 04:00:00', 1, '2026-09-30 23:59:59', '2021-10-21 10:09:35', 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_tujFgQto.pdf'),
(319, 8713053299, 'Túlóra tájékoztató', 2, '2021-09-05 04:00:00', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20211129211449_2eZflE7s.pdf');

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
  MODIFY `document_id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

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
