-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'product'
--
-- ---

DROP DATABASE IF EXISTS productOverview;
CREATE DATABASE productOverview;

USE productOverview;

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `productId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `productName` VARCHAR(60) NULL DEFAULT NULL,
  `Slogan` VARCHAR(500) NULL DEFAULT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `category` VARCHAR(500) NULL DEFAULT NULL,
  `defaultPrice` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`productId`)
);

LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/product.csv'
INTO TABLE product
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- ---
-- Table 'Sku'
--
-- ---

DROP TABLE IF EXISTS `Sku`;

CREATE TABLE `Sku` (
  `skuId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `styleId` INTEGER NULL DEFAULT NULL,
  `size` VARCHAR(4) NULL DEFAULT NULL,
  `quantity` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`skuId`)
);

LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/skus.csv'
INTO TABLE Sku
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ---
-- Table 'styles'
--
-- ---

DROP TABLE IF EXISTS `styles`;

CREATE TABLE `styles` (
  `styleId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `productId` INTEGER NULL DEFAULT NULL,
  `productName` VARCHAR(100) NULL DEFAULT NULL,
  `sale` INTEGER NULL DEFAULT NULL,
  `originalPrice` INTEGER NULL DEFAULT NULL,
  `defaultStyle` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`styleId`)
);


LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/styles.csv'
INTO TABLE styles
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(styleId, productId, productName, @vSale, originalPrice, defaultStyle)
SET sale = NULLIF(@vSale,'null');
-- ---
-- Table 'cart'
--
-- ---

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cartId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `userSession` INTEGER NULL DEFAULT NULL,
  `productId` INTEGER NULL DEFAULT NULL,
  `active` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`cartId`)
);


LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/cart.csv'
INTO TABLE cart
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- ---
-- Table 'photos'
--
-- ---

DROP TABLE IF EXISTS `photos`;

CREATE TABLE `photos` (
  `photoId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `styleId` INTEGER NULL DEFAULT NULL,
  `url` VARCHAR(500) NULL DEFAULT NULL,
  `thumbnailUrl` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`photoId`)
);


LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/photos.csv'
INTO TABLE photos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- ---
-- Table 'features'
--
-- ---

DROP TABLE IF EXISTS `features`;

CREATE TABLE `features` (
  `featureId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `productId` INTEGER NULL DEFAULT NULL,
  `feature` VARCHAR(100) NULL DEFAULT NULL,
  `value` VARCHAR(100) NULL DEFAULT NULL
);

LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/features.csv'
INTO TABLE features
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- ---
-- Table 'related'
--
-- ---


DROP TABLE IF EXISTS `related`;

CREATE TABLE `related` (
  `relatedId` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
  `currentProductId` INTEGER NULL DEFAULT NULL,
  `relatedProductId` INTEGER NULL DEFAULT NULL
);

LOAD DATA LOCAL INFILE '/home/sprung/hackreactor/Product-Overview/rawData/related.csv'
INTO TABLE related
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- ---
-- Foreign Keys
-- ---

ALTER TABLE `Sku` ADD FOREIGN KEY (styleId) REFERENCES `styles` (`styleId`);
ALTER TABLE `styles` ADD FOREIGN KEY (productId) REFERENCES `product` (`productId`);
ALTER TABLE `cart` ADD FOREIGN KEY (productId) REFERENCES `product` (`productId`);
ALTER TABLE `photos` ADD FOREIGN KEY (styleId) REFERENCES `styles` (`styleId`);
ALTER TABLE `features` ADD FOREIGN KEY (productId) REFERENCES `product` (`productId`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `product` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Sku` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `styles` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cart` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `photos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `product` (`productId`,`productName`,`Slogan`,`description`,`category`,`defaultPrice`) VALUES
-- ('','','','','','');
-- INSERT INTO `Sku` (`skuId`,`styleId`,`size`,`quantity`) VALUES
-- ('','','','');
-- INSERT INTO `styles` (`styleId`,`productId`,`productName`,`sale`,`originalPrice`,`defaultStyle`) VALUES
-- ('','','','','','');
-- INSERT INTO `cart` (`cartId`,`userSession`,`productId`,`active`) VALUES
-- ('','','','');
-- INSERT INTO `photos` (`photoId`,`styleId`,`url`,`thumbnailUrl`) VALUES
-- ('','','','');