-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 29 Agu 2021 pada 10.56
-- Versi server: 10.4.17-MariaDB
-- Versi PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `newsportal`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbladmin`
--

CREATE TABLE `tbladmin` (
  `id` int(11) NOT NULL,
  `AdminUserName` varchar(255) NOT NULL,
  `AdminPassword` varchar(255) NOT NULL,
  `AdminEmailId` varchar(255) NOT NULL,
  `Is_Active` int(11) NOT NULL,
  `CreationDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbladmin`
--

INSERT INTO `tbladmin` (`id`, `AdminUserName`, `AdminPassword`, `AdminEmailId`, `Is_Active`, `CreationDate`, `UpdationDate`) VALUES
(1, 'admin', '$2y$12$i4LMfeFPQpGSNPTaccIkKuwxAkJ4PhBr3JND7FpXwWFjRvchQn17C', 'phpgurukulofficial@gmail.com', 1, '2018-05-27 17:51:00', '2018-10-24 18:21:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblcategory`
--

CREATE TABLE `tblcategory` (
  `id` int(11) NOT NULL,
  `CategoryName` varchar(200) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL,
  `Is_Active` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tblcategory`
--

INSERT INTO `tblcategory` (`id`, `CategoryName`, `Description`, `PostingDate`, `UpdationDate`, `Is_Active`) VALUES
(2, 'Technology', 'Technology News', '2018-06-06 10:28:09', '2018-06-30 18:41:07', 1),
(3, 'Sports', 'Related to sports news', '2018-06-06 10:35:09', '2018-06-14 11:11:55', 1),
(5, 'Entertainment', 'Entertainment related  News', '2018-06-14 05:32:58', '2018-06-14 05:33:41', 1),
(6, 'Politics', 'Politics', '2018-06-22 15:46:09', '0000-00-00 00:00:00', 1),
(7, 'Business', 'Business', '2018-06-22 15:46:22', '0000-00-00 00:00:00', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblcomments`
--

CREATE TABLE `tblcomments` (
  `id` int(11) NOT NULL,
  `postId` char(11) DEFAULT NULL,
  `name` varchar(120) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `comment` mediumtext DEFAULT NULL,
  `postingDate` timestamp NULL DEFAULT current_timestamp(),
  `status` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tblcomments`
--

INSERT INTO `tblcomments` (`id`, `postId`, `name`, `email`, `comment`, `postingDate`, `status`) VALUES
(1, '12', 'Anuj', 'anuj@gmail.com', 'Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis.', '2018-11-21 11:06:22', 1),
(2, '12', 'Test user', 'test@gmail.com', 'This is sample text for testing.', '2018-11-21 11:25:56', 1),
(3, '7', 'ABC', 'abc@test.com', 'This is sample text for testing.', '2018-11-21 11:27:06', 1),
(4, '12', 'Opal', 'opal@gmail.com', 'halo halo test', '2021-08-07 22:22:05', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblpages`
--

CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `PageName` varchar(200) DEFAULT NULL,
  `PageTitle` mediumtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tblpages`
--

INSERT INTO `tblpages` (`id`, `PageName`, `PageTitle`, `Description`, `PostingDate`, `UpdationDate`) VALUES
(1, 'aboutus', 'About News Portal', '<font color=\"#7b8898\" face=\"Mercury SSm A, Mercury SSm B, Georgia, Times, Times New Roman, Microsoft YaHei New, Microsoft Yahei, å¾®è½¯é›…é»‘, å®‹ä½“, SimSun, STXihei, åŽæ–‡ç»†é»‘, serif\"><span style=\"font-size: 26px;\">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</span></font><br>', '2018-06-30 18:01:03', '2018-06-30 19:19:51'),
(2, 'contactus', 'Contact Details', '<p><br></p><p><b>Address :&nbsp; </b>New Delhi India</p><p><b>Phone Number : </b>+91 -01234567890</p><p><b>Email -id : </b>phpgurukulofficial@gmail.com</p>', '2018-06-30 18:01:36', '2018-06-30 19:23:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblposts`
--

CREATE TABLE `tblposts` (
  `id` int(11) NOT NULL,
  `PostTitle` longtext DEFAULT NULL,
  `CategoryId` int(11) DEFAULT NULL,
  `SubCategoryId` int(11) DEFAULT NULL,
  `PostDetails` longtext CHARACTER SET utf8 DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `Is_Active` int(1) DEFAULT NULL,
  `PostUrl` mediumtext DEFAULT NULL,
  `PostImage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tblposts`
--

INSERT INTO `tblposts` (`id`, `PostTitle`, `CategoryId`, `SubCategoryId`, `PostDetails`, `PostingDate`, `UpdationDate`, `Is_Active`, `PostUrl`, `PostImage`) VALUES
(7, 'Jasprit Bumrah ruled out of England T20I series due to injury', 3, 4, 'Sebuah kota di wilayah barat daya Afghanistan menjadi ibu kota provinsi pertama yang jatuh ke tangan Taliban semenjak kelompok militan ini melancarkan serangan besar-besaran awal tahun ini.Para pejabat setempat mengatakan Taliban telah merebut Zaranj, di provinsi Nimroz, yang merupakan pukulan telak bagi pasukan pemerintah.Kelompok pemberontak terus membuat kemajuan pesat di seluruh negeri ketika pasukan asing mundur.Mereka menguasai kawasan pedesaan dan saat ini menargetkan kota-kota utama.Beberapa ibu kota provinsi lainnya, yang saat ini berada di bawah tekanan, di antaranya Herat di wilayah barat, dan kota-kota di daerah selatan, seperti Kandahar dan Lashkar Gah.Utusan khusus PBB untuk Afghanistan, Deborah Lyons, pada hari Jumat mengatakan perang di sana telah memasuki fase baru, lebih mematikan, dan lebih merusak, dengan lebih dari 1.000 warga sipil tewas dalam sebulan terakhir.Dia memperingatkan bahwa negara itu tengah menuju malapetaka, dan meminta Dewan Keamanan PBB supaya mengeluarkan pernyataan jelas bahwa serangan terhadap kota-kota harus dihentikan sekarang juga.Belakangan, pada hari Jumat, pemerintah Inggris menyarankan semua warganya di Afghanistan untuk meninggalkan negeri itu karena situasi keamanan memburuk.', '2018-06-30 18:49:23', '2021-08-07 22:46:32', 1, 'Jasprit-Bumrah-ruled-out-of-England-T20I-series-due-to-injury', '6d08a26c92cf30db69197a1fb7230626.jpg'),
(10, 'Tata Steel, Thyssenkrupp Finalise Landmark Steel Deal', 7, 9, 'Sebuah kota di wilayah barat daya Afghanistan menjadi ibu kota provinsi pertama yang jatuh ke tangan Taliban semenjak kelompok militan ini melancarkan serangan besar-besaran awal tahun ini.Para pejabat setempat mengatakan Taliban telah merebut Zaranj, di provinsi Nimroz, yang merupakan pukulan telak bagi pasukan pemerintah.Kelompok pemberontak terus membuat kemajuan pesat di seluruh negeri ketika pasukan asing mundur.Mereka menguasai kawasan pedesaan dan saat ini menargetkan kota-kota utama.Beberapa ibu kota provinsi lainnya, yang saat ini berada di bawah tekanan, di antaranya Herat di wilayah barat, dan kota-kota di daerah selatan, seperti Kandahar dan Lashkar Gah.Utusan khusus PBB untuk Afghanistan, Deborah Lyons, pada hari Jumat mengatakan perang di sana telah memasuki fase baru, lebih mematikan, dan lebih merusak, dengan lebih dari 1.000 warga sipil tewas dalam sebulan terakhir.Dia memperingatkan bahwa negara itu tengah menuju malapetaka, dan meminta Dewan Keamanan PBB supaya mengeluarkan pernyataan jelas bahwa serangan terhadap kota-kota harus dihentikan sekarang juga.Belakangan, pada hari Jumat, pemerintah Inggris menyarankan semua warganya di Afghanistan untuk meninggalkan negeri itu karena situasi keamanan memburuk.', '2018-06-30 19:08:56', '2021-08-07 22:46:34', 1, 'Tata-Steel,-Thyssenkrupp-Finalise-Landmark-Steel-Deal', '505e59c459d38ce4e740e3c9f5c6caf7.jpg'),
(11, 'UNs Jean Pierre Lacroix thanks India for contribution to peacekeeping', 6, 8, 'Sebuah kota di wilayah barat daya Afghanistan menjadi ibu kota provinsi pertama yang jatuh ke tangan Taliban semenjak kelompok militan ini melancarkan serangan besar-besaran awal tahun ini.Para pejabat setempat mengatakan Taliban telah merebut Zaranj, di provinsi Nimroz, yang merupakan pukulan telak bagi pasukan pemerintah.Kelompok pemberontak terus membuat kemajuan pesat di seluruh negeri ketika pasukan asing mundur.Mereka menguasai kawasan pedesaan dan saat ini menargetkan kota-kota utama.Beberapa ibu kota provinsi lainnya, yang saat ini berada di bawah tekanan, di antaranya Herat di wilayah barat, dan kota-kota di daerah selatan, seperti Kandahar dan Lashkar Gah.Utusan khusus PBB untuk Afghanistan, Deborah Lyons, pada hari Jumat mengatakan perang di sana telah memasuki fase baru, lebih mematikan, dan lebih merusak, dengan lebih dari 1.000 warga sipil tewas dalam sebulan terakhir.Dia memperingatkan bahwa negara itu tengah menuju malapetaka, dan meminta Dewan Keamanan PBB supaya mengeluarkan pernyataan jelas bahwa serangan terhadap kota-kota harus dihentikan sekarang juga.Belakangan, pada hari Jumat, pemerintah Inggris menyarankan semua warganya di Afghanistan untuk meninggalkan negeri itu karena situasi keamanan memburuk.', '2018-06-30 19:10:36', '2021-08-07 22:46:37', 1, 'UNs-Jean-Pierre-Lacroix-thanks-India-for-contribution-to-peacekeeping', '27095ab35ac9b89abb8f32ad3adef56a.jpg'),
(12, 'Shah holds meeting with NE states leaders in Manipur', 6, 7, 'Sebuah kota di wilayah barat daya Afghanistan menjadi ibu kota provinsi pertama yang jatuh ke tangan Taliban semenjak kelompok militan ini melancarkan serangan besar-besaran awal tahun ini.</br> Para pejabat setempat mengatakan Taliban telah merebut Zaranj, di provinsi Nimroz, yang merupakan pukulan telak bagi pasukan pemerintah.</br>Kelompok pemberontak terus membuat kemajuan pesat di seluruh negeri ketika pasukan asing mundur.</br>Mereka menguasai kawasan pedesaan dan saat ini menargetkan kota-kota utama.Beberapa ibu kota provinsi lainnya, yang saat ini berada di bawah tekanan, di antaranya Herat di wilayah barat, dan kota-kota di daerah selatan, seperti Kandahar dan Lashkar Gah.</br>Utusan khusus PBB untuk Afghanistan, Deborah Lyons, pada hari Jumat mengatakan perang di sana telah memasuki \"fase baru, lebih mematikan, dan lebih merusak\", dengan lebih dari 1.000 warga sipil tewas dalam sebulan terakhir.</br>Dia memperingatkan bahwa negara itu tengah menuju \"malapetaka\", dan meminta Dewan Keamanan PBB supaya mengeluarkan \"pernyataan jelas bahwa serangan terhadap kota-kota harus dihentikan sekarang juga\".</br>Belakangan, pada hari Jumat, pemerintah Inggris menyarankan semua warganya di Afghanistan untuk meninggalkan negeri itu karena situasi keamanan memburuk.', '2018-06-30 19:11:44', '2021-08-07 22:46:30', 1, 'Shah-holds-meeting-with-NE-states-leaders-in-Manipur', '7fdc1a630c238af0815181f9faa190f5.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tblsubcategory`
--

CREATE TABLE `tblsubcategory` (
  `SubCategoryId` int(11) NOT NULL,
  `CategoryId` int(11) DEFAULT NULL,
  `Subcategory` varchar(255) DEFAULT NULL,
  `SubCatDescription` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL,
  `Is_Active` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tblsubcategory`
--

INSERT INTO `tblsubcategory` (`SubCategoryId`, `CategoryId`, `Subcategory`, `SubCatDescription`, `PostingDate`, `UpdationDate`, `Is_Active`) VALUES
(3, 5, 'Bollywood ', 'Bollywood masala', '2018-06-22 15:45:38', '0000-00-00 00:00:00', 1),
(4, 3, 'Cricket', 'Cricket\r\n\r\n', '2018-06-30 09:00:43', '0000-00-00 00:00:00', 1),
(5, 3, 'Football', 'Football', '2018-06-30 09:00:58', '0000-00-00 00:00:00', 1),
(6, 5, 'Television', 'TeleVision', '2018-06-30 18:59:22', '0000-00-00 00:00:00', 1),
(7, 6, 'National', 'National', '2018-06-30 19:04:29', '0000-00-00 00:00:00', 1),
(8, 6, 'International', 'International', '2018-06-30 19:04:43', '0000-00-00 00:00:00', 1),
(9, 7, 'India', 'India', '2018-06-30 19:08:42', '0000-00-00 00:00:00', 1);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbladmin`
--
ALTER TABLE `tbladmin`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblcategory`
--
ALTER TABLE `tblcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblcomments`
--
ALTER TABLE `tblcomments`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblpages`
--
ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblposts`
--
ALTER TABLE `tblposts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tblsubcategory`
--
ALTER TABLE `tblsubcategory`
  ADD PRIMARY KEY (`SubCategoryId`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbladmin`
--
ALTER TABLE `tbladmin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `tblcategory`
--
ALTER TABLE `tblcategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tblcomments`
--
ALTER TABLE `tblcomments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `tblpages`
--
ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tblposts`
--
ALTER TABLE `tblposts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `tblsubcategory`
--
ALTER TABLE `tblsubcategory`
  MODIFY `SubCategoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
