CREATE TABLE `member` (
 `id` varchar(20) NOT NULL PRIMARY KEY,
 `password` varchar(20) NOT NULL,
 `name` varchar(10) NOT NULL,
 `phone` int(11) unsigned NOT NULL,
 `email` varchar(40) NULL,
 `zipcode` int(5) unsigned NOT NULL,
 `birth` date NOT NULL,
 `sex` char(1) NOT NULL,
 `address` varchar(20) NOT NULL
);

CREATE TABLE `member_withdraw` (
 `id` varchar(20) NOT NULL,
 `password` varchar(20) NOT NULL,
 `reason` varchar(40) NULL,
 `time` timestamp NULL
);

CREATE TABLE `member_login` (
 `id` varchar(20) NOT NULL PRIMARY KEY,
 `password` varchar(20) NOT NULL,
 `final_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `zipcode` (
 `zipcode` int unsigned NOT NULL,
 `address1` varchar(20) NOT NULL,
 `address2` varchar(20) NOT NULL,
 `address3` varchar(80) NOT NULL,
 `address_old` varchar(80) NOT NULL,
 `address4` varchar(100) NOT NULL
);

CREATE TABLE `product` (
 `num` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `name` varchar(40) NOT NULL,
 `price_before` int unsigned NOT NULL DEFAULT 0,
 `price` int unsigned NOT NULL DEFAULT 0,
 `views` int unsigned NOT NULL DEFAULT 0,
 `amount` int unsigned NOT NULL DEFAULT 0,
 `content` TEXT NOT NULL,
 `count_review` int unsigned NOT NULL DEFAULT 0,
 `brand_num` int unsigned NOT NULL,
 `company_num` int unsigned NOT NULL,
 `category_num` int unsigned NULL
);

CREATE TABLE `notice` (
 `idx` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `title` varchar(100) NOT NULL,
 `content` TEXT NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `update_time` timestamp NOT NULL,
 `admin_id` varchar(20) NOT NULL
);

CREATE TABLE `category` (
 `num` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `name` varchar(20) NOT NULL
);

CREATE TABLE `cart` (
 `product_num` int unsigned NOT NULL,
 `id` varchar(20) NOT NULL,
 `purchase_amount` int unsigned NOT NULL
);

CREATE TABLE `admin` (
 `id` varchar(20) NOT NULL PRIMARY KEY,
 `password` varchar(20) NOT NULL,
 `name` varchar(10) NOT NULL,
 `level` int unsigned NOT NULL DEFAULT 1
);

CREATE TABLE `views` (
 `ip` int unsigned NOT NULL,
 `connect_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `product_num` int unsigned NOT NULL
);

CREATE TABLE `order` (
 `num` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `price` int unsigned NOT NULL,
 `id` varchar(20) NOT NULL,
 `product_num` int unsigned NOT NULL,
 `memo` varchar(50) NULL,
 `zipcode` int unsigned NOT NULL,
 `address` varchar(200) NOT NULL
);

CREATE TABLE `order_ship` (
 `num` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `ship_num` int unsigned NOT NULL,
 `arrival_time` timestamp NULL,
 `state_code` varchar(20) NOT NULL,
 `change_state` varchar(10) NULL
);

CREATE TABLE `brand` (
 `num` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `name` varchar(20) NOT NULL
);

CREATE TABLE `company` (
 `num` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `name` varchar(20) NOT NULL,
 `ceo_name` varchar(10) NOT NULL,
 `reg_num` int unsigned NOT NULL,
 `sector` varchar(100) NOT NULL,
 `tel` varchar(11) NOT NULL,
 `address` varchar(20) NOT NULL
);

CREATE TABLE `review` (
 `idx` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `title` varchar(100) NOT NULL,
 `content` TEXT NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `product_num` int unsigned NOT NULL,
 `id2` varchar(20) NOT NULL
);

