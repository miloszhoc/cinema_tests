-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 07 Mar 2022, 14:06
-- Wersja serwera: 10.1.32-MariaDB
-- Wersja PHP: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `testlink`
--

DELIMITER $$
--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `UDFStripHTMLTags` (`Dirty` TEXT) RETURNS TEXT CHARSET utf8 BEGIN
DECLARE iStart, iEnd, iLength int;
   WHILE Locate( '<', Dirty ) > 0 And Locate( '>', Dirty, Locate( '<', Dirty )) > 0 DO
      BEGIN
        SET iStart = Locate( '<', Dirty ), iEnd = Locate( '>', Dirty, Locate('<', Dirty ));
        SET iLength = ( iEnd - iStart) + 1;
        IF iLength > 0 THEN
          BEGIN
            SET Dirty = Insert( Dirty, iStart, iLength, '');
          END;
        END IF;
      END;
    END WHILE;
RETURN Dirty;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `assignment_status`
--

CREATE TABLE `assignment_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `assignment_status`
--

INSERT INTO `assignment_status` (`id`, `description`) VALUES
(1, 'open'),
(2, 'closed'),
(3, 'completed'),
(4, 'todo_urgent'),
(5, 'todo');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `assignment_types`
--

CREATE TABLE `assignment_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_table` varchar(30) DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `assignment_types`
--

INSERT INTO `assignment_types` (`id`, `fk_table`, `description`) VALUES
(1, 'testplan_tcversions', 'testcase_execution'),
(2, 'tcversions', 'testcase_review');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `attachments`
--

CREATE TABLE `attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `fk_table` varchar(250) DEFAULT '',
  `title` varchar(250) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `file_name` varchar(250) NOT NULL DEFAULT '',
  `file_path` varchar(250) DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT '0',
  `file_type` varchar(250) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` longblob,
  `compression_type` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `baseline_l1l2_context`
--

CREATE TABLE `baseline_l1l2_context` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `being_exec_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_exec_ts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `baseline_l1l2_details`
--

CREATE TABLE `baseline_l1l2_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `context_id` int(10) UNSIGNED NOT NULL,
  `top_tsuite_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `child_tsuite_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `status` char(1) DEFAULT NULL,
  `qty` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `total_tc` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `builds`
--

CREATE TABLE `builds` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  `notes` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `release_date` date DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `commit_id` varchar(64) DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `branch` varchar(64) DEFAULT NULL,
  `release_candidate` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Available builds';

--
-- Zrzut danych tabeli `builds`
--

INSERT INTO `builds` (`id`, `testplan_id`, `name`, `notes`, `active`, `is_open`, `author_id`, `creation_ts`, `release_date`, `closed_on_date`, `commit_id`, `tag`, `branch`, `release_candidate`) VALUES
(1, 64, 'test build', '', 1, 1, NULL, '2022-03-05 00:10:56', NULL, NULL, '', '', '', ''),
(2, 64, 'test build 2', '', 1, 1, NULL, '2022-03-06 22:38:48', NULL, NULL, '', '', '', ''),
(3, 427, '07_03', '', 1, 1, NULL, '2022-03-07 12:06:13', NULL, NULL, '', '', '', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cfield_build_design_values`
--

CREATE TABLE `cfield_build_design_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `node_id` int(10) NOT NULL DEFAULT '0',
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cfield_design_values`
--

CREATE TABLE `cfield_design_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `node_id` int(10) NOT NULL DEFAULT '0',
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cfield_execution_values`
--

CREATE TABLE `cfield_execution_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `execution_id` int(10) NOT NULL DEFAULT '0',
  `testplan_id` int(10) NOT NULL DEFAULT '0',
  `tcversion_id` int(10) NOT NULL DEFAULT '0',
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cfield_node_types`
--

CREATE TABLE `cfield_node_types` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `node_type_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cfield_testplan_design_values`
--

