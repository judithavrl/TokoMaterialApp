-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2020 at 11:07 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualantokomaterial_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `ID_brgmasuk` varchar(100) NOT NULL,
  `tanggal_masuk` date DEFAULT NULL,
  `kode_barang` varchar(100) NOT NULL,
  `nama_barang` varchar(1000) NOT NULL,
  `stok_masuk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`ID_brgmasuk`, `tanggal_masuk`, `kode_barang`, `nama_barang`, `stok_masuk`) VALUES
('BM-000001', '2020-06-03', 'KD-000006', 'Tool Kit Set 6pcs', 10),
('BM-000002', '2020-06-03', 'KD-000008', 'Diton Cat Semprot 300 Ml - Biru', 15),
('BM-000003', '2020-06-03', 'KD-000011', 'K-Lock Engsel Soft Closing Hh001m', 20),
('BM-000004', '2020-06-03', 'KD-000012', 'K-Lock Gagang Pintu 0.8x9.6 Cm', 40),
('BM-000005', '2020-06-03', 'KD-000005', 'Kenmaster K380 Tool Box', 1);

--
-- Triggers `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `barang_masuk` AFTER INSERT ON `barang_masuk` FOR EACH ROW BEGIN

   UPDATE databarang SET stok = stok + NEW.stok_masuk

   WHERE kode_barang = NEW.kode_barang;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `databarang`
--

CREATE TABLE `databarang` (
  `kode_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `kategori` varchar(20) NOT NULL,
  `stok` int(11) NOT NULL,
  `satuan` varchar(20) NOT NULL,
  `hargajual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `databarang`
--

INSERT INTO `databarang` (`kode_barang`, `nama_barang`, `kategori`, `stok`, `satuan`, `hargajual`) VALUES
('KD-000001', 'Semen Gresik PPC 40kg', 'Bahan Bangunan', 1000, 'Sak', 40000),
('KD-000002', 'Semen Tiga Roda 50 kg', 'Bahan Bangunan', 190, 'Sak', 38000),
('KD-000003', 'Solder Listrik Double Power', 'Peralatan Listrik ', 250, 'Buah', 70000),
('KD-000004', 'BROCO Stop Kontak Extension 5 Socket', 'Peralatan Listrik ', 498, 'Buah', 80000),
('KD-000005', 'Kenmaster K380 Tool Box', 'Perkakas', 450, 'Buah', 45000),
('KD-000006', 'Tool Kit Set 6pcs', 'Perkakas', 60, 'Buah', 35000),
('KD-000007', 'Kingorigin Set Kuas Cat 3 Pcs', 'Cat & Peralatannya', 50, 'Buah', 60000),
('KD-000008', 'Diton Cat Semprot 300 Ml - Biru', 'Cat & Peralatannya', 75, 'Buah', 25000),
('KD-000009', 'Diton Cat Semprot 300 Ml - Kuning', 'Cat & Peralatannya', 50, 'Buah', 25000),
('KD-000010', 'Diton Cat Semprot 300 Ml - Silver', 'Cat & Peralatannya', 80, 'Buah', 25000),
('KD-000011', 'K-Lock Engsel Soft Closing Hh001m', 'Pintu', 80, 'Buah', 15000),
('KD-000012', 'K-Lock Gagang Pintu 0.8x9.6 Cm', 'Pintu', 90, 'Buah', 17000);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `no_transaksi` varchar(100) NOT NULL,
  `kode_barang` varchar(100) NOT NULL,
  `nama_barang` varchar(250) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga_satuan` int(11) NOT NULL,
  `harga_akhir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`no_transaksi`, `kode_barang`, `nama_barang`, `jumlah`, `harga_satuan`, `harga_akhir`) VALUES
('TJ-000001', 'KD-000009', 'Diton Cat Semprot 300 Ml - Kuning', 5, 25000, 125000),
('TJ-000002', 'KD-000004', 'BROCO Stop Kontak Extension 5 Socket', 2, 80000, 160000),
('TJ-000002', 'KD-000005', 'Kenmaster K380 Tool Box', 1, 45000, 45000),
('TJ-000003', 'KD-000002', 'Semen Tiga Roda 50 kg', 10, 38000, 380000);

--
-- Triggers `detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `barang_keluar` AFTER INSERT ON `detail_penjualan` FOR EACH ROW BEGIN

   UPDATE databarang SET stok = stok - NEW.jumlah

   WHERE kode_barang = NEW.kode_barang;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_penjualan`
--

CREATE TABLE `transaksi_penjualan` (
  `no_transaksi` varchar(100) NOT NULL,
  `tanggal_jual` varchar(100) NOT NULL,
  `total_harga` int(11) NOT NULL,
  `pembayaran` int(11) NOT NULL,
  `kembali` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaksi_penjualan`
--

INSERT INTO `transaksi_penjualan` (`no_transaksi`, `tanggal_jual`, `total_harga`, `pembayaran`, `kembali`) VALUES
('TJ-000001', '2020-06-03', 125000, 150000, 25000),
('TJ-000002', '2020-06-03', 205000, 210000, 5000),
('TJ-000003', '2020-06-03', 380000, 400000, 20000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transaksi_penjualan`
--
ALTER TABLE `transaksi_penjualan`
  ADD KEY `no_transaksi` (`no_transaksi`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