CREATE TABLE `qna` (
 `idx` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `title` varchar(50) NOT NULL,
 `content` TEXT NOT NULL,
 `id2` varchar(20) NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `qna_answer` (
 `idx` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `content` TEXT NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `admin_id` varchar(20) NOT NULL,
 `qna_idx` int unsigned NOT NULL
);

CREATE TABLE `review_answer` (
 `idx` int unsigned NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `content` TEXT NOT NULL,
 `review_idx` int unsigned NOT NULL,
 `admin_id` varchar(20) NOT NULL
);

CREATE TABLE `product_qna` (
 `idx` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `title` varchar(50) NOT NULL,
 `content` TEXT NOT NULL,
 `id2` varchar(20) NOT NULL,
 `num` int unsigned NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `product_qna_answer` (
 `idx` int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
 `content` TEXT NOT NULL,
 `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `admin_id` varchar(20) NOT NULL,
 `product_qna_idx` int unsigned NOT NULL
);

ALTER TABLE `cart` ADD CONSTRAINT `PK_CART` PRIMARY KEY (
 `product_num`,
 `id`
);

ALTER TABLE `views` ADD CONSTRAINT `PK_VIEWS` PRIMARY KEY (
 `ip`,
 `connect_time`,
 `product_num`
);

ALTER TABLE `product` ADD CONSTRAINT `FK_brand_TO_product_1` FOREIGN KEY (
 `brand_num`
)
REFERENCES `brand` (
 `num`
);

ALTER TABLE `product` ADD CONSTRAINT `FK_company_TO_product_1` FOREIGN KEY (
 `company_num`
)
REFERENCES `company` (
 `num`
);

ALTER TABLE `product` ADD CONSTRAINT `FK_category_TO_product_1` FOREIGN KEY (
 `category_num`
)
REFERENCES `category` (
 `num`
);

ALTER TABLE `notice` ADD CONSTRAINT `FK_admin_TO_notice_1` FOREIGN KEY (
 `admin_id`
)
REFERENCES `admin` (
 `id`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_product_TO_cart_1` FOREIGN KEY (
 `product_num`
)
REFERENCES `product` (
 `num`
);

ALTER TABLE `cart` ADD CONSTRAINT `FK_member_login_TO_cart_1` FOREIGN KEY (
 `id`
)
REFERENCES `member_login` (
 `id`
);

ALTER TABLE `views` ADD CONSTRAINT `FK_product_TO_views_1` FOREIGN KEY (
 `product_num`
)
REFERENCES `product` (
 `num`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_member_login_TO_order_1` FOREIGN KEY (
 `id`
)
REFERENCES `member_login` (
 `id`
);

ALTER TABLE `order` ADD CONSTRAINT `FK_product_TO_order_1` FOREIGN KEY (
 `product_num`
)
REFERENCES `product` (
 `num`
);

ALTER TABLE `order_ship` ADD CONSTRAINT `FK_order_TO_order_ship_1` FOREIGN KEY (
 `num`
)
REFERENCES `order` (
 `num`
);

ALTER TABLE `member_withdraw` ADD CONSTRAINT `FK_member_TO_member_withdraw_1` FOREIGN KEY (
 `id`
)
REFERENCES `member` (
 `id`
);

ALTER TABLE `member_login` ADD CONSTRAINT `FK_member_TO_member_login_1` FOREIGN KEY (
 `id`
)
REFERENCES `member` (
 `id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_product_TO_review_1` FOREIGN KEY (
 `product_num`
)
REFERENCES `product` (
 `num`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_member_login_TO_review_1` FOREIGN KEY (
 `id2`
)
REFERENCES `member_login` (
 `id`
);

ALTER TABLE `qna` ADD CONSTRAINT `FK_member_login_TO_qna_1` FOREIGN KEY (
 `id2`
)
REFERENCES `member_login` (
 `id`
);

ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_admin_TO_qna_answer_1` FOREIGN KEY (
 `admin_id`
)
REFERENCES `admin` (
 `id`
);

ALTER TABLE `qna_answer` ADD CONSTRAINT `FK_qna_TO_qna_answer_1` FOREIGN KEY (
 `qna_idx`
)
REFERENCES `qna` (
 `idx`
);

ALTER TABLE `review_answer` ADD CONSTRAINT `FK_review_TO_review_answer_1` FOREIGN KEY (
 `review_idx`
)
REFERENCES `review` (
 `idx`
);

ALTER TABLE `review_answer` ADD CONSTRAINT `FK_admin_TO_review_answer_1` FOREIGN KEY (
 `admin_id`
)
REFERENCES `admin` (
 `id`
);

ALTER TABLE `product_qna` ADD CONSTRAINT `FK_member_login_TO_product_qna_1` FOREIGN KEY (
 `id2`
)
REFERENCES `member_login` (
 `id`
);

ALTER TABLE `product_qna` ADD CONSTRAINT `FK_product_TO_product_qna_1` FOREIGN KEY (
 `num`
)
REFERENCES `product` (
 `num`
);

ALTER TABLE `product_qna_answer` ADD CONSTRAINT `FK_admin_TO_product_qna_answer_1` FOREIGN KEY (
 `admin_id`
)
REFERENCES `admin` (
 `id`
);

ALTER TABLE `product_qna_answer` ADD CONSTRAINT `FK_product_qna_TO_product_qna_answer_1` FOREIGN KEY (
 `product_qna_idx`
)
REFERENCES `product_qna` (
 `idx`
);