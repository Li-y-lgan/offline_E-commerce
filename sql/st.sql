
CREATE TABLE `ods_micro_detail_log` (
                                        `user_id` STRING COMMENT '用户 ID',
                                        `sku_id` STRING COMMENT '商品 ID',
                                        `access_time` TIMESTAMP COMMENT '访问时间'
) COMMENT '微详情页日志表'
    PARTITIONED BY (`dt` STRING) -- 明确指定分区字段类型
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_micro_detail_log'
TBLPROPERTIES ('PARQUET.compression'='snappy');

-- 订单信息表
CREATE TABLE `ods_order_info` (
                                  `order_id` STRING COMMENT '订单 ID',
                                  `buyer_id` STRING COMMENT '买家 ID',
                                  `sku_id` STRING COMMENT '商品 ID',
                                  `order_time` TIMESTAMP COMMENT '下单时间',
                                  `payment_status` STRING COMMENT '支付状态，如已支付、未支付、退款等',
                                  `order_items` INT COMMENT '下单件数'
) COMMENT '订单信息表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_order_info'
TBLPROPERTIES ('compression'='snappy');

-- 支付记录表
CREATE TABLE `ods_payment_record` (
                                      `payment_id` STRING COMMENT '支付 ID',
                                      `buyer_id` STRING COMMENT '买家 ID',
                                      `order_id` STRING COMMENT '订单 ID',
                                      `payment_time` TIMESTAMP COMMENT '支付时间',
                                      `amount` DECIMAL(18, 2) COMMENT '支付金额',
                                      `refund_amount` DECIMAL(18, 2) COMMENT '退款金额'
) COMMENT '支付记录表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_payment_record'
TBLPROPERTIES ('compression'='snappy');

-- 价格带配置表
CREATE TABLE `ods_price_band_config` (
                                         `price_band_id` STRING COMMENT '价格带 ID',
                                         `price_min` DECIMAL(18, 2) COMMENT '价格下限',
                                         `price_max` DECIMAL(18, 2) COMMENT '价格上限'
) COMMENT '价格带配置表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_price_band_config'
TBLPROPERTIES ('compression'='snappy');

-- 商品信息表
CREATE TABLE `ods_product_info` (
                                    `sku_id` STRING COMMENT '商品 ID',
                                    `price` DECIMAL(18, 2) COMMENT '商品价格',
                                    `category` STRING COMMENT '商品分类'
) COMMENT '商品信息表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_product_info'
TBLPROPERTIES ('compression'='snappy');

-- 商品评分表
CREATE TABLE `ods_product_score` (
                                     `sku_id` STRING COMMENT '商品 ID',
                                     `score` DECIMAL(5, 2) COMMENT '商品评分'
) COMMENT '商品评分表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_product_score'
TBLPROPERTIES ('compression'='snappy');

-- 店铺信息表
CREATE TABLE `ods_shop_info` (
                                 `shop_id` STRING COMMENT '店铺 ID',
                                 `shop_name` STRING COMMENT '店铺名称'
) COMMENT '店铺信息表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_shop_info'
TBLPROPERTIES ('compression'='snappy');

-- 时间维度表
CREATE TABLE `ods_time_dim` (
                                `date_id` STRING COMMENT '日期 ID',
                                `date` TIMESTAMP COMMENT '日期',
                                `week_of_year` INT COMMENT '一年中的周数',
                                `month` INT COMMENT '月份',
                                `year` INT COMMENT '年份'
) COMMENT '时间维度表'
    ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_time_dim'
TBLPROPERTIES ('compression'='snappy');

-- 用户行为日志表
CREATE TABLE `ods_user_behavior` (
                                     `user_id` STRING COMMENT '用户 ID',
                                     `sku_id` STRING COMMENT '商品 ID',
                                     `action_type` STRING COMMENT '行为类型，如浏览、收藏、加购等',
                                     `action_time` TIMESTAMP COMMENT '行为发生时间',
                                     `stay_time` INT COMMENT '停留时长（秒）',
                                     `is_bounce` BOOLEAN COMMENT '是否跳出页面'
) COMMENT '用户行为日志表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_user_behavior'
TBLPROPERTIES ('compression'='snappy');

-- 用户信息表
CREATE TABLE `ods_user_info` (
                                 `user_id` STRING COMMENT '用户 ID',
                                 `register_time` TIMESTAMP COMMENT '注册时间',
                                 `first_purchase_time` TIMESTAMP COMMENT '首次购买时间'
) COMMENT '用户信息表'
    PARTITIONED BY (`dt` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS PARQUET
LOCATION '/home/user/hive/warehouse/offline_yanli.db/ods/ods_user_info'
TBLPROPERTIES ('compression'='snappy');