CREATE TABLE `cfield_testplan_design_values` (
  `field_id` int(10) NOT NULL DEFAULT '0',
  `link_id` int(10) NOT NULL DEFAULT '0' COMMENT 'point to testplan_tcversion id',
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cfield_testprojects`
--

CREATE TABLE `cfield_testprojects` (
  `field_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `display_order` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `location` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `required_on_design` tinyint(1) NOT NULL DEFAULT '0',
  `required_on_execution` tinyint(1) NOT NULL DEFAULT '0',
  `monitorable` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `codetrackers`
--

CREATE TABLE `codetrackers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT '0',
  `cfg` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` int(10) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `label` varchar(64) NOT NULL DEFAULT '' COMMENT 'label to display on user interface',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `possible_values` varchar(4000) NOT NULL DEFAULT '',
  `default_value` varchar(4000) NOT NULL DEFAULT '',
  `valid_regexp` varchar(255) NOT NULL DEFAULT '',
  `length_min` int(10) NOT NULL DEFAULT '0',
  `length_max` int(10) NOT NULL DEFAULT '0',
  `show_on_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=> show it during specification design',
  `enable_on_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=> user can write/manage it during specification design',
  `show_on_execution` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '1=> show it during test case execution',
  `enable_on_execution` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '1=> user can write/manage it during test case execution',
  `show_on_testplan_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `enable_on_testplan_design` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `db_version`
--

CREATE TABLE `db_version` (
  `version` varchar(50) NOT NULL DEFAULT 'unknown',
  `upgrade_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `db_version`
--

INSERT INTO `db_version` (`version`, `upgrade_ts`, `notes`) VALUES
('DB 1.9.20', '2022-03-04 23:04:26', 'TestLink 1.9.20 Raijin');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `events`
--

CREATE TABLE `events` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `log_level` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `source` varchar(45) DEFAULT NULL,
  `description` text NOT NULL,
  `fired_at` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `activity` varchar(45) DEFAULT NULL,
  `object_id` int(10) UNSIGNED DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `events`
--

INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(1, 1, 16, 'GUI', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:5:\"admin\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646435333, 'LOGIN', 1, 'users'),
(2, 2, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:25:\"audit_testproject_created\";s:6:\"params\";a:1:{i:0;s:12:\"cinema_tests\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646435362, 'CREATE', 1, 'testprojects'),
(3, 3, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646435371, 'PHP', 0, NULL),
(4, 4, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646435371, 'PHP', 0, NULL),
(5, 5, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646435380, 'PHP', 0, NULL),
(6, 6, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646435380, 'PHP', 0, NULL),
(7, 7, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646436788, 'PHP', 0, NULL),
(8, 8, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646436788, 'PHP', 0, NULL),
(9, 9, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646436790, 'PHP', 0, NULL),
(10, 10, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646436802, 'PHP', 0, NULL),
(11, 11, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436826, 'PHP', 0, NULL),
(12, 11, 32, 'GUI - Test Project ID : 1', 'string \'img_title_remove_platform\' is not localized for locale \'en_GB\' ', 1646436827, 'LOCALIZATION', 0, NULL),
(13, 11, 32, 'GUI - Test Project ID : 1', 'string \'remove_plat_msgbox_msg\' is not localized for locale \'en_GB\' ', 1646436827, 'LOCALIZATION', 0, NULL),
(14, 11, 32, 'GUI - Test Project ID : 1', 'string \'remove_plat_msgbox_title\' is not localized for locale \'en_GB\' ', 1646436827, 'LOCALIZATION', 0, NULL),
(15, 12, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646436828, 'PHP', 0, NULL),
(16, 13, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436839, 'PHP', 0, NULL),
(17, 14, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436872, 'PHP', 0, NULL),
(18, 15, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646436873, 'PHP', 0, NULL),
(19, 16, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436887, 'PHP', 0, NULL),
(20, 17, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436906, 'PHP', 0, NULL),
(21, 18, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646436907, 'PHP', 0, NULL),
(22, 19, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436918, 'PHP', 0, NULL),
(23, 20, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436954, 'PHP', 0, NULL),
(24, 21, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646436955, 'PHP', 0, NULL),
(25, 22, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646436969, 'PHP', 0, NULL),
(26, 23, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$dialogName - in R:\\xampp\\htdocs\\testlink\\lib\\keywords\\keywordsEdit.php - Line 68', 1646437091, 'PHP', 0, NULL),
(27, 23, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\ffe7389801f46b1222e9833cab86e7e3e0f5eacd_0.file.keywordsEdit.tpl.php - Line 60', 1646437092, 'PHP', 0, NULL),
(28, 23, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\ffe7389801f46b1222e9833cab86e7e3e0f5eacd_0.file.keywordsEdit.tpl.php - Line 71', 1646437092, 'PHP', 0, NULL),
(29, 23, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\ffe7389801f46b1222e9833cab86e7e3e0f5eacd_0.file.keywordsEdit.tpl.php - Line 72', 1646437092, 'PHP', 0, NULL),
(30, 24, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437117, 'PHP', 0, NULL),
(31, 25, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646437118, 'PHP', 0, NULL),
(32, 26, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646437197, 'PHP', 0, NULL),
(33, 27, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437213, 'PHP', 0, NULL),
(34, 28, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437245, 'PHP', 0, NULL),
(35, 29, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437246, 'PHP', 0, NULL),
(36, 30, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437265, 'PHP', 0, NULL),
(37, 31, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437287, 'PHP', 0, NULL),
(38, 32, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437288, 'PHP', 0, NULL),
(39, 33, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437305, 'PHP', 0, NULL),
(40, 34, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437345, 'PHP', 0, NULL),
(41, 35, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437354, 'PHP', 0, NULL),
(42, 36, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437473, 'PHP', 0, NULL),
(43, 37, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437474, 'PHP', 0, NULL),
(44, 38, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437496, 'PHP', 0, NULL),
(45, 39, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437527, 'PHP', 0, NULL),
(46, 40, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437528, 'PHP', 0, NULL),
(47, 41, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437547, 'PHP', 0, NULL),
(48, 42, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437560, 'PHP', 0, NULL),
(49, 43, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437575, 'PHP', 0, NULL),
(50, 44, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437575, 'PHP', 0, NULL),
(51, 45, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437596, 'PHP', 0, NULL),
(52, 46, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437649, 'PHP', 0, NULL),
(53, 47, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437650, 'PHP', 0, NULL),
(54, 48, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437656, 'PHP', 0, NULL),
(55, 49, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437667, 'PHP', 0, NULL),
(56, 50, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437684, 'PHP', 0, NULL),
(57, 51, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437685, 'PHP', 0, NULL),
(58, 52, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437704, 'PHP', 0, NULL),
(59, 53, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437721, 'PHP', 0, NULL),
(60, 54, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437722, 'PHP', 0, NULL),
(61, 55, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437740, 'PHP', 0, NULL),
(62, 56, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437771, 'PHP', 0, NULL),
(63, 57, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437772, 'PHP', 0, NULL),
(64, 58, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437788, 'PHP', 0, NULL),
(65, 59, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646437810, 'PHP', 0, NULL),
(66, 60, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437822, 'PHP', 0, NULL),
(67, 61, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437840, 'PHP', 0, NULL),
(68, 62, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437841, 'PHP', 0, NULL),
(69, 63, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437852, 'PHP', 0, NULL),
(70, 64, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437880, 'PHP', 0, NULL),
(71, 65, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646437880, 'PHP', 0, NULL),
(72, 66, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646437889, 'PHP', 0, NULL),
(73, 67, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646438842, 'PHP', 0, NULL),
(74, 68, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646438843, 'PHP', 0, NULL),
(75, 69, 32, 'GUI - Test Project ID : 1', 'string \'plugin_TLTest_config\' is not localized for locale \'en_GB\'  - using en_GB', 1646438880, 'LOCALIZATION', 0, NULL),
(76, 70, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646438986, 'PHP', 0, NULL),
(77, 70, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646438986, 'PHP', 0, NULL),
(78, 71, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646438992, 'PHP', 0, NULL),
(79, 71, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646438992, 'PHP', 0, NULL),
(80, 72, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:12:\"cinema_tests\";i:1;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439024, 'CREATED', 64, 'testplans'),
(81, 72, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:32:\"audit_users_roles_added_testplan\";s:6:\"params\";a:3:{i:0;s:5:\"admin\";i:1;s:11:\"test plan 1\";i:2;s:5:\"admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439025, 'ASSIGN', 64, 'testplans'),
(82, 73, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646439027, 'PHP', 0, NULL),
(83, 73, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646439027, 'PHP', 0, NULL),
(84, 73, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index:  - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 302', 1646439027, 'PHP', 0, NULL),
(85, 74, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$creation_ts - in R:\\xampp\\htdocs\\testlink\\lib\\plan\\buildEdit.php - Line 390', 1646439056, 'PHP', 0, NULL),
(86, 74, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:12:\"cinema_tests\";i:1;s:11:\"test plan 1\";i:2;s:10:\"test build\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439056, 'CREATE', 1, 'builds'),
(87, 75, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646439093, 'PHP', 0, NULL),
(88, 76, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:28:\"C-1 : Login as administrator\";i:1;s:1:\"1\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439108, 'ASSIGN', 64, 'testplans'),
(89, 76, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:63:\"C-2 : Login as administrator with access to manage users module\";i:1;s:1:\"1\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439108, 'ASSIGN', 64, 'testplans'),
(90, 76, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:32:\"C-3 : Login as ordinary employee\";i:1;s:1:\"1\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439108, 'ASSIGN', 64, 'testplans'),
(91, 76, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:36:\"C-4 : Login with invalid credentials\";i:1;s:1:\"1\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646439108, 'ASSIGN', 64, 'testplans'),
(92, 77, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646439109, 'PHP', 0, NULL),
(93, 78, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646439115, 'PHP', 0, NULL),
(94, 79, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646439182, 'PHP', 0, NULL),
(95, 80, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646439182, 'PHP', 0, NULL),
(96, 81, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646439197, 'PHP', 0, NULL),
(97, 82, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646581045, 'PHP', 0, NULL),
(98, 83, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646581046, 'PHP', 0, NULL),
(99, 84, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646581057, 'PHP', 0, NULL),
(100, 85, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646581057, 'PHP', 0, NULL),
(101, 86, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646592520, 'PHP', 0, NULL),
(102, 87, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646592557, 'PHP', 0, NULL),
(103, 88, 2, 'GUI', 'E_NOTICE\nUndefined index: testplanid - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 1398', 1646594935, 'PHP', 0, NULL),
(104, 89, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646596367, 'PHP', 0, NULL),
(105, 89, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646596367, 'PHP', 0, NULL),
(106, 90, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646596418, 'PHP', 0, NULL),
(107, 90, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646596418, 'PHP', 0, NULL),
(108, 91, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646596443, 'PHP', 0, NULL),
(109, 91, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646596443, 'PHP', 0, NULL),
(110, 92, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598139, 'PHP', 0, NULL),
(111, 92, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598140, 'PHP', 0, NULL),
(112, 93, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598140, 'PHP', 0, NULL),
(113, 93, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598140, 'PHP', 0, NULL),
(114, 94, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598169, 'PHP', 0, NULL),
(115, 94, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598170, 'PHP', 0, NULL),
(116, 95, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598170, 'PHP', 0, NULL),
(117, 95, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598170, 'PHP', 0, NULL),
(118, 96, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598201, 'PHP', 0, NULL),
(119, 96, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598201, 'PHP', 0, NULL),
(120, 97, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598202, 'PHP', 0, NULL),
(121, 97, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598202, 'PHP', 0, NULL),
(122, 98, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598211, 'PHP', 0, NULL),
(123, 98, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598211, 'PHP', 0, NULL),
(124, 99, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598212, 'PHP', 0, NULL),
(125, 99, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598212, 'PHP', 0, NULL),
(126, 100, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598235, 'PHP', 0, NULL),
(127, 100, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598235, 'PHP', 0, NULL),
(128, 101, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646598235, 'PHP', 0, NULL),
(129, 101, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646598235, 'PHP', 0, NULL),
(130, 102, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646599177, 'PHP', 0, NULL),
(131, 102, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646599177, 'PHP', 0, NULL),
(132, 103, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646599177, 'PHP', 0, NULL),
(133, 103, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646599178, 'PHP', 0, NULL),
(134, 104, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646599265, 'PHP', 0, NULL),
(135, 105, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$platformID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 61', 1646600189, 'PHP', 0, NULL),
(136, 105, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$enable_on_design - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 100', 1646600189, 'PHP', 0, NULL),
(137, 105, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 108', 1646600190, 'PHP', 0, NULL),
(138, 106, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\b843970be75278292d9d658d70484d7726b9583d_0.file.platformsView.tpl.php - Line 100', 1646600198, 'PHP', 0, NULL),
(139, 106, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: inactive_click_to_change - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\b843970be75278292d9d658d70484d7726b9583d_0.file.platformsView.tpl.php - Line 171', 1646600198, 'PHP', 0, NULL),
(140, 106, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: inactive_click_to_change - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\b843970be75278292d9d658d70484d7726b9583d_0.file.platformsView.tpl.php - Line 172', 1646600198, 'PHP', 0, NULL),
(141, 106, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: active_click_to_change - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\b843970be75278292d9d658d70484d7726b9583d_0.file.platformsView.tpl.php - Line 185', 1646600198, 'PHP', 0, NULL),
(142, 106, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: active_click_to_change - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\b843970be75278292d9d658d70484d7726b9583d_0.file.platformsView.tpl.php - Line 186', 1646600199, 'PHP', 0, NULL),
(143, 107, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$platformID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 61', 1646600201, 'PHP', 0, NULL),
(144, 108, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$platformID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 61', 1646600204, 'PHP', 0, NULL),
(145, 108, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$enable_on_design - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 100', 1646600204, 'PHP', 0, NULL),
(146, 108, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\e188996053d3f0975d118851c77bd02f8cd0714d_0.file.platformsEdit.tpl.php - Line 108', 1646600204, 'PHP', 0, NULL),
(147, 109, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600273, 'PHP', 0, NULL),
(148, 110, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600502, 'PHP', 0, NULL),
(149, 111, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600592, 'PHP', 0, NULL),
(150, 112, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600710, 'PHP', 0, NULL),
(151, 113, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600735, 'PHP', 0, NULL),
(152, 114, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600802, 'PHP', 0, NULL),
(153, 115, 2, 'GUI', 'E_NOTICE\nUndefined variable: messagePrefix - in R:\\xampp\\htdocs\\testlink\\lib\\api\\xmlrpc\\v1\\xmlrpc.class.php - Line 4651', 1646600811, 'PHP', 0, NULL),
(154, 116, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646600855, 'PHP', 0, NULL),
(155, 116, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646600855, 'PHP', 0, NULL),
(156, 116, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index:  - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 302', 1646600855, 'PHP', 0, NULL),
(157, 117, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: selected - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\d03b0e9fe0080cba7049e7cb41d0a807d732a04a_0.file.buildEdit.tpl.php - Line 252', 1646600874, 'PHP', 0, NULL),
(158, 118, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: selected - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\d03b0e9fe0080cba7049e7cb41d0a807d732a04a_0.file.buildEdit.tpl.php - Line 252', 1646600880, 'PHP', 0, NULL),
(159, 119, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: selected - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\d03b0e9fe0080cba7049e7cb41d0a807d732a04a_0.file.buildEdit.tpl.php - Line 252', 1646600909, 'PHP', 0, NULL),
(160, 120, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646601849, 'PHP', 0, NULL),
(161, 120, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646601849, 'PHP', 0, NULL),
(162, 121, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604755, 'PHP', 0, NULL),
(163, 121, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604755, 'PHP', 0, NULL),
(164, 122, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604782, 'PHP', 0, NULL),
(165, 122, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604782, 'PHP', 0, NULL),
(166, 123, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604783, 'PHP', 0, NULL),
(167, 123, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604783, 'PHP', 0, NULL),
(168, 124, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604807, 'PHP', 0, NULL),
(169, 124, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604807, 'PHP', 0, NULL),
(170, 125, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604808, 'PHP', 0, NULL),
(171, 125, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604808, 'PHP', 0, NULL),
(172, 126, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604857, 'PHP', 0, NULL),
(173, 126, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604857, 'PHP', 0, NULL),
(174, 127, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604858, 'PHP', 0, NULL),
(175, 127, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604858, 'PHP', 0, NULL),
(176, 128, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604930, 'PHP', 0, NULL),
(177, 128, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604930, 'PHP', 0, NULL),
(178, 129, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646604931, 'PHP', 0, NULL),
(179, 129, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646604931, 'PHP', 0, NULL),
(180, 130, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605078, 'PHP', 0, NULL),
(181, 130, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605078, 'PHP', 0, NULL),
(182, 131, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605078, 'PHP', 0, NULL),
(183, 131, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605079, 'PHP', 0, NULL),
(184, 132, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605114, 'PHP', 0, NULL),
(185, 132, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605114, 'PHP', 0, NULL),
(186, 133, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605115, 'PHP', 0, NULL),
(187, 133, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605115, 'PHP', 0, NULL),
(188, 134, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605129, 'PHP', 0, NULL),
(189, 134, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605129, 'PHP', 0, NULL),
(190, 135, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605130, 'PHP', 0, NULL),
(191, 135, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605130, 'PHP', 0, NULL),
(192, 136, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605149, 'PHP', 0, NULL),
(193, 136, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605149, 'PHP', 0, NULL),
(194, 137, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605149, 'PHP', 0, NULL),
(195, 137, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605149, 'PHP', 0, NULL),
(196, 138, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605160, 'PHP', 0, NULL),
(197, 138, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605161, 'PHP', 0, NULL),
(198, 139, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605161, 'PHP', 0, NULL),
(199, 139, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605161, 'PHP', 0, NULL),
(200, 140, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605185, 'PHP', 0, NULL),
(201, 140, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605185, 'PHP', 0, NULL),
(202, 141, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605185, 'PHP', 0, NULL),
(203, 141, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605185, 'PHP', 0, NULL),
(204, 142, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605211, 'PHP', 0, NULL),
(205, 142, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605212, 'PHP', 0, NULL),
(206, 143, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605243, 'PHP', 0, NULL),
(207, 143, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605243, 'PHP', 0, NULL),
(208, 144, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605261, 'PHP', 0, NULL),
(209, 144, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605262, 'PHP', 0, NULL),
(210, 145, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605262, 'PHP', 0, NULL),
(211, 145, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605262, 'PHP', 0, NULL),
(212, 146, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605288, 'PHP', 0, NULL),
(213, 146, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605288, 'PHP', 0, NULL),
(214, 147, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605288, 'PHP', 0, NULL),
(215, 147, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605288, 'PHP', 0, NULL),
(216, 148, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605309, 'PHP', 0, NULL),
(217, 148, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605310, 'PHP', 0, NULL),
(218, 149, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605310, 'PHP', 0, NULL),
(219, 149, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605310, 'PHP', 0, NULL),
(220, 150, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605315, 'PHP', 0, NULL),
(221, 150, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605315, 'PHP', 0, NULL),
(222, 151, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605316, 'PHP', 0, NULL),
(223, 151, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605316, 'PHP', 0, NULL),
(224, 152, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605354, 'PHP', 0, NULL),
(225, 152, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605354, 'PHP', 0, NULL),
(226, 153, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605355, 'PHP', 0, NULL),
(227, 153, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605355, 'PHP', 0, NULL),
(228, 154, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605368, 'PHP', 0, NULL),
(229, 154, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605368, 'PHP', 0, NULL),
(230, 155, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605369, 'PHP', 0, NULL),
(231, 155, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605369, 'PHP', 0, NULL),
(232, 156, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605408, 'PHP', 0, NULL),
(233, 156, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605408, 'PHP', 0, NULL),
(234, 157, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605409, 'PHP', 0, NULL),
(235, 157, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605409, 'PHP', 0, NULL),
(236, 158, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646605434, 'PHP', 0, NULL),
(237, 159, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646605434, 'PHP', 0, NULL),
(238, 160, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646605574, 'PHP', 0, NULL),
(239, 160, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646605574, 'PHP', 0, NULL),
(240, 161, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$dialogName - in R:\\xampp\\htdocs\\testlink\\lib\\keywords\\keywordsEdit.php - Line 68', 1646605861, 'PHP', 0, NULL),
(241, 161, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\ffe7389801f46b1222e9833cab86e7e3e0f5eacd_0.file.keywordsEdit.tpl.php - Line 60', 1646605861, 'PHP', 0, NULL),
(242, 161, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$bodyOnLoad - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\ffe7389801f46b1222e9833cab86e7e3e0f5eacd_0.file.keywordsEdit.tpl.php - Line 71', 1646605861, 'PHP', 0, NULL),
(243, 161, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$bodyOnUnload - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\ffe7389801f46b1222e9833cab86e7e3e0f5eacd_0.file.keywordsEdit.tpl.php - Line 72', 1646605861, 'PHP', 0, NULL);
INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(244, 162, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646605941, 'PHP', 0, NULL),
(245, 163, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646605941, 'PHP', 0, NULL),
(246, 164, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: selected - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\d03b0e9fe0080cba7049e7cb41d0a807d732a04a_0.file.buildEdit.tpl.php - Line 252', 1646606321, 'PHP', 0, NULL),
(247, 165, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$creation_ts - in R:\\xampp\\htdocs\\testlink\\lib\\plan\\buildEdit.php - Line 390', 1646606328, 'PHP', 0, NULL),
(248, 165, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:12:\"cinema_tests\";i:1;s:11:\"test plan 1\";i:2;s:12:\"test build 2\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646606328, 'CREATE', 2, 'builds'),
(249, 166, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646607230, 'PHP', 0, NULL),
(250, 167, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646607230, 'PHP', 0, NULL),
(251, 168, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646607262, 'PHP', 0, NULL),
(252, 169, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646607262, 'PHP', 0, NULL),
(253, 170, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607266, 'PHP', 0, NULL),
(254, 170, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607267, 'PHP', 0, NULL),
(255, 171, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607300, 'PHP', 0, NULL),
(256, 171, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607301, 'PHP', 0, NULL),
(257, 172, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607348, 'PHP', 0, NULL),
(258, 172, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607348, 'PHP', 0, NULL),
(259, 173, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607357, 'PHP', 0, NULL),
(260, 173, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607357, 'PHP', 0, NULL),
(261, 174, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607400, 'PHP', 0, NULL),
(262, 174, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607400, 'PHP', 0, NULL),
(263, 175, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607419, 'PHP', 0, NULL),
(264, 175, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607419, 'PHP', 0, NULL),
(265, 176, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607442, 'PHP', 0, NULL),
(266, 176, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607442, 'PHP', 0, NULL),
(267, 177, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607531, 'PHP', 0, NULL),
(268, 177, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607531, 'PHP', 0, NULL),
(269, 178, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607539, 'PHP', 0, NULL),
(270, 178, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607539, 'PHP', 0, NULL),
(271, 179, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607565, 'PHP', 0, NULL),
(272, 179, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607565, 'PHP', 0, NULL),
(273, 180, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607569, 'PHP', 0, NULL),
(274, 180, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607569, 'PHP', 0, NULL),
(275, 181, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607622, 'PHP', 0, NULL),
(276, 181, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607622, 'PHP', 0, NULL),
(277, 182, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607623, 'PHP', 0, NULL),
(278, 182, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607623, 'PHP', 0, NULL),
(279, 183, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607720, 'PHP', 0, NULL),
(280, 183, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607721, 'PHP', 0, NULL),
(281, 184, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607721, 'PHP', 0, NULL),
(282, 184, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607721, 'PHP', 0, NULL),
(283, 185, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607738, 'PHP', 0, NULL),
(284, 185, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607739, 'PHP', 0, NULL),
(285, 186, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607739, 'PHP', 0, NULL),
(286, 186, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607739, 'PHP', 0, NULL),
(287, 187, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607836, 'PHP', 0, NULL),
(288, 187, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607836, 'PHP', 0, NULL),
(289, 188, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607836, 'PHP', 0, NULL),
(290, 188, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607837, 'PHP', 0, NULL),
(291, 189, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607855, 'PHP', 0, NULL),
(292, 189, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607855, 'PHP', 0, NULL),
(293, 190, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607856, 'PHP', 0, NULL),
(294, 190, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607856, 'PHP', 0, NULL),
(295, 191, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607875, 'PHP', 0, NULL),
(296, 191, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607875, 'PHP', 0, NULL),
(297, 192, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607876, 'PHP', 0, NULL),
(298, 192, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607876, 'PHP', 0, NULL),
(299, 193, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607882, 'PHP', 0, NULL),
(300, 193, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607882, 'PHP', 0, NULL),
(301, 194, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646607882, 'PHP', 0, NULL),
(302, 194, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646607882, 'PHP', 0, NULL),
(303, 195, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608148, 'PHP', 0, NULL),
(304, 195, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608148, 'PHP', 0, NULL),
(305, 196, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608149, 'PHP', 0, NULL),
(306, 196, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608149, 'PHP', 0, NULL),
(307, 197, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608186, 'PHP', 0, NULL),
(308, 197, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608187, 'PHP', 0, NULL),
(309, 198, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608201, 'PHP', 0, NULL),
(310, 198, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608201, 'PHP', 0, NULL),
(311, 199, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608281, 'PHP', 0, NULL),
(312, 199, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608281, 'PHP', 0, NULL),
(313, 200, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608299, 'PHP', 0, NULL),
(314, 200, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608299, 'PHP', 0, NULL),
(315, 201, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646608313, 'PHP', 0, NULL),
(316, 202, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646608314, 'PHP', 0, NULL),
(317, 203, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:3:\"C-1\";i:1;s:10:\"test build\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646608335, 'DELETE', 1, 'execution'),
(318, 204, 2, 'GUI - Test Project ID : 1', 'In TestRun with testrunid: 7, planid: 64, buildid: 1, testcaseid: 3, Notes: p, Status: http://localhost/testlink/ltx.php?item=exec&feature_id=1&build_id=1', 1646608347, NULL, 0, NULL),
(319, 204, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:3:\"C-1\";i:1;s:10:\"test build\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646608347, 'CREATE', 7, 'execution'),
(320, 205, 2, 'GUI - Test Project ID : 1', 'In TestRun with testrunid: 8, planid: 64, buildid: 2, testcaseid: 3, Notes: f, Status: http://localhost/testlink/ltx.php?item=exec&feature_id=1&build_id=2', 1646608397, NULL, 0, NULL),
(321, 205, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:3:\"C-1\";i:1;s:12:\"test build 2\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646608397, 'CREATE', 8, 'execution'),
(322, 206, 2, 'GUI - Test Project ID : 1', 'In TestRun with testrunid: 9, planid: 64, buildid: 1, testcaseid: 9, Notes: f, Status: http://localhost/testlink/ltx.php?item=exec&feature_id=3&build_id=1', 1646608423, NULL, 0, NULL),
(323, 206, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:16:\"audit_exec_saved\";s:6:\"params\";a:3:{i:0;s:3:\"C-3\";i:1;s:10:\"test build\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646608423, 'CREATE', 9, 'execution'),
(324, 207, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608574, 'PHP', 0, NULL),
(325, 207, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608574, 'PHP', 0, NULL),
(326, 208, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:3:\"C-1\";i:1;s:10:\"test build\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646608628, 'DELETE', 7, 'execution'),
(327, 209, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608665, 'PHP', 0, NULL),
(328, 209, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608665, 'PHP', 0, NULL),
(329, 210, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646608691, 'PHP', 0, NULL),
(330, 210, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646608691, 'PHP', 0, NULL),
(331, 211, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:18:\"audit_exec_deleted\";s:6:\"params\";a:3:{i:0;s:3:\"C-4\";i:1;s:10:\"test build\";i:2;s:11:\"test plan 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646609256, 'DELETE', 2, 'execution'),
(332, 212, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646610567, 'PHP', 0, NULL),
(333, 212, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646610567, 'PHP', 0, NULL),
(334, 213, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646610607, 'PHP', 0, NULL),
(335, 213, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646610607, 'PHP', 0, NULL),
(336, 214, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646643303, 'PHP', 0, NULL),
(337, 214, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646643303, 'PHP', 0, NULL),
(338, 215, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646643359, 'PHP', 0, NULL),
(339, 216, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646643359, 'PHP', 0, NULL),
(340, 217, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646646027, 'PHP', 0, NULL),
(341, 217, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646646027, 'PHP', 0, NULL),
(342, 218, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646474, 'PHP', 0, NULL),
(343, 219, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646646475, 'PHP', 0, NULL),
(344, 220, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646541, 'PHP', 0, NULL),
(345, 221, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646542, 'PHP', 0, NULL),
(346, 222, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646565, 'PHP', 0, NULL),
(347, 223, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646589, 'PHP', 0, NULL),
(348, 224, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646590, 'PHP', 0, NULL),
(349, 225, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646599, 'PHP', 0, NULL),
(350, 226, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646621, 'PHP', 0, NULL),
(351, 227, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646622, 'PHP', 0, NULL),
(352, 228, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646651, 'PHP', 0, NULL),
(353, 229, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646686, 'PHP', 0, NULL),
(354, 230, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646687, 'PHP', 0, NULL),
(355, 231, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646723, 'PHP', 0, NULL),
(356, 232, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646745, 'PHP', 0, NULL),
(357, 233, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646746, 'PHP', 0, NULL),
(358, 234, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646780, 'PHP', 0, NULL),
(359, 235, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646801, 'PHP', 0, NULL),
(360, 236, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646802, 'PHP', 0, NULL),
(361, 237, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646819, 'PHP', 0, NULL),
(362, 238, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646841, 'PHP', 0, NULL),
(363, 239, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646841, 'PHP', 0, NULL),
(364, 240, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646857, 'PHP', 0, NULL),
(365, 241, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646864, 'PHP', 0, NULL),
(366, 242, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646881, 'PHP', 0, NULL),
(367, 243, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646882, 'PHP', 0, NULL),
(368, 244, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646890, 'PHP', 0, NULL),
(369, 245, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646896, 'PHP', 0, NULL),
(370, 246, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646646921, 'PHP', 0, NULL),
(371, 247, 32, 'GUI - Test Project ID : 1', 'string \'plugin_TLTest_testsuite_display_message\' is not localized for locale \'en_GB\'  - using en_GB', 1646646933, 'LOCALIZATION', 0, NULL),
(372, 247, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646646933, NULL, 0, NULL),
(373, 248, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646934, 'PHP', 0, NULL),
(374, 249, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646646995, 'PHP', 0, NULL),
(375, 250, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646646996, 'PHP', 0, NULL),
(376, 251, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647003, 'PHP', 0, NULL),
(377, 252, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647021, 'PHP', 0, NULL),
(378, 253, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647021, 'PHP', 0, NULL),
(379, 254, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647035, 'PHP', 0, NULL),
(380, 255, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647075, 'PHP', 0, NULL),
(381, 256, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647076, 'PHP', 0, NULL),
(382, 257, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647086, 'PHP', 0, NULL),
(383, 258, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647126, 'PHP', 0, NULL),
(384, 259, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647439, 'PHP', 0, NULL),
(385, 260, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647440, 'PHP', 0, NULL),
(386, 261, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647454, 'PHP', 0, NULL),
(387, 262, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647472, 'PHP', 0, NULL),
(388, 263, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647473, 'PHP', 0, NULL),
(389, 264, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647482, 'PHP', 0, NULL),
(390, 265, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647514, 'PHP', 0, NULL),
(391, 266, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647533, 'PHP', 0, NULL),
(392, 267, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647534, 'PHP', 0, NULL),
(393, 268, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647542, 'PHP', 0, NULL),
(394, 269, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647588, 'PHP', 0, NULL),
(395, 270, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647589, 'PHP', 0, NULL),
(396, 271, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647618, 'PHP', 0, NULL),
(397, 272, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647668, 'PHP', 0, NULL),
(398, 273, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647669, 'PHP', 0, NULL),
(399, 274, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647713, 'PHP', 0, NULL),
(400, 275, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647739, 'PHP', 0, NULL),
(401, 276, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647740, 'PHP', 0, NULL),
(402, 277, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647774, 'PHP', 0, NULL),
(403, 278, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647842, 'PHP', 0, NULL),
(404, 279, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647843, 'PHP', 0, NULL),
(405, 280, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647852, 'PHP', 0, NULL),
(406, 281, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647897, 'PHP', 0, NULL),
(407, 282, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647898, 'PHP', 0, NULL),
(408, 283, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647904, 'PHP', 0, NULL),
(409, 284, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647921, 'PHP', 0, NULL),
(410, 285, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647921, 'PHP', 0, NULL),
(411, 286, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647934, 'PHP', 0, NULL),
(412, 287, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647938, 'PHP', 0, NULL),
(413, 288, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647953, 'PHP', 0, NULL),
(414, 289, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646647954, 'PHP', 0, NULL),
(415, 290, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646647976, 'PHP', 0, NULL),
(416, 291, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648006, 'PHP', 0, NULL),
(417, 292, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648007, 'PHP', 0, NULL),
(418, 293, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648016, 'PHP', 0, NULL),
(419, 294, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648034, 'PHP', 0, NULL),
(420, 295, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648047, 'PHP', 0, NULL),
(421, 296, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648048, 'PHP', 0, NULL),
(422, 297, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648055, 'PHP', 0, NULL),
(423, 298, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648068, 'PHP', 0, NULL),
(424, 299, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648085, 'PHP', 0, NULL),
(425, 300, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648085, 'PHP', 0, NULL),
(426, 301, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648092, 'PHP', 0, NULL),
(427, 302, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648107, 'PHP', 0, NULL),
(428, 303, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648108, 'PHP', 0, NULL),
(429, 304, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648125, 'PHP', 0, NULL),
(430, 305, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648149, 'PHP', 0, NULL),
(431, 306, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648149, 'PHP', 0, NULL),
(432, 307, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648310, 'PHP', 0, NULL),
(433, 308, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648572, 'PHP', 0, NULL),
(434, 309, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648573, 'PHP', 0, NULL),
(435, 310, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648600, 'PHP', 0, NULL),
(436, 311, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648623, 'PHP', 0, NULL),
(437, 312, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648624, 'PHP', 0, NULL),
(438, 313, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648631, 'PHP', 0, NULL),
(439, 314, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648664, 'PHP', 0, NULL),
(440, 315, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648665, 'PHP', 0, NULL),
(441, 316, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648674, 'PHP', 0, NULL),
(442, 317, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648685, 'PHP', 0, NULL),
(443, 318, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648686, 'PHP', 0, NULL),
(444, 319, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648698, 'PHP', 0, NULL),
(445, 320, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646648703, 'PHP', 0, NULL),
(446, 321, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646648774, NULL, 0, NULL),
(447, 322, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648774, 'PHP', 0, NULL),
(448, 323, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648792, 'PHP', 0, NULL),
(449, 324, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648793, 'PHP', 0, NULL),
(450, 325, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648799, 'PHP', 0, NULL),
(451, 326, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648812, 'PHP', 0, NULL),
(452, 327, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648813, 'PHP', 0, NULL),
(453, 328, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648825, 'PHP', 0, NULL),
(454, 329, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648846, 'PHP', 0, NULL),
(455, 330, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648847, 'PHP', 0, NULL),
(456, 331, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648864, 'PHP', 0, NULL),
(457, 332, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648873, 'PHP', 0, NULL),
(458, 333, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648890, 'PHP', 0, NULL),
(459, 334, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648891, 'PHP', 0, NULL),
(460, 335, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648900, 'PHP', 0, NULL),
(461, 336, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648914, 'PHP', 0, NULL),
(462, 337, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648915, 'PHP', 0, NULL),
(463, 338, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648929, 'PHP', 0, NULL),
(464, 339, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648953, 'PHP', 0, NULL),
(465, 340, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648953, 'PHP', 0, NULL),
(466, 341, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648968, 'PHP', 0, NULL),
(467, 342, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646648985, 'PHP', 0, NULL),
(468, 343, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646648986, 'PHP', 0, NULL),
(469, 344, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649000, 'PHP', 0, NULL),
(470, 345, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649007, 'PHP', 0, NULL),
(471, 346, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649025, 'PHP', 0, NULL),
(472, 347, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649026, 'PHP', 0, NULL),
(473, 348, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649035, 'PHP', 0, NULL),
(474, 349, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649049, 'PHP', 0, NULL),
(475, 350, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649050, 'PHP', 0, NULL),
(476, 351, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649059, 'PHP', 0, NULL),
(477, 352, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649071, 'PHP', 0, NULL),
(478, 353, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649071, 'PHP', 0, NULL),
(479, 354, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649089, 'PHP', 0, NULL),
(480, 355, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646649118, 'PHP', 0, NULL),
(481, 356, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646649120, 'PHP', 0, NULL),
(482, 357, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649130, NULL, 0, NULL);
INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(483, 358, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649131, 'PHP', 0, NULL),
(484, 359, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649150, 'PHP', 0, NULL),
(485, 360, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649151, 'PHP', 0, NULL),
(486, 361, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649158, 'PHP', 0, NULL),
(487, 362, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649171, 'PHP', 0, NULL),
(488, 363, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649172, 'PHP', 0, NULL),
(489, 364, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649189, 'PHP', 0, NULL),
(490, 365, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649204, 'PHP', 0, NULL),
(491, 366, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649205, 'PHP', 0, NULL),
(492, 367, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649228, 'PHP', 0, NULL),
(493, 368, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649246, 'PHP', 0, NULL),
(494, 369, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649247, 'PHP', 0, NULL),
(495, 370, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649255, 'PHP', 0, NULL),
(496, 371, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649266, 'PHP', 0, NULL),
(497, 372, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649267, 'PHP', 0, NULL),
(498, 373, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649280, 'PHP', 0, NULL),
(499, 374, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649285, 'PHP', 0, NULL),
(500, 375, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649297, 'PHP', 0, NULL),
(501, 376, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649298, 'PHP', 0, NULL),
(502, 377, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649313, 'PHP', 0, NULL),
(503, 378, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649404, 'PHP', 0, NULL),
(504, 379, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649405, 'PHP', 0, NULL),
(505, 380, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649420, 'PHP', 0, NULL),
(506, 381, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649434, 'PHP', 0, NULL),
(507, 382, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649435, 'PHP', 0, NULL),
(508, 383, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649446, 'PHP', 0, NULL),
(509, 384, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649462, 'PHP', 0, NULL),
(510, 385, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649463, 'PHP', 0, NULL),
(511, 386, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649469, 'PHP', 0, NULL),
(512, 387, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649492, 'PHP', 0, NULL),
(513, 388, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649493, 'PHP', 0, NULL),
(514, 389, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649508, 'PHP', 0, NULL),
(515, 390, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649539, 'PHP', 0, NULL),
(516, 391, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649540, 'PHP', 0, NULL),
(517, 392, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649556, 'PHP', 0, NULL),
(518, 393, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646649600, 'PHP', 0, NULL),
(519, 394, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649612, NULL, 0, NULL),
(520, 395, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649613, 'PHP', 0, NULL),
(521, 396, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646649649, 'PHP', 0, NULL),
(522, 397, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649653, 'PHP', 0, NULL),
(523, 398, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646649654, 'PHP', 0, NULL),
(524, 399, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646649658, 'PHP', 0, NULL),
(525, 400, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649665, NULL, 0, NULL),
(526, 401, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649666, 'PHP', 0, NULL),
(527, 402, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649673, 'PHP', 0, NULL),
(528, 403, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649674, 'PHP', 0, NULL),
(529, 404, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649696, NULL, 0, NULL),
(530, 405, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649697, 'PHP', 0, NULL),
(531, 406, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649705, NULL, 0, NULL),
(532, 407, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649706, 'PHP', 0, NULL),
(533, 408, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649712, NULL, 0, NULL),
(534, 409, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649712, 'PHP', 0, NULL),
(535, 410, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649719, NULL, 0, NULL),
(536, 411, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649720, 'PHP', 0, NULL),
(537, 412, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649724, NULL, 0, NULL),
(538, 413, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649724, 'PHP', 0, NULL),
(539, 414, 2, 'GUI - Test Project ID : 1', 'Im in testsuite create', 1646649727, NULL, 0, NULL),
(540, 415, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649727, 'PHP', 0, NULL),
(541, 416, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649763, 'PHP', 0, NULL),
(542, 417, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649764, 'PHP', 0, NULL),
(543, 418, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649771, 'PHP', 0, NULL),
(544, 419, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649793, 'PHP', 0, NULL),
(545, 420, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649794, 'PHP', 0, NULL),
(546, 421, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649801, 'PHP', 0, NULL),
(547, 422, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649824, 'PHP', 0, NULL),
(548, 423, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649825, 'PHP', 0, NULL),
(549, 424, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649833, 'PHP', 0, NULL),
(550, 425, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649845, 'PHP', 0, NULL),
(551, 426, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649846, 'PHP', 0, NULL),
(552, 427, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649855, 'PHP', 0, NULL),
(553, 428, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649870, 'PHP', 0, NULL),
(554, 429, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649871, 'PHP', 0, NULL),
(555, 430, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649877, 'PHP', 0, NULL),
(556, 431, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649889, 'PHP', 0, NULL),
(557, 432, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649890, 'PHP', 0, NULL),
(558, 433, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649897, 'PHP', 0, NULL),
(559, 434, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649910, 'PHP', 0, NULL),
(560, 435, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649911, 'PHP', 0, NULL),
(561, 436, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649919, 'PHP', 0, NULL),
(562, 437, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649956, 'PHP', 0, NULL),
(563, 438, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649957, 'PHP', 0, NULL),
(564, 439, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649962, 'PHP', 0, NULL),
(565, 440, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649975, 'PHP', 0, NULL),
(566, 441, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649976, 'PHP', 0, NULL),
(567, 442, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649982, 'PHP', 0, NULL),
(568, 443, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646649993, 'PHP', 0, NULL),
(569, 444, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646649994, 'PHP', 0, NULL),
(570, 445, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650001, 'PHP', 0, NULL),
(571, 446, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650019, 'PHP', 0, NULL),
(572, 447, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650020, 'PHP', 0, NULL),
(573, 448, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650026, 'PHP', 0, NULL),
(574, 449, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650030, 'PHP', 0, NULL),
(575, 450, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650044, 'PHP', 0, NULL),
(576, 451, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650045, 'PHP', 0, NULL),
(577, 452, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650052, 'PHP', 0, NULL),
(578, 453, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650076, 'PHP', 0, NULL),
(579, 454, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650077, 'PHP', 0, NULL),
(580, 455, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650084, 'PHP', 0, NULL),
(581, 456, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650095, 'PHP', 0, NULL),
(582, 457, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650095, 'PHP', 0, NULL),
(583, 458, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650105, 'PHP', 0, NULL),
(584, 459, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650116, 'PHP', 0, NULL),
(585, 460, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650117, 'PHP', 0, NULL),
(586, 461, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650157, 'PHP', 0, NULL),
(587, 462, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650172, 'PHP', 0, NULL),
(588, 463, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650173, 'PHP', 0, NULL),
(589, 464, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650190, 'PHP', 0, NULL),
(590, 465, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650205, 'PHP', 0, NULL),
(591, 466, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650206, 'PHP', 0, NULL),
(592, 467, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650223, 'PHP', 0, NULL),
(593, 468, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650236, 'PHP', 0, NULL),
(594, 469, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650236, 'PHP', 0, NULL),
(595, 470, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650265, 'PHP', 0, NULL),
(596, 471, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650278, 'PHP', 0, NULL),
(597, 472, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650279, 'PHP', 0, NULL),
(598, 473, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650292, 'PHP', 0, NULL),
(599, 474, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650297, 'PHP', 0, NULL),
(600, 475, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650311, 'PHP', 0, NULL),
(601, 476, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650312, 'PHP', 0, NULL),
(602, 477, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650324, 'PHP', 0, NULL),
(603, 478, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650338, 'PHP', 0, NULL),
(604, 479, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650339, 'PHP', 0, NULL),
(605, 480, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650350, 'PHP', 0, NULL),
(606, 481, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650363, 'PHP', 0, NULL),
(607, 482, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650364, 'PHP', 0, NULL),
(608, 483, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650387, 'PHP', 0, NULL),
(609, 484, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650401, 'PHP', 0, NULL),
(610, 485, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650413, 'PHP', 0, NULL),
(611, 486, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650424, 'PHP', 0, NULL),
(612, 487, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650439, 'PHP', 0, NULL),
(613, 488, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650455, 'PHP', 0, NULL),
(614, 489, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650467, 'PHP', 0, NULL),
(615, 490, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650482, 'PHP', 0, NULL),
(616, 491, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\lib\\testcases\\testcaseCommands.class.php - Line 1129', 1646650492, 'PHP', 0, NULL),
(617, 492, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646650511, 'PHP', 0, NULL),
(618, 493, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646650538, 'PHP', 0, NULL),
(619, 494, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650543, 'PHP', 0, NULL),
(620, 495, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646650573, 'PHP', 0, NULL),
(621, 496, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646651718, 'PHP', 0, NULL),
(622, 497, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646653107, 'PHP', 0, NULL),
(623, 498, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646653108, 'PHP', 0, NULL),
(624, 499, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646653135, 'PHP', 0, NULL),
(625, 500, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654347, 'PHP', 0, NULL),
(626, 501, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646654348, 'PHP', 0, NULL),
(627, 502, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646654602, 'PHP', 0, NULL),
(628, 502, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646654602, 'PHP', 0, NULL),
(629, 503, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:22:\"audit_testplan_created\";s:6:\"params\";a:2:{i:0;s:12:\"cinema_tests\";i:1;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654613, 'CREATED', 427, 'testplans'),
(630, 503, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:32:\"audit_users_roles_added_testplan\";s:6:\"params\";a:3:{i:0;s:5:\"admin\";i:1;s:3:\"All\";i:2;s:5:\"admin\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654613, 'ASSIGN', 427, 'testplans'),
(631, 504, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654631, 'PHP', 0, NULL),
(632, 505, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654636, 'PHP', 0, NULL),
(633, 506, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:28:\"C-1 : Login as administrator\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654672, 'ASSIGN', 427, 'testplans'),
(634, 506, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:63:\"C-2 : Login as administrator with access to manage users module\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654672, 'ASSIGN', 427, 'testplans'),
(635, 506, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:32:\"C-3 : Login as ordinary employee\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654672, 'ASSIGN', 427, 'testplans'),
(636, 506, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:36:\"C-4 : Login with invalid credentials\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654672, 'ASSIGN', 427, 'testplans'),
(637, 507, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654673, 'PHP', 0, NULL),
(638, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:17:\"C-5 : Open module\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654682, 'ASSIGN', 427, 'testplans'),
(639, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:18:\"C-14 : Open module\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(640, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:40:\"C-16 : Open archive film screenings list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(641, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:32:\"C-18 : Add active film screening\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(642, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:28:\"C-22 : Update film screening\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(643, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:28:\"C-23 : Delete film screening\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(644, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:47:\"C-24 : open reservation list (active film show)\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(645, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:49:\"C-25 : open reservation list (archived film show)\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(646, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:61:\"C-26 : add resetvation to active film screening with an email\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(647, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:62:\"C-27 : add resetvation to archive film screening with an email\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(648, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:49:\"C-29 : choose taken seats in add reservation form\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654683, 'ASSIGN', 427, 'testplans'),
(649, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:72:\"C-31 : add resetvation to active film screening and confirm it instantly\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(650, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:77:\"C-32 : add resetvation to active film screening and mark it as paid instantly\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(651, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:49:\"C-33 : add resetvation to archived film screening\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(652, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:31:\"C-34 : open reservation details\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(653, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:50:\"C-35 : update reservation in active film screening\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(654, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:78:\"C-36 : add tickets to existing reservation in active film screening with email\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(655, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:52:\"C-38 : choose taken seats in update reservation form\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(656, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:65:\"C-40 : update payment and confirmation status in active film show\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(657, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:50:\"C-42 : delete reservation in active film screening\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(658, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:55:\"C-45 : Trigger automatic reservations deletion manually\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(659, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:30:\"C-46 : open active movies list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654684, 'ASSIGN', 427, 'testplans'),
(660, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:31:\"C-47 : open deleted movies list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(661, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:20:\"C-48 : add new movie\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(662, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:25:\"C-49 : open movie details\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(663, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:19:\"C-50 : update movie\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(664, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:31:\"C-51 : delete movie permanently\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(665, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:28:\"C-52 : abandon deletion form\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(666, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:44:\"C-53 : delete movie without admin privilages\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(667, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:28:\"C-55 : mark movie as deleted\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(668, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:36:\"C-56 : open active ticket types list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(669, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:37:\"C-57 : open deleted ticket types list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654685, 'ASSIGN', 427, 'testplans'),
(670, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:26:\"C-58 : add new ticket type\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654686, 'ASSIGN', 427, 'testplans'),
(671, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:31:\"C-59 : open ticket type details\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654686, 'ASSIGN', 427, 'testplans'),
(672, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:25:\"C-60 : update ticket type\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654686, 'ASSIGN', 427, 'testplans'),
(673, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:37:\"C-62 : delete ticket type permanently\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654686, 'ASSIGN', 427, 'testplans'),
(674, 508, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:34:\"C-66 : mark ticket type as deleted\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654686, 'ASSIGN', 427, 'testplans'),
(675, 509, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654690, 'PHP', 0, NULL),
(676, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:24:\"C-67 : open contact page\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654714, 'ASSIGN', 427, 'testplans'),
(677, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:22:\"C-68 : open about page\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(678, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:25:\"C-73 : open movie details\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(679, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:52:\"C-75 : open price list page with active ticket types\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(680, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:41:\"C-76 : deleted ticket types on price list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(681, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:50:\"C-77 : open repertiore page with active film shows\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(682, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:49:\"C-79 : open reservation form from repertoire list\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(683, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:47:\"C-80 : open reservation form from movie details\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans');
INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(684, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:31:\"C-81 : create valid reservation\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(685, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:48:\"C-82 : create reservation for more that 10 seats\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654715, 'ASSIGN', 427, 'testplans'),
(686, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:26:\"C-85 : confirm reservation\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654716, 'ASSIGN', 427, 'testplans'),
(687, 510, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:25:\"C-86 : reject reservation\";i:1;s:1:\"1\";i:2;s:3:\"All\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654716, 'ASSIGN', 427, 'testplans'),
(688, 511, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654717, 'PHP', 0, NULL),
(689, 512, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646654725, 'PHP', 0, NULL),
(690, 513, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 130', 1646654749, 'PHP', 0, NULL),
(691, 513, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$itemID - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 152', 1646654749, 'PHP', 0, NULL),
(692, 513, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index:  - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\785cb45c52a75d8bf79dae9daf25c1e9f5f03006_0.file.planEdit.tpl.php - Line 302', 1646654749, 'PHP', 0, NULL),
(693, 514, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$creation_ts - in R:\\xampp\\htdocs\\testlink\\lib\\plan\\buildEdit.php - Line 390', 1646654773, 'PHP', 0, NULL),
(694, 514, 16, 'GUI - Test Project ID : 1', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:12:\"cinema_tests\";i:1;s:3:\"All\";i:2;s:5:\"07_03\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1646654773, 'CREATE', 3, 'builds'),
(695, 515, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: selected - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\d03b0e9fe0080cba7049e7cb41d0a807d732a04a_0.file.buildEdit.tpl.php - Line 252', 1646654778, 'PHP', 0, NULL),
(696, 516, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654829, 'PHP', 0, NULL),
(697, 516, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654829, 'PHP', 0, NULL),
(698, 517, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654829, 'PHP', 0, NULL),
(699, 517, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654830, 'PHP', 0, NULL),
(700, 518, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654843, 'PHP', 0, NULL),
(701, 518, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654843, 'PHP', 0, NULL),
(702, 519, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654843, 'PHP', 0, NULL),
(703, 519, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654843, 'PHP', 0, NULL),
(704, 520, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654854, 'PHP', 0, NULL),
(705, 520, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654854, 'PHP', 0, NULL),
(706, 521, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654857, 'PHP', 0, NULL),
(707, 521, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654857, 'PHP', 0, NULL),
(708, 522, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654873, 'PHP', 0, NULL),
(709, 522, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654873, 'PHP', 0, NULL),
(710, 523, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654874, 'PHP', 0, NULL),
(711, 523, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654874, 'PHP', 0, NULL),
(712, 524, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654891, 'PHP', 0, NULL),
(713, 524, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654891, 'PHP', 0, NULL),
(714, 525, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654893, 'PHP', 0, NULL),
(715, 525, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654893, 'PHP', 0, NULL),
(716, 526, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654918, 'PHP', 0, NULL),
(717, 526, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654918, 'PHP', 0, NULL),
(718, 527, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654931, 'PHP', 0, NULL),
(719, 527, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654931, 'PHP', 0, NULL),
(720, 528, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654931, 'PHP', 0, NULL),
(721, 528, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654931, 'PHP', 0, NULL),
(722, 529, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654944, 'PHP', 0, NULL),
(723, 530, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654944, 'PHP', 0, NULL),
(724, 529, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654945, 'PHP', 0, NULL),
(725, 530, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654945, 'PHP', 0, NULL),
(726, 531, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654954, 'PHP', 0, NULL),
(727, 531, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654954, 'PHP', 0, NULL),
(728, 532, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654964, 'PHP', 0, NULL),
(729, 532, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654964, 'PHP', 0, NULL),
(730, 533, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654967, 'PHP', 0, NULL),
(731, 533, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654967, 'PHP', 0, NULL),
(732, 534, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654978, 'PHP', 0, NULL),
(733, 534, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654978, 'PHP', 0, NULL),
(734, 535, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646654981, 'PHP', 0, NULL),
(735, 535, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646654981, 'PHP', 0, NULL),
(736, 536, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655003, 'PHP', 0, NULL),
(737, 536, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655003, 'PHP', 0, NULL),
(738, 537, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655020, 'PHP', 0, NULL),
(739, 537, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655020, 'PHP', 0, NULL),
(740, 538, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655023, 'PHP', 0, NULL),
(741, 538, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655024, 'PHP', 0, NULL),
(742, 539, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655033, 'PHP', 0, NULL),
(743, 539, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655033, 'PHP', 0, NULL),
(744, 540, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655041, 'PHP', 0, NULL),
(745, 540, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655041, 'PHP', 0, NULL),
(746, 541, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655052, 'PHP', 0, NULL),
(747, 541, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655052, 'PHP', 0, NULL),
(748, 542, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655053, 'PHP', 0, NULL),
(749, 542, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655054, 'PHP', 0, NULL),
(750, 543, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655075, 'PHP', 0, NULL),
(751, 543, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655075, 'PHP', 0, NULL),
(752, 544, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655083, 'PHP', 0, NULL),
(753, 544, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655083, 'PHP', 0, NULL),
(754, 545, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655105, 'PHP', 0, NULL),
(755, 545, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655105, 'PHP', 0, NULL),
(756, 546, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655112, 'PHP', 0, NULL),
(757, 546, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655112, 'PHP', 0, NULL),
(758, 547, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655117, 'PHP', 0, NULL),
(759, 547, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655117, 'PHP', 0, NULL),
(760, 548, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655133, 'PHP', 0, NULL),
(761, 548, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655133, 'PHP', 0, NULL),
(762, 549, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655149, 'PHP', 0, NULL),
(763, 549, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655149, 'PHP', 0, NULL),
(764, 550, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655155, 'PHP', 0, NULL),
(765, 550, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655155, 'PHP', 0, NULL),
(766, 551, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655166, 'PHP', 0, NULL),
(767, 551, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655167, 'PHP', 0, NULL),
(768, 552, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655174, 'PHP', 0, NULL),
(769, 552, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655174, 'PHP', 0, NULL),
(770, 553, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655194, 'PHP', 0, NULL),
(771, 553, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655195, 'PHP', 0, NULL),
(772, 554, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655194, 'PHP', 0, NULL),
(773, 554, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655195, 'PHP', 0, NULL),
(774, 555, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655201, 'PHP', 0, NULL),
(775, 555, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655201, 'PHP', 0, NULL),
(776, 556, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655210, 'PHP', 0, NULL),
(777, 556, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655210, 'PHP', 0, NULL),
(778, 557, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655224, 'PHP', 0, NULL),
(779, 557, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655224, 'PHP', 0, NULL),
(780, 558, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655235, 'PHP', 0, NULL),
(781, 558, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655235, 'PHP', 0, NULL),
(782, 559, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655235, 'PHP', 0, NULL),
(783, 559, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655235, 'PHP', 0, NULL),
(784, 560, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655246, 'PHP', 0, NULL),
(785, 560, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655246, 'PHP', 0, NULL),
(786, 561, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655247, 'PHP', 0, NULL),
(787, 561, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655248, 'PHP', 0, NULL),
(788, 562, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7096', 1646655257, 'PHP', 0, NULL),
(789, 562, 2, 'GUI', 'E_NOTICE\nUndefined index: keywords - in R:\\xampp\\htdocs\\testlink\\lib\\functions\\testplan.class.php - Line 7126', 1646655258, 'PHP', 0, NULL),
(790, 563, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined index: size - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\03df0c260af076ae7495e2f5d9148a691f9a19b5_0.file.inc_filter_panel.tpl.php - Line 351', 1646658281, 'PHP', 0, NULL),
(791, 564, 2, 'GUI - Test Project ID : 1', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in R:\\xampp\\htdocs\\testlink\\gui\\templates_c\\8f87b6ab58375246e4a205612894093ae7c9932f_0.file.containerView.tpl.php - Line 123', 1646658281, 'PHP', 0, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `executions`
--

CREATE TABLE `executions` (
  `id` int(10) UNSIGNED NOT NULL,
  `build_id` int(10) NOT NULL DEFAULT '0',
  `tester_id` int(10) UNSIGNED DEFAULT NULL,
  `execution_ts` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_number` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `execution_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -> manual, 2 -> automated',
  `execution_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `executions`
--

INSERT INTO `executions` (`id`, `build_id`, `tester_id`, `execution_ts`, `status`, `testplan_id`, `tcversion_id`, `tcversion_number`, `platform_id`, `execution_type`, `execution_duration`, `notes`) VALUES
(3, 1, 1, '2022-03-07 00:09:10', 'p', 64, 10, 1, 0, 2, NULL, NULL),
(4, 1, 1, '2022-03-07 00:09:48', 'p', 64, 10, 1, 0, 2, NULL, NULL),
(5, 1, 1, '2022-03-07 00:10:02', 'b', 64, 10, 1, 0, 2, NULL, NULL),
(6, 1, 1, '2022-03-07 00:11:40', 'p', 64, 7, 1, 0, 2, NULL, NULL),
(8, 2, 1, '2022-03-07 00:13:17', 'f', 64, 4, 1, 0, 1, NULL, ''),
(9, 1, 1, '2022-03-07 00:13:43', 'f', 64, 10, 1, 0, 1, NULL, ''),
(10, 1, 1, '2022-03-07 00:16:15', 'p', 64, 10, 1, 0, 2, NULL, NULL),
(11, 1, 1, '2022-03-07 00:17:46', 'p', 64, 4, 1, 0, 2, NULL, NULL),
(12, 1, 1, '2022-03-07 00:18:12', 'b', 64, 4, 1, 0, 2, NULL, NULL),
(13, 1, 1, '2022-03-07 00:49:29', 'p', 64, 13, 1, 0, 2, NULL, NULL),
(14, 1, 1, '2022-03-07 00:50:08', 'f', 64, 13, 1, 0, 2, NULL, NULL),
(15, 1, 1, '2022-03-07 10:40:28', 'p', 64, 13, 1, 0, 2, NULL, NULL),
(16, 3, 1, '2022-03-07 13:07:11', 'p', 427, 326, 1, 0, 2, NULL, NULL),
(17, 3, 1, '2022-03-07 13:07:12', 'p', 427, 323, 1, 0, 2, NULL, NULL),
(18, 3, 1, '2022-03-07 13:07:24', 'p', 427, 347, 1, 0, 2, NULL, NULL),
(19, 3, 1, '2022-03-07 13:07:25', 'p', 427, 341, 1, 0, 2, NULL, NULL),
(20, 3, 1, '2022-03-07 13:07:35', 'p', 427, 350, 1, 0, 2, NULL, NULL),
(21, 3, 1, '2022-03-07 13:07:38', 'p', 427, 353, 1, 0, 2, NULL, NULL),
(22, 3, 1, '2022-03-07 13:07:55', 'f', 427, 365, 1, 0, 2, NULL, NULL),
(23, 3, 1, '2022-03-07 13:07:56', 'p', 427, 374, 1, 0, 2, NULL, NULL),
(24, 3, 1, '2022-03-07 13:08:12', 'p', 427, 359, 1, 0, 2, NULL, NULL),
(25, 3, 1, '2022-03-07 13:08:15', 'p', 427, 362, 1, 0, 2, NULL, NULL),
(26, 3, 1, '2022-03-07 13:08:40', 'f', 427, 397, 1, 0, 2, NULL, NULL),
(27, 3, 1, '2022-03-07 13:08:53', 'f', 427, 392, 1, 0, 2, NULL, NULL),
(28, 3, 1, '2022-03-07 13:08:53', 'p', 427, 7, 1, 0, 2, NULL, NULL),
(29, 3, 1, '2022-03-07 13:09:06', 'p', 427, 66, 1, 0, 2, NULL, NULL),
(30, 3, 1, '2022-03-07 13:09:06', 'p', 427, 4, 1, 0, 2, NULL, NULL),
(31, 3, 1, '2022-03-07 13:09:15', 'p', 427, 10, 1, 0, 2, NULL, NULL),
(32, 3, 1, '2022-03-07 13:09:25', 'p', 427, 13, 1, 0, 2, NULL, NULL),
(33, 3, 1, '2022-03-07 13:09:28', 'f', 427, 101, 1, 0, 2, NULL, NULL),
(34, 3, 1, '2022-03-07 13:09:39', 'p', 427, 73, 1, 0, 2, NULL, NULL),
(35, 3, 1, '2022-03-07 13:09:42', 'p', 427, 17, 1, 0, 2, NULL, NULL),
(36, 3, 1, '2022-03-07 13:10:06', 'p', 427, 234, 1, 0, 2, NULL, NULL),
(37, 3, 1, '2022-03-07 13:10:22', 'p', 427, 106, 1, 0, 2, NULL, NULL),
(38, 3, 1, '2022-03-07 13:10:25', 'p', 427, 234, 1, 0, 2, NULL, NULL),
(39, 3, 1, '2022-03-07 13:10:36', 'p', 427, 59, 1, 0, 2, NULL, NULL),
(40, 3, 1, '2022-03-07 13:10:43', 'p', 427, 247, 1, 0, 2, NULL, NULL),
(41, 3, 1, '2022-03-07 13:10:53', 'p', 427, 252, 1, 0, 2, NULL, NULL),
(42, 3, 1, '2022-03-07 13:10:55', 'p', 427, 230, 1, 0, 2, NULL, NULL),
(43, 3, 1, '2022-03-07 13:11:16', 'f', 427, 118, 1, 0, 2, NULL, NULL),
(44, 3, 1, '2022-03-07 13:11:28', 'p', 427, 257, 1, 0, 2, NULL, NULL),
(45, 3, 1, '2022-03-07 13:11:47', 'p', 427, 242, 1, 0, 2, NULL, NULL),
(46, 3, 1, '2022-03-07 13:11:53', 'p', 427, 170, 1, 0, 2, NULL, NULL),
(47, 3, 1, '2022-03-07 13:11:58', 'p', 427, 227, 1, 0, 2, NULL, NULL),
(48, 3, 1, '2022-03-07 13:12:16', 'p', 427, 111, 1, 0, 2, NULL, NULL),
(49, 3, 1, '2022-03-07 13:12:30', 'p', 427, 114, 1, 0, 2, NULL, NULL),
(50, 3, 1, '2022-03-07 13:12:36', 'p', 427, 140, 1, 0, 2, NULL, NULL),
(51, 3, 1, '2022-03-07 13:12:48', 'p', 427, 203, 1, 0, 2, NULL, NULL),
(52, 3, 1, '2022-03-07 13:12:55', 'p', 427, 152, 1, 0, 2, NULL, NULL),
(53, 3, 1, '2022-03-07 13:13:16', 'p', 427, 195, 1, 0, 2, NULL, NULL),
(54, 3, 1, '2022-03-07 13:13:16', 'p', 427, 176, 1, 0, 2, NULL, NULL),
(55, 3, 1, '2022-03-07 13:13:22', 'p', 427, 222, 1, 0, 2, NULL, NULL),
(56, 3, 1, '2022-03-07 13:13:32', 'p', 427, 276, 1, 0, 2, NULL, NULL),
(57, 3, 1, '2022-03-07 13:13:45', 'p', 427, 294, 1, 0, 2, NULL, NULL),
(58, 3, 1, '2022-03-07 13:13:56', 'p', 427, 269, 1, 0, 2, NULL, NULL),
(59, 3, 1, '2022-03-07 13:13:57', 'p', 427, 211, 1, 0, 2, NULL, NULL),
(60, 3, 1, '2022-03-07 13:14:07', 'p', 427, 272, 1, 0, 2, NULL, NULL),
(61, 3, 1, '2022-03-07 13:14:09', 'p', 427, 276, 1, 0, 2, NULL, NULL),
(62, 3, 1, '2022-03-07 13:14:19', 'p', 427, 284, 1, 0, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `execution_bugs`
--

CREATE TABLE `execution_bugs` (
  `execution_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `bug_id` varchar(64) NOT NULL DEFAULT '0',
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `execution_tcsteps`
--

CREATE TABLE `execution_tcsteps` (
  `id` int(10) UNSIGNED NOT NULL,
  `execution_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `notes` text,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `execution_tcsteps`
--

INSERT INTO `execution_tcsteps` (`id`, `execution_id`, `tcstep_id`, `notes`, `status`) VALUES
(2, 8, 5, '', 'p'),
(3, 9, 11, '', 'p');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `execution_tcsteps_wip`
--

CREATE TABLE `execution_tcsteps_wip` (
  `id` int(10) UNSIGNED NOT NULL,
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `build_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tester_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `exec_by_date_time`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `exec_by_date_time` (
`testplan_name` varchar(100)
,`yyyy_mm_dd` varchar(10)
,`yyyy_mm` varchar(7)
,`hh` varchar(7)
,`hour` varchar(7)
,`id` int(10) unsigned
,`build_id` int(10)
,`tester_id` int(10) unsigned
,`execution_ts` datetime
,`status` char(1)
,`testplan_id` int(10) unsigned
,`tcversion_id` int(10) unsigned
,`tcversion_number` smallint(5) unsigned
,`platform_id` int(10) unsigned
,`execution_type` tinyint(1)
,`execution_duration` decimal(6,2)
,`notes` text
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `inventory`
--

CREATE TABLE `inventory` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `ipaddress` varchar(255) NOT NULL,
  `content` text,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modification_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `issuetrackers`
--

CREATE TABLE `issuetrackers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT '0',
  `cfg` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `keywords`
--

CREATE TABLE `keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_exec_by_context`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_exec_by_context` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`build_id` int(10)
,`platform_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_exec_by_testplan`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_exec_by_testplan` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_exec_by_testplan_plat`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_exec_by_testplan_plat` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`platform_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_req_version`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_req_version` (
`req_id` int(10) unsigned
,`version` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_req_version_id`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_req_version_id` (
`req_id` int(10) unsigned
,`version` smallint(5) unsigned
,`req_version_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_rspec_revision`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_rspec_revision` (
`req_spec_id` int(10) unsigned
,`testproject_id` int(10) unsigned
,`revision` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_tcase_version_id`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_tcase_version_id` (
`testcase_id` int(10) unsigned
,`version` smallint(5) unsigned
,`tcversion_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `latest_tcase_version_number`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `latest_tcase_version_number` (
`testcase_id` int(10) unsigned
,`version` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `milestones`
--

CREATE TABLE `milestones` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `target_date` date NOT NULL,
  `start_date` date DEFAULT NULL,
  `a` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `b` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `c` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT 'undefined'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `nodes_hierarchy`
--

CREATE TABLE `nodes_hierarchy` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `node_type_id` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `node_order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `nodes_hierarchy`
--

INSERT INTO `nodes_hierarchy` (`id`, `name`, `parent_id`, `node_type_id`, `node_order`) VALUES
(1, 'cinema_tests', NULL, 1, 1),
(2, 'Main Panel', 314, 2, 0),
(3, 'Login as administrator', 2, 3, 1000),
(4, '', 3, 4, 0),
(5, '', 4, 9, 0),
(6, 'Login as administrator with access to manage users module', 2, 3, 1001),
(7, '', 6, 4, 0),
(8, '', 7, 9, 0),
(9, 'Login as ordinary employee', 2, 3, 1002),
(10, '', 9, 4, 0),
(11, '', 10, 9, 0),
(12, 'Login with invalid credentials', 2, 3, 1003),
(13, '', 12, 4, 0),
(14, '', 13, 9, 0),
(15, 'Manage users module', 314, 2, 1),
(16, 'Open module', 15, 3, 1000),
(17, '', 16, 4, 0),
(18, '', 17, 9, 0),
(19, 'Add user', 15, 3, 1001),
(20, '', 19, 4, 0),
(21, '', 20, 9, 0),
(22, '', 20, 9, 0),
(23, '', 20, 9, 0),
(24, '', 20, 9, 0),
(25, '', 20, 9, 0),
(26, '', 20, 9, 0),
(27, 'Edit user', 15, 3, 1002),
(28, '', 27, 4, 0),
(29, '', 28, 9, 0),
(30, '', 28, 9, 0),
(31, 'Assign user to group', 15, 3, 1003),
(32, '', 31, 4, 0),
(33, '', 32, 9, 0),
(34, '', 32, 9, 0),
(35, 'Delete user from group', 15, 3, 1004),
(36, '', 35, 4, 0),
(37, '', 36, 9, 0),
(38, '', 36, 9, 0),
(39, 'Give user access to Django admin panel', 15, 3, 1005),
(40, '', 39, 4, 0),
(41, '', 40, 9, 0),
(42, '', 40, 9, 0),
(43, '', 40, 9, 0),
(44, 'Delete user account', 15, 3, 1006),
(45, '', 44, 4, 0),
(46, '', 45, 9, 0),
(47, '', 45, 9, 0),
(48, '', 45, 9, 0),
(49, 'Set account as inactive', 15, 3, 1007),
(50, '', 49, 4, 0),
(51, '', 50, 9, 0),
(52, '', 50, 9, 0),
(53, 'Change password', 15, 3, 1008),
(54, '', 53, 4, 0),
(55, '', 54, 9, 0),
(56, '', 54, 9, 0),
(57, 'Film screening module', 314, 2, 2),
(58, 'Open module', 57, 3, 1000),
(59, '', 58, 4, 0),
(60, '', 59, 9, 0),
(61, 'List pagination', 57, 3, 1001),
(62, '', 61, 4, 0),
(63, '', 62, 9, 0),
(64, 'test plan 1', 1, 5, 0),
(65, 'Open archive film screenings list', 57, 3, 1002),
(66, '', 65, 4, 0),
(67, '', 66, 9, 0),
(68, '', 66, 9, 0),
(69, 'open active film screening details', 57, 3, 1003),
(70, '', 69, 4, 0),
(71, '', 70, 9, 0),
(72, 'Add active film screening', 57, 3, 1004),
(73, '', 72, 4, 0),
(74, '', 73, 9, 0),
(75, '', 73, 9, 0),
(76, '', 73, 9, 0),
(77, '', 73, 9, 0),
(78, '', 73, 9, 0),
(79, 'Archive film screening (instantly)', 57, 3, 1005),
(80, '', 79, 4, 0),
(81, '', 80, 9, 0),
(82, '', 80, 9, 0),
(83, '', 80, 9, 0),
(84, '', 80, 9, 0),
(85, '', 80, 9, 0),
(86, '', 80, 9, 0),
(87, 'Archive film screening (automatically)', 57, 3, 1006),
(88, '', 87, 4, 0),
(89, '', 88, 9, 0),
(90, '', 88, 9, 0),
(91, '', 88, 9, 0),
(92, '', 88, 9, 0),
(93, '', 88, 9, 0),
(94, '', 88, 9, 0),
(95, '', 88, 9, 0),
(96, 'open archived film screening details', 57, 3, 1007),
(97, '', 96, 4, 0),
(98, '', 97, 9, 0),
(99, '', 97, 9, 0),
(100, 'Update film screening', 57, 3, 1008),
(101, '', 100, 4, 0),
(102, '', 101, 9, 0),
(103, '', 101, 9, 0),
(104, '', 101, 9, 0),
(105, 'Delete film screening', 57, 3, 1009),
(106, '', 105, 4, 0),
(107, '', 106, 9, 0),
(108, '', 106, 9, 0),
(109, 'Reservations and tickets module', 314, 2, 3),
(110, 'open reservation list (active film show)', 109, 3, 1000),
(111, '', 110, 4, 0),
(112, '', 111, 9, 0),
(113, 'open reservation list (archived film show)', 109, 3, 1001),
(114, '', 113, 4, 0),
(115, '', 114, 9, 0),
(116, '', 114, 9, 0),
(117, 'add resetvation to active film screening with an email', 109, 3, 1002),
(118, '', 117, 4, 0),
(119, '', 118, 9, 0),
(120, '', 118, 9, 0),
(121, '', 118, 9, 0),
(122, '', 118, 9, 0),
(123, '', 118, 9, 0),
(124, '', 118, 9, 0),
(125, '', 118, 9, 0),
(126, '', 118, 9, 0),
(127, 'add resetvation to archive film screening with an email', 109, 3, 1003),
(128, '', 127, 4, 0),
(129, '', 128, 9, 0),
(130, 'add resetvation to active film screening without an email', 109, 3, 1004),
(131, '', 130, 4, 0),
(132, '', 131, 9, 0),
(133, '', 131, 9, 0),
(134, '', 131, 9, 0),
(135, '', 131, 9, 0),
(136, '', 131, 9, 0),
(137, '', 131, 9, 0),
(138, '', 131, 9, 0),
(139, 'choose taken seats in add reservation form', 109, 3, 1005),
(140, '', 139, 4, 0),
(141, '', 140, 9, 0),
(142, 'add resetvation to active film screening when mailing service doesnt work', 109, 3, 1006),
(143, '', 142, 4, 0),
(144, '', 143, 9, 0),
(145, '', 143, 9, 0),
(146, '', 143, 9, 0),
(147, '', 143, 9, 0),
(148, '', 143, 9, 0),
(149, '', 143, 9, 0),
(150, '', 143, 9, 0),
(151, 'add resetvation to active film screening and confirm it instantly', 109, 3, 1007),
(152, '', 151, 4, 0),
(153, '', 152, 9, 0),
(154, '', 152, 9, 0),
(155, '', 152, 9, 0),
(156, '', 152, 9, 0),
(157, '', 152, 9, 0),
(158, '', 152, 9, 0),
(159, '', 152, 9, 0),
(160, 'add resetvation to active film screening and mark it as paid instantly', 109, 3, 1008),
(161, '', 160, 4, 0),
(162, '', 161, 9, 0),
(163, '', 161, 9, 0),
(164, '', 161, 9, 0),
(165, '', 161, 9, 0),
(166, '', 161, 9, 0),
(167, '', 161, 9, 0),
(168, '', 161, 9, 0),
(169, 'add resetvation to archived film screening', 109, 3, 1009),
(170, '', 169, 4, 0),
(171, '', 170, 9, 0),
(172, 'open reservation details', 109, 3, 1010),
(173, '', 172, 4, 0),
(174, '', 173, 9, 0),
(175, 'update reservation in active film screening', 109, 3, 1011),
(176, '', 175, 4, 0),
(177, '', 176, 9, 0),
(178, '', 176, 9, 0),
(179, '', 176, 9, 0),
(180, 'add tickets to existing reservation in active film screening with email', 109, 3, 1012),
(181, '', 180, 4, 0),
(182, '', 181, 9, 0),
(183, '', 181, 9, 0),
(184, '', 181, 9, 0),
(185, '', 181, 9, 0),
(186, '', 181, 9, 0),
(187, 'add tickets to existing reservation in active film screening without an email', 109, 3, 1013),
(188, '', 187, 4, 0),
(189, '', 188, 9, 0),
(190, '', 188, 9, 0),
(191, '', 188, 9, 0),
(192, '', 188, 9, 0),
(193, '', 188, 9, 0),
(194, 'choose taken seats in update reservation form', 109, 3, 1014),
(195, '', 194, 4, 0),
(196, '', 195, 9, 0),
(197, '', 195, 9, 0),
(198, '', 195, 9, 0),
(199, 'update reservation in archived film screening', 109, 3, 1015),
(200, '', 199, 4, 0),
(201, '', 200, 9, 0),
(202, 'update payment and confirmation status in active film show', 109, 3, 1016),
(203, '', 202, 4, 0),
(204, '', 203, 9, 0),
(205, '', 203, 9, 0),
(206, '', 203, 9, 0),
(207, 'update payment and confirmation status in archived film show', 109, 3, 1017),
(208, '', 207, 4, 0),
(209, '', 208, 9, 0),
(210, 'delete reservation in active film screening', 109, 3, 1018),
(211, '', 210, 4, 0),
(212, '', 211, 9, 0),
(213, '', 211, 9, 0),
(214, '', 211, 9, 0),
(215, 'delete reservation in archived film screening', 109, 3, 1019),
(216, '', 215, 4, 0),
(217, '', 216, 9, 0),
(218, 'Automatic reservations deleting', 109, 3, 1020),
(219, '', 218, 4, 0),
(220, '', 219, 9, 0),
(221, 'Trigger automatic reservations deletion manually', 109, 3, 1021),
(222, '', 221, 4, 0),
(223, '', 222, 9, 0),
(224, '', 222, 9, 0),
(225, 'Movies module', 314, 2, 4),
(226, 'open active movies list', 225, 3, 1000),
(227, '', 226, 4, 0),
(228, '', 227, 9, 0),
(229, 'open deleted movies list', 225, 3, 1001),
(230, '', 229, 4, 0),
(231, '', 230, 9, 0),
(232, '', 230, 9, 0),
(233, 'add new movie', 225, 3, 1002),
(234, '', 233, 4, 0),
(235, '', 234, 9, 0),
(236, '', 234, 9, 0),
(237, '', 234, 9, 0),
(238, 'open movie details', 225, 3, 1003),
(239, '', 238, 4, 0),
(240, '', 239, 9, 0),
(241, 'update movie', 225, 3, 1004),
(242, '', 241, 4, 0),
(243, '', 242, 9, 0),
(244, '', 242, 9, 0),
(245, '', 242, 9, 0),
(246, 'delete movie permanently', 225, 3, 1005),
(247, '', 246, 4, 0),
(248, '', 247, 9, 0),
(249, '', 247, 9, 0),
(250, '', 247, 9, 0),
(251, 'abandon deletion form', 225, 3, 1006),
(252, '', 251, 4, 0),
(253, '', 252, 9, 0),
(254, '', 252, 9, 0),
(255, '', 252, 9, 0),
(256, 'delete movie without admin privilages', 225, 3, 1007),
(257, '', 256, 4, 0),
(258, '', 257, 9, 0),
(259, 'delete movie which is connected to film screening', 225, 3, 1008),
(260, '', 259, 4, 0),
(261, '', 260, 9, 0),
(262, 'mark movie as deleted', 225, 3, 1009),
(263, '', 262, 4, 0),
(264, '', 263, 9, 0),
(265, '', 263, 9, 0),
(266, '', 263, 9, 0),
(267, 'Ticket types module', 314, 2, 5),
(268, 'open active ticket types list', 267, 3, 1000),
(269, '', 268, 4, 0),
(270, '', 269, 9, 0),
(271, 'open deleted ticket types list', 267, 3, 1001),
(272, '', 271, 4, 0),
(273, '', 272, 9, 0),
(274, '', 272, 9, 0),
(275, 'add new ticket type', 267, 3, 1002),
(276, '', 275, 4, 0),
(277, '', 276, 9, 0),
(278, '', 276, 9, 0),
(279, '', 276, 9, 0),
(280, 'open ticket type details', 267, 3, 1003),
(281, '', 280, 4, 0),
(282, '', 281, 9, 0),
(283, 'update ticket type', 267, 3, 1004),
(284, '', 283, 4, 0),
(285, '', 284, 9, 0),
(286, '', 284, 9, 0),
(287, '', 284, 9, 0),
(288, 'change ticket type price', 267, 3, 1005),
(289, '', 288, 4, 0),
(290, '', 289, 9, 0),
(291, '', 289, 9, 0),
(292, '', 289, 9, 0),
(293, 'delete ticket type permanently', 267, 3, 1006),
(294, '', 293, 4, 0),
(295, '', 294, 9, 0),
(296, '', 294, 9, 0),
(297, '', 294, 9, 0),
(298, 'abandon deletion form', 267, 3, 1007),
(299, '', 298, 4, 0),
(300, '', 299, 9, 0),
(301, '', 299, 9, 0),
(302, '', 299, 9, 0),
(303, 'delete ticket type without admin privilages', 267, 3, 1008),
(304, '', 303, 4, 0),
(305, '', 304, 9, 0),
(306, 'delete ticket type which is connected to reservation', 267, 3, 1009),
(307, '', 306, 4, 0),
(308, '', 307, 9, 0),
(309, 'mark ticket type as deleted', 267, 3, 1010),
(310, '', 309, 4, 0),
(311, '', 310, 9, 0),
(312, '', 310, 9, 0),
(313, '', 310, 9, 0),
(314, 'worker module', 1, 2, 6),
(315, 'client module', 1, 2, 7),
(316, 'Contact Page', 315, 2, 1),
(317, 'About Page', 315, 2, 2),
(318, 'Main Page', 315, 2, 3),
(319, 'Price list Page', 315, 2, 4),
(320, 'Repertoire Page', 315, 2, 5),
(321, 'Reservation tests', 315, 2, 6),
(322, 'open contact page', 316, 3, 1000),
(323, '', 322, 4, 0),
(324, '', 323, 9, 0),
(325, 'open about page', 317, 3, 1000),
(326, '', 325, 4, 0),
(327, '', 326, 9, 0),
(328, 'open main page without active film screenings', 318, 3, 1000),
(329, '', 328, 4, 0),
(330, '', 329, 9, 0),
(331, 'open main page with archived film screening', 318, 3, 1001),
(332, '', 331, 4, 0),
(333, '', 332, 9, 0),
(334, 'open main page with film shows for today', 318, 3, 1002),
(335, '', 334, 4, 0),
(336, '', 335, 9, 0),
(337, 'open main page with film shows for next two weeks', 318, 3, 1003),
(338, '', 337, 4, 0),
(339, '', 338, 9, 0),
(340, 'open movie details', 318, 3, 1004),
(341, '', 340, 4, 0),
(342, '', 341, 9, 0),
(343, 'open price list page with no active ticket types', 319, 3, 1000),
(344, '', 343, 4, 0),
(345, '', 344, 9, 0),
(346, 'open price list page with active ticket types', 319, 3, 1001),
(347, '', 346, 4, 0),
(348, '', 347, 9, 0),
(349, 'deleted ticket types on price list', 319, 3, 1002),
(350, '', 349, 4, 0),
(351, '', 350, 9, 0),
(352, 'open repertiore page with active film shows', 320, 3, 1000),
(353, '', 352, 4, 0),
(354, '', 353, 9, 0),
(355, 'open repertiore page without active film shows', 320, 3, 1001),
(356, '', 355, 4, 0),
(357, '', 356, 9, 0),
(358, 'open reservation form from repertoire list', 321, 3, 1000),
(359, '', 358, 4, 0),
(360, '', 359, 9, 0),
(361, 'open reservation form from movie details', 321, 3, 1001),
(362, '', 361, 4, 0),
(363, '', 362, 9, 0),
(364, 'create valid reservation', 321, 3, 1002),
(365, '', 364, 4, 0),
(366, '', 365, 9, 0),
(367, '', 365, 9, 0),
(368, '', 365, 9, 0),
(369, '', 365, 9, 0),
(370, '', 365, 9, 0),
(371, '', 365, 9, 0),
(372, '', 365, 9, 0),
(373, 'create reservation for more that 10 seats', 321, 3, 1003),
(374, '', 373, 4, 0),
(375, '', 374, 9, 0),
(376, '', 374, 9, 0),
(377, '', 374, 9, 0),
(378, 'create reservation without selecting seats', 321, 3, 1004),
(379, '', 378, 4, 0),
(380, '', 379, 9, 0),
(381, '', 379, 9, 0),
(382, '', 379, 9, 0),
(383, 'add resetvation to active film screening when mailing service doesnt work', 321, 3, 1005),
(384, '', 383, 4, 0),
(385, '', 384, 9, 0),
(386, '', 384, 9, 0),
(387, '', 384, 9, 0),
(388, '', 384, 9, 0),
(389, '', 384, 9, 0),
(390, '', 384, 9, 0),
(391, 'confirm reservation', 321, 3, 1006),
(392, '', 391, 4, 0),
(393, '', 392, 9, 0),
(394, '', 392, 9, 0),
(395, '', 392, 9, 0),
(396, 'reject reservation', 321, 3, 1007),
(397, '', 396, 4, 0),
(398, '', 397, 9, 0),
(399, '', 397, 9, 0),
(400, '', 397, 9, 0),
(401, 'reject reservation after rejection', 321, 3, 1008),
(402, '', 401, 4, 0),
(403, '', 402, 9, 0),
(404, '', 402, 9, 0),
(405, 'reject reservation after confirmation', 321, 3, 1009),
(406, '', 405, 4, 0),
(407, '', 406, 9, 0),
(408, '', 406, 9, 0),
(409, '', 406, 9, 0),
(410, 'confirm reservation after rejection', 321, 3, 1010),
(411, '', 410, 4, 0),
(412, '', 411, 9, 0),
(413, '', 411, 9, 0),
(414, 'confirm reservation after confrimation', 321, 3, 1011),
(415, '', 414, 4, 0),
(416, '', 415, 9, 0),
(417, '', 415, 9, 0),
(418, '', 415, 9, 0),
(419, 'confirm reservation when reservation link expired', 321, 3, 1012),
(420, '', 419, 4, 0),
(421, '', 420, 9, 0),
(422, '', 420, 9, 0),
(423, 'reject reservation when reservation link expired', 321, 3, 1013),
(424, '', 423, 4, 0),
(425, '', 424, 9, 0),
(426, '', 424, 9, 0),
(427, 'All', 1, 5, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `node_types`
--

CREATE TABLE `node_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT 'testproject'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `node_types`
--

INSERT INTO `node_types` (`id`, `description`) VALUES
(1, 'testproject'),
(2, 'testsuite'),
(3, 'testcase'),
(4, 'testcase_version'),
(5, 'testplan'),
(6, 'requirement_spec'),
(7, 'requirement'),
(8, 'requirement_version'),
(9, 'testcase_step'),
(10, 'requirement_revision'),
(11, 'requirement_spec_revision'),
(12, 'build'),
(13, 'platform'),
(14, 'user');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `object_keywords`
--

CREATE TABLE `object_keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `fk_table` varchar(30) DEFAULT '',
  `keyword_id` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `platforms`
--

CREATE TABLE `platforms` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `notes` text NOT NULL,
  `enable_on_design` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `enable_on_execution` tinyint(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `platforms`
--

INSERT INTO `platforms` (`id`, `name`, `testproject_id`, `notes`, `enable_on_design`, `enable_on_execution`) VALUES
(1, 'Chrome', 1, '', 0, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `plugins`
--

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL,
  `basename` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `plugins`
--

INSERT INTO `plugins` (`id`, `basename`, `enabled`, `author_id`, `creation_ts`) VALUES
(1, 'TLTest', 1, NULL, '2022-03-05 00:07:56');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `plugins_configuration`
--

CREATE TABLE `plugins_configuration` (
  `id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL,
  `config_key` varchar(255) NOT NULL,
  `config_type` int(11) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `reqmgrsystems`
--

CREATE TABLE `reqmgrsystems` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT '0',
  `cfg` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `requirements`
--

CREATE TABLE `requirements` (
  `id` int(10) UNSIGNED NOT NULL,
  `srs_id` int(10) UNSIGNED NOT NULL,
  `req_doc_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_coverage`
--

CREATE TABLE `req_coverage` (
  `id` int(10) UNSIGNED NOT NULL,
  `req_id` int(10) NOT NULL,
  `req_version_id` int(10) NOT NULL,
  `testcase_id` int(10) NOT NULL,
  `tcversion_id` int(10) NOT NULL,
  `link_status` int(11) NOT NULL DEFAULT '1',
  `is_active` int(11) NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `review_requester_id` int(10) UNSIGNED DEFAULT NULL,
  `review_request_ts` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='relation test case version ** requirement version';

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_monitor`
--

CREATE TABLE `req_monitor` (
  `req_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_relations`
--

CREATE TABLE `req_relations` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `relation_type` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_revisions`
--

CREATE TABLE `req_revisions` (
  `parent_id` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `req_doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `expected_coverage` int(10) NOT NULL DEFAULT '1',
  `log_message` text,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_specs`
--

CREATE TABLE `req_specs` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `doc_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dev. Documents (e.g. System Requirements Specification)';

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_specs_revisions`
--

CREATE TABLE `req_specs_revisions` (
  `parent_id` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text,
  `total_req` int(10) NOT NULL DEFAULT '0',
  `status` int(10) UNSIGNED DEFAULT '1',
  `type` char(1) DEFAULT NULL,
  `log_message` text,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `req_versions`
--

CREATE TABLE `req_versions` (
  `id` int(10) UNSIGNED NOT NULL,
  `version` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `scope` text,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `expected_coverage` int(10) NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `log_message` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rights`
--

CREATE TABLE `rights` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `rights`
--

INSERT INTO `rights` (`id`, `description`) VALUES
(53, 'cfield_assignment'),
(18, 'cfield_management'),
(17, 'cfield_view'),
(51, 'codetracker_management'),
(52, 'codetracker_view'),
(56, 'delete_frozen_tcversion'),
(22, 'events_mgt'),
(54, 'exec_assign_testcases'),
(36, 'exec_delete'),
(35, 'exec_edit_notes'),
(49, 'exec_ro_access'),
(41, 'exec_testcases_assigned_to_me'),
(31, 'issuetracker_management'),
(32, 'issuetracker_view'),
(29, 'keyword_assignment'),
(9, 'mgt_modify_key'),
(12, 'mgt_modify_product'),
(11, 'mgt_modify_req'),
(7, 'mgt_modify_tc'),
(48, 'mgt_plugins'),
(16, 'mgt_testplan_create'),
(30, 'mgt_unfreeze_req'),
(13, 'mgt_users'),
(20, 'mgt_view_events'),
(8, 'mgt_view_key'),
(10, 'mgt_view_req'),
(6, 'mgt_view_tc'),
(21, 'mgt_view_usergroups'),
(50, 'monitor_requirement'),
(24, 'platform_management'),
(25, 'platform_view'),
(26, 'project_inventory_management'),
(27, 'project_inventory_view'),
(33, 'reqmgrsystem_management'),
(34, 'reqmgrsystem_view'),
(28, 'req_tcase_link_management'),
(14, 'role_management'),
(19, 'system_configuration'),
(47, 'testcase_freeze'),
(43, 'testplan_add_remove_platforms'),
(2, 'testplan_create_build'),
(1, 'testplan_execute'),
(3, 'testplan_metrics'),
(40, 'testplan_milestone_overview'),
(4, 'testplan_planning'),
(45, 'testplan_set_urgent_testcases'),
(46, 'testplan_show_testcases_newest_versions'),
(37, 'testplan_unlink_executed_testcases'),
(44, 'testplan_update_linked_testcase_versions'),
(5, 'testplan_user_role_assignment'),
(55, 'testproject_add_remove_keywords_executed_tcversions'),
(38, 'testproject_delete_executed_testcases'),
(39, 'testproject_edit_executed_testcases'),
(42, 'testproject_metrics_dashboard'),
(23, 'testproject_user_role_assignment'),
(15, 'user_role_assignment');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `risk_assignments`
--

CREATE TABLE `risk_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `node_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `risk` char(1) NOT NULL DEFAULT '2',
  `importance` char(1) NOT NULL DEFAULT 'M'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT '',
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `roles`
--

INSERT INTO `roles` (`id`, `description`, `notes`) VALUES
(1, '<reserved system role 1>', NULL),
(2, '<reserved system role 2>', NULL),
(3, '<no rights>', NULL),
(4, 'test designer', NULL),
(5, 'guest', NULL),
(6, 'senior tester', NULL),
(7, 'tester', NULL),
(8, 'admin', NULL),
(9, 'leader', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `role_rights`
--

CREATE TABLE `role_rights` (
  `role_id` int(10) NOT NULL DEFAULT '0',
  `right_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `role_rights`
--

INSERT INTO `role_rights` (`role_id`, `right_id`) VALUES
(4, 3),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 28),
(4, 29),
(4, 30),
(4, 50),
(5, 3),
(5, 6),
(5, 8),
(6, 1),
(6, 2),
(6, 3),
(6, 6),
(6, 7),
(6, 8),
(6, 9),
(6, 11),
(6, 25),
(6, 27),
(6, 28),
(6, 29),
(6, 30),
(6, 50),
(7, 1),
(7, 3),
(7, 6),
(7, 8),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(8, 9),
(8, 10),
(8, 11),
(8, 12),
(8, 13),
(8, 14),
(8, 15),
(8, 16),
(8, 17),
(8, 18),
(8, 19),
(8, 20),
(8, 21),
(8, 22),
(8, 23),
(8, 24),
(8, 25),
(8, 26),
(8, 27),
(8, 28),
(8, 29),
(8, 30),
(8, 31),
(8, 32),
(8, 33),
(8, 34),
(8, 35),
(8, 36),
(8, 37),
(8, 38),
(8, 39),
(8, 40),
(8, 41),
(8, 42),
(8, 43),
(8, 44),
(8, 45),
(8, 46),
(8, 47),
(8, 48),
(8, 50),
(8, 51),
(8, 52),
(8, 53),
(8, 54),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 15),
(9, 16),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 47),
(9, 50);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tcsteps`
--

CREATE TABLE `tcsteps` (
  `id` int(10) UNSIGNED NOT NULL,
  `step_number` int(11) NOT NULL DEFAULT '1',
  `actions` text,
  `expected_results` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `execution_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -> manual, 2 -> automated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `tcsteps`
--

INSERT INTO `tcsteps` (`id`, `step_number`, `actions`, `expected_results`, `active`, `execution_type`) VALUES
(5, 1, '<p>1. User clicks &quot;zaloguj&quot; button and types valid username and password</p>\r\n', '<p>User sees: &nbsp; &nbsp;<br />\r\n- account&#39;s name in top left corner, &nbsp;&nbsp;<br />\r\n- two buttons: one which redirects to worker&#39;s module main page, and logout button, &nbsp;&nbsp;<br />\r\n- list with 3 modules: &nbsp;&nbsp;<br />\r\n* &quot;Seanse&quot;<br />\r\n* &quot;Filmy&quot;<br />\r\n* &quot;Typy bilet&oacute;w&quot;</p>\r\n', 1, 2),
(8, 1, '<p>1. User clicks &quot;zaloguj&quot; button and types valid username and password</p>\r\n', '<p>User sees: &nbsp; &nbsp;<br />\r\n- account&#39;s name in top left corner, &nbsp;&nbsp;<br />\r\n- two buttons: one which redirects to worker&#39;s module main page, and logout button, &nbsp;&nbsp;<br />\r\n- list with 4 modules: &nbsp;&nbsp;<br />\r\n* &quot;Zarządzanie użytkownikami&quot;<br />\r\n* &quot;Seanse&quot;<br />\r\n* &quot;Filmy&quot;<br />\r\n* &quot;Typy bilet&oacute;w&quot;</p>\r\n', 1, 2),
(11, 1, '<p>1. User clicks &quot;zaloguj&quot; button and types valid username and password</p>\r\n', '<p>User sees: &nbsp; &nbsp;<br />\r\n- account&#39;s name in top left corner, &nbsp;&nbsp;<br />\r\n- two buttons: one which redirects to worker&#39;s module main page, and logout button, &nbsp;&nbsp;<br />\r\n- list with 3 modules: &nbsp;&nbsp;<br />\r\n* &quot;Seanse&quot;<br />\r\n* &quot;Filmy&quot;<br />\r\n* &quot;Typy bilet&oacute;w&quot;</p>\r\n', 1, 2),
(14, 1, '<p>1. User clicks &quot;zaloguj&quot; button and types invalid username and password</p>\r\n', '<p>Page refreshes<br />\r\nUser sees &quot;Wprowadź poprawne wartości p&oacute;l użytkownik oraz hasło. Uwaga: wielkość liter ma znaczenie.&quot; message.</p>\r\n', 1, 2),
(18, 1, '<p>1. User clicks on &quot;Zarządzanie użytkownikami&quot; link.</p>\r\n', '<p>- Application redirects user to module.<br />\r\n- User sees on the top right corner username and 3 buttons (redirect to cinema&#39;s main page, change password and logout).<br />\r\n- &quot;Ostatnie działania&quot; section shows last performed actions on user&#39;s accounts.<br />\r\n- &quot;UWIERZYTELNIANIE I AUTORYZACJA&quot; section contains &quot;Użytkownicy&quot; link which redirects to list of all registered users in application.</p>\r\n', 1, 2),
(21, 1, '<p>&nbsp;</p>\r\n\r\n<p>1. Clicks on &quot;Użytkownicy&quot; link</p>\r\n', '', 1, 1),
(22, 2, '<p>&nbsp;</p>\r\n\r\n<p>2. Clicks either &quot;+ Dodaj&quot; button in &quot;UWIERZYTELNIANIE I AUTORYZACJA&quot; section on left side menu or &quot;DODAJ UŻYTKOWNIK +&quot; button on top right corner (under &quot;wyloguj button&quot;).</p>\r\n', '', 1, 1),
(23, 3, '<p>3. User types: name, last name, account name, password (with complexity rules) in appropriate fields</p>\r\n', '', 1, 1),
(24, 4, '<p>4. Clicks &quot;Zapisz&quot; button in order to save. (system redirects to edit user form)</p>\r\n', '', 1, 1),
(25, 5, '<p>5. User can change here basic account information, decide if account can access to django admin panel, deactivate or delete account, assign account to group (by double clicking on group name), see last login date.</p>\r\n', '', 1, 1),
(26, 6, '<p>6. User clicks &quot;save&quot;.</p>\r\n', '<p>System redirects user to all users list, newly added account appears on the list.</p>\r\n', 1, 1),
(29, 1, '<p>1. Clicks on &quot;Użytkownicy&quot; link</p>\r\n', '', 1, 1),
(30, 2, '<p>2. Clicks on account&#39;s name</p>\r\n', '<p>System redirects user to edit account form.</p>\r\n', 1, 1),
(33, 1, '<p>1. In &quot;Permissions&quot; section and &quot;Grupy&quot; subsection. user double clicks on group name in &quot;Dostępne grupy&quot; panel (gropu name disappears from this panel and appears in &quot;Wybrane grupy&quot; panel)<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(34, 2, '<p>2. User clicks &quot;Zapisz&quot; button in order to save.</p>\r\n', '<p>- Account is now assigned to selected group<br />\r\n- system redirects to all users list,</p>\r\n', 1, 1),
(37, 1, '<p>1. In &quot;Permissions&quot; section and &quot;Grupy&quot; subsection. user double clicks on group name in &quot;Wybrane grupy&quot; panel (gropu name disappears from this panel and appears in &quot;Dostępne grupy&quot; panel)<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(38, 2, '<p>2. User clicks &quot;Zapisz&quot; button in order to save.</p>\r\n', '<p>- Account has been deleted from group<br />\r\n- system redirects to all users list,</p>\r\n', 1, 1),
(41, 1, '<p>1. User assigns account to &quot;Administratorzy&quot; group.<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(42, 2, '<p>2. In section &quot;Permissions&quot; checks &quot;W zespole&quot; checkbox.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(43, 3, '<p>3. User clicks &quot;Zapisz&quot; button in order to save.</p>\r\n', '<p>- Account has now access to django admin panel<br />\r\n- system redirects to all users list,</p>\r\n', 1, 1),
(46, 1, '<p>1. User scrolls to bottom of page<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(47, 2, '<p>2. User clicks red &quot;Usuń&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(48, 3, '<p>3. User confirms choice by clicking red &quot;Tak, na pewno&quot; button.</p>\r\n', '<p>- User on the screen sees success message &quot;Użytkownik &bdquo;&lt;username&gt;&rdquo; usunięty pomyślnie.&quot;<br />\r\n- system redirects to all users list,<br />\r\n- account disappears from the list</p>\r\n', 1, 1),
(51, 1, '<p>1. In section &quot;Permissions&quot; user unchecks &quot;Aktywny&quot; checkbox.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(52, 2, '<p>2. User clicks &quot;Zapisz&quot; button in order to save.</p>\r\n', '<p>- User on the screen sees success message &quot;Użytkownik &bdquo;&lt;username&gt;&rdquo; został pomyślnie zmieniony.&quot;<br />\r\n- system redirects to all users list,</p>\r\n', 1, 1),
(55, 1, '<p>1. At the top of the form - under the &quot;Hasło&quot; field user clicks &quot; tego formularza.&quot; link.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(56, 2, '<p>2. User types new password, confirms it and clicks &quot;ZMIANA HASŁA&quot; button.</p>\r\n', '<p>- User sees cuccess message &quot;Hasło zostało zmienione pomyślnie.&quot;<br />\r\n- system redirects to edit user form,</p>\r\n', 1, 1),
(60, 1, '<p>1. User clicks on &quot;Seanse&quot; link.</p>\r\n', '<p>- Application redirects user to module.<br />\r\n- User sees &quot;Dodaj seans&quot; and &quot;Archiwalne Seanse&quot; buttons.<br />\r\n- Sees table with following columns: Tytuł seansu, Data rozpoczęcia, Data Zakończenia</p>\r\n', 1, 2),
(63, 1, '<p>1. User clicks on &quot;2&quot; digit in page numbers section</p>\r\n', '<p>System redirects to second page.</p>\r\n', 1, 1),
(67, 1, '<p>1. User clicks on &quot;Seanse&quot; link.</p>\r\n', '', 1, 2),
(68, 2, '<p>2. User clicks on &quot;Archiwalne Seanse&quot; link/</p>\r\n', '<p>- Application redirects user to module.<br />\r\n- Sees table with following columns: Tytuł seansu, Data rozpoczęcia, Data Zakończenia</p>\r\n', 1, 2),
(71, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User sees:<br />\r\n- &quot;Aktualizuj informacje o seansie&quot; button which allows to update information about film screening.<br />\r\n- &quot;Przejdź do szczeg&oacute;ł&oacute;w filmu&quot; button which allows to see movie details.<br />\r\n- movie title<br />\r\n- movie thumbnail<br />\r\n- start and end datetime<br />\r\n- duration of film show<br />\r\n- &quot;Dodaj rezerwację&quot; button which leads to reservation form<br />\r\n- reservations list</p>\r\n', 1, 1),
(74, 1, '<p>1. User clicks &quot;Dodaj seans&quot; button</p>\r\n', '', 1, 2),
(75, 2, '<p>2. User chooses movie from dropdown list</p>\r\n', '', 1, 2),
(76, 3, '<p>3. User chooses start datetime from the future in &quot;Godzina i data rozpoczęcia&quot; field&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(77, 4, '<p>4. User types number of minutes dedicated to break after show</p>\r\n', '', 1, 2),
(78, 5, '<p>5. User clicks &quot;Zapisz&quot; button</p>\r\n', '<p>- System redirects user to &quot;show list&quot; page<br />\r\n- New show appears at the beginning of the active film screenings list.<br />\r\n- in movie details user sees &quot;Dodaj rezerwację&quot; link, &quot;Aktualizuj informacje o seansie&quot; link, &quot;Usuń seans&quot; link&nbsp;</p>\r\n', 1, 2),
(81, 1, '<p>1. User clicks &quot;Dodaj seans&quot; button</p>\r\n', '', 1, 1),
(82, 2, '<p>2. User chooses movie from dropdown list</p>\r\n', '', 1, 1),
(83, 3, '<p>3. User chooses start datetime from the past in &quot;Godzina i data rozpoczęcia&quot; field<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(84, 4, '<p>4. User types number of minutes dedicated to break after show<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(85, 5, '<p>5. User clicks &quot;Zapisz&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(86, 6, '<p>6. User clicks &quot;Archiwalne Seanse&quot; link</p>\r\n', '<p>- New show appears at the beginning of the archive film screenings list.<br />\r\n- in movie details user does not see &quot;Dodaj rezerwację&quot; link, &quot;Aktualizuj informacje o seansie&quot; link,&nbsp;<br />\r\n- in movie details user sees &nbsp;&quot;Usuń seans&quot; link</p>\r\n', 1, 1),
(89, 1, '<p>&quot;1. User clicks &quot;&quot;Dodaj seans&quot;&quot; button</p>\r\n', '', 1, 1),
(90, 2, '<p>2. User chooses movie from dropdown list<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(91, 3, '<p>3. User chooses start datetime from the future in &quot;&quot;Godzina i data rozpoczęcia&quot;&quot; field<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(92, 4, '<p>4. User types number of minutes dedicated to break after show<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(93, 5, '<p>5. User clicks &quot;&quot;Zapisz&quot;&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(94, 6, '<p>7. User waits to film screening start time to elapse<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(95, 7, '<p>6. User clicks &quot;&quot;Archiwalne Seanse&quot;&quot; link&quot;</p>\r\n', '<p>- New show appears at the beginning of the archive film screenings list.</p>\r\n', 1, 1),
(98, 1, '<p>1. User clicks &quot;&quot;Archiwalne Seanse&quot;&quot; link<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(99, 2, '<p>2. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User sees:<br />\r\n- &quot;Przejdź do szczeg&oacute;ł&oacute;w filmu&quot; button which allows to see movie details.<br />\r\n- movie title<br />\r\n- movie thumbnail<br />\r\n- start and end datetime<br />\r\n- duration of film show<br />\r\n- reservations list&quot;</p>\r\n', 1, 1),
(102, 1, '<p>1. User clicks on &quot;Aktualizuj informacje o seansie&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(103, 2, '<p>2. User changes film screening details<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(104, 3, '<p>3. Clicks &quot;zapisz&quot; button.</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- user sees updated show details<br />\r\n- all customers who made reservation on this show revceives an email which information about updated details</p>\r\n', 1, 2),
(107, 1, '<p>1. User clicks on &quot;Usuń seans&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(108, 2, '<p>2. User clicks &quot;Tak&quot; button.</p>\r\n', '<p>- System redirects user to &quot;show list&quot; page<br />\r\n- all resetvations correlated with this show are deleted</p>\r\n', 1, 2),
(112, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User sees:<br />\r\n- film show details<br />\r\n- link &quot;dodaj rezerwację&quot;<br />\r\n- reservations list (structure of the list:: no. ID, Imię i nazwisko, Do zapłaty, Opłacona, Potwierdzona, Data rezerwacji, Opłacenie/Potwierdzenie, Edycja, Usuwanie)</p>\r\n', 1, 2),
(115, 1, '<p>1. User clicks on &quot;Archiwalne Seanse&quot; link<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(116, 2, '<p>2. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User sees:<br />\r\n- film show details<br />\r\n- reservations list (structure of the list:: no. ID, Imię i nazwisko, Do zapłaty, Opłacona, Potwierdzona, Data rezerwacji)</p>\r\n', 1, 2),
(119, 1, '<p>1. User clicks &quot;Dodaj rezerwację&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(120, 2, '<p>2. User types:<br />\r\n- Imię - name<br />\r\n- Nazwisko - last name<br />\r\n- email<br />\r\n- Numer telefonu - phone number<br />\r\nAll fields are mandatory</p>\r\n', '', 1, 2),
(121, 3, '<p>3. From cinema&#39;s hall map user checks any number of free seats and clicks &quot;Dalej&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(122, 4, '<p>4. In next step user sees choices made in first step, movie detail and start datetime<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(123, 5, '<p>5. User chooses tickets types for each seat and clicks &quot;Dalej&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(124, 6, '<p>6. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(125, 7, '<p>&nbsp;</p>\r\n\r\n<p>7. User checks checkbox: Wyślij maila z potwierdzeniem</p>\r\n', '', 1, 2),
(126, 8, '<p>8. User clicks &quot;rezerwuj&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- New reservation appeared on the list<br />\r\n- User sees message &quot;&#39;Rezerwacja została pomyślnie utworzona, na adres mailowy klienta została wysłana wiadomość z potwierdzeniem. Jeśli klient nie potwierdzi rezerwacji w ciągu 30 minut, to zostanie ona usunięta z systemu&quot;<br />\r\n- Client receives an email with link to confirm and reject reservation</p>\r\n', 1, 2),
(129, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- User does not see &quot;Dodaj rezerwację&quot; button</p>\r\n', 1, 2),
(132, 1, '<p>1. User clicks &quot;Dodaj rezerwację&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(133, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(134, 3, '<p>3. From cinema&#39;s hall map user checks any number of free seats and clicks &quot;Dalej&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(135, 4, '<p>4. In next step user fills out arbitrary fields and clicks &quot;Dalej&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(136, 5, '<p>5. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(137, 6, '<p>6. User does not check checkbox: Wyślij maila z potwierdzeniem<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(138, 7, '<p>7. User clicks &quot;rezerwuj&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- New reservation appeared on the list<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie utworzona. Nie została zaznaczona opcja wysyłki wiadomości email do klienta.&quot;</p>\r\n', 1, 1),
(141, 1, '<p>1. User clicks &quot;Dodaj rezerwację&quot; button</p>\r\n', '<p>On cinema&#39;s hall map user can not check taken seats</p>\r\n', 1, 2),
(144, 1, '<p>1. User clicks &quot;Dodaj rezerwację&quot; button</p>\r\n', '', 1, 1),
(145, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(146, 3, '<p>3. From cinema&#39;s hall map user checks any number of free seats and clicks &quot;Dalej&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(147, 4, '<p>4. In next step user fills out arbitrary fields and clicks &quot;Dalej&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(148, 5, '<p>5. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(149, 6, '<p>6. User does not check checkbox: Wyślij maila z potwierdzeniem<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(150, 7, '<p>7. User clicks &quot;rezerwuj&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- New reservation appeared on the list<br />\r\n- User sees message &quot;Wystąpił problem z wysłaniem wiadomości. Skontaktuj się z klientem w celu potwierdzenia lub odrzucenia rezerwacji.&quot;</p>\r\n', 1, 1),
(153, 1, '<p>1. User clicks &quot;Dodaj rezerwację&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(154, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(155, 3, '<p>3. From cinema&#39;s hall map user checks any number of free seats and clicks &quot;Dalej&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(156, 4, '<p>4. In next step user fills out arbitrary fields and clicks &quot;Dalej&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(157, 5, '<p>5. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(158, 6, '<p>6. User checks checkbox: Potwierdzona<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(159, 7, '<p>7. User clicks &quot;rezerwuj&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- New reservation appeared on the list<br />\r\n- in column &quot;Potwierdzona&quot; user sees &quot;Tak&quot;</p>\r\n', 1, 2),
(162, 1, '<p>1. User clicks &quot;Dodaj rezerwację&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(163, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(164, 3, '<p>3. From cinema&#39;s hall map user checks any number of free seats and clicks &quot;Dalej&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(165, 4, '<p>4. In next step user fills out arbitrary fields and clicks &quot;Dalej&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(166, 5, '<p>5. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(167, 6, '<p>6. User checks checkbox: Opłacona<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(168, 7, '<p>7. User clicks &quot;rezerwuj&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- New reservation appeared on the list<br />\r\n- in column &quot;Opłacona&quot; user sees &quot;Tak&quot;</p>\r\n', 1, 2),
(171, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User does not see &quot;Dodaj rezerwację&quot; button. Reservation can&#39;t be created</p>\r\n', 1, 2),
(174, 1, '<p>1. User clicks &quot;Pokaż szczeg&oacute;ły&quot; below reservation row</p>\r\n', '<p>User sees:<br />\r\n- chosen seats by client with prices<br />\r\n- client&#39;s email<br />\r\n- client&#39;s phone number</p>\r\n', 1, 2),
(177, 1, '<p>1. User clicks &quot;Edytuj&quot; in the reservation row&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(178, 2, '<p>2. In form user can edit fields in reservation details<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(179, 3, '<p>3. User clicks &quot;Zatwierdź&quot;</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie zaktualizowana.&quot;</p>\r\n', 1, 2),
(182, 1, '<p>1. User clicks &quot;Edytuj&quot; in the reservation row&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(183, 2, '<p>2. In &quot;Edytuj ilość bilet&oacute;w:&quot; section user selects new number of tickets and clicks &quot;Dodaj&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(184, 3, '<p>3. User selects new seats, assigns ticket types for those seats<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(185, 4, '<p>4. User checks &quot;Wyślij maila z potwierdzeniem&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(186, 5, '<p>5. User clicks &quot;Zatwierdź&quot;</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie zaktualizowana, na adres mailowy klienta została wysłana wiadomość z potwierdzeniem. Jeśli klient nie potwierdzi rezerwacji w ciągu 30 minut, to zostanie ona usunięta z systemu&quot;<br />\r\n- Client receives an email with link to confirm and reject reservation</p>\r\n', 1, 2),
(189, 1, '<p>1. User clicks &quot;Edytuj&quot; in the reservation row&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(190, 2, '<p>2. In &quot;Edytuj ilość bilet&oacute;w:&quot; section user selects new number of tickets and clicks &quot;Dodaj&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(191, 3, '<p>3. User selects new seats, assigns ticket types for those seats<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(192, 4, '<p>4. User does not checks &quot;Wyślij maila z potwierdzeniem&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(193, 5, '<p>5. User clicks &quot;Zatwierdź&quot;</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie zaktualizowana. Nie została zaznaczona opcja wysyłki wiadomości email do klienta.&quot;</p>\r\n', 1, 1),
(196, 1, '<p>1. User clicks &quot;Edytuj&quot; in the reservation row&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(197, 2, '<p>2. In &quot;Edytuj ilość bilet&oacute;w:&quot; section user selects new number of tickets and clicks &quot;Dodaj&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(198, 3, '<p>3. User opens seats list</p>\r\n', '<p>- User does not &nbsp;see taken seats on list</p>\r\n', 1, 2),
(201, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User does not see &quot;Edytuj&quot; button. &nbsp;Reservation can&#39;t be updated</p>\r\n', 1, 1),
(204, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(205, 2, '<p>2. User clicks &quot;Opłać/Potwierdź&quot; in the reservation row<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(206, 3, '<p>3. User checks &quot;Opłacona&quot; and &quot;Potwierdzona&quot;checkboxes</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- in columns &quot;Opłacona&quot; and &quot;Potwierdzona&quot; user sees &quot;Tak&quot;</p>\r\n', 1, 2),
(209, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User does not see &quot;Opłać/Potwierdź&quot; button. &nbsp;Status cant be updated</p>\r\n', 1, 1),
(212, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(213, 2, '<p>2. User clicks &quot;Usuń&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(214, 3, '<p>3. User clicks &quot;Usuń&quot; button</p>\r\n', '<p>- System redirects user to &quot;show details&quot; page<br />\r\n- Reservation disappears from the list<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie usunięta.&quot;</p>\r\n', 1, 2),
(217, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', '<p>User does not see &quot;Usuń&quot; button. &nbsp;Reservation cant be deleted</p>\r\n', 1, 1),
(220, 1, '<p>1. User waits up to 10 min since reservation has expired</p>\r\n', '<p>- All clients with unconfirmed reservation recives an email<br />\r\n- All data related to unconfirmed reservation is deleted</p>\r\n', 1, 1),
(223, 1, '<p>1. User waits up to 10 min since reservation has expired<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(224, 2, '<p>2. User visits &#39;&lt;cinema_url&gt;/worker/cron/usun-rezerwacje&#39; URL</p>\r\n', '<p>- All clients with unconfirmed reservation recives an email<br />\r\n- All data related to unconfirmed reservation is deleted</p>\r\n\r\n<p>User sees:&nbsp;<br />\r\n- number of deleted reservation&nbsp;<br />\r\n- number of deleted tickets<br />\r\n- errors</p>\r\n', 1, 2),
(228, 1, '<p>1. User clicks on &quot;Filmy&quot; link.</p>\r\n', '<p>- Application redirects user to module.<br />\r\n- User sees &quot;Lista film&oacute;w&quot; list title.<br />\r\n- User sees &quot;Usunięte filmy&quot; button.<br />\r\n- Sees table with following columns: Tytuł filmu, Usunięty and &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', 1, 2),
(231, 1, '<p>1. User clicks on &quot;Filmy&quot; link.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(232, 2, '<p>2. User clicks &quot;Usunięte filmy&quot; link.</p>\r\n', '<p>- Application redirects user to list.<br />\r\n- User sees &quot;Lista usuniętych film&oacute;w&quot; list title.<br />\r\n- Sees table with following columns: Tytuł filmu, Usunięty and &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', 1, 2),
(235, 1, '<p>1. User clicks &quot;Dodaj film&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(236, 2, '<p>2. User types:<br />\r\n- movie title<br />\r\n- director name<br />\r\n- relase year<br />\r\n- duration from dropdown list<br />\r\n- description<br />\r\n- link to page with opinions<br />\r\n- chooses thumbnail from disk<br />\r\n- Youtube trailer video id<br />\r\n- decides if wants to mark movie as deleted instantly</p>\r\n', '', 1, 2),
(237, 3, '<p>3. Clicks &quot;zapisz&quot; button.</p>\r\n', '<p>- Application redirects user to movie details.<br />\r\n- Movie appears on active or deleted &nbsp;movie list depending on checked/unchecked checkbox while movie creation</p>\r\n', 1, 2),
(240, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.</p>\r\n', '<p>- Application redirects user to movie details<br />\r\n- User sees:&nbsp;<br />\r\n- movie thumbnail<br />\r\n- title<br />\r\n- director name<br />\r\n- release date<br />\r\n- duration time<br />\r\n- description<br />\r\n- trailer</p>\r\n', 1, 2),
(243, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(244, 2, '<p>2. User clicks &quot;Aktualizuj informacje o filmie&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(245, 3, '<p>3. User changes value in fields and clicks &quot;zapisz&quot; button</p>\r\n', '<p>- Application redirects user to movie details<br />\r\n- User sees updated data in fields</p>\r\n', 1, 2),
(248, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(249, 2, '<p>2. User clicks &quot;Usuń film&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(250, 3, '<p>3. User clicks &quot;Tak&quot; button</p>\r\n', '<p>- Application redirects user to movie list<br />\r\n- Deleted movie disappears from the list<br />\r\n- Deleted movie is not present in deleted movies list</p>\r\n', 1, 2),
(253, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(254, 2, '<p>2. User clicks &quot;Usuń film&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(255, 3, '<p>3. User clicks &quot;Nie&quot; button</p>\r\n', '<p>- Application redirects user to movie details<br />\r\n- Deleted movie does not disappears from the active movies list</p>\r\n', 1, 2),
(258, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.</p>\r\n', '<p>- User does not see &quot;Usuń film&quot; link.</p>\r\n', 1, 2),
(261, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.</p>\r\n', '<p>- User does not see &quot;Usuń film&quot; link.</p>\r\n', 1, 1),
(264, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(265, 2, '<p>2. User clicks &quot;Aktualizuj informacje o filmie&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(266, 3, '<p>3. User checks &quot;Usunięty&quot; checkbox and clicks &quot;zapisz&quot; button</p>\r\n', '<p>- Application redirects user to movie details<br />\r\n- Deleted movie disappears from the active movies list<br />\r\n- Deleted movie is present in deleted movies list<br />\r\n- User sees &quot;Tak&quot; in &quot;Usunięty&quot; column</p>\r\n', 1, 2),
(270, 1, '<p>1. User clicks on &quot;Typy bilet&oacute;w&quot; link.</p>\r\n', '<p>- Application redirects user to module.<br />\r\n- User sees &quot;Usunięte typy bilet&oacute;w&quot; button.<br />\r\n- Sees table with following columns: Typ biletu, &quot;Cena&quot; and &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', 1, 2),
(273, 1, '<p>1. User clicks on &quot;Typy bilet&oacute;w&quot; link.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(274, 2, '<p>2. User clicks &quot;Usunięte typy bilet&oacute;w&quot; link.</p>\r\n', '<p>- Application redirects user to list.<br />\r\n- User sees list of ticket types.&nbsp;<br />\r\n- Sees table with following columns: Typ biletu, &quot;Cena&quot; and &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button</p>\r\n', 1, 2),
(277, 1, '<p>1. User clicks &quot;Dodaj typ biletu&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(278, 2, '<p>2. User types:<br />\r\n- name of the ticket type<br />\r\n- price<br />\r\n- additional &nbsp;information<br />\r\n- decides if wants to mark ticket as deleted instantly<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(279, 3, '<p>3. Clicks &quot;zapisz&quot; button.</p>\r\n', '<p>- Application redirects user to ticket type details.<br />\r\n- Ticket type appears on active or deleted ticket types list depending on checked/unchecked checkbox while creation</p>\r\n', 1, 2),
(282, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.</p>\r\n', '<p>- Application redirects user to type details<br />\r\n- User sees:&nbsp;<br />\r\n- Type name<br />\r\n- price<br />\r\n- additonal information</p>\r\n', 1, 2),
(285, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(286, 2, '<p>2. User clicks &quot;Aktualizuj informacje o typie biletu&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(287, 3, '<p>3. User changes value in fields and clicks &quot;zapisz&quot; button</p>\r\n', '<p>- Application redirects user to ticket type list<br />\r\n- User sees updated data in ticket type details&nbsp;</p>\r\n', 1, 2),
(290, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(291, 2, '<p>2. User clicks &quot;Aktualizuj informacje o typie biletu&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(292, 3, '<p>3. User changes price and clicks &quot;zapisz&quot; button</p>\r\n', '<p>- Application redirects user to ticket type list<br />\r\n- User sees updated data in ticket type details&nbsp;<br />\r\n- Existing reservation are not affected</p>\r\n', 1, 1),
(295, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(296, 2, '<p>2. User clicks &quot;Usuń typ biletu&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(297, 3, '<p>3. User clicks &quot;Tak&quot; button</p>\r\n', '<p>- Application redirects user to ticket types list<br />\r\n- Deleted ticket type disappears from the list<br />\r\n- Deleted ticket type is not present in deleted ticket types list</p>\r\n', 1, 2),
(300, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(301, 2, '<p>2. User clicks &quot;Usuń typ biletu&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(302, 3, '<p>3. User clicks &quot;Nie&quot; button</p>\r\n', '<p>- Application redirects user to ticket type details<br />\r\n- Deleted ticket type does not disappears from the active ticket types list</p>\r\n', 1, 1),
(305, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.</p>\r\n', '<p>- User does not see &quot;Usuń typ biletu&quot; link.</p>\r\n', 1, 1),
(308, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.</p>\r\n', '<p>- User does not see &quot;Usuń typ biletu&quot; link.</p>\r\n', 1, 1),
(311, 1, '<p>1. User clicks on &quot;Przejdź do szczeg&oacute;ł&oacute;w&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(312, 2, '<p>2. User clicks &quot;Aktualizuj informacje o typie biletu&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(313, 3, '<p>3. User checks &quot;Usunięty&quot; checkbox and clicks &quot;zapisz&quot; button</p>\r\n', '<p>- Application redirects user to ticket types list<br />\r\n- Deleted ticket type disappears from the active ticket types list<br />\r\n- Deleted ticket type is present in deleted ticket types list</p>\r\n', 1, 2),
(324, 1, '<p>1. User clicks &quot;Kontakt&quot; in top menu.</p>\r\n', '<p>User sees:<br />\r\n- &quot;Kontakt&quot; title next to logo in top left corner<br />\r\n- contact details</p>\r\n', 1, 2),
(327, 1, '<p>1. User clicks &quot;O kinie&quot; in top menu.</p>\r\n', '<p>User sees:<br />\r\n- &quot;O kinie&quot; title next to logo in top left corner<br />\r\n- information about cinema</p>\r\n', 1, 2),
(330, 1, '<p>1. In browser&#39;s address&#39; bar user types cinema&#39;s website address and clicks enter</p>\r\n', '<p>User sees:&nbsp;<br />\r\n- list which shows currently playing movies (splited into sections: &quot;dzisiaj gramy&quot; - today&#39;s movies, &quot;W najbliższe dni gramy&quot; - movies for the next two weeks)</p>\r\n', 1, 1),
(333, 1, '<p>1. In browser&#39;s address&#39; bar user types cinema&#39;s website address and clicks enter</p>\r\n', '<p>User sees top menu and &quot;Obecnie nie wyświetlamy żadych film&oacute;w&quot; text</p>\r\n', 1, 1),
(336, 1, '<p>1. In browser&#39;s address&#39; bar user types cinema&#39;s website address and clicks enter</p>\r\n', '<p>User sees:&nbsp;<br />\r\n- top menu&nbsp;<br />\r\n- list which shows one section &quot;dzisiaj gramy&quot; - today&#39;s movies,</p>\r\n', 1, 1),
(339, 1, '<p>1. In browser&#39;s address&#39; bar user types cinema&#39;s website address and clicks enter</p>\r\n', '<p>User sees:&nbsp;<br />\r\n- top menu&nbsp;<br />\r\n- list which shows one section &nbsp;&quot;W najbliższe dni gramy&quot; - movies for the next two weeks</p>\r\n', 1, 1),
(342, 1, '<p>1. User clicks on movie thumbnail</p>\r\n', '<p>- Application redirects user to movie details</p>\r\n\r\n<p>- User sees:&nbsp;<br />\r\n- movie thumbnail<br />\r\n- title<br />\r\n- director name<br />\r\n- release date<br />\r\n- duration time<br />\r\n- description<br />\r\n- trailer<br />\r\n- link which redirect to movie reviews<br />\r\n- film screenings for this movie sorted ascending by start date</p>\r\n', 1, 2),
(345, 1, '<p>1. User clicks &quot;Cennik&quot; in top menu.</p>\r\n', '<p>User sees:<br />\r\n- &quot;Cennik&quot; title next to logo in top left corner<br />\r\n- &nbsp;table with two columns: &quot;Typ&quot; and &quot;Cena&quot;<br />\r\n- &quot;Brak dostępnych typ&oacute;w bilet&oacute;w.&quot; information in table</p>\r\n', 1, 1),
(348, 1, '<p>1. User clicks &quot;Cennik&quot; in top menu.</p>\r\n', '<p>User sees:<br />\r\n- &quot;Cennik&quot; title next to logo in top left corner<br />\r\n- table with two columns: &quot;Typ&quot; and &quot;Cena&quot;<br />\r\n- list of ticket type names with its price<br />\r\n- Under the table ticket type&#39;s details</p>\r\n', 1, 2),
(351, 1, '<p>1. User clicks &quot;Cennik&quot; in top menu.</p>\r\n', '<p>User does not see ticket type on price list</p>\r\n', 1, 2),
(354, 1, '<p>1. User clicks &quot;Repertuar&quot; in top menu.</p>\r\n', '<p>User sees:<br />\r\n- &quot;Repertuar&quot; title next to logo in top left corner<br />\r\n- table with three columns: &quot;Tytuł&quot; (movie title), &quot;Godzina rozpoczęcia&quot; (film show start date), &quot;Godzina zakończenia&quot; (film show end date)<br />\r\n- table is groupped by dates, groups contains list of film shows for each day<br />\r\n- each film show has &quot;zarezerwuj miejsce&quot; button which leads to reservation form</p>\r\n', 1, 2),
(357, 1, '<p>1. User clicks &quot;Repertuar&quot; in top menu.</p>\r\n', '<p>User sees:<br />\r\n- &quot;Repertuar&quot; title next to logo in top left corner<br />\r\n- &quot;Obecnie nie wyświetlamy żadych film&oacute;w&quot; text</p>\r\n', 1, 1),
(360, 1, '<p>1. User clicks &quot;zarezerwuj miejsce&quot; button.</p>\r\n', '<p>Application redirects user to reservation form.</p>\r\n', 1, 2),
(363, 1, '<p>1. User clicks &quot;zarezerwuj miejsce&quot; button.</p>\r\n', '<p>Application redirects user to reservation form.</p>\r\n', 1, 2),
(366, 1, '<p>1. User clicks &quot;zarezerwuj miejsce&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(367, 2, '<p>2. User types:<br />\r\n- Imię - name<br />\r\n- Nazwisko - last name<br />\r\n- email<br />\r\n- Numer telefonu - phone number<br />\r\nAll fields are mandatory<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(368, 3, '<p>3. From cinema&#39;s hall map user checks up to 10 free seats and clicks &quot;Dalej&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(369, 4, '<p>4. In next step user sees choices made in first step, movie detail and start datetime<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(370, 5, '<p>5. User chooses tickets types for each seat and clicks &quot;Dalej&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(371, 6, '<p>6. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(372, 7, '<p>7. User clicks &quot;Zarezerwuj&quot; button</p>\r\n', '<p>- System redirects user to movie details.<br />\r\n- User sees message: &quot;Rezerwacja została pomyślnie utworzona, na tw&oacute;j adres mailowy została wysłana wiadomość z potwierdzeniem. Jeśli nie potwierdzisz rezerwacji w ciągu 30 minut, to zostanie ona automatycznie usunięta z systemu. W przypadku braku otrzymania wiadomości email prosimy o pilny kontakt telefoniczny.&quot;<br />\r\n- New reservation appears in the system<br />\r\n- User receives an email with links to reservation confirmation and rejection</p>\r\n', 1, 2),
(375, 1, '<p>1. User clicks &quot;zarezerwuj miejsce&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(376, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(377, 3, '<p>3. From cinema&#39;s hall map user checks over 10 free seats and clicks &quot;Dalej&quot; button</p>\r\n', '<p>- Page refreshes.<br />\r\n- User sees message &quot;Możesz zarezerwować maksymalnie 10 miejsc! W celu rezerwacji większej ilości miejsc skontaktuj się z pracownikiem kina.&#39;</p>\r\n', 1, 2),
(380, 1, '<p>1. User clicks &quot;zarezerwuj miejsce&quot; button.<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(381, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(382, 3, '<p>3. User does not select seats and clicks &quot;Dalej&quot; button</p>\r\n', '<p>- Page refreshes.<br />\r\n- User sees message &quot;Nie wybrano żadnych miejsc!&quot;</p>\r\n', 1, 1),
(385, 1, '<p>&quot;1. User clicks &quot;zarezerwuj miejsce&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(386, 2, '<p>2. User fills out arbitrary fields<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(387, 3, '<p>3. From cinema&#39;s hall map user checks up to 10 free seats and clicks &quot;&quot;Dalej&quot;&quot; button<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(388, 4, '<p>4. In next step user fills out arbitrary fields and clicks &quot;&quot;Dalej&quot;&quot;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(389, 5, '<p>5. User sees summarized previous choices and total price which needs to be paid.&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(390, 6, '<p>6. User clicks &quot;&quot;Zarezerwuj&quot;&quot; button&quot;</p>\r\n', '<p>- System redirects user to movie details.<br />\r\n- User sees message with links to reservation confirmation and rejection: &quot;Wystąpił problem z wysłaniem wiadomości. W celu potwierdzenia rezerwacji prosimy przejść pod adres &lt;url&gt;/potwierdz/&lt;individual uuld&gt; W celu odzucenia rezerwacji prosimy przejść pod adres &lt;url&gt;/anuluj/&lt;individual uuld&gt;&quot;<br />\r\n- New reservation appears in the system</p>\r\n', 1, 1),
(393, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(394, 2, '<p>2. user clicks confirmation link&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(395, 3, '<p>3. User sees reservation detail and clicks &quot;Potwierdź&quot; button</p>\r\n', '<p>- System redirects user to main page<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie potwierdzona.&quot;<br />\r\n- reservation become confirmed</p>\r\n', 1, 2),
(398, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(399, 2, '<p>2. user clicks rejection link&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 2),
(400, 3, '<p>3. User sees reservation detail and clicks &quot;Zrezygnuj&quot; button</p>\r\n', '<p>- System redirects user to main page<br />\r\n- User sees message &quot;Rezerwacja została pomyślnie usunięta.&quot;<br />\r\n- reservation disappears from system</p>\r\n', 1, 2),
(403, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(404, 2, '<p>2. user clicks rejection link</p>\r\n', '<p>User sees 404 page</p>\r\n', 1, 1),
(407, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(408, 2, '<p>2. user clicks rejection link&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(409, 3, '<p>3. User sees reservation detail and clicks &quot;Zrezygnuj&quot; button</p>\r\n', '<p>- Page refreshes.<br />\r\n- User sees message &quot;Nie można anulować! Rezerwacja została już potwierdzona.&quot;</p>\r\n', 1, 1),
(412, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(413, 2, '<p>2. user clicks confirmation link</p>\r\n', '<p>User sees 404 page</p>\r\n', 1, 1),
(416, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(417, 2, '<p>2. user clicks confirmation link&nbsp;<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(418, 3, '<p>3. User sees reservation detail and clicks &quot;Potwierdź&quot; button</p>\r\n', '<p>- Page refreshes.<br />\r\n- User sees message &quot;Rezerwacja została już potwierdzona.&quot;</p>\r\n', 1, 1),
(421, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(422, 2, '<p>2. user clicks confirmation link&nbsp;</p>\r\n', '<p>User sees 404 page</p>\r\n', 1, 1),
(425, 1, '<p>1. User opens email message<br />\r\n&nbsp;</p>\r\n', '', 1, 1),
(426, 2, '<p>2. user clicks rejection link</p>\r\n', '<p>User sees 404 page</p>\r\n', 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tcversions`
--

CREATE TABLE `tcversions` (
  `id` int(10) UNSIGNED NOT NULL,
  `tc_external_id` int(10) UNSIGNED DEFAULT NULL,
  `version` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `layout` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `status` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `summary` text,
  `preconditions` text,
  `importance` smallint(5) UNSIGNED NOT NULL DEFAULT '2',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updater_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `execution_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -> manual, 2 -> automated',
  `estimated_exec_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `tcversions`
--

INSERT INTO `tcversions` (`id`, `tc_external_id`, `version`, `layout`, `status`, `summary`, `preconditions`, `importance`, `author_id`, `creation_ts`, `updater_id`, `modification_ts`, `active`, `is_open`, `execution_type`, `estimated_exec_duration`) VALUES
(4, 1, 1, 1, 1, '<p>Test checks if it is possible to login as app administrator</p>\r\n', '<p>1. User has valid credentials to account in &#39;Administratorzy&#39; group.<br />\r\n2. User is on &lt;website_name&gt;/worker/ page.</p>\r\n', 2, 1, '2022-03-04 23:33:46', 1, '2022-03-05 01:16:09', 1, 1, 2, NULL),
(7, 2, 1, 1, 1, '<p>Test checks if it is possible to login as app administrator with access to Django admin panel</p>\r\n', '<p>1. User has valid credentials to account in &#39;Admins&#39; group and &quot;in staff&quot; permissions.<br />\r\n2. User is on &lt;website_name&gt;/worker/ page.</p>\r\n', 2, 1, '2022-03-04 23:34:32', 1, '2022-03-05 01:16:16', 1, 1, 2, NULL),
(10, 3, 1, 1, 1, '<p>Test checks if it is possible to login as employee with basic access</p>\r\n', '<p>1. User has valid credentials to account in &#39;workers&#39; group.<br />\r\n2. User is on &lt;website_name&gt;/worker/ page.</p>\r\n', 2, 1, '2022-03-04 23:35:06', 1, '2022-03-05 01:16:23', 1, 1, 2, NULL),
(13, 4, 1, 1, 1, '<p>Test checks if user without account can&#39;t login</p>\r\n', '<p>1. User has invalid credentials.<br />\r\n2. User is on &lt;website_name&gt;/worker/ page.</p>\r\n', 2, 1, '2022-03-04 23:35:54', 1, '2022-03-05 01:13:40', 1, 1, 2, NULL),
(17, 5, 1, 1, 1, '<p>Test checks if user can open module</p>\r\n', '<p>User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\nUser is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-04 23:40:44', 1, '2022-03-05 01:14:02', 1, 1, 2, NULL),
(20, 6, 1, 1, 1, '<p>Test checks if it is possible to add new employee&#39;s account</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;Zarządzanie użytkownikami&quot; module<br />\r\n- At least one added account in application</p>\r\n', 2, 1, '2022-03-04 23:41:27', 1, '2022-03-05 01:17:00', 1, 1, 1, NULL),
(28, 7, 1, 1, 1, '<p>Test checks if it is possible to edit employee&#39;s account</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.</p>\r\n\r\n<p>- User is in &quot;Zarządzanie użytkownikami&quot; module</p>\r\n', 2, 1, '2022-03-04 23:44:33', 1, '2022-03-05 01:17:04', 1, 1, 1, NULL),
(32, 8, 1, 1, 1, '<p>Test checks if it is possible to assign account to group.</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;edit user&quot; form</p>\r\n', 2, 1, '2022-03-04 23:45:27', 1, '2022-03-05 01:17:07', 1, 1, 1, NULL),
(36, 9, 1, 1, 1, '<p>Test checks if it is possible to delete account from group.</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;edit user&quot; form<br />\r\n- Account is assigned to at least one group.</p>\r\n', 2, 1, '2022-03-04 23:46:15', 1, '2022-03-05 01:17:11', 1, 1, 1, NULL),
(40, 10, 1, 1, 1, '<p>Check if it is possible to allow user log in into Django admin panel.</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;edit user&quot; form</p>\r\n', 2, 1, '2022-03-04 23:47:29', 1, '2022-03-05 01:17:16', 1, 1, 1, NULL),
(45, 11, 1, 1, 1, '<p>Check if it is possible to permanently delete account</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;edit user&quot; form</p>\r\n', 2, 1, '2022-03-04 23:48:04', 1, '2022-03-05 01:17:19', 1, 1, 1, NULL),
(50, 12, 1, 1, 1, '<p>Check if it is possible to set account as inactive</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;edit user&quot; form</p>\r\n', 2, 1, '2022-03-04 23:48:41', 1, '2022-03-05 01:17:23', 1, 1, 1, NULL),
(54, 13, 1, 1, 1, '<p>Check if it is possible to change account pasword</p>\r\n', '<p>- User logged in as administrator with &quot;in staff&quot; permissions.<br />\r\n- User is in &quot;edit user&quot; form</p>\r\n', 2, 1, '2022-03-04 23:49:31', 1, '2022-03-05 01:17:27', 1, 1, 1, NULL),
(59, 14, 1, 1, 1, '<p>Test checks if user can open module</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-04 23:50:40', 1, '2022-03-05 01:14:52', 1, 1, 2, NULL),
(62, 15, 1, 1, 1, '<p>Test checks if pagination works</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is in &quot;seanse&quot; module.<br />\r\n- At least 11 added active film screenings</p>\r\n', 2, 1, '2022-03-04 23:51:20', 1, '2022-03-05 01:17:37', 1, 1, 1, NULL),
(66, 16, 1, 1, 1, '<p>Test checks if user can see archived film screenings</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-07 09:49:01', 1, '2022-03-07 11:56:36', 1, 1, 2, NULL),
(70, 17, 1, 1, 1, '<p>Test checks if user can see details of active film screenings</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- User is in &quot;seanse&quot; module.<br />\r\n- At least 1 added active film screening</p>\r\n', 2, 1, '2022-03-07 09:49:49', 1, '2022-03-07 10:49:59', 1, 1, 1, NULL),
(73, 18, 1, 1, 1, '<p>Test checks i it is possible to add new film screening.&nbsp;</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- User is in &quot;seanse&quot; module.<br />\r\n- At least one added movie</p>\r\n', 2, 1, '2022-03-07 09:50:21', 1, '2022-03-07 11:56:53', 1, 1, 2, NULL),
(80, 19, 1, 1, 1, '<p>Test checks if if film screening can be archived instantly after creation</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- User is in &quot;seanse&quot; module.<br />\r\n- At least one added movie</p>\r\n', 2, 1, '2022-03-07 09:51:26', 1, '2022-03-07 10:52:03', 1, 1, 1, NULL),
(88, 20, 1, 1, 1, '<p>Test checks if if film screening can be archived after start time elapses</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- User is in &quot;seanse&quot; module.</p>\r\n', 2, 1, '2022-03-07 09:52:25', 1, '2022-03-07 10:53:00', 1, 1, 1, NULL),
(97, 21, 1, 1, 1, '<p>Test checks if user can see details of archived film screenings</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- User is in &quot;seanse&quot; module.<br />\r\n- 1 film screening archived</p>\r\n', 2, 1, '2022-03-07 09:53:21', 1, '2022-03-07 10:53:39', 1, 1, 1, NULL),
(101, 22, 1, 1, 1, '<p>Test checks if user can update film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- User is in film screening details.<br />\r\n- 1 active film show&nbsp;<br />\r\n- at least one reservation connected with film show</p>\r\n', 2, 1, '2022-03-07 09:54:01', 1, '2022-03-07 11:57:12', 1, 1, 2, NULL),
(106, 23, 1, 1, 1, '<p>Test checks if user can delete film screening</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is in film screening details.<br />\r\n- 1 active or archived film show&nbsp;<br />\r\n- at least one reservation connecet with this show</p>\r\n', 2, 1, '2022-03-07 09:54:41', 1, '2022-03-07 11:57:19', 1, 1, 2, NULL),
(111, 24, 1, 1, 1, '<p>Test checks if it is possible to open reservation list in an active film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in &quot;seanse&quot; module.<br />\r\n- at least one active film screening&nbsp;</p>\r\n', 2, 1, '2022-03-07 09:56:35', 1, '2022-03-07 11:57:35', 1, 1, 2, NULL),
(114, 25, 1, 1, 1, '<p>open reservation list (archived film show)</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in &quot;seanse&quot; module.<br />\r\n- at least one archived film screening&nbsp;</p>\r\n', 2, 1, '2022-03-07 09:57:01', 1, '2022-03-07 11:57:45', 1, 1, 2, NULL),
(118, 26, 1, 1, 1, '<p>Test checks if it is possible to add reservation to active film screening and send email to client</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details with free seats<br />\r\n- at least one added ticket type</p>\r\n', 2, 1, '2022-03-07 09:57:55', 1, '2022-03-07 11:58:00', 1, 1, 2, NULL),
(128, 27, 1, 1, 1, '<p>Test checks if it is possible to add reservation to archive film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is on archive film show list (on list there is archived film show)<br />\r\n- at least one added ticket type</p>\r\n', 2, 1, '2022-03-07 10:03:59', 1, '2022-03-07 11:58:15', 1, 1, 2, NULL),
(131, 28, 1, 1, 1, '<p>Test checks if it is possible to add reservation to active film screening without sending an email to client</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details with free seats<br />\r\n- at least one added ticket type</p>\r\n', 2, 1, '2022-03-07 10:04:32', 1, '2022-03-07 11:05:14', 1, 1, 1, NULL),
(140, 29, 1, 1, 1, '<p>Test checks if it is possible to assign seat to more than one ticket in active film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details.<br />\r\n- at least two added reservation</p>\r\n', 2, 1, '2022-03-07 10:05:33', 1, '2022-03-07 11:58:25', 1, 1, 2, NULL),
(143, 30, 1, 1, 1, '<p>Test checks if it is possible to add reservation to active film screening when error with mailing service occured</p>\r\n', '<p>- Mailing service doesnt work<br />\r\n- User logged in on account without special permissions.<br />\r\n- user is in active film show details with free seats<br />\r\n- at least one added ticket type</p>\r\n', 2, 1, '2022-03-07 10:06:27', 1, '2022-03-07 11:06:58', 1, 1, 1, NULL),
(152, 31, 1, 1, 1, '<p>Test checks if it is possible to add confirmed reservation to active film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details with free seats<br />\r\n- at least one added ticket type</p>\r\n', 2, 1, '2022-03-07 10:07:48', 1, '2022-03-07 11:58:39', 1, 1, 2, NULL),
(161, 32, 1, 1, 1, '<p>Test checks if it is possible to add paid reservation to active film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details with free seats<br />\r\n- at least one added ticket type</p>\r\n', 2, 1, '2022-03-07 10:08:59', 1, '2022-03-07 11:58:48', 1, 1, 2, NULL),
(170, 33, 1, 1, 1, '<p>Test checks if it is possible to add reservation to archived film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in archived film show list.</p>\r\n', 2, 1, '2022-03-07 10:10:42', 1, '2022-03-07 11:58:59', 1, 1, 2, NULL),
(173, 34, 1, 1, 1, '<p>Test checks if it is possible to open reservation details</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in film show details.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:11:37', 1, '2022-03-07 11:59:08', 1, 1, 2, NULL),
(176, 35, 1, 1, 1, '<p>Test checks if it is possible to update reservation in active film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:12:01', 1, '2022-03-07 11:59:26', 1, 1, 2, NULL),
(181, 36, 1, 1, 1, '<p>Test checks if it is possible to assign more tickets to reservation in active film screening and send email to client</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:12:33', 1, '2022-03-07 11:59:50', 1, 1, 2, NULL),
(188, 37, 1, 1, 1, '<p>Test checks if it is possible to assign more tickets to reservation in active film screening without email to client</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:13:26', 1, '2022-03-07 11:13:54', 1, 1, 1, NULL),
(195, 38, 1, 1, 1, '<p>Test checks if it is possible to assign seat to more than one ticket in active film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show details.<br />\r\n- at least two added reservation</p>\r\n', 2, 1, '2022-03-07 10:14:07', 1, '2022-03-07 12:00:02', 1, 1, 2, NULL),
(200, 39, 1, 1, 1, '<p>Test checks if it is possible to update reservation in archived film screening</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in archived film show list.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:14:45', 1, '2022-03-07 11:14:52', 1, 1, 1, NULL),
(203, 40, 1, 1, 1, '<p>Test checks if it is possible to update payment and confirmation status in active film show</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in active film show list.<br />\r\n- at least one added reservation without checked &quot;Opłacona&quot;, &quot;Potwierdzona&quot; checkboxes</p>\r\n', 2, 1, '2022-03-07 10:15:07', 1, '2022-03-07 12:00:28', 1, 1, 2, NULL),
(208, 41, 1, 1, 1, '<p>Test checks if it is possible to update payment and confirmation status in archived film show</p>\r\n', '<p>- User logged in on account without special permissions.<br />\r\n- user is in archived film show list.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:15:48', 1, '2022-03-07 11:18:30', 1, 1, 1, NULL),
(211, 42, 1, 1, 1, '<p>Test checks if it is possible to delete reservation in active film screening</p>\r\n', '<p>- User logged in on account with admin permissions.<br />\r\n- user is in active film show list.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:22:52', 1, '2022-03-07 12:00:34', 1, 1, 2, NULL),
(216, 43, 1, 1, 1, '<p>Test checks if it is possible to delete reservation in archived film screening</p>\r\n', '<p>- User logged in on account with admin permissions.<br />\r\n- user is in archived film show list.<br />\r\n- at least one added reservation</p>\r\n', 2, 1, '2022-03-07 10:23:43', 1, '2022-03-07 11:23:50', 1, 1, 1, NULL),
(219, 44, 1, 1, 1, '<p>Test checks if automatic reservations deleting works</p>\r\n', '<p>- at least one added reservation which is marked as unpaid</p>\r\n', 2, 1, '2022-03-07 10:24:24', 1, '2022-03-07 11:24:34', 1, 1, 1, NULL),
(222, 45, 1, 1, 1, '<p>Test checks if user can manually trigger automatic reservations deletion</p>\r\n', '<p>- at least one added reservation which is marked as unpaid</p>\r\n', 2, 1, '2022-03-07 10:24:45', 1, '2022-03-07 12:00:53', 1, 1, 2, NULL),
(227, 46, 1, 1, 1, '<p>Test checks if user can open module</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-07 10:26:32', 1, '2022-03-07 12:01:13', 1, 1, 2, NULL),
(230, 47, 1, 1, 1, '<p>Test checks if user can open deleted movies list</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-07 10:26:52', 1, '2022-03-07 12:01:16', 1, 1, 2, NULL),
(234, 48, 1, 1, 1, '<p>Test checks if user can add movie</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is in &quot;Filmy&quot; module</p>\r\n', 2, 1, '2022-03-07 10:27:26', 1, '2022-03-07 12:01:21', 1, 1, 2, NULL),
(239, 49, 1, 1, 1, '<p>Test checks if user can open movie details</p>\r\n', '<p>- User logged in on account with or without special permissions<br />\r\n- at least one movie added<br />\r\n- user is on movie list page</p>\r\n', 2, 1, '2022-03-07 10:28:10', 1, '2022-03-07 12:01:25', 1, 1, 2, NULL),
(242, 50, 1, 1, 1, '<p>Test checks if user can update movie</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on movie list</p>\r\n', 2, 1, '2022-03-07 10:28:34', 1, '2022-03-07 12:01:34', 1, 1, 2, NULL),
(247, 51, 1, 1, 1, '<p>Test checks if user can delete movie permanently</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on movie list<br />\r\n- There is no film screenings connected with this movie&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:29:12', 1, '2022-03-07 12:01:40', 1, 1, 2, NULL),
(252, 52, 1, 1, 1, '<p>Test checks if user can abandon deletion movie form</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on movie list<br />\r\n- There is no film screenings connected with this movie&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:29:45', 1, '2022-03-07 12:01:45', 1, 1, 2, NULL),
(257, 53, 1, 1, 1, '<p>Test checks if ordinary worker without special privilages can delete movie</p>\r\n', '<p>- User logged in on account without administration permissions.<br />\r\n- User is on movie list<br />\r\n- There is no film screenings connected with this movie&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:30:25', 1, '2022-03-07 12:01:53', 1, 1, 2, NULL),
(260, 54, 1, 1, 1, '<p>Test checks if user can delete movie permanently when there is film screening connected with this movie</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on movie list<br />\r\n- There is a film screening connected with this movie&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:30:49', 1, '2022-03-07 11:30:59', 1, 1, 1, NULL),
(263, 55, 1, 1, 1, '<p>Test checks if user can mark movie as deleted</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on movie list<br />\r\n- There is or there isn&#39;t film screening connected with this movie&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:31:10', 1, '2022-03-07 12:02:02', 1, 1, 2, NULL),
(269, 56, 1, 1, 1, '<p>Test checks if user can open module</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-07 10:32:30', 1, '2022-03-07 12:03:03', 1, 1, 2, NULL),
(272, 57, 1, 1, 1, '<p>Test checks if user can open deleted ticket types list</p>\r\n', '<p>- User logged in on account with or without special permissions.<br />\r\n- User is on worker&#39;s panel page.</p>\r\n', 2, 1, '2022-03-07 10:32:51', 1, '2022-03-07 12:03:09', 1, 1, 2, NULL),
(276, 58, 1, 1, 1, '<p>Test checks if user can add ticket type</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is in &quot;Typy bilet&oacute;w&quot; module</p>\r\n', 2, 1, '2022-03-07 10:33:24', 1, '2022-03-07 12:03:15', 1, 1, 2, NULL),
(281, 59, 1, 1, 1, '<p>Test checks if user can open ticket type details</p>\r\n', '<p>- User logged in on account with or without special permissions<br />\r\n- at least one ticket type added<br />\r\n- user is on ticket type list page</p>\r\n', 2, 1, '2022-03-07 10:34:06', 1, '2022-03-07 12:03:20', 1, 1, 2, NULL),
(284, 60, 1, 1, 1, '<p>Test checks if user can update ticket type</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on ticket types list</p>\r\n', 2, 1, '2022-03-07 10:34:26', 1, '2022-03-07 12:03:26', 1, 1, 2, NULL),
(289, 61, 1, 1, 1, '<p>Test checks if user can change ticket type price</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on ticket types list<br />\r\n- There are tickets connected with this ticket type</p>\r\n', 2, 1, '2022-03-07 10:34:57', 1, '2022-03-07 11:35:13', 1, 1, 1, NULL),
(294, 62, 1, 1, 1, '<p>Test checks if user can delete ticket type permanently</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on ticket types list<br />\r\n- There are no tickets connected with this ticket type</p>\r\n', 2, 1, '2022-03-07 10:36:44', 1, '2022-03-07 12:03:33', 1, 1, 2, NULL),
(299, 63, 1, 1, 1, '<p>Test checks if user can abandon deletion form</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on ticket types list<br />\r\n- There is no reservations connected with this ticket type</p>\r\n', 2, 1, '2022-03-07 10:37:14', 1, '2022-03-07 11:37:26', 1, 1, 1, NULL),
(304, 64, 1, 1, 1, '<p>Test checks if ordinary worker without special privilages can delete ticket type</p>\r\n', '<p>- User logged in on account without administration permissions.<br />\r\n- User is on ticket types list<br />\r\n- There is no reservations connected with this ticket type</p>\r\n', 2, 1, '2022-03-07 10:37:42', 1, '2022-03-07 11:37:49', 1, 1, 1, NULL),
(307, 65, 1, 1, 1, '<p>Test checks if user can delete ticket type permanently when there is reservation connected with this ticket type</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on ticket types list<br />\r\n- There are tickets within reservation connected with this ticket type</p>\r\n', 2, 1, '2022-03-07 10:38:12', 1, '2022-03-07 11:38:28', 1, 1, 1, NULL),
(310, 66, 1, 1, 1, '<p>Test checks if user can mark ticket type as deleted</p>\r\n', '<p>- User logged in on account with administration permissions.<br />\r\n- User is on ticket types list<br />\r\n- There is no tickets connected with this ticket type</p>\r\n', 2, 1, '2022-03-07 10:38:59', 1, '2022-03-07 12:03:58', 1, 1, 2, NULL),
(323, 67, 1, 1, 1, '<p>Test checks if it is possible to open contact page.</p>\r\n', '<p>User is on main page</p>\r\n', 2, 1, '2022-03-07 10:42:43', 1, '2022-03-07 12:04:23', 1, 1, 2, NULL),
(326, 68, 1, 1, 1, '<p>Test checks if it is possible to open about page.</p>\r\n', '<p>User is on main page</p>\r\n', 2, 1, '2022-03-07 10:43:13', 1, '2022-03-07 12:04:29', 1, 1, 2, NULL),
(329, 69, 1, 1, 1, '<p>Test checks if it is possible to visit cinema&#39;s website when there is no active film screenings</p>\r\n', '<p>- User opened web browser<br />\r\n- no added movies</p>\r\n', 2, 1, '2022-03-07 10:43:44', 1, '2022-03-07 11:43:53', 1, 1, 1, NULL),
(332, 70, 1, 1, 1, '<p>Test checks if it is possible to visit cinema&#39;s website when there are only archived film screenings</p>\r\n', '<p>- User opened web browser<br />\r\n- archived film screenings</p>\r\n', 2, 1, '2022-03-07 10:44:05', 1, '2022-03-07 11:44:15', 1, 1, 1, NULL),
(335, 71, 1, 1, 1, '<p>Test checks if it is possible to visit cinema&#39;s website when there is active film screening today</p>\r\n', '<p>- User opened web browser<br />\r\n- At least one added active film screening for today</p>\r\n', 2, 1, '2022-03-07 10:44:30', 1, '2022-03-07 11:44:37', 1, 1, 1, NULL),
(338, 72, 1, 1, 1, '<p>Test checks if it is possible to visit cinema&#39;s website when there is active film screening within 2 weeks</p>\r\n', '<p>- User opened web browser<br />\r\n- At least one added active film screening tomorrow or any date within 2 weeks</p>\r\n', 2, 1, '2022-03-07 10:44:49', 1, '2022-03-07 11:44:57', 1, 1, 1, NULL),
(341, 73, 1, 1, 1, '<p>Test checks if it is possible to open movie details</p>\r\n', '<p>- User is on main page<br />\r\n- At least one added active film screening</p>\r\n', 2, 1, '2022-03-07 10:45:10', 1, '2022-03-07 12:04:39', 1, 1, 2, NULL),
(344, 74, 1, 1, 1, '<p>Test checks if it is possible to open price list page</p>\r\n', '<p>- No active ticket types</p>\r\n', 2, 1, '2022-03-07 10:45:56', 1, '2022-03-07 13:00:27', 1, 1, 1, NULL),
(347, 75, 1, 1, 1, '<p>Test checks if it is possible to open price list page</p>\r\n', '<p>- At least one added actice ticket type in application</p>\r\n', 2, 1, '2022-03-07 10:46:15', 1, '2022-03-07 12:05:19', 1, 1, 2, NULL),
(350, 76, 1, 1, 1, '<p>Test checks if deleted ticket type appears on price list page</p>\r\n', '<p>- At least one added actice ticket type marked as deleted in application</p>\r\n', 2, 1, '2022-03-07 10:46:33', 1, '2022-03-07 12:05:31', 1, 1, 2, NULL),
(353, 77, 1, 1, 1, '<p>Test checks if it is possible to open repertoire page when there is at least one active film show.</p>\r\n', '<p>- User is on main page.<br />\r\n- At least one added active film screening in application</p>\r\n', 2, 1, '2022-03-07 10:46:59', 1, '2022-03-07 12:05:41', 1, 1, 2, NULL),
(356, 78, 1, 1, 1, '<p>Test checks if it is possible to open repertoire page when there is no active film shows.</p>\r\n', '<p>- User is on main page.<br />\r\n- No active film screening in application</p>\r\n', 2, 1, '2022-03-07 10:47:24', 1, '2022-03-07 11:47:32', 1, 1, 1, NULL),
(359, 79, 1, 1, 1, '<p>Test checks if it is possible to open reservation form from repertoire list</p>\r\n', '<p>- User is on repertoire page.<br />\r\n- At least one added film screening in application</p>\r\n', 2, 1, '2022-03-07 10:47:55', 1, '2022-03-07 12:14:22', 1, 1, 2, NULL),
(362, 80, 1, 1, 1, '<p>Test checks if it is possible to open reservation form from movie details</p>\r\n', '<p>- User is in movie details<br />\r\n- At least one added film screening in application</p>\r\n', 2, 1, '2022-03-07 10:48:15', 1, '2022-03-07 12:14:31', 1, 1, 2, NULL),
(365, 81, 1, 1, 1, '<p>Test checks if it is possible to create valid reservation for 10 or less seats</p>\r\n', '<p>- User is in movie details<br />\r\n- At least one added film screening in application</p>\r\n', 2, 1, '2022-03-07 10:48:36', 1, '2022-03-07 12:14:37', 1, 1, 2, NULL),
(374, 82, 1, 1, 1, '<p>Test checks if it is possible to create reservation for more than 10 seats</p>\r\n', '<p>- User is in movie details<br />\r\n- At least one added film screening in application</p>\r\n', 2, 1, '2022-03-07 10:49:31', 1, '2022-03-07 12:14:47', 1, 1, 2, NULL),
(379, 83, 1, 1, 1, '<p>Test checks if it is possible to create reservation without selected seats</p>\r\n', '<p>- User is in movie details<br />\r\n- At least one added film screening in application</p>\r\n', 2, 1, '2022-03-07 10:50:05', 1, '2022-03-07 11:50:23', 1, 1, 1, NULL),
(384, 84, 1, 1, 1, '<p>Test checks if it is possible to create valid reservation when mailing service doesn&#39;t work</p>\r\n', '<p>- User is in movie details<br />\r\n- At least one added film screening in application<br />\r\n- mailing service doesnt work</p>\r\n', 2, 1, '2022-03-07 10:50:36', 1, '2022-03-07 11:51:05', 1, 1, 1, NULL),
(392, 85, 1, 1, 1, '<p>Test checks if it is possible to confirm reservation</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:51:18', 1, '2022-03-07 12:14:58', 1, 1, 2, NULL),
(397, 86, 1, 1, 1, '<p>Test checks if it is possible to reject reservation</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;</p>\r\n', 2, 1, '2022-03-07 10:51:51', 1, '2022-03-07 12:15:03', 1, 1, 2, NULL),
(402, 87, 1, 1, 1, '<p>Test checks if it is possible to reject reservation after rejection</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;<br />\r\n- User rejected reservation</p>\r\n', 2, 1, '2022-03-07 10:52:18', 1, '2022-03-07 11:52:30', 1, 1, 1, NULL),
(406, 88, 1, 1, 1, '<p>Test checks if it is possible to reject reservation after confirmation</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;<br />\r\n- User confirmed reservation</p>\r\n', 2, 1, '2022-03-07 10:52:43', 1, '2022-03-07 11:53:07', 1, 1, 1, NULL),
(411, 89, 1, 1, 1, '<p>Test checks if it is possible to confirm reservation after rejection</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;<br />\r\n- User rejected reservation</p>\r\n', 2, 1, '2022-03-07 10:53:21', 1, '2022-03-07 11:53:33', 1, 1, 1, NULL),
(415, 90, 1, 1, 1, '<p>Test checks if it is possible to confirm reservation after confirmation</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;<br />\r\n- User confirmed reservation</p>\r\n', 2, 1, '2022-03-07 10:53:44', 1, '2022-03-07 11:53:59', 1, 1, 1, NULL),
(420, 91, 1, 1, 1, '<p>Test checks if it is possible to confirm reservationwhen reservation has beed deleted (link expired)</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;<br />\r\n- Reservation has beed deleted</p>\r\n', 2, 1, '2022-03-07 10:54:15', 1, '2022-03-07 11:54:27', 1, 1, 1, NULL),
(424, 92, 1, 1, 1, '<p>Test checks if it is possible to reject reservationwhen reservation has beed deleted (link expired)</p>\r\n', '<p>- Added reservation to film screening in application<br />\r\n- User received an email&nbsp;<br />\r\n- Reservation has beed deleted</p>\r\n', 2, 1, '2022-03-07 10:54:42', 1, '2022-03-07 11:54:52', 1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `tcversions_without_keywords`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `tcversions_without_keywords` (
`testcase_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `tcversions_without_platforms`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `tcversions_without_platforms` (
`testcase_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testcase_keywords`
--

CREATE TABLE `testcase_keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `testcase_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `keyword_id` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testcase_platforms`
--

CREATE TABLE `testcase_platforms` (
  `id` int(10) UNSIGNED NOT NULL,
  `testcase_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testcase_relations`
--

CREATE TABLE `testcase_relations` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `link_status` tinyint(1) NOT NULL DEFAULT '1',
  `relation_type` smallint(5) UNSIGNED NOT NULL DEFAULT '1',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testcase_script_links`
--

CREATE TABLE `testcase_script_links` (
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `project_key` varchar(64) NOT NULL,
  `repository_name` varchar(64) NOT NULL,
  `code_path` varchar(255) NOT NULL,
  `branch_name` varchar(64) DEFAULT NULL,
  `commit_id` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testplans`
--

CREATE TABLE `testplans` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `notes` text,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_open` tinyint(1) NOT NULL DEFAULT '1',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `api_key` varchar(64) NOT NULL DEFAULT '829a2ded3ed0829a2dedd8ab81dfa2c77e8235bc3ed0d8ab81dfa2c77e8235bc'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `testplans`
--

INSERT INTO `testplans` (`id`, `testproject_id`, `notes`, `active`, `is_open`, `is_public`, `api_key`) VALUES
(64, 1, '', 0, 1, 0, '941c377c73c0efed759c993f1b8595263d57fe6de705fec3cecae336ae23a03a'),
(427, 1, '', 1, 1, 0, '2f1b2e593a33988ea62ed7c9c96101473cbfb2330b21840b385a45c958602663');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testplan_platforms`
--

CREATE TABLE `testplan_platforms` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL,
  `platform_id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connects a testplan with platforms';

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testplan_tcversions`
--

CREATE TABLE `testplan_tcversions` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `node_order` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `urgency` smallint(5) NOT NULL DEFAULT '2',
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `testplan_tcversions`
--

INSERT INTO `testplan_tcversions` (`id`, `testplan_id`, `tcversion_id`, `node_order`, `urgency`, `platform_id`, `author_id`, `creation_ts`) VALUES
(1, 64, 4, 10000, 2, 0, 1, '2022-03-05 00:11:48'),
(2, 64, 7, 10010, 2, 0, 1, '2022-03-05 00:11:48'),
(3, 64, 10, 10020, 2, 0, 1, '2022-03-05 00:11:48'),
(4, 64, 13, 10030, 2, 0, 1, '2022-03-05 00:11:48'),
(5, 427, 4, 10000, 2, 0, 1, '2022-03-07 12:04:32'),
(6, 427, 7, 10010, 2, 0, 1, '2022-03-07 12:04:32'),
(7, 427, 10, 10020, 2, 0, 1, '2022-03-07 12:04:32'),
(8, 427, 13, 10030, 2, 0, 1, '2022-03-07 12:04:32'),
(9, 427, 17, 10000, 2, 0, 1, '2022-03-07 12:04:42'),
(10, 427, 59, 10000, 2, 0, 1, '2022-03-07 12:04:42'),
(11, 427, 66, 10020, 2, 0, 1, '2022-03-07 12:04:42'),
(12, 427, 73, 10040, 2, 0, 1, '2022-03-07 12:04:42'),
(13, 427, 101, 10080, 2, 0, 1, '2022-03-07 12:04:42'),
(14, 427, 106, 10090, 2, 0, 1, '2022-03-07 12:04:42'),
(15, 427, 111, 10000, 2, 0, 1, '2022-03-07 12:04:42'),
(16, 427, 114, 10010, 2, 0, 1, '2022-03-07 12:04:42'),
(17, 427, 118, 10020, 2, 0, 1, '2022-03-07 12:04:42'),
(18, 427, 128, 10030, 2, 0, 1, '2022-03-07 12:04:42'),
(19, 427, 140, 10050, 2, 0, 1, '2022-03-07 12:04:42'),
(20, 427, 152, 10070, 2, 0, 1, '2022-03-07 12:04:42'),
(21, 427, 161, 10080, 2, 0, 1, '2022-03-07 12:04:42'),
(22, 427, 170, 10090, 2, 0, 1, '2022-03-07 12:04:42'),
(23, 427, 173, 10100, 2, 0, 1, '2022-03-07 12:04:42'),
(24, 427, 176, 10110, 2, 0, 1, '2022-03-07 12:04:42'),
(25, 427, 181, 10120, 2, 0, 1, '2022-03-07 12:04:42'),
(26, 427, 195, 10140, 2, 0, 1, '2022-03-07 12:04:42'),
(27, 427, 203, 10160, 2, 0, 1, '2022-03-07 12:04:42'),
(28, 427, 211, 10180, 2, 0, 1, '2022-03-07 12:04:42'),
(29, 427, 222, 10210, 2, 0, 1, '2022-03-07 12:04:42'),
(30, 427, 227, 10000, 2, 0, 1, '2022-03-07 12:04:42'),
(31, 427, 230, 10010, 2, 0, 1, '2022-03-07 12:04:42'),
(32, 427, 234, 10020, 2, 0, 1, '2022-03-07 12:04:42'),
(33, 427, 239, 10030, 2, 0, 1, '2022-03-07 12:04:42'),
(34, 427, 242, 10040, 2, 0, 1, '2022-03-07 12:04:42'),
(35, 427, 247, 10050, 2, 0, 1, '2022-03-07 12:04:42'),
(36, 427, 252, 10060, 2, 0, 1, '2022-03-07 12:04:42'),
(37, 427, 257, 10070, 2, 0, 1, '2022-03-07 12:04:42'),
(38, 427, 263, 10090, 2, 0, 1, '2022-03-07 12:04:42'),
(39, 427, 269, 10000, 2, 0, 1, '2022-03-07 12:04:42'),
(40, 427, 272, 10010, 2, 0, 1, '2022-03-07 12:04:42'),
(41, 427, 276, 10020, 2, 0, 1, '2022-03-07 12:04:42'),
(42, 427, 281, 10030, 2, 0, 1, '2022-03-07 12:04:42'),
(43, 427, 284, 10040, 2, 0, 1, '2022-03-07 12:04:42'),
(44, 427, 294, 10060, 2, 0, 1, '2022-03-07 12:04:42'),
(45, 427, 310, 10100, 2, 0, 1, '2022-03-07 12:04:42'),
(46, 427, 323, 10000, 2, 0, 1, '2022-03-07 12:05:14'),
(47, 427, 326, 10000, 2, 0, 1, '2022-03-07 12:05:14'),
(48, 427, 341, 10040, 2, 0, 1, '2022-03-07 12:05:14'),
(49, 427, 347, 10010, 2, 0, 1, '2022-03-07 12:05:14'),
(50, 427, 350, 10020, 2, 0, 1, '2022-03-07 12:05:14'),
(51, 427, 353, 10000, 2, 0, 1, '2022-03-07 12:05:14'),
(52, 427, 359, 10000, 2, 0, 1, '2022-03-07 12:05:14'),
(53, 427, 362, 10010, 2, 0, 1, '2022-03-07 12:05:14'),
(54, 427, 365, 10020, 2, 0, 1, '2022-03-07 12:05:14'),
(55, 427, 374, 10030, 2, 0, 1, '2022-03-07 12:05:14'),
(56, 427, 392, 10060, 2, 0, 1, '2022-03-07 12:05:14'),
(57, 427, 397, 10070, 2, 0, 1, '2022-03-07 12:05:14');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testprojects`
--

CREATE TABLE `testprojects` (
  `id` int(10) UNSIGNED NOT NULL,
  `notes` text,
  `color` varchar(12) NOT NULL DEFAULT '#9BD',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `option_reqs` tinyint(1) NOT NULL DEFAULT '0',
  `option_priority` tinyint(1) NOT NULL DEFAULT '0',
  `option_automation` tinyint(1) NOT NULL DEFAULT '0',
  `options` text,
  `prefix` varchar(16) NOT NULL,
  `tc_counter` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `issue_tracker_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `code_tracker_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `reqmgr_integration_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `api_key` varchar(64) NOT NULL DEFAULT '0d8ab81dfa2c77e8235bc829a2ded3edfa2c78235bc829a27eded3ed0d8ab81d'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `testprojects`
--

INSERT INTO `testprojects` (`id`, `notes`, `color`, `active`, `option_reqs`, `option_priority`, `option_automation`, `options`, `prefix`, `tc_counter`, `is_public`, `issue_tracker_enabled`, `code_tracker_enabled`, `reqmgr_integration_enabled`, `api_key`) VALUES
(1, '<p>Tests for cinema project.</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}', 'C', 92, 1, 0, 0, 0, 'a90d826cba0c19f753c6273448ccaf0c7ebc686287f7afcdb4a2af8644b852b2');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testproject_codetracker`
--

CREATE TABLE `testproject_codetracker` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `codetracker_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testproject_issuetracker`
--

CREATE TABLE `testproject_issuetracker` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `issuetracker_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testproject_reqmgrsystem`
--

CREATE TABLE `testproject_reqmgrsystem` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `reqmgrsystem_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `testsuites`
--

CREATE TABLE `testsuites` (
  `id` int(10) UNSIGNED NOT NULL,
  `details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `testsuites`
--

INSERT INTO `testsuites` (`id`, `details`) VALUES
(2, ''),
(15, ''),
(57, ''),
(109, ''),
(225, ''),
(267, ''),
(314, ''),
(315, ''),
(316, ''),
(317, ''),
(318, ''),
(319, ''),
(320, ''),
(321, '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `text_templates`
--

CREATE TABLE `text_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `template_data` text,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_public` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Global Project Templates';

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `entry_point` varchar(45) NOT NULL DEFAULT '',
  `start_time` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `end_time` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `session_id` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `transactions`
--

INSERT INTO `transactions` (`id`, `entry_point`, `start_time`, `end_time`, `user_id`, `session_id`) VALUES
(1, '/testlink/login.php', 1646435333, 1646435333, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(2, '/testlink/lib/project/projectEdit.php', 1646435362, 1646435363, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(3, '/testlink/lib/testcases/listTestCases.php', 1646435371, 1646435371, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(4, '/testlink/lib/testcases/archiveData.php', 1646435371, 1646435371, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(5, '/testlink/lib/testcases/listTestCases.php', 1646435380, 1646435380, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(6, '/testlink/lib/testcases/archiveData.php', 1646435380, 1646435380, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(7, '/testlink/lib/testcases/listTestCases.php', 1646436788, 1646436788, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(8, '/testlink/lib/testcases/archiveData.php', 1646436788, 1646436788, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(9, '/testlink/lib/testcases/archiveData.php', 1646436790, 1646436790, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(10, '/testlink/lib/testcases/listTestCases.php', 1646436802, 1646436802, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(11, '/testlink/lib/testcases/tcEdit.php', 1646436826, 1646436827, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(12, '/testlink/lib/testcases/listTestCases.php', 1646436828, 1646436828, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(13, '/testlink/lib/testcases/tcEdit.php', 1646436839, 1646436839, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(14, '/testlink/lib/testcases/tcEdit.php', 1646436872, 1646436872, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(15, '/testlink/lib/testcases/listTestCases.php', 1646436873, 1646436873, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(16, '/testlink/lib/testcases/tcEdit.php', 1646436887, 1646436887, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(17, '/testlink/lib/testcases/tcEdit.php', 1646436906, 1646436906, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(18, '/testlink/lib/testcases/listTestCases.php', 1646436907, 1646436907, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(19, '/testlink/lib/testcases/tcEdit.php', 1646436918, 1646436918, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(20, '/testlink/lib/testcases/tcEdit.php', 1646436954, 1646436954, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(21, '/testlink/lib/testcases/listTestCases.php', 1646436955, 1646436955, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(22, '/testlink/lib/testcases/tcEdit.php', 1646436969, 1646436969, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(23, '/testlink/lib/keywords/keywordsEdit.php', 1646437091, 1646437092, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(24, '/testlink/lib/testcases/listTestCases.php', 1646437117, 1646437118, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(25, '/testlink/lib/testcases/archiveData.php', 1646437118, 1646437118, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(26, '/testlink/lib/testcases/archiveData.php', 1646437197, 1646437197, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(27, '/testlink/lib/testcases/listTestCases.php', 1646437213, 1646437213, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(28, '/testlink/lib/testcases/tcEdit.php', 1646437245, 1646437245, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(29, '/testlink/lib/testcases/listTestCases.php', 1646437246, 1646437246, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(30, '/testlink/lib/testcases/tcEdit.php', 1646437265, 1646437265, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(31, '/testlink/lib/testcases/tcEdit.php', 1646437287, 1646437287, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(32, '/testlink/lib/testcases/listTestCases.php', 1646437288, 1646437288, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(33, '/testlink/lib/testcases/tcEdit.php', 1646437305, 1646437306, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(34, '/testlink/lib/testcases/tcEdit.php', 1646437345, 1646437345, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(35, '/testlink/lib/testcases/tcEdit.php', 1646437354, 1646437354, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(36, '/testlink/lib/testcases/tcEdit.php', 1646437473, 1646437473, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(37, '/testlink/lib/testcases/listTestCases.php', 1646437474, 1646437474, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(38, '/testlink/lib/testcases/tcEdit.php', 1646437496, 1646437496, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(39, '/testlink/lib/testcases/tcEdit.php', 1646437527, 1646437527, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(40, '/testlink/lib/testcases/listTestCases.php', 1646437528, 1646437528, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(41, '/testlink/lib/testcases/tcEdit.php', 1646437547, 1646437547, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(42, '/testlink/lib/testcases/tcEdit.php', 1646437560, 1646437560, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(43, '/testlink/lib/testcases/tcEdit.php', 1646437575, 1646437575, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(44, '/testlink/lib/testcases/listTestCases.php', 1646437575, 1646437576, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(45, '/testlink/lib/testcases/tcEdit.php', 1646437596, 1646437597, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(46, '/testlink/lib/testcases/tcEdit.php', 1646437649, 1646437649, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(47, '/testlink/lib/testcases/listTestCases.php', 1646437650, 1646437650, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(48, '/testlink/lib/testcases/tcEdit.php', 1646437656, 1646437656, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(49, '/testlink/lib/testcases/tcEdit.php', 1646437667, 1646437668, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(50, '/testlink/lib/testcases/tcEdit.php', 1646437684, 1646437684, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(51, '/testlink/lib/testcases/listTestCases.php', 1646437685, 1646437685, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(52, '/testlink/lib/testcases/tcEdit.php', 1646437704, 1646437704, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(53, '/testlink/lib/testcases/tcEdit.php', 1646437721, 1646437721, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(54, '/testlink/lib/testcases/listTestCases.php', 1646437722, 1646437722, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(55, '/testlink/lib/testcases/tcEdit.php', 1646437740, 1646437740, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(56, '/testlink/lib/testcases/tcEdit.php', 1646437771, 1646437771, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(57, '/testlink/lib/testcases/listTestCases.php', 1646437772, 1646437772, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(58, '/testlink/lib/testcases/tcEdit.php', 1646437788, 1646437788, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(59, '/testlink/lib/testcases/archiveData.php', 1646437810, 1646437810, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(60, '/testlink/lib/testcases/listTestCases.php', 1646437822, 1646437823, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(61, '/testlink/lib/testcases/tcEdit.php', 1646437840, 1646437840, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(62, '/testlink/lib/testcases/listTestCases.php', 1646437841, 1646437841, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(63, '/testlink/lib/testcases/tcEdit.php', 1646437852, 1646437852, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(64, '/testlink/lib/testcases/tcEdit.php', 1646437880, 1646437880, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(65, '/testlink/lib/testcases/listTestCases.php', 1646437880, 1646437881, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(66, '/testlink/lib/testcases/tcEdit.php', 1646437889, 1646437890, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(67, '/testlink/lib/testcases/listTestCases.php', 1646438842, 1646438843, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(68, '/testlink/lib/testcases/archiveData.php', 1646438843, 1646438843, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(69, '/testlink/lib/general/mainPage.php', 1646438880, 1646438880, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(70, '/testlink/lib/plan/planEdit.php', 1646438986, 1646438986, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(71, '/testlink/lib/plan/planEdit.php', 1646438992, 1646438992, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(72, '/testlink/lib/plan/planEdit.php', 1646439024, 1646439025, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(73, '/testlink/lib/plan/planEdit.php', 1646439027, 1646439027, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(74, '/testlink/lib/plan/buildEdit.php', 1646439056, 1646439056, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(75, '/testlink/lib/plan/planAddTCNavigator.php', 1646439093, 1646439093, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(76, '/testlink/lib/plan/planAddTC.php', 1646439108, 1646439109, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(77, '/testlink/lib/plan/planAddTCNavigator.php', 1646439109, 1646439109, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(78, '/testlink/lib/plan/planAddTCNavigator.php', 1646439115, 1646439115, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(79, '/testlink/lib/testcases/archiveData.php', 1646439182, 1646439182, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(80, '/testlink/lib/testcases/listTestCases.php', 1646439182, 1646439182, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(81, '/testlink/lib/testcases/tcEdit.php', 1646439197, 1646439197, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(82, '/testlink/lib/testcases/archiveData.php', 1646581045, 1646581045, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(83, '/testlink/lib/testcases/listTestCases.php', 1646581046, 1646581046, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(84, '/testlink/lib/testcases/listTestCases.php', 1646581057, 1646581057, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(85, '/testlink/lib/testcases/archiveData.php', 1646581057, 1646581057, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(86, '/testlink/lib/testcases/listTestCases.php', 1646592520, 1646592520, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(87, '/testlink/lib/testcases/listTestCases.php', 1646592557, 1646592557, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(88, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646594935, 1646594935, 1, ''),
(89, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646596367, 1646596367, 1, ''),
(90, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646596418, 1646596418, 1, ''),
(91, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646596443, 1646596443, 1, ''),
(92, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598139, 1646598140, 1, ''),
(93, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598140, 1646598140, 1, ''),
(94, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598169, 1646598170, 1, ''),
(95, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598170, 1646598170, 1, ''),
(96, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598201, 1646598201, 1, ''),
(97, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598202, 1646598202, 1, ''),
(98, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598211, 1646598212, 1, ''),
(99, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598212, 1646598212, 1, ''),
(100, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598235, 1646598235, 1, ''),
(101, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646598235, 1646598235, 1, ''),
(102, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646599177, 1646599177, 1, ''),
(103, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646599177, 1646599178, 1, ''),
(104, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646599265, 1646599265, 1, ''),
(105, '/testlink/lib/platforms/platformsEdit.php', 1646600189, 1646600190, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(106, '/testlink/lib/platforms/platformsEdit.php', 1646600198, 1646600199, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(107, '/testlink/lib/platforms/platformsEdit.php', 1646600201, 1646600201, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(108, '/testlink/lib/platforms/platformsEdit.php', 1646600204, 1646600204, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(109, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600273, 1646600274, 1, ''),
(110, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600502, 1646600502, 1, ''),
(111, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600592, 1646600592, 1, ''),
(112, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600710, 1646600710, 1, ''),
(113, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600735, 1646600735, 1, ''),
(114, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600802, 1646600802, 1, ''),
(115, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646600811, 1646600811, 1, ''),
(116, '/testlink/lib/plan/planEdit.php', 1646600855, 1646600855, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(117, '/testlink/lib/plan/buildEdit.php', 1646600874, 1646600874, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(118, '/testlink/lib/plan/buildEdit.php', 1646600880, 1646600880, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(119, '/testlink/lib/plan/buildEdit.php', 1646600909, 1646600909, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(120, '/testlink/lib/plan/planEdit.php', 1646601849, 1646601849, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(121, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604755, 1646604755, 1, ''),
(122, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604782, 1646604782, 1, ''),
(123, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604783, 1646604783, 1, ''),
(124, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604807, 1646604807, 1, ''),
(125, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604808, 1646604808, 1, ''),
(126, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604857, 1646604857, 1, ''),
(127, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604858, 1646604858, 1, ''),
(128, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604930, 1646604930, 1, ''),
(129, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646604931, 1646604931, 1, ''),
(130, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605078, 1646605078, 1, ''),
(131, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605078, 1646605079, 1, ''),
(132, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605114, 1646605114, 1, ''),
(133, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605115, 1646605115, 1, ''),
(134, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605129, 1646605129, 1, ''),
(135, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605130, 1646605130, 1, ''),
(136, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605149, 1646605149, 1, ''),
(137, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605149, 1646605149, 1, ''),
(138, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605160, 1646605161, 1, ''),
(139, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605161, 1646605161, 1, ''),
(140, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605185, 1646605185, 1, ''),
(141, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605185, 1646605186, 1, ''),
(142, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605211, 1646605212, 1, ''),
(143, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605243, 1646605243, 1, ''),
(144, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605261, 1646605262, 1, ''),
(145, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605262, 1646605262, 1, ''),
(146, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605288, 1646605288, 1, ''),
(147, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605288, 1646605288, 1, ''),
(148, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605309, 1646605310, 1, ''),
(149, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605310, 1646605310, 1, ''),
(150, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605315, 1646605315, 1, ''),
(151, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605316, 1646605316, 1, ''),
(152, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605354, 1646605354, 1, ''),
(153, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605355, 1646605355, 1, ''),
(154, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605368, 1646605369, 1, ''),
(155, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605369, 1646605369, 1, ''),
(156, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605408, 1646605408, 1, ''),
(157, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605409, 1646605409, 1, ''),
(158, '/testlink/lib/testcases/listTestCases.php', 1646605434, 1646605434, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(159, '/testlink/lib/testcases/archiveData.php', 1646605434, 1646605434, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(160, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646605574, 1646605574, 1, ''),
(161, '/testlink/lib/keywords/keywordsEdit.php', 1646605861, 1646605861, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(162, '/testlink/lib/testcases/listTestCases.php', 1646605941, 1646605941, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(163, '/testlink/lib/testcases/archiveData.php', 1646605941, 1646605941, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(164, '/testlink/lib/plan/buildEdit.php', 1646606321, 1646606321, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(165, '/testlink/lib/plan/buildEdit.php', 1646606328, 1646606328, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(166, '/testlink/lib/testcases/listTestCases.php', 1646607230, 1646607230, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(167, '/testlink/lib/testcases/archiveData.php', 1646607230, 1646607231, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(168, '/testlink/lib/testcases/listTestCases.php', 1646607262, 1646607262, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(169, '/testlink/lib/testcases/archiveData.php', 1646607262, 1646607262, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(170, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607266, 1646607267, 1, ''),
(171, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607300, 1646607301, 1, ''),
(172, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607348, 1646607348, 1, ''),
(173, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607357, 1646607358, 1, ''),
(174, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607400, 1646607400, 1, ''),
(175, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607419, 1646607419, 1, ''),
(176, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607442, 1646607442, 1, ''),
(177, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607531, 1646607531, 1, ''),
(178, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607539, 1646607539, 1, ''),
(179, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607565, 1646607565, 1, ''),
(180, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607569, 1646607569, 1, ''),
(181, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607622, 1646607622, 1, ''),
(182, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607623, 1646607623, 1, ''),
(183, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607720, 1646607721, 1, ''),
(184, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607721, 1646607721, 1, ''),
(185, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607738, 1646607739, 1, ''),
(186, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607739, 1646607739, 1, ''),
(187, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607836, 1646607836, 1, ''),
(188, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607836, 1646607837, 1, ''),
(189, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607855, 1646607855, 1, ''),
(190, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607856, 1646607856, 1, ''),
(191, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607875, 1646607875, 1, ''),
(192, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607876, 1646607876, 1, ''),
(193, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607882, 1646607882, 1, ''),
(194, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646607882, 1646607882, 1, ''),
(195, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608148, 1646608148, 1, ''),
(196, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608149, 1646608149, 1, ''),
(197, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608186, 1646608187, 1, ''),
(198, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608201, 1646608201, 1, ''),
(199, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608281, 1646608281, 1, ''),
(200, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608299, 1646608300, 1, ''),
(201, '/testlink/lib/testcases/listTestCases.php', 1646608313, 1646608313, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(202, '/testlink/lib/testcases/archiveData.php', 1646608314, 1646608314, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(203, '/testlink/lib/execute/execSetResults.php', 1646608335, 1646608336, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(204, '/testlink/lib/execute/execSetResults.php', 1646608347, 1646608347, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(205, '/testlink/lib/execute/execSetResults.php', 1646608397, 1646608397, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(206, '/testlink/lib/execute/execSetResults.php', 1646608423, 1646608424, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(207, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608574, 1646608574, 1, ''),
(208, '/testlink/lib/execute/execSetResults.php', 1646608628, 1646608629, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(209, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608665, 1646608665, 1, ''),
(210, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646608691, 1646608691, 1, ''),
(211, '/testlink/lib/execute/execSetResults.php', 1646609256, 1646609256, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(212, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646610567, 1646610567, 1, ''),
(213, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646610607, 1646610607, 1, ''),
(214, '/testlink/lib/plan/planEdit.php', 1646643303, 1646643303, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(215, '/testlink/lib/testcases/listTestCases.php', 1646643359, 1646643359, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(216, '/testlink/lib/testcases/archiveData.php', 1646643359, 1646643359, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(217, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646646027, 1646646027, 1, ''),
(218, '/testlink/lib/testcases/listTestCases.php', 1646646474, 1646646474, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(219, '/testlink/lib/testcases/archiveData.php', 1646646475, 1646646475, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(220, '/testlink/lib/testcases/tcEdit.php', 1646646541, 1646646542, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(221, '/testlink/lib/testcases/listTestCases.php', 1646646542, 1646646542, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(222, '/testlink/lib/testcases/tcEdit.php', 1646646565, 1646646565, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(223, '/testlink/lib/testcases/tcEdit.php', 1646646589, 1646646589, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(224, '/testlink/lib/testcases/listTestCases.php', 1646646590, 1646646590, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(225, '/testlink/lib/testcases/tcEdit.php', 1646646599, 1646646599, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(226, '/testlink/lib/testcases/tcEdit.php', 1646646621, 1646646621, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(227, '/testlink/lib/testcases/listTestCases.php', 1646646622, 1646646622, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(228, '/testlink/lib/testcases/tcEdit.php', 1646646651, 1646646651, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(229, '/testlink/lib/testcases/tcEdit.php', 1646646686, 1646646686, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(230, '/testlink/lib/testcases/listTestCases.php', 1646646687, 1646646687, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(231, '/testlink/lib/testcases/tcEdit.php', 1646646723, 1646646724, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(232, '/testlink/lib/testcases/tcEdit.php', 1646646745, 1646646746, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(233, '/testlink/lib/testcases/listTestCases.php', 1646646746, 1646646746, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(234, '/testlink/lib/testcases/tcEdit.php', 1646646780, 1646646781, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(235, '/testlink/lib/testcases/tcEdit.php', 1646646801, 1646646801, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(236, '/testlink/lib/testcases/listTestCases.php', 1646646802, 1646646802, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(237, '/testlink/lib/testcases/tcEdit.php', 1646646819, 1646646819, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(238, '/testlink/lib/testcases/tcEdit.php', 1646646841, 1646646841, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(239, '/testlink/lib/testcases/listTestCases.php', 1646646841, 1646646841, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(240, '/testlink/lib/testcases/tcEdit.php', 1646646857, 1646646857, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(241, '/testlink/lib/testcases/tcEdit.php', 1646646864, 1646646864, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(242, '/testlink/lib/testcases/tcEdit.php', 1646646881, 1646646882, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(243, '/testlink/lib/testcases/listTestCases.php', 1646646882, 1646646882, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(244, '/testlink/lib/testcases/tcEdit.php', 1646646890, 1646646890, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(245, '/testlink/lib/testcases/tcEdit.php', 1646646896, 1646646897, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(246, '/testlink/lib/testcases/archiveData.php', 1646646921, 1646646921, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(247, '/testlink/lib/testcases/containerEdit.php', 1646646933, 1646646933, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(248, '/testlink/lib/testcases/listTestCases.php', 1646646934, 1646646934, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(249, '/testlink/lib/testcases/tcEdit.php', 1646646995, 1646646995, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(250, '/testlink/lib/testcases/listTestCases.php', 1646646996, 1646646996, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(251, '/testlink/lib/testcases/tcEdit.php', 1646647003, 1646647003, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(252, '/testlink/lib/testcases/tcEdit.php', 1646647021, 1646647021, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(253, '/testlink/lib/testcases/listTestCases.php', 1646647021, 1646647022, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(254, '/testlink/lib/testcases/tcEdit.php', 1646647035, 1646647035, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(255, '/testlink/lib/testcases/tcEdit.php', 1646647075, 1646647075, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(256, '/testlink/lib/testcases/listTestCases.php', 1646647076, 1646647076, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(257, '/testlink/lib/testcases/tcEdit.php', 1646647086, 1646647087, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(258, '/testlink/lib/testcases/tcEdit.php', 1646647126, 1646647126, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(259, '/testlink/lib/testcases/tcEdit.php', 1646647439, 1646647439, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(260, '/testlink/lib/testcases/listTestCases.php', 1646647440, 1646647440, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(261, '/testlink/lib/testcases/tcEdit.php', 1646647454, 1646647454, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(262, '/testlink/lib/testcases/tcEdit.php', 1646647472, 1646647472, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(263, '/testlink/lib/testcases/listTestCases.php', 1646647473, 1646647473, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(264, '/testlink/lib/testcases/tcEdit.php', 1646647482, 1646647483, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(265, '/testlink/lib/testcases/tcEdit.php', 1646647514, 1646647514, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(266, '/testlink/lib/testcases/tcEdit.php', 1646647533, 1646647534, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(267, '/testlink/lib/testcases/listTestCases.php', 1646647534, 1646647534, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(268, '/testlink/lib/testcases/tcEdit.php', 1646647542, 1646647543, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(269, '/testlink/lib/testcases/tcEdit.php', 1646647588, 1646647588, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(270, '/testlink/lib/testcases/listTestCases.php', 1646647589, 1646647589, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(271, '/testlink/lib/testcases/tcEdit.php', 1646647618, 1646647618, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(272, '/testlink/lib/testcases/tcEdit.php', 1646647668, 1646647669, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(273, '/testlink/lib/testcases/listTestCases.php', 1646647669, 1646647669, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(274, '/testlink/lib/testcases/tcEdit.php', 1646647713, 1646647713, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(275, '/testlink/lib/testcases/tcEdit.php', 1646647739, 1646647739, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(276, '/testlink/lib/testcases/listTestCases.php', 1646647740, 1646647740, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(277, '/testlink/lib/testcases/tcEdit.php', 1646647774, 1646647774, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(278, '/testlink/lib/testcases/tcEdit.php', 1646647842, 1646647842, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(279, '/testlink/lib/testcases/listTestCases.php', 1646647843, 1646647843, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(280, '/testlink/lib/testcases/tcEdit.php', 1646647852, 1646647852, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(281, '/testlink/lib/testcases/tcEdit.php', 1646647897, 1646647897, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(282, '/testlink/lib/testcases/listTestCases.php', 1646647898, 1646647898, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(283, '/testlink/lib/testcases/tcEdit.php', 1646647904, 1646647904, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(284, '/testlink/lib/testcases/tcEdit.php', 1646647921, 1646647921, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(285, '/testlink/lib/testcases/listTestCases.php', 1646647921, 1646647922, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(286, '/testlink/lib/testcases/tcEdit.php', 1646647934, 1646647934, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(287, '/testlink/lib/testcases/tcEdit.php', 1646647938, 1646647938, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(288, '/testlink/lib/testcases/tcEdit.php', 1646647953, 1646647953, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(289, '/testlink/lib/testcases/listTestCases.php', 1646647954, 1646647954, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(290, '/testlink/lib/testcases/tcEdit.php', 1646647976, 1646647977, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(291, '/testlink/lib/testcases/tcEdit.php', 1646648006, 1646648007, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(292, '/testlink/lib/testcases/listTestCases.php', 1646648007, 1646648008, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(293, '/testlink/lib/testcases/tcEdit.php', 1646648016, 1646648016, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(294, '/testlink/lib/testcases/tcEdit.php', 1646648034, 1646648034, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(295, '/testlink/lib/testcases/tcEdit.php', 1646648047, 1646648047, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(296, '/testlink/lib/testcases/listTestCases.php', 1646648048, 1646648048, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(297, '/testlink/lib/testcases/tcEdit.php', 1646648055, 1646648056, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(298, '/testlink/lib/testcases/tcEdit.php', 1646648068, 1646648068, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(299, '/testlink/lib/testcases/tcEdit.php', 1646648085, 1646648085, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(300, '/testlink/lib/testcases/listTestCases.php', 1646648085, 1646648085, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(301, '/testlink/lib/testcases/tcEdit.php', 1646648092, 1646648092, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(302, '/testlink/lib/testcases/tcEdit.php', 1646648107, 1646648108, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(303, '/testlink/lib/testcases/listTestCases.php', 1646648108, 1646648108, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(304, '/testlink/lib/testcases/tcEdit.php', 1646648125, 1646648126, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(305, '/testlink/lib/testcases/tcEdit.php', 1646648149, 1646648149, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(306, '/testlink/lib/testcases/listTestCases.php', 1646648149, 1646648150, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(307, '/testlink/lib/testcases/tcEdit.php', 1646648310, 1646648311, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(308, '/testlink/lib/testcases/tcEdit.php', 1646648572, 1646648572, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(309, '/testlink/lib/testcases/listTestCases.php', 1646648573, 1646648573, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(310, '/testlink/lib/testcases/tcEdit.php', 1646648600, 1646648601, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(311, '/testlink/lib/testcases/tcEdit.php', 1646648623, 1646648623, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(312, '/testlink/lib/testcases/listTestCases.php', 1646648624, 1646648624, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(313, '/testlink/lib/testcases/tcEdit.php', 1646648631, 1646648631, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(314, '/testlink/lib/testcases/tcEdit.php', 1646648664, 1646648665, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(315, '/testlink/lib/testcases/listTestCases.php', 1646648665, 1646648665, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(316, '/testlink/lib/testcases/tcEdit.php', 1646648674, 1646648674, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(317, '/testlink/lib/testcases/tcEdit.php', 1646648685, 1646648686, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(318, '/testlink/lib/testcases/listTestCases.php', 1646648686, 1646648686, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(319, '/testlink/lib/testcases/tcEdit.php', 1646648698, 1646648698, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(320, '/testlink/lib/testcases/archiveData.php', 1646648703, 1646648703, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(321, '/testlink/lib/testcases/containerEdit.php', 1646648774, 1646648774, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(322, '/testlink/lib/testcases/listTestCases.php', 1646648774, 1646648774, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(323, '/testlink/lib/testcases/tcEdit.php', 1646648792, 1646648792, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(324, '/testlink/lib/testcases/listTestCases.php', 1646648793, 1646648793, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(325, '/testlink/lib/testcases/tcEdit.php', 1646648799, 1646648799, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(326, '/testlink/lib/testcases/tcEdit.php', 1646648812, 1646648812, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(327, '/testlink/lib/testcases/listTestCases.php', 1646648813, 1646648813, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(328, '/testlink/lib/testcases/tcEdit.php', 1646648825, 1646648825, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(329, '/testlink/lib/testcases/tcEdit.php', 1646648846, 1646648846, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(330, '/testlink/lib/testcases/listTestCases.php', 1646648847, 1646648847, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(331, '/testlink/lib/testcases/tcEdit.php', 1646648864, 1646648865, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(332, '/testlink/lib/testcases/tcEdit.php', 1646648873, 1646648873, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(333, '/testlink/lib/testcases/tcEdit.php', 1646648890, 1646648891, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(334, '/testlink/lib/testcases/listTestCases.php', 1646648891, 1646648891, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(335, '/testlink/lib/testcases/tcEdit.php', 1646648900, 1646648900, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(336, '/testlink/lib/testcases/tcEdit.php', 1646648914, 1646648914, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(337, '/testlink/lib/testcases/listTestCases.php', 1646648915, 1646648915, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(338, '/testlink/lib/testcases/tcEdit.php', 1646648929, 1646648929, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(339, '/testlink/lib/testcases/tcEdit.php', 1646648953, 1646648953, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(340, '/testlink/lib/testcases/listTestCases.php', 1646648953, 1646648954, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(341, '/testlink/lib/testcases/tcEdit.php', 1646648968, 1646648968, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(342, '/testlink/lib/testcases/tcEdit.php', 1646648985, 1646648985, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(343, '/testlink/lib/testcases/listTestCases.php', 1646648986, 1646648986, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(344, '/testlink/lib/testcases/tcEdit.php', 1646649000, 1646649000, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(345, '/testlink/lib/testcases/tcEdit.php', 1646649007, 1646649007, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(346, '/testlink/lib/testcases/tcEdit.php', 1646649025, 1646649025, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(347, '/testlink/lib/testcases/listTestCases.php', 1646649026, 1646649026, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(348, '/testlink/lib/testcases/tcEdit.php', 1646649035, 1646649035, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(349, '/testlink/lib/testcases/tcEdit.php', 1646649049, 1646649050, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(350, '/testlink/lib/testcases/listTestCases.php', 1646649050, 1646649050, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(351, '/testlink/lib/testcases/tcEdit.php', 1646649059, 1646649059, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(352, '/testlink/lib/testcases/tcEdit.php', 1646649071, 1646649071, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(353, '/testlink/lib/testcases/listTestCases.php', 1646649071, 1646649072, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(354, '/testlink/lib/testcases/tcEdit.php', 1646649089, 1646649089, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(355, '/testlink/lib/testcases/archiveData.php', 1646649118, 1646649119, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(356, '/testlink/lib/testcases/archiveData.php', 1646649120, 1646649120, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(357, '/testlink/lib/testcases/containerEdit.php', 1646649130, 1646649130, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(358, '/testlink/lib/testcases/listTestCases.php', 1646649131, 1646649131, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(359, '/testlink/lib/testcases/tcEdit.php', 1646649150, 1646649150, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(360, '/testlink/lib/testcases/listTestCases.php', 1646649151, 1646649151, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(361, '/testlink/lib/testcases/tcEdit.php', 1646649158, 1646649159, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(362, '/testlink/lib/testcases/tcEdit.php', 1646649171, 1646649171, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(363, '/testlink/lib/testcases/listTestCases.php', 1646649172, 1646649172, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(364, '/testlink/lib/testcases/tcEdit.php', 1646649189, 1646649189, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(365, '/testlink/lib/testcases/tcEdit.php', 1646649204, 1646649205, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(366, '/testlink/lib/testcases/listTestCases.php', 1646649205, 1646649206, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(367, '/testlink/lib/testcases/tcEdit.php', 1646649228, 1646649228, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(368, '/testlink/lib/testcases/tcEdit.php', 1646649246, 1646649246, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(369, '/testlink/lib/testcases/listTestCases.php', 1646649247, 1646649247, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(370, '/testlink/lib/testcases/tcEdit.php', 1646649255, 1646649255, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(371, '/testlink/lib/testcases/tcEdit.php', 1646649266, 1646649266, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(372, '/testlink/lib/testcases/listTestCases.php', 1646649267, 1646649267, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(373, '/testlink/lib/testcases/tcEdit.php', 1646649280, 1646649280, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(374, '/testlink/lib/testcases/tcEdit.php', 1646649285, 1646649285, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(375, '/testlink/lib/testcases/tcEdit.php', 1646649297, 1646649297, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(376, '/testlink/lib/testcases/listTestCases.php', 1646649298, 1646649298, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(377, '/testlink/lib/testcases/tcEdit.php', 1646649313, 1646649313, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(378, '/testlink/lib/testcases/tcEdit.php', 1646649404, 1646649405, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(379, '/testlink/lib/testcases/listTestCases.php', 1646649405, 1646649405, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(380, '/testlink/lib/testcases/tcEdit.php', 1646649420, 1646649420, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(381, '/testlink/lib/testcases/tcEdit.php', 1646649434, 1646649434, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(382, '/testlink/lib/testcases/listTestCases.php', 1646649435, 1646649435, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(383, '/testlink/lib/testcases/tcEdit.php', 1646649446, 1646649446, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(384, '/testlink/lib/testcases/tcEdit.php', 1646649462, 1646649463, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(385, '/testlink/lib/testcases/listTestCases.php', 1646649463, 1646649463, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(386, '/testlink/lib/testcases/tcEdit.php', 1646649469, 1646649469, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(387, '/testlink/lib/testcases/tcEdit.php', 1646649492, 1646649493, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(388, '/testlink/lib/testcases/listTestCases.php', 1646649493, 1646649493, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(389, '/testlink/lib/testcases/tcEdit.php', 1646649508, 1646649509, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(390, '/testlink/lib/testcases/tcEdit.php', 1646649539, 1646649539, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(391, '/testlink/lib/testcases/listTestCases.php', 1646649540, 1646649540, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(392, '/testlink/lib/testcases/tcEdit.php', 1646649556, 1646649556, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(393, '/testlink/lib/testcases/archiveData.php', 1646649600, 1646649600, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(394, '/testlink/lib/testcases/containerEdit.php', 1646649612, 1646649612, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(395, '/testlink/lib/testcases/listTestCases.php', 1646649613, 1646649613, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(396, '/testlink/lib/testcases/archiveData.php', 1646649649, 1646649649, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(397, '/testlink/lib/testcases/listTestCases.php', 1646649653, 1646649654, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(398, '/testlink/lib/testcases/archiveData.php', 1646649654, 1646649654, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(399, '/testlink/lib/testcases/archiveData.php', 1646649658, 1646649658, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(400, '/testlink/lib/testcases/containerEdit.php', 1646649665, 1646649665, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(401, '/testlink/lib/testcases/listTestCases.php', 1646649666, 1646649666, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(402, '/testlink/lib/testcases/listTestCases.php', 1646649673, 1646649673, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(403, '/testlink/lib/testcases/listTestCases.php', 1646649674, 1646649674, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(404, '/testlink/lib/testcases/containerEdit.php', 1646649696, 1646649697, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(405, '/testlink/lib/testcases/listTestCases.php', 1646649697, 1646649697, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(406, '/testlink/lib/testcases/containerEdit.php', 1646649705, 1646649705, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(407, '/testlink/lib/testcases/listTestCases.php', 1646649706, 1646649706, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(408, '/testlink/lib/testcases/containerEdit.php', 1646649712, 1646649712, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(409, '/testlink/lib/testcases/listTestCases.php', 1646649712, 1646649712, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(410, '/testlink/lib/testcases/containerEdit.php', 1646649719, 1646649719, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(411, '/testlink/lib/testcases/listTestCases.php', 1646649720, 1646649720, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(412, '/testlink/lib/testcases/containerEdit.php', 1646649724, 1646649724, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(413, '/testlink/lib/testcases/listTestCases.php', 1646649724, 1646649725, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(414, '/testlink/lib/testcases/containerEdit.php', 1646649727, 1646649727, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(415, '/testlink/lib/testcases/listTestCases.php', 1646649727, 1646649728, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(416, '/testlink/lib/testcases/tcEdit.php', 1646649763, 1646649763, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(417, '/testlink/lib/testcases/listTestCases.php', 1646649764, 1646649764, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(418, '/testlink/lib/testcases/tcEdit.php', 1646649771, 1646649772, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(419, '/testlink/lib/testcases/tcEdit.php', 1646649793, 1646649793, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(420, '/testlink/lib/testcases/listTestCases.php', 1646649794, 1646649794, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(421, '/testlink/lib/testcases/tcEdit.php', 1646649801, 1646649801, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(422, '/testlink/lib/testcases/tcEdit.php', 1646649824, 1646649824, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(423, '/testlink/lib/testcases/listTestCases.php', 1646649825, 1646649825, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(424, '/testlink/lib/testcases/tcEdit.php', 1646649833, 1646649833, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(425, '/testlink/lib/testcases/tcEdit.php', 1646649845, 1646649845, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(426, '/testlink/lib/testcases/listTestCases.php', 1646649846, 1646649846, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(427, '/testlink/lib/testcases/tcEdit.php', 1646649855, 1646649856, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(428, '/testlink/lib/testcases/tcEdit.php', 1646649870, 1646649870, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(429, '/testlink/lib/testcases/listTestCases.php', 1646649871, 1646649871, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(430, '/testlink/lib/testcases/tcEdit.php', 1646649877, 1646649877, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(431, '/testlink/lib/testcases/tcEdit.php', 1646649889, 1646649889, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(432, '/testlink/lib/testcases/listTestCases.php', 1646649890, 1646649890, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(433, '/testlink/lib/testcases/tcEdit.php', 1646649897, 1646649897, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(434, '/testlink/lib/testcases/tcEdit.php', 1646649910, 1646649910, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(435, '/testlink/lib/testcases/listTestCases.php', 1646649911, 1646649911, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(436, '/testlink/lib/testcases/tcEdit.php', 1646649919, 1646649919, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(437, '/testlink/lib/testcases/tcEdit.php', 1646649956, 1646649956, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(438, '/testlink/lib/testcases/listTestCases.php', 1646649957, 1646649957, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(439, '/testlink/lib/testcases/tcEdit.php', 1646649962, 1646649963, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(440, '/testlink/lib/testcases/tcEdit.php', 1646649975, 1646649975, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(441, '/testlink/lib/testcases/listTestCases.php', 1646649976, 1646649976, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(442, '/testlink/lib/testcases/tcEdit.php', 1646649982, 1646649982, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(443, '/testlink/lib/testcases/tcEdit.php', 1646649993, 1646649993, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(444, '/testlink/lib/testcases/listTestCases.php', 1646649994, 1646649994, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(445, '/testlink/lib/testcases/tcEdit.php', 1646650001, 1646650001, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(446, '/testlink/lib/testcases/tcEdit.php', 1646650019, 1646650019, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(447, '/testlink/lib/testcases/listTestCases.php', 1646650020, 1646650020, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(448, '/testlink/lib/testcases/tcEdit.php', 1646650026, 1646650026, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(449, '/testlink/lib/testcases/tcEdit.php', 1646650030, 1646650030, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(450, '/testlink/lib/testcases/tcEdit.php', 1646650044, 1646650044, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(451, '/testlink/lib/testcases/listTestCases.php', 1646650045, 1646650045, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(452, '/testlink/lib/testcases/tcEdit.php', 1646650052, 1646650052, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(453, '/testlink/lib/testcases/tcEdit.php', 1646650076, 1646650076, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(454, '/testlink/lib/testcases/listTestCases.php', 1646650077, 1646650077, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(455, '/testlink/lib/testcases/tcEdit.php', 1646650084, 1646650085, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(456, '/testlink/lib/testcases/tcEdit.php', 1646650095, 1646650095, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(457, '/testlink/lib/testcases/listTestCases.php', 1646650095, 1646650096, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(458, '/testlink/lib/testcases/tcEdit.php', 1646650105, 1646650105, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(459, '/testlink/lib/testcases/tcEdit.php', 1646650116, 1646650117, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(460, '/testlink/lib/testcases/listTestCases.php', 1646650117, 1646650117, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(461, '/testlink/lib/testcases/tcEdit.php', 1646650157, 1646650157, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(462, '/testlink/lib/testcases/tcEdit.php', 1646650172, 1646650172, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(463, '/testlink/lib/testcases/listTestCases.php', 1646650173, 1646650173, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(464, '/testlink/lib/testcases/tcEdit.php', 1646650190, 1646650190, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(465, '/testlink/lib/testcases/tcEdit.php', 1646650205, 1646650205, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(466, '/testlink/lib/testcases/listTestCases.php', 1646650206, 1646650206, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(467, '/testlink/lib/testcases/tcEdit.php', 1646650223, 1646650223, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(468, '/testlink/lib/testcases/tcEdit.php', 1646650236, 1646650236, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(469, '/testlink/lib/testcases/listTestCases.php', 1646650236, 1646650237, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(470, '/testlink/lib/testcases/tcEdit.php', 1646650265, 1646650266, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(471, '/testlink/lib/testcases/tcEdit.php', 1646650278, 1646650279, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(472, '/testlink/lib/testcases/listTestCases.php', 1646650279, 1646650279, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(473, '/testlink/lib/testcases/tcEdit.php', 1646650292, 1646650292, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(474, '/testlink/lib/testcases/tcEdit.php', 1646650297, 1646650297, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(475, '/testlink/lib/testcases/tcEdit.php', 1646650311, 1646650311, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(476, '/testlink/lib/testcases/listTestCases.php', 1646650312, 1646650312, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(477, '/testlink/lib/testcases/tcEdit.php', 1646650324, 1646650324, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(478, '/testlink/lib/testcases/tcEdit.php', 1646650338, 1646650338, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(479, '/testlink/lib/testcases/listTestCases.php', 1646650339, 1646650339, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(480, '/testlink/lib/testcases/tcEdit.php', 1646650350, 1646650350, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(481, '/testlink/lib/testcases/tcEdit.php', 1646650363, 1646650364, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(482, '/testlink/lib/testcases/listTestCases.php', 1646650364, 1646650365, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(483, '/testlink/lib/testcases/tcEdit.php', 1646650387, 1646650387, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(484, '/testlink/lib/testcases/tcEdit.php', 1646650401, 1646650402, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(485, '/testlink/lib/testcases/tcEdit.php', 1646650413, 1646650413, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(486, '/testlink/lib/testcases/tcEdit.php', 1646650424, 1646650425, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(487, '/testlink/lib/testcases/tcEdit.php', 1646650439, 1646650439, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(488, '/testlink/lib/testcases/tcEdit.php', 1646650455, 1646650455, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(489, '/testlink/lib/testcases/tcEdit.php', 1646650467, 1646650468, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(490, '/testlink/lib/testcases/tcEdit.php', 1646650482, 1646650482, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(491, '/testlink/lib/testcases/tcEdit.php', 1646650492, 1646650493, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(492, '/testlink/lib/testcases/archiveData.php', 1646650511, 1646650511, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(493, '/testlink/lib/testcases/archiveData.php', 1646650538, 1646650538, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(494, '/testlink/lib/testcases/listTestCases.php', 1646650543, 1646650544, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(495, '/testlink/lib/testcases/listTestCases.php', 1646650573, 1646650573, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(496, '/testlink/lib/testcases/archiveData.php', 1646651718, 1646651718, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(497, '/testlink/lib/testcases/archiveData.php', 1646653107, 1646653108, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(498, '/testlink/lib/testcases/listTestCases.php', 1646653108, 1646653108, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(499, '/testlink/lib/testcases/listTestCases.php', 1646653135, 1646653135, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(500, '/testlink/lib/testcases/listTestCases.php', 1646654347, 1646654347, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(501, '/testlink/lib/testcases/archiveData.php', 1646654348, 1646654348, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(502, '/testlink/lib/plan/planEdit.php', 1646654602, 1646654602, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(503, '/testlink/lib/plan/planEdit.php', 1646654613, 1646654613, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(504, '/testlink/lib/plan/planAddTCNavigator.php', 1646654631, 1646654631, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(505, '/testlink/lib/plan/planAddTCNavigator.php', 1646654636, 1646654636, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(506, '/testlink/lib/plan/planAddTC.php', 1646654672, 1646654672, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(507, '/testlink/lib/plan/planAddTCNavigator.php', 1646654673, 1646654673, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(508, '/testlink/lib/plan/planAddTC.php', 1646654682, 1646654689, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(509, '/testlink/lib/plan/planAddTCNavigator.php', 1646654690, 1646654690, 1, '4i08nsp2hbuk8a67u70506cvmv');
INSERT INTO `transactions` (`id`, `entry_point`, `start_time`, `end_time`, `user_id`, `session_id`) VALUES
(510, '/testlink/lib/plan/planAddTC.php', 1646654714, 1646654717, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(511, '/testlink/lib/plan/planAddTCNavigator.php', 1646654717, 1646654717, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(512, '/testlink/lib/plan/planAddTCNavigator.php', 1646654725, 1646654725, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(513, '/testlink/lib/plan/planEdit.php', 1646654749, 1646654749, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(514, '/testlink/lib/plan/buildEdit.php', 1646654773, 1646654773, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(515, '/testlink/lib/plan/buildEdit.php', 1646654778, 1646654778, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(516, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654829, 1646654829, 1, ''),
(517, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654829, 1646654830, 1, ''),
(518, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654843, 1646654843, 1, ''),
(519, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654843, 1646654843, 1, ''),
(520, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654854, 1646654854, 1, ''),
(521, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654857, 1646654857, 1, ''),
(522, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654873, 1646654873, 1, ''),
(523, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654874, 1646654874, 1, ''),
(524, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654891, 1646654891, 1, ''),
(525, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654893, 1646654894, 1, ''),
(526, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654918, 1646654918, 1, ''),
(527, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654931, 1646654931, 1, ''),
(528, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654931, 1646654931, 1, ''),
(529, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654944, 1646654945, 1, ''),
(530, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654944, 1646654945, 1, ''),
(531, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654954, 1646654954, 1, ''),
(532, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654964, 1646654964, 1, ''),
(533, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654967, 1646654967, 1, ''),
(534, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654978, 1646654978, 1, ''),
(535, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646654981, 1646654981, 1, ''),
(536, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655003, 1646655003, 1, ''),
(537, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655020, 1646655020, 1, ''),
(538, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655023, 1646655024, 1, ''),
(539, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655033, 1646655033, 1, ''),
(540, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655041, 1646655041, 1, ''),
(541, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655052, 1646655052, 1, ''),
(542, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655053, 1646655054, 1, ''),
(543, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655075, 1646655075, 1, ''),
(544, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655083, 1646655083, 1, ''),
(545, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655105, 1646655106, 1, ''),
(546, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655112, 1646655112, 1, ''),
(547, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655117, 1646655117, 1, ''),
(548, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655133, 1646655133, 1, ''),
(549, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655149, 1646655149, 1, ''),
(550, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655155, 1646655155, 1, ''),
(551, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655166, 1646655167, 1, ''),
(552, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655174, 1646655174, 1, ''),
(553, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655194, 1646655195, 1, ''),
(554, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655194, 1646655195, 1, ''),
(555, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655201, 1646655201, 1, ''),
(556, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655210, 1646655210, 1, ''),
(557, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655224, 1646655224, 1, ''),
(558, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655235, 1646655235, 1, ''),
(559, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655235, 1646655235, 1, ''),
(560, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655246, 1646655246, 1, ''),
(561, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655247, 1646655248, 1, ''),
(562, '/testlink/lib/api/xmlrpc/v1/xmlrpc.php', 1646655257, 1646655258, 1, ''),
(563, '/testlink/lib/testcases/listTestCases.php', 1646658281, 1646658281, 1, '4i08nsp2hbuk8a67u70506cvmv'),
(564, '/testlink/lib/testcases/archiveData.php', 1646658281, 1646658282, 1, '4i08nsp2hbuk8a67u70506cvmv');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `tsuites_tree_depth_2`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `tsuites_tree_depth_2` (
`prefix` varchar(16)
,`testproject_name` varchar(100)
,`level1_name` varchar(100)
,`level2_name` varchar(100)
,`testproject_id` int(10) unsigned
,`level1_id` int(10) unsigned
,`level2_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(100) NOT NULL DEFAULT '',
  `first` varchar(50) NOT NULL DEFAULT '',
  `last` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(10) NOT NULL DEFAULT 'en_GB',
  `default_testproject_id` int(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `script_key` varchar(32) DEFAULT NULL,
  `cookie_string` varchar(64) NOT NULL DEFAULT '',
  `auth_method` varchar(10) DEFAULT '',
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User information';

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `role_id`, `email`, `first`, `last`, `locale`, `default_testproject_id`, `active`, `script_key`, `cookie_string`, `auth_method`, `creation_ts`, `expiration_date`) VALUES
(1, 'admin', '$2y$10$IQ8fGiONMNoXi.CHHsAKvO32UM88WI0Dii94ymfAcd2Fa0xMtiPKG', 8, '', 'Testlink', 'Administrator', 'en_GB', NULL, 1, '2d0896f5160cfa04c99978e46d30bd36', 'a993a176355b21a141617d3f8eb21a354e110a0608bc7fd3a06c3623fe8fff6d', '', '2022-03-04 23:04:33', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_assignments`
--

CREATE TABLE `user_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `feature_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(10) UNSIGNED DEFAULT '0',
  `build_id` int(10) UNSIGNED DEFAULT '0',
  `deadline_ts` datetime DEFAULT NULL,
  `assigner_id` int(10) UNSIGNED DEFAULT '0',
  `creation_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(10) UNSIGNED DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_group`
--

CREATE TABLE `user_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_group_assign`
--

CREATE TABLE `user_group_assign` (
  `usergroup_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_testplan_roles`
--

CREATE TABLE `user_testplan_roles` (
  `user_id` int(10) NOT NULL DEFAULT '0',
  `testplan_id` int(10) NOT NULL DEFAULT '0',
  `role_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `user_testplan_roles`
--

INSERT INTO `user_testplan_roles` (`user_id`, `testplan_id`, `role_id`) VALUES
(1, 64, 8),
(1, 427, 8);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_testproject_roles`
--

CREATE TABLE `user_testproject_roles` (
  `user_id` int(10) NOT NULL DEFAULT '0',
  `testproject_id` int(10) NOT NULL DEFAULT '0',
  `role_id` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura widoku `exec_by_date_time`
--
DROP TABLE IF EXISTS `exec_by_date_time`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `exec_by_date_time`  AS  (select `nhtpl`.`name` AS `testplan_name`,date_format(`e`.`execution_ts`,'%Y-%m-%d') AS `yyyy_mm_dd`,date_format(`e`.`execution_ts`,'%Y-%m') AS `yyyy_mm`,date_format(`e`.`execution_ts`,'%H') AS `hh`,date_format(`e`.`execution_ts`,'%k') AS `hour`,`e`.`id` AS `id`,`e`.`build_id` AS `build_id`,`e`.`tester_id` AS `tester_id`,`e`.`execution_ts` AS `execution_ts`,`e`.`status` AS `status`,`e`.`testplan_id` AS `testplan_id`,`e`.`tcversion_id` AS `tcversion_id`,`e`.`tcversion_number` AS `tcversion_number`,`e`.`platform_id` AS `platform_id`,`e`.`execution_type` AS `execution_type`,`e`.`execution_duration` AS `execution_duration`,`e`.`notes` AS `notes` from ((`executions` `e` join `testplans` `tpl` on((`tpl`.`id` = `e`.`testplan_id`))) join `nodes_hierarchy` `nhtpl` on((`nhtpl`.`id` = `tpl`.`id`)))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_exec_by_context`
--
DROP TABLE IF EXISTS `latest_exec_by_context`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_context`  AS  select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,`executions`.`build_id` AS `build_id`,`executions`.`platform_id` AS `platform_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id`,`executions`.`build_id`,`executions`.`platform_id` ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_exec_by_testplan`
--
DROP TABLE IF EXISTS `latest_exec_by_testplan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_testplan`  AS  select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id` ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_exec_by_testplan_plat`
--
DROP TABLE IF EXISTS `latest_exec_by_testplan_plat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_testplan_plat`  AS  select `executions`.`tcversion_id` AS `tcversion_id`,`executions`.`testplan_id` AS `testplan_id`,`executions`.`platform_id` AS `platform_id`,max(`executions`.`id`) AS `id` from `executions` group by `executions`.`tcversion_id`,`executions`.`testplan_id`,`executions`.`platform_id` ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_req_version`
--
DROP TABLE IF EXISTS `latest_req_version`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_req_version`  AS  select `rq`.`id` AS `req_id`,max(`rqv`.`version`) AS `version` from ((`nodes_hierarchy` `nhrqv` join `requirements` `rq` on((`rq`.`id` = `nhrqv`.`parent_id`))) join `req_versions` `rqv` on((`rqv`.`id` = `nhrqv`.`id`))) group by `rq`.`id` ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_req_version_id`
--
DROP TABLE IF EXISTS `latest_req_version_id`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_req_version_id`  AS  select `lrqvn`.`req_id` AS `req_id`,`lrqvn`.`version` AS `version`,`reqv`.`id` AS `req_version_id` from ((`latest_req_version` `lrqvn` join `nodes_hierarchy` `nhrqv` on((`nhrqv`.`parent_id` = `lrqvn`.`req_id`))) join `req_versions` `reqv` on(((`reqv`.`id` = `nhrqv`.`id`) and (`reqv`.`version` = `lrqvn`.`version`)))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_rspec_revision`
--
DROP TABLE IF EXISTS `latest_rspec_revision`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_rspec_revision`  AS  select `rsr`.`parent_id` AS `req_spec_id`,`rs`.`testproject_id` AS `testproject_id`,max(`rsr`.`revision`) AS `revision` from (`req_specs_revisions` `rsr` join `req_specs` `rs` on((`rs`.`id` = `rsr`.`parent_id`))) group by `rsr`.`parent_id`,`rs`.`testproject_id` ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_tcase_version_id`
--
DROP TABLE IF EXISTS `latest_tcase_version_id`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_tcase_version_id`  AS  select `ltcvn`.`testcase_id` AS `testcase_id`,`ltcvn`.`version` AS `version`,`tcv`.`id` AS `tcversion_id` from ((`latest_tcase_version_number` `ltcvn` join `nodes_hierarchy` `nhtcv` on((`nhtcv`.`parent_id` = `ltcvn`.`testcase_id`))) join `tcversions` `tcv` on(((`tcv`.`id` = `nhtcv`.`id`) and (`tcv`.`version` = `ltcvn`.`version`)))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `latest_tcase_version_number`
--
DROP TABLE IF EXISTS `latest_tcase_version_number`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_tcase_version_number`  AS  select `nh_tc`.`id` AS `testcase_id`,max(`tcv`.`version`) AS `version` from ((`nodes_hierarchy` `nh_tc` join `nodes_hierarchy` `nh_tcv` on((`nh_tcv`.`parent_id` = `nh_tc`.`id`))) join `tcversions` `tcv` on((`nh_tcv`.`id` = `tcv`.`id`))) group by `nh_tc`.`id` ;

-- --------------------------------------------------------

--
-- Struktura widoku `tcversions_without_keywords`
--
DROP TABLE IF EXISTS `tcversions_without_keywords`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tcversions_without_keywords`  AS  select `nhtcv`.`parent_id` AS `testcase_id`,`nhtcv`.`id` AS `id` from `nodes_hierarchy` `nhtcv` where ((`nhtcv`.`node_type_id` = 4) and (not(exists(select 1 from `testcase_keywords` `tck` where (`tck`.`tcversion_id` = `nhtcv`.`id`))))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `tcversions_without_platforms`
--
DROP TABLE IF EXISTS `tcversions_without_platforms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tcversions_without_platforms`  AS  select `nhtcv`.`parent_id` AS `testcase_id`,`nhtcv`.`id` AS `id` from `nodes_hierarchy` `nhtcv` where ((`nhtcv`.`node_type_id` = 4) and (not(exists(select 1 from `testcase_platforms` `tcpl` where (`tcpl`.`tcversion_id` = `nhtcv`.`id`))))) ;

-- --------------------------------------------------------

--
-- Struktura widoku `tsuites_tree_depth_2`
--
DROP TABLE IF EXISTS `tsuites_tree_depth_2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tsuites_tree_depth_2`  AS  select `tprj`.`prefix` AS `prefix`,`nhtprj`.`name` AS `testproject_name`,`nhts_l1`.`name` AS `level1_name`,`nhts_l2`.`name` AS `level2_name`,`nhtprj`.`id` AS `testproject_id`,`nhts_l1`.`id` AS `level1_id`,`nhts_l2`.`id` AS `level2_id` from (((`testprojects` `tprj` join `nodes_hierarchy` `nhtprj` on((`tprj`.`id` = `nhtprj`.`id`))) left join `nodes_hierarchy` `nhts_l1` on((`nhts_l1`.`parent_id` = `nhtprj`.`id`))) left join `nodes_hierarchy` `nhts_l2` on((`nhts_l2`.`parent_id` = `nhts_l1`.`id`))) where ((`nhtprj`.`node_type_id` = 1) and (`nhts_l1`.`node_type_id` = 2) and (`nhts_l2`.`node_type_id` = 2)) ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `assignment_status`
--
ALTER TABLE `assignment_status`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `assignment_types`
--
ALTER TABLE `assignment_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachments_idx1` (`fk_id`);

--
-- Indeksy dla tabeli `baseline_l1l2_context`
--
ALTER TABLE `baseline_l1l2_context`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `udx1` (`testplan_id`,`platform_id`,`creation_ts`);

--
-- Indeksy dla tabeli `baseline_l1l2_details`
--
ALTER TABLE `baseline_l1l2_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `udx1` (`context_id`,`top_tsuite_id`,`child_tsuite_id`,`status`);

--
-- Indeksy dla tabeli `builds`
--
ALTER TABLE `builds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`testplan_id`,`name`),
  ADD KEY `testplan_id` (`testplan_id`);

--
-- Indeksy dla tabeli `cfield_build_design_values`
--
ALTER TABLE `cfield_build_design_values`
  ADD PRIMARY KEY (`field_id`,`node_id`),
  ADD KEY `idx_cfield_build_design_values` (`node_id`);

--
-- Indeksy dla tabeli `cfield_design_values`
--
ALTER TABLE `cfield_design_values`
  ADD PRIMARY KEY (`field_id`,`node_id`),
  ADD KEY `idx_cfield_design_values` (`node_id`);

--
-- Indeksy dla tabeli `cfield_execution_values`
--
ALTER TABLE `cfield_execution_values`
  ADD PRIMARY KEY (`field_id`,`execution_id`,`testplan_id`,`tcversion_id`);

--
-- Indeksy dla tabeli `cfield_node_types`
--
ALTER TABLE `cfield_node_types`
  ADD PRIMARY KEY (`field_id`,`node_type_id`),
  ADD KEY `idx_custom_fields_assign` (`node_type_id`);

--
-- Indeksy dla tabeli `cfield_testplan_design_values`
--
ALTER TABLE `cfield_testplan_design_values`
  ADD PRIMARY KEY (`field_id`,`link_id`),
  ADD KEY `idx_cfield_tplan_design_val` (`link_id`);

--
-- Indeksy dla tabeli `cfield_testprojects`
--
ALTER TABLE `cfield_testprojects`
  ADD PRIMARY KEY (`field_id`,`testproject_id`);

--
-- Indeksy dla tabeli `codetrackers`
--
ALTER TABLE `codetrackers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codetrackers_uidx1` (`name`);

--
-- Indeksy dla tabeli `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_custom_fields_name` (`name`);

--
-- Indeksy dla tabeli `db_version`
--
ALTER TABLE `db_version`
  ADD PRIMARY KEY (`version`);

--
-- Indeksy dla tabeli `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `fired_at` (`fired_at`);

--
-- Indeksy dla tabeli `executions`
--
ALTER TABLE `executions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `executions_idx1` (`testplan_id`,`tcversion_id`,`platform_id`,`build_id`),
  ADD KEY `executions_idx2` (`execution_type`),
  ADD KEY `executions_idx3` (`tcversion_id`);

--
-- Indeksy dla tabeli `execution_bugs`
--
ALTER TABLE `execution_bugs`
  ADD PRIMARY KEY (`execution_id`,`bug_id`,`tcstep_id`);

--
-- Indeksy dla tabeli `execution_tcsteps`
--
ALTER TABLE `execution_tcsteps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `execution_tcsteps_idx1` (`execution_id`,`tcstep_id`);

--
-- Indeksy dla tabeli `execution_tcsteps_wip`
--
ALTER TABLE `execution_tcsteps_wip`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `execution_tcsteps_wip_idx1` (`tcstep_id`,`testplan_id`,`platform_id`,`build_id`);

--
-- Indeksy dla tabeli `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_idx1` (`testproject_id`);

--
-- Indeksy dla tabeli `issuetrackers`
--
ALTER TABLE `issuetrackers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `issuetrackers_uidx1` (`name`);

--
-- Indeksy dla tabeli `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `keyword_testproject_id` (`keyword`,`testproject_id`),
  ADD KEY `testproject_id` (`testproject_id`),
  ADD KEY `keyword` (`keyword`);

--
-- Indeksy dla tabeli `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_testplan_id` (`name`,`testplan_id`),
  ADD KEY `testplan_id` (`testplan_id`);

--
-- Indeksy dla tabeli `nodes_hierarchy`
--
ALTER TABLE `nodes_hierarchy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid_m_nodeorder` (`parent_id`,`node_order`),
  ADD KEY `nodes_hierarchy_node_type_id` (`node_type_id`);

--
-- Indeksy dla tabeli `node_types`
--
ALTER TABLE `node_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `object_keywords`
--
ALTER TABLE `object_keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `udx01_object_keywords` (`fk_id`,`fk_table`,`keyword_id`);

--
-- Indeksy dla tabeli `platforms`
--
ALTER TABLE `platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_platforms` (`testproject_id`,`name`);

--
-- Indeksy dla tabeli `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `plugins_configuration`
--
ALTER TABLE `plugins_configuration`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `reqmgrsystems`
--
ALTER TABLE `reqmgrsystems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reqmgrsystems_uidx1` (`name`);

--
-- Indeksy dla tabeli `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `requirements_req_doc_id` (`srs_id`,`req_doc_id`);

--
-- Indeksy dla tabeli `req_coverage`
--
ALTER TABLE `req_coverage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_coverage_full_link` (`req_id`,`req_version_id`,`testcase_id`,`tcversion_id`);

--
-- Indeksy dla tabeli `req_monitor`
--
ALTER TABLE `req_monitor`
  ADD PRIMARY KEY (`req_id`,`user_id`,`testproject_id`);

--
-- Indeksy dla tabeli `req_relations`
--
ALTER TABLE `req_relations`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `req_revisions`
--
ALTER TABLE `req_revisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_revisions_uidx1` (`parent_id`,`revision`);

--
-- Indeksy dla tabeli `req_specs`
--
ALTER TABLE `req_specs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_spec_uk1` (`doc_id`,`testproject_id`),
  ADD KEY `testproject_id` (`testproject_id`);

--
-- Indeksy dla tabeli `req_specs_revisions`
--
ALTER TABLE `req_specs_revisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_specs_revisions_uidx1` (`parent_id`,`revision`);

--
-- Indeksy dla tabeli `req_versions`
--
ALTER TABLE `req_versions`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `rights`
--
ALTER TABLE `rights`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rights_descr` (`description`);

--
-- Indeksy dla tabeli `risk_assignments`
--
ALTER TABLE `risk_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `risk_assignments_tplan_node_id` (`testplan_id`,`node_id`);

--
-- Indeksy dla tabeli `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_rights_roles_descr` (`description`);

--
-- Indeksy dla tabeli `role_rights`
--
ALTER TABLE `role_rights`
  ADD PRIMARY KEY (`role_id`,`right_id`);

--
-- Indeksy dla tabeli `tcsteps`
--
ALTER TABLE `tcsteps`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `tcversions`
--
ALTER TABLE `tcversions`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `testcase_keywords`
--
ALTER TABLE `testcase_keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx01_testcase_keywords` (`testcase_id`,`tcversion_id`,`keyword_id`),
  ADD KEY `idx02_testcase_keywords` (`tcversion_id`);

--
-- Indeksy dla tabeli `testcase_platforms`
--
ALTER TABLE `testcase_platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx01_testcase_platform` (`testcase_id`,`tcversion_id`,`platform_id`),
  ADD KEY `idx02_testcase_platform` (`tcversion_id`);

--
-- Indeksy dla tabeli `testcase_relations`
--
ALTER TABLE `testcase_relations`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `testcase_script_links`
--
ALTER TABLE `testcase_script_links`
  ADD PRIMARY KEY (`tcversion_id`,`project_key`,`repository_name`,`code_path`);

--
-- Indeksy dla tabeli `testplans`
--
ALTER TABLE `testplans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testplans_api_key` (`api_key`),
  ADD KEY `testplans_testproject_id_active` (`testproject_id`,`active`);

--
-- Indeksy dla tabeli `testplan_platforms`
--
ALTER TABLE `testplan_platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_testplan_platforms` (`testplan_id`,`platform_id`);

--
-- Indeksy dla tabeli `testplan_tcversions`
--
ALTER TABLE `testplan_tcversions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testplan_tcversions_tplan_tcversion` (`testplan_id`,`tcversion_id`,`platform_id`);

--
-- Indeksy dla tabeli `testprojects`
--
ALTER TABLE `testprojects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testprojects_prefix` (`prefix`),
  ADD UNIQUE KEY `testprojects_api_key` (`api_key`),
  ADD KEY `testprojects_id_active` (`id`,`active`);

--
-- Indeksy dla tabeli `testproject_codetracker`
--
ALTER TABLE `testproject_codetracker`
  ADD PRIMARY KEY (`testproject_id`);

--
-- Indeksy dla tabeli `testproject_issuetracker`
--
ALTER TABLE `testproject_issuetracker`
  ADD PRIMARY KEY (`testproject_id`);

--
-- Indeksy dla tabeli `testproject_reqmgrsystem`
--
ALTER TABLE `testproject_reqmgrsystem`
  ADD PRIMARY KEY (`testproject_id`);

--
-- Indeksy dla tabeli `testsuites`
--
ALTER TABLE `testsuites`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `text_templates`
--
ALTER TABLE `text_templates`
  ADD UNIQUE KEY `idx_text_templates` (`type`,`title`);

--
-- Indeksy dla tabeli `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_login` (`login`),
  ADD UNIQUE KEY `users_cookie_string` (`cookie_string`);

--
-- Indeksy dla tabeli `user_assignments`
--
ALTER TABLE `user_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_assignments_feature_id` (`feature_id`);

--
-- Indeksy dla tabeli `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_user_group` (`title`);

--
-- Indeksy dla tabeli `user_group_assign`
--
ALTER TABLE `user_group_assign`
  ADD UNIQUE KEY `idx_user_group_assign` (`usergroup_id`,`user_id`);

--
-- Indeksy dla tabeli `user_testplan_roles`
--
ALTER TABLE `user_testplan_roles`
  ADD PRIMARY KEY (`user_id`,`testplan_id`);

--
-- Indeksy dla tabeli `user_testproject_roles`
--
ALTER TABLE `user_testproject_roles`
  ADD PRIMARY KEY (`user_id`,`testproject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `assignment_status`
--
ALTER TABLE `assignment_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `assignment_types`
--
ALTER TABLE `assignment_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `baseline_l1l2_context`
--
ALTER TABLE `baseline_l1l2_context`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `baseline_l1l2_details`
--
ALTER TABLE `baseline_l1l2_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `builds`
--
ALTER TABLE `builds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `codetrackers`
--
ALTER TABLE `codetrackers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `events`
--
ALTER TABLE `events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=792;

--
-- AUTO_INCREMENT dla tabeli `executions`
--
ALTER TABLE `executions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT dla tabeli `execution_tcsteps`
--
ALTER TABLE `execution_tcsteps`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `execution_tcsteps_wip`
--
ALTER TABLE `execution_tcsteps_wip`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `issuetrackers`
--
ALTER TABLE `issuetrackers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `milestones`
--
ALTER TABLE `milestones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `nodes_hierarchy`
--
ALTER TABLE `nodes_hierarchy`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=428;

--
-- AUTO_INCREMENT dla tabeli `node_types`
--
ALTER TABLE `node_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `object_keywords`
--
ALTER TABLE `object_keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `platforms`
--
ALTER TABLE `platforms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `plugins_configuration`
--
ALTER TABLE `plugins_configuration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `reqmgrsystems`
--
ALTER TABLE `reqmgrsystems`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `req_coverage`
--
ALTER TABLE `req_coverage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `req_relations`
--
ALTER TABLE `req_relations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `rights`
--
ALTER TABLE `rights`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT dla tabeli `risk_assignments`
--
ALTER TABLE `risk_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT dla tabeli `testcase_keywords`
--
ALTER TABLE `testcase_keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `testcase_platforms`
--
ALTER TABLE `testcase_platforms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `testcase_relations`
--
ALTER TABLE `testcase_relations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `testplan_platforms`
--
ALTER TABLE `testplan_platforms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `testplan_tcversions`
--
ALTER TABLE `testplan_tcversions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT dla tabeli `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=565;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `user_assignments`
--
ALTER TABLE `user_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
