/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.16-MariaDB : Database - homestead2
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`homestead2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `homestead2`;

/*Table structure for table `bids` */

DROP TABLE IF EXISTS `bids`;

CREATE TABLE `bids` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `value` bigint(20) unsigned NOT NULL,
  `winner` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bids_user_id_foreign` (`user_id`),
  KEY `bids_product_id_foreign` (`product_id`),
  CONSTRAINT `bids_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `bids_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `bids` */

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `categories` */

insert  into `categories`(`id`,`uniqueid`,`slug`,`name`,`active`,`created_at`,`updated_at`) values 
(1,'123456','slug_123','shirt',1,'2021-07-16 14:35:45','2021-07-16 14:35:47'),
(2,'231232','slug_123','pants',1,'2021-07-15 14:35:50','2021-07-15 14:35:53');

/*Table structure for table `dispute_replies` */

DROP TABLE IF EXISTS `dispute_replies`;

CREATE TABLE `dispute_replies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `dispute_id` int(10) unsigned NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `adminreply` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dispute_replies_user_id_foreign` (`user_id`),
  KEY `dispute_replies_dispute_id_foreign` (`dispute_id`),
  CONSTRAINT `dispute_replies_dispute_id_foreign` FOREIGN KEY (`dispute_id`) REFERENCES `disputes` (`id`),
  CONSTRAINT `dispute_replies_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `dispute_replies` */

/*Table structure for table `disputes` */

DROP TABLE IF EXISTS `disputes`;

CREATE TABLE `disputes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_id` int(10) unsigned NOT NULL,
  `seller_id` int(10) unsigned NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `resolved` tinyint(1) NOT NULL DEFAULT 0,
  `winner` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `disputes_buyer_id_foreign` (`buyer_id`),
  KEY `disputes_seller_id_foreign` (`seller_id`),
  KEY `disputes_purchase_id_foreign` (`purchase_id`),
  CONSTRAINT `disputes_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `disputes_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  CONSTRAINT `disputes_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `disputes` */

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `positive` tinyint(1) NOT NULL,
  `seller_id` int(10) unsigned NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `for` int(10) unsigned NOT NULL,
  `from` int(10) unsigned NOT NULL,
  `purchase_id` int(10) unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedback_buyer_id_foreign` (`buyer_id`),
  KEY `feedback_seller_id_foreign` (`seller_id`),
  KEY `feedback_for_foreign` (`for`),
  KEY `feedback_from_foreign` (`from`),
  KEY `feedback_purchase_id_foreign` (`purchase_id`),
  CONSTRAINT `feedback_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `feedback_for_foreign` FOREIGN KEY (`for`) REFERENCES `users` (`id`),
  CONSTRAINT `feedback_from_foreign` FOREIGN KEY (`from`) REFERENCES `users` (`id`),
  CONSTRAINT `feedback_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  CONSTRAINT `feedback_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `feedback` */

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to` int(10) unsigned NOT NULL,
  `from` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `viewed` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_to_foreign` (`to`),
  KEY `messages_from_foreign` (`from`),
  CONSTRAINT `messages_from_foreign` FOREIGN KEY (`from`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_to_foreign` FOREIGN KEY (`to`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `messages` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2017_02_10_153052_create_vendor_applications_table',1),
(3,'2017_02_10_183029_create_categories_table',1),
(4,'2017_02_10_201803_create_products_table',1),
(5,'2017_02_11_191501_create_settings_table',1),
(6,'2017_02_11_193750_create_bids_table',1),
(7,'2017_02_12_160342_create_purchases_table',1),
(8,'2017_02_12_181921_create_feedback_table',1),
(9,'2017_02_13_211032_create_disputes_table',1),
(10,'2017_02_13_211045_create_dispute_replies_table',1),
(11,'2017_02_16_130704_create_messages_table',1),
(12,'2017_02_16_145314_create_news_table',1);

/*Table structure for table `news` */

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `news` */

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` bigint(20) unsigned NOT NULL,
  `buyout` bigint(20) unsigned DEFAULT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `auction` tinyint(1) NOT NULL DEFAULT 0,
  `end_date` datetime DEFAULT NULL,
  `goods` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_policy` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sold` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `state` int(11) NOT NULL DEFAULT 0,
  `autofilled` tinyint(1) NOT NULL DEFAULT 0,
  `autofill` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` int(10) unsigned NOT NULL,
  `buyer_id` int(10) unsigned DEFAULT NULL,
  `purchase_time` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_seller_id_foreign` (`seller_id`),
  KEY `products_buyer_id_foreign` (`buyer_id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `products` */

/*Table structure for table `purchases` */

DROP TABLE IF EXISTS `purchases`;

CREATE TABLE `purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `buyer_id` int(10) unsigned NOT NULL,
  `seller_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `value` bigint(20) unsigned NOT NULL,
  `delivered` tinyint(1) NOT NULL DEFAULT 0,
  `goods` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchases_buyer_id_foreign` (`buyer_id`),
  KEY `purchases_seller_id_foreign` (`seller_id`),
  KEY `purchases_product_id_foreign` (`product_id`),
  CONSTRAINT `purchases_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `purchases_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `purchases_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `purchases` */

/*Table structure for table `settings` */

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_price` bigint(20) unsigned NOT NULL DEFAULT 1000000,
  `fee` bigint(20) unsigned NOT NULL DEFAULT 0,
  `collected_fee` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `settings` */

insert  into `settings`(`id`,`vendor_price`,`fee`,`collected_fee`,`created_at`,`updated_at`) values 
(1,1000000,1,0,'2021-07-11 10:21:18','2021-07-11 10:21:25');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mnemonic` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pgp` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` bigint(20) unsigned NOT NULL,
  `last_credited` bigint(20) unsigned NOT NULL DEFAULT 0,
  `pin` int(11) NOT NULL,
  `vendor` tinyint(1) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `last_seen` datetime DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`uniqueid`,`password`,`username`,`mnemonic`,`profile`,`pgp`,`balance`,`last_credited`,`pin`,`vendor`,`admin`,`verified`,`last_seen`,`remember_token`,`created_at`,`updated_at`,`image`) values 
(1,'IDyNFm2cx9B5je9MjIugxVyaWbGJAs','$2y$10$.fDfLd7sA1f2JdkFuWF9O.l7jYzYgmid.c.udvAre3ZR3sDWMluhu','user1111','enemy selfish victim card birth salty catch hello bullet neighbor dress husbandguess work teeth prove huge',NULL,NULL,0,0,111111,0,0,1,'2021-07-18 10:49:14','dPEq457k59SddNzBDv5qKDdBFVNmFW3qRAsn0BBuiMpqxZMt0pJPrPKFw9GT','2021-07-11 08:29:01','2021-07-18 09:49:14',NULL),
(2,'IDspJOBAZqyf8XHjpIT9UIpQ1e8YT8','$2y$10$MlbC1T5e///4QWBA4U8YyuoF9eztR2aOWAXKDCCakVqc3EBwBfCpS','user2222','hour smart awake reflection sound struggle bring nod bless double dark armydespair carefully acid wish loose',NULL,NULL,0,0,111111,0,0,1,NULL,NULL,'2021-07-11 09:29:55','2021-07-11 09:30:01',NULL),
(3,'IDXAKZTgpwOUGx6ZDq7U97axBfqyi8','$2y$10$2EBJ3wnTVcn8ZCUsT126l.hUImINUNkR7YaLsjzzguZqBZC61orgi','my_user','revenge tie dot rose worst mention heavy grasp push hum add fragilewindow selfish freely image beard',NULL,NULL,0,0,112233,0,0,1,'2021-07-17 17:04:47',NULL,'2021-07-16 13:37:45','2021-07-17 16:04:47',NULL);

/*Table structure for table `vendor_applications` */

DROP TABLE IF EXISTS `vendor_applications`;

CREATE TABLE `vendor_applications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `offer` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `void` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `other_markets` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vendor_applications_user_id_foreign` (`user_id`),
  CONSTRAINT `vendor_applications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `vendor_applications` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
