-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Sze 07. 21:23
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
  `company_id` int(10) UNSIGNED NOT NULL,
  `company_name` varchar(45) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

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
  `document_id` int(10) UNSIGNED NOT NULL,
  `user_tax_number` int(10) UNSIGNED NOT NULL,
  `document_name` varchar(100) COLLATE utf8_hungarian_ci NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
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
(418, 1002477194, 'Teszt 01', 1, '2021-09-07 21:07:28', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210728_Vd4YJatk.pdf'),
(419, 1002477194, 'Teszt 02', 2, '2021-09-07 21:07:28', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210728_sFGSdU4r.pdf'),
(420, 1002477194, 'Teszt 03', 1, '2021-09-07 21:07:28', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210728_p8Y1y1oi.pdf'),
(421, 1234567890, 'Teszt 01', 1, '2021-09-07 21:08:53', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210853_Az6kFBsB.pdf'),
(422, 1234567890, 'Teszt 02', 2, '2021-09-07 21:08:53', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210853_BfHPtDPn.pdf'),
(423, 1234567890, 'Teszt 03', 1, '2021-09-07 21:08:53', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210853_ro1VJtQP.pdf'),
(424, 1315760217, 'Teszt 01', 1, '2021-09-07 21:09:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210911_7GvDSHtV.pdf'),
(425, 1315760217, 'Teszt 02', 2, '2021-09-07 21:09:11', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210911_Fd6hthPQ.pdf'),
(426, 1315760217, 'Teszt 03', 1, '2021-09-07 21:09:11', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210911_V7fMU5eR.pdf'),
(427, 1443062569, 'Teszt 01', 1, '2021-09-07 21:09:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210924_L9UvKftT.pdf'),
(428, 1443062569, 'Teszt 02', 2, '2021-09-07 21:09:24', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210924_ZOdyKTnw.pdf'),
(429, 1443062569, 'Teszt 03', 1, '2021-09-07 21:09:24', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210924_HZCHxMXD.pdf'),
(430, 1567276835, 'Teszt 01', 1, '2021-09-07 21:09:40', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210940_bD4BIDer.pdf'),
(431, 1567276835, 'Teszt 02', 2, '2021-09-07 21:09:40', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210940_xeHXbPuu.pdf'),
(432, 1567276835, 'Teszt 03', 1, '2021-09-07 21:09:40', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210940_ZNVbg3mv.pdf'),
(433, 2316039994, 'Teszt 01', 1, '2021-09-07 21:09:54', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210954_iglMrXG5.pdf'),
(434, 2316039994, 'Teszt 02', 2, '2021-09-07 21:09:54', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210954_ILvftJUT.pdf'),
(435, 2316039994, 'Teszt 03', 1, '2021-09-07 21:09:54', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907210954_LEkgd9wh.pdf'),
(436, 2656686847, 'Teszt 01', 1, '2021-09-07 21:10:17', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211017_8XPNmYeY.pdf'),
(437, 2656686847, 'Teszt 02', 2, '2021-09-07 21:10:17', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211017_xjLGtccw.pdf'),
(438, 2656686847, 'Teszt 03', 1, '2021-09-07 21:10:17', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211017_5fqhh1rO.pdf'),
(439, 2909536725, 'Teszt 01', 1, '2021-09-07 21:10:29', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211029_6AdQqoZS.pdf'),
(440, 2909536725, 'Teszt 02', 2, '2021-09-07 21:10:29', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211029_SDf3Ugg0.pdf'),
(441, 2909536725, 'Teszt 03', 1, '2021-09-07 21:10:29', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211029_h5TRB1hW.pdf'),
(442, 3635528484, 'Teszt 01', 1, '2021-09-07 21:10:41', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211041_7d50Gf1x.pdf'),
(443, 3635528484, 'Teszt 02', 2, '2021-09-07 21:10:41', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211041_juaHZzhr.pdf'),
(444, 3635528484, 'Teszt 03', 1, '2021-09-07 21:10:41', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211041_mnaKViYm.pdf'),
(445, 3672948044, 'Teszt 01', 1, '2021-09-07 21:10:52', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211052_6NZZdXEe.pdf'),
(446, 3672948044, 'Teszt 02', 2, '2021-09-07 21:10:52', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211052_E4TvMWmi.pdf'),
(447, 3672948044, 'Teszt 03', 1, '2021-09-07 21:10:52', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211052_ZKLgblPr.pdf'),
(448, 4283164402, 'Teszt 01', 1, '2021-09-07 21:11:04', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211104_xjUNKi8M.pdf'),
(449, 4283164402, 'Teszt 02', 2, '2021-09-07 21:11:04', 1, NULL, NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211104_i6ZjLAjR.pdf'),
(450, 4283164402, 'Teszt 03', 1, '2021-09-07 21:11:04', 1, '2022-12-31 23:59:59', NULL, 'D:\\OneDrive\\web\\thesis-dms/doc/doc_20210907211104_QeEld3Ye.pdf');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `document_category`
--

DROP TABLE IF EXISTS `document_category`;
CREATE TABLE `document_category` (
  `category_id` int(10) UNSIGNED NOT NULL,
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
-- Tábla szerkezet ehhez a táblához `document_code`
--

DROP TABLE IF EXISTS `document_code`;
CREATE TABLE `document_code` (
  `document_id` int(10) UNSIGNED NOT NULL,
  `upload_code` char(60) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_tax_number` int(10) UNSIGNED NOT NULL,
  `company_code` int(10) UNSIGNED NOT NULL,
  `user_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `user_real_name` varchar(45) COLLATE latin2_hungarian_ci NOT NULL,
  `user_email` varchar(45) COLLATE latin2_hungarian_ci DEFAULT NULL,
  `email_status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `user_password` varchar(100) COLLATE latin2_hungarian_ci NOT NULL,
  `user_login_attempt` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `user_last_login_attempt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`user_tax_number`, `company_code`, `user_status`, `user_real_name`, `user_email`, `email_status`, `user_password`, `user_login_attempt`, `user_last_login_attempt`) VALUES
(1002477194, 1, 0, 'Példa Dolgozó3', NULL, 0, '$2y$10$A56yqTRZWAkX/LRtY4Rv9./EvRv9rRemkC2YAS8X4i0q1vPRZm2sq', 0, '2021-09-06 17:15:50'),
(1234567890, 1, 1, 'Példa Dolgozó', 'tiller2004@gmail.com', 2, '$2y$10$oKPCgs20auDNcSe/cxpn4.dsV30OFp8o.Jm9031yZtyhMu9i.MpMK', 0, '2021-09-06 17:15:50'),
(1315760217, 2, 1, 'Példa Dolgozó1', 'till.zoltan90@gmail.com', 2, '$2y$10$KKCcggSasmR3kCRaumaoqubiOSm.OKkTAGxWLBdSsfTdpNEysW9U6', 0, '2021-09-06 17:15:50'),
(1443062569, 2, 1, 'Példa Dolgozó5', NULL, 0, '$2y$10$VqSPGO52dB6K2D8lipp1z.0TjVCIagFsIrVj.urB2TUGqx6PpTRD2', 0, '2021-09-06 17:15:50'),
(1567276835, 1, 1, 'Példa Dolgozó2', NULL, 0, '$2y$10$AKbc8hbK1ElpFvUa1BehM.6I9kr/CY6IbJRUQFZ5L7DeufMWldHhW', 0, '2021-09-06 17:15:50'),
(2316039994, 2, 1, 'Példa Dolgozó6', NULL, 0, '$2y$10$iBjVuUdwFSA8QAAEGa/ITeGfS8LCn/zHETab2nohUonjAde958JSu', 0, '2021-09-06 17:15:50'),
(2656686847, 2, 1, 'Példa Dolgozó10', NULL, 0, '$2y$10$9YWTOAyXIpWreqaDQvYQqu6b.jcDaALxGIGWNYei2N2pL6iNmCnWe', 0, '2021-09-06 17:15:50'),
(2909536725, 1, 1, 'Példa Dolgozó9', NULL, 0, '$2y$10$GYHmoLJ63yl6xamb/4REk.sKhB1Rg5QuK7vCSiQVVacD6X3QNW07m', 0, '2021-09-06 17:15:50'),
(3635528484, 1, 1, 'Példa Dolgozó7', NULL, 0, '$2y$10$B0SesV.UTavivjkbi/ze6eY2ShbB31CZnZa25IDd043Kw31EbLMf.', 0, '2021-09-06 17:15:50'),
(3672948044, 2, 1, 'Példa Dolgozó4', NULL, 0, '$2y$10$XB9Hm5PcK/YvxqYR8Ihf6esvam5RGuQ9RF4JfoM25sKISZFV6QZlO', 0, '2021-09-06 17:15:50'),
(4283164402, 1, 1, 'Példa Dolgozó8', NULL, 0, '$2y$10$xkPgtlcN7FbVuxOQirLiUegAq7G3.Q4GOposoXVNQWWJ50nT0Z2UC', 0, '2021-09-06 17:15:50');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_email_code`
--

DROP TABLE IF EXISTS `user_email_code`;
CREATE TABLE `user_email_code` (
  `user_tax_number` int(10) UNSIGNED NOT NULL,
  `email_code` varchar(100) COLLATE latin2_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin2 COLLATE=latin2_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_permissions`
--

DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE `user_permissions` (
  `user_tax_number` int(10) UNSIGNED NOT NULL,
  `user_permission` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `user_permissions`
--

INSERT INTO `user_permissions` (`user_tax_number`, `user_permission`) VALUES
(1315760217, 0),
(1315760217, 1),
(1315760217, 2),
(1315760217, 3);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_id`);

--
-- A tábla indexei `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `felhasznalo_adoazonosito` (`user_tax_number`),
  ADD KEY `document_ibfk_2` (`category_id`);

--
-- A tábla indexei `document_category`
--
ALTER TABLE `document_category`
  ADD PRIMARY KEY (`category_id`);

--
-- A tábla indexei `document_code`
--
ALTER TABLE `document_code`
  ADD KEY `dokumentum_azon` (`document_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_tax_number`),
  ADD KEY `user_ibfk_1` (`company_code`);

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
  MODIFY `document_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=451;

--
-- AUTO_INCREMENT a táblához `document_category`
--
ALTER TABLE `document_category`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`user_tax_number`) REFERENCES `user` (`user_tax_number`),
  ADD CONSTRAINT `document_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `document_category` (`category_id`);

--
-- Megkötések a táblához `document_code`
--
ALTER TABLE `document_code`
  ADD CONSTRAINT `document_code_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `document` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_id`);

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
