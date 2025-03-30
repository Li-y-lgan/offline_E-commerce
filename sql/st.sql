-- hive (gmall)>
drop table if exists ods_order_info;
create external table ods_order_info (
    `id` string COMMENT '订单号',
    `final_total_amount` decimal(16,2) COMMENT '订单金额',
    `order_status` string COMMENT '订单状态',
    `user_id` string COMMENT '用户id',
    `out_trade_no` string COMMENT '支付流水号',
    `create_time` string COMMENT '创建时间',
    `operate_time` string COMMENT '操作时间',
    `province_id` string COMMENT '省份ID',
    `benefit_reduce_amount` decimal(16,2) COMMENT '优惠金额',
    `original_total_amount` decimal(16,2)  COMMENT '原价金额',
    `feight_fee` decimal(16,2)  COMMENT '运费'
) COMMENT '订单表'
PARTITIONED BY (`dt` string) -- 按照时间创建分区
row format delimited fields terminated by '\t' -- 指定分割符为\t
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_order_info/'
tblproperties ('compression'='snappy')
;
load data inpath '/origin_data/db/order_info/2025-03-27'into table ods_order_info partition (`dt`='2025-03-27');

select * from ods_order_info;

-- hive (gmall)>
drop table if exists ods_order_detail;
create external table ods_order_detail(
    `id` string COMMENT '编号',
    `order_id` string  COMMENT '订单号',
    `user_id` string COMMENT '用户id',
    `sku_id` string COMMENT '商品id',
    `sku_name` string COMMENT '商品名称',
    `order_price` decimal(16,2) COMMENT '商品价格',
    `sku_num` bigint COMMENT '商品数量',
    `create_time` string COMMENT '创建时间',
    `source_type` string COMMENT '来源类型',
    `source_id` string COMMENT '来源编号'
) COMMENT '订单详情表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_order_detail/'
tblproperties ('compression'='snappy')
;

load data inpath '/origin_data/db/order_detail/2025-03-27'into table ods_order_detail partition (`dt`='2025-03-27');
select * from ods_order_detail;

-- hive (gmall)>
drop table if exists ods_sku_info;
create external table ods_sku_info(
    `id` string COMMENT 'skuId',
    `spu_id` string   COMMENT 'spuid',
    `price` decimal(16,2) COMMENT '价格',
    `sku_name` string COMMENT '商品名称',
    `sku_desc` string COMMENT '商品描述',
    `weight` string COMMENT '重量',
    `tm_id` string COMMENT '品牌id',
    `category3_id` string COMMENT '品类id',
    `create_time` string COMMENT '创建时间'
) COMMENT 'SKU商品表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_sku_info/'
tblproperties ('compression'='snappy');

load data inpath '/origin_data/db/sku_info/2025-03-27'into table ods_sku_info partition (`dt`='2025-03-27');

select * from ods_sku_info;

-- hive (gmall)>
drop table if exists ods_user_info;
create external table ods_user_info(
    `id` string COMMENT '用户id',
    `name`  string COMMENT '姓名',
    `birthday` string COMMENT '生日',
    `gender` string COMMENT '性别',
    `email` string COMMENT '邮箱',
    `user_level` string COMMENT '用户等级',
    `create_time` string COMMENT '创建时间',
    `operate_time` string COMMENT '操作时间'
) COMMENT '用户表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_user_info/'
tblproperties ('compression'='snappy');

load data inpath '/origin_data/db/user_info/2025-03-27'into table ods_user_info partition (`dt`='2025-03-27');

select * from ods_user_info;

-- hive (gmall)>
drop table if exists ods_base_category1;
create external table ods_base_category1(
    `id` string COMMENT 'id',
    `name`  string COMMENT '名称'
) COMMENT '商品一级分类表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_category1/'
tblproperties ('compression'='snappy');

load data inpath '/origin_data/db/base_category1/2025-03-27'into table ods_base_category1 partition (`dt`='2025-03-27');
select * from ods_base_category1;

-- hive (gmall)>
drop table if exists ods_base_category2;
create external table ods_base_category2(
    `id` string COMMENT ' id',
    `name` string COMMENT '名称',
    category1_id string COMMENT '一级品类id'
) COMMENT '商品二级分类表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_category2/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/base_category2/2025-03-27'into table ods_base_category2 partition (`dt`='2025-03-27');

select * from ods_base_category2;
-- hive (gmall)>
drop table if exists ods_base_category3;
create external table ods_base_category3(
    `id` string COMMENT ' id',
    `name`  string COMMENT '名称',
    category2_id string COMMENT '二级品类id'
) COMMENT '商品三级分类表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_category3/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/base_category3/2025-03-27'into table ods_base_category3 partition (`dt`='2025-03-27');
select * from ods_base_category3;

-- hive (gmall)>
drop table if exists ods_payment_info;
create external table ods_payment_info(
    `id`   bigint COMMENT '编号',
    `out_trade_no`    string COMMENT '对外业务编号',
    `order_id`        string COMMENT '订单编号',
    `user_id`         string COMMENT '用户编号',
    `alipay_trade_no` string COMMENT '支付宝交易流水编号',
    `total_amount`    decimal(16,2) COMMENT '支付金额',
    `subject`         string COMMENT '交易内容',
    `payment_type`    string COMMENT '支付类型',
    `payment_time`    string COMMENT '支付时间'
)  COMMENT '支付流水表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_payment_info/'
tblproperties ('compression'='snappy');

load data inpath '/origin_data/db/payment_info/2025-03-27'into table ods_payment_info partition (`dt`='2025-03-27');
select * from ods_payment_info;


-- hive (gmall)>
drop table if exists ods_base_province;
create external table ods_base_province (
    `id`   bigint COMMENT '编号',
    `name`        string COMMENT '省份名称',
    `region_id`    string COMMENT '地区ID',
    `area_code`    string COMMENT '地区编码',
    `iso_code` string COMMENT 'iso编码,superset可视化使用'
)  COMMENT '省份表'
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_province/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/base_province/2025-03-27'into table ods_base_province;
select * from ods_base_province;
-- 3.3.10 地区表（特殊）
-- hive (gmall)>
drop table if exists ods_base_region;
create external table ods_base_region (
    `id` string COMMENT '编号',
    `region_name` string COMMENT '地区名称'
)  COMMENT '地区表'
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_region/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/base_region/2025-03-27'into table ods_base_region;
select * from ods_base_region;
-- 3.3.11 品牌表（全量）
-- hive (gmall)>
drop table if exists ods_base_trademark;
create external table ods_base_trademark (
    `tm_id`   string COMMENT '编号',
    `tm_name` string COMMENT '品牌名称'
)  COMMENT '品牌表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_trademark/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/base_trademark/2025-03-27'into table ods_base_trademark   partition (`dt`='2025-03-27');
select * from ods_base_trademark;
-- 3.3.12 订单状态表（增量）
-- hive (gmall)>
drop table if exists ods_order_status_log;
create external table ods_order_status_log (
    `id`   string COMMENT '编号',
    `order_id` string COMMENT '订单ID',
    `order_status` string COMMENT '订单状态',
    `operate_time` string COMMENT '修改时间'
)  COMMENT '订单状态表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_order_status_log/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/status_log/2025-03-27'into table ods_order_status_log   partition (`dt`='2025-03-27');
-- 3.3.13 SPU商品表（全量）
-- hive (gmall)>
drop table if exists ods_spu_info;
create external table ods_spu_info(
    `id` string COMMENT 'spuid',
    `spu_name` string COMMENT 'spu名称',
    `category3_id` string COMMENT '品类id',
    `tm_id` string COMMENT '品牌id'
) COMMENT 'SPU商品表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_spu_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/spu_info/2025-03-27'into table ods_spu_info   partition (`dt`='2025-03-27');
-- 3.3.14 商品评论表（增量）
-- hive (gmall)>
drop table if exists ods_comment_info;
create external table ods_comment_info(
    `id` string COMMENT '编号',
    `user_id` string COMMENT '用户ID',
    `sku_id` string COMMENT '商品sku',
    `spu_id` string COMMENT '商品spu',
    `order_id` string COMMENT '订单ID',
    `appraise` string COMMENT '评价',
    `create_time` string COMMENT '评价时间'
) COMMENT '商品评论表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_comment_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/comment_info/2025-03-27'into table ods_comment_info   partition (`dt`='2025-03-27');
-- 3.3.15 退单表（增量）
-- hive (gmall)>
drop table if exists ods_order_refund_info;
create external table ods_order_refund_info(
    `id` string COMMENT '编号',
    `user_id` string COMMENT '用户ID',
    `order_id` string COMMENT '订单ID',
    `sku_id` string COMMENT '商品ID',
    `refund_type` string COMMENT '退款类型',
    `refund_num` bigint COMMENT '退款件数',
    `refund_amount` decimal(16,2) COMMENT '退款金额',
    `refund_reason_type` string COMMENT '退款原因类型',
    `create_time` string COMMENT '退款时间'
) COMMENT '退单表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_order_refund_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/order_refund_info/2025-03-27'into table ods_order_refund_info   partition (`dt`='2025-03-27');
-- 3.3.16 加购表（全量）
-- hive (gmall)>
drop table if exists ods_cart_info;
create external table ods_cart_info(
    `id` string COMMENT '编号',
    `user_id` string  COMMENT '用户id',
    `sku_id` string  COMMENT 'skuid',
    `cart_price` decimal(16,2)  COMMENT '放入购物车时价格',
    `sku_num` bigint  COMMENT '数量',
    `sku_name` string  COMMENT 'sku名称 (冗余)',
    `create_time` string  COMMENT '创建时间',
    `operate_time` string COMMENT '修改时间',
    `is_ordered` string COMMENT '是否已经下单',
    `order_time` string  COMMENT '下单时间',
    `source_type` string COMMENT '来源类型',
    `source_id` string COMMENT '来源编号'
) COMMENT '加购表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_cart_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/cart_info/2025-03-27'into table ods_cart_info   partition (`dt`='2025-03-27');
-- 3.3.17 商品收藏表（全量）
-- hive (gmall)>
drop table if exists ods_favor_info;
create external table ods_favor_info(
    `id` string COMMENT '编号',
    `user_id` string  COMMENT '用户id',
    `sku_id` string  COMMENT 'skuid',
    `spu_id` string  COMMENT 'spuid',
    `is_cancel` string  COMMENT '是否取消',
    `create_time` string  COMMENT '收藏时间',
    `cancel_time` string  COMMENT '取消时间'
) COMMENT '商品收藏表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_favor_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/favor_info/2025-03-27'into table ods_favor_info   partition (`dt`='2025-03-27');

-- 3.3.18 优惠券领用表（新增及变化）
-- hive (gmall)>
drop table if exists ods_coupon_use;
create external table ods_coupon_use(
    `id` string COMMENT '编号',
    `coupon_id` string  COMMENT '优惠券ID',
    `user_id` string  COMMENT 'skuid',
    `order_id` string  COMMENT 'spuid',
    `coupon_status` string  COMMENT '优惠券状态',
    `get_time` string  COMMENT '领取时间',
    `using_time` string  COMMENT '使用时间(下单)',
    `used_time` string  COMMENT '使用时间(支付)'
) COMMENT '优惠券领用表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_coupon_use/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/coupon_use/2025-03-27'into table ods_coupon_use   partition (`dt`='2025-03-27');
-- 3.3.19 优惠券表（全量）
-- hive (gmall)>
drop table if exists ods_coupon_info;
create external table ods_coupon_info(
  `id` string COMMENT '购物券编号',
  `coupon_name` string COMMENT '购物券名称',
  `coupon_type` string COMMENT '购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券',
  `condition_amount` decimal(16,2) COMMENT '满额数',
  `condition_num` bigint COMMENT '满件数',
  `activity_id` string COMMENT '活动编号',
  `benefit_amount` decimal(16,2) COMMENT '减金额',
  `benefit_discount` decimal(16,2) COMMENT '折扣',
  `create_time` string COMMENT '创建时间',
  `range_type` string COMMENT '范围类型 1、商品 2、品类 3、品牌',
  `spu_id` string COMMENT '商品id',
  `tm_id` string COMMENT '品牌id',
  `category3_id` string COMMENT '品类id',
  `limit_num` bigint COMMENT '最多领用次数',
  `operate_time`  string COMMENT '修改时间',
  `expire_time`  string COMMENT '过期时间'
) COMMENT '优惠券表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_coupon_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/coupon_info/2025-03-27'into table ods_coupon_info   partition (`dt`='2025-03-27');
-- 3.3.20 活动表（全量）
-- hive (gmall)>
drop table if exists ods_activity_info;
create external table ods_activity_info(
    `id` string COMMENT '编号',
    `activity_name` string  COMMENT '活动名称',
    `activity_type` string  COMMENT '活动类型',
    `start_time` string  COMMENT '开始时间',
    `end_time` string  COMMENT '结束时间',
    `create_time` string  COMMENT '创建时间'
) COMMENT '活动表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_activity_info/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/activity_info/2025-03-27'into table ods_activity_info   partition (`dt`='2025-03-27');
-- 3.3.21 活动订单关联表（增量）
-- hive (gmall)>
drop table if exists ods_activity_order;
create external table ods_activity_order(
    `id` string COMMENT '编号',
    `activity_id` string  COMMENT '优惠券ID',
    `order_id` string  COMMENT 'skuid',
    `create_time` string  COMMENT '领取时间'
) COMMENT '活动订单关联表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_activity_order/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/activity_order/2025-03-27'into table ods_activity_order   partition (`dt`='2025-03-27');
-- 3.3.22 优惠规则表（全量）
-- hive (gmall)>
drop table if exists ods_activity_rule;
create external table ods_activity_rule(
    `id` string COMMENT '编号',
    `activity_id` string  COMMENT '活动ID',
    `condition_amount` decimal(16,2) COMMENT '满减金额',
    `condition_num` bigint COMMENT '满减件数',
    `benefit_amount` decimal(16,2) COMMENT '优惠金额',
    `benefit_discount` decimal(16,2) COMMENT '优惠折扣',
    `benefit_level` string  COMMENT '优惠级别'
) COMMENT '优惠规则表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_activity_rule/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/activity_rule/2025-03-27'into table ods_activity_rule   partition (`dt`='2025-03-27');
-- 3.3.23 编码字典表（全量）
-- hive (gmall)>
drop table if exists ods_base_dic;
create external table ods_base_dic(
    `dic_code` string COMMENT '编号',
    `dic_name` string  COMMENT '编码名称',
    `parent_code` string  COMMENT '父编码',
    `create_time` string  COMMENT '创建日期',
    `operate_time` string  COMMENT '操作日期'
) COMMENT '编码字典表'
PARTITIONED BY (`dt` string)
row format delimited fields terminated by '\t'
location '/home/user/hive/warehouse/dev_e_commerce_yanli.db/ods/ods_base_dic/'
tblproperties ('compression'='snappy');
load data inpath '/origin_data/db/base_dic/2025-03-27'into table ods_base_dic   partition (`dt`='2025-03-27');




-- 3.4.1 创建订单表
-- hive (gmall)>
drop table if exists dwd_order_info;
create external table dwd_order_info (
   `id` string COMMENT '',
   `total_amount` decimal(10,2) COMMENT '',
   `order_status` string COMMENT ' 1 2  3  4  5',
  `user_id` string COMMENT 'id' ,
 `payment_way` string COMMENT '',
 `out_trade_no` string COMMENT '',
 `create_time` string COMMENT '',
 `operate_time` string COMMENT ''
) COMMENT ''
PARTITIONED BY ( `dt` string)
stored as  parquet
location '/warehouse/gmall/dwd/dwd_order_info/'
tblproperties ("parquet.compression"="snappy")
;
-- 3.4.2 创建订单详情表
-- hive (gmall)>
drop table if exists dwd_order_detail;
create external table dwd_order_detail(
   `id` string COMMENT '',
   `order_id` decimal(10,2) COMMENT '',
  `user_id` string COMMENT 'id' ,
 `sku_id` string COMMENT 'id',
 `sku_name` string COMMENT '',
 `order_price` string COMMENT '',
 `sku_num` string COMMENT '',
 `create_time` string COMMENT ''
) COMMENT ''
PARTITIONED BY ( `dt` string)
stored as  parquet
location '/warehouse/gmall/dwd/dwd_order_detail/'
tblproperties ("parquet.compression"="snappy")
;
-- 3.4.3 创建用户表
-- hive (gmall)>
drop table if exists dwd_user_info;
create external table dwd_user_info(
   `id` string COMMENT 'id',
   `name`  string COMMENT '',
  `birthday` string COMMENT '' ,
 `gender` string COMMENT '',
 `email` string COMMENT '',
 `user_level` string COMMENT '',
 `create_time` string COMMENT ''
) COMMENT ''
PARTITIONED BY ( `dt` string)
stored as  parquet
location '/warehouse/gmall/dwd/dwd_user_info/'
tblproperties ("parquet.compression"="snappy")
;
-- 3.4.4 创建支付流水表
-- hive (gmall)>
drop table if exists `dwd_payment_info`;
create external  table  `dwd_payment_info`(
`id`  bigint COMMENT '',
`out_trade_no`  string COMMENT '',
`order_id`  string COMMENT '',
`user_id`  string COMMENT '',
`alipay_trade_no` string COMMENT '',
`total_amount`  decimal(16,2) COMMENT '',
`subject`  string COMMENT '',
`payment_type` string COMMENT '',
`payment_time`  string COMMENT ''
 )  COMMENT ''
PARTITIONED BY ( `dt` string)
stored as  parquet
location '/warehouse/gmall/dwd/dwd_payment_info/'
tblproperties ("parquet.compression"="snappy")
;
-- 3.4.5 创建商品表（增加分类）

-- hive (gmall)>
drop table if exists dwd_sku_info;
create external table dwd_sku_info(
   `id` string COMMENT 'skuId',
   `spu_id` string COMMENT 'spuid',
  `price` decimal(10,2) COMMENT '' ,
 `sku_name` string COMMENT '',
 `sku_desc` string COMMENT '',
 `weight` string COMMENT '',
 `tm_id` string COMMENT 'id',
 `category3_id` string COMMENT '1id',
 `category2_id` string COMMENT '2id',
 `category1_id` string COMMENT '3id',
 `category3_name` string COMMENT '3',
 `category2_name` string COMMENT '2',
 `category1_name` string COMMENT '1',
 `create_time` string COMMENT ''
) COMMENT ''
PARTITIONED BY ( `dt` string)
stored as  parquet
location '/warehouse/gmall/dwd/dwd_sku_info/'
tblproperties ("parquet.compression"="snappy")
;


create  database if not exists  month;
use month;

-- ods_order_info、ods_order_detail、ods_sku_info、ods_user_info。
create external table  ods_order_info(
id string comment '编号',
total_amount decimal(10,2) comment '总金额',
order_status string comment '订单状态',
user_id string comment '用户id',
payment_way string comment '订单备注',
out_trade_no string comment '订单交易编号（第三方支付用)',
create_time string comment '创建时间',
operate_time string comment '操作时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/warehouse/month/ods/ods_order_info'
tblproperties ('parquet.compression'='snappy');

create external table  ods_order_detail(
id string comment ' 编号',
order_id string comment '订单编号',
user_id string comment '用户id',
sku_id  string comment  'sku_id',
sku_name string comment 'sku名称（冗余)',
img_url string comment '图片名称（冗余)',
order_price decimal(10,2) comment '购买价格(下单时sku价格）',
sku_num int comment '购买个数',
create_time string comment '创建时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/warehouse/month/ods/ods_order_detail'
tblproperties ('parquet.compression'='snappy');

create external table  ods_sku_info(
id string comment 'skuid(itemID)',
spu_id string comment 'spuid',
price decimal(10,2)comment '价格',
sku_name string comment 'sku名称',
sku_desc string comment '商品规格描述',
weight decimal(10,2) comment '重量',
tm_id string comment '品牌(冗余)',
category3_id string comment '三级分类id（冗余)',
create_time string comment '创建时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/warehouse/month/ods/ods_sku_info'
tblproperties ('parquet.compression'='snappy');

create external table  ods_user_info(
id string comment '编号',
name string comment '用户姓名',
birthday string comment '用户生日',
gender string comment '性别 M男,F女',
email string comment '邮箱',
user_level string comment '用户级别',
create_time string comment '创建时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/warehouse/gmall/ods/ods_user_info'
tblproperties ('parquet.compression'='snappy');

load data inpath '/origin_data/db/order_info/2023-08-27' into table ods_order_info partition (dt='2023-08-27');
load data inpath '/origin_data/db/order_detail/2023-08-27' into table ods_order_detail partition (dt='2023-08-27');
load data inpath '/origin_data/db/sku_info/2023-08-27' into table ods_sku_info partition (dt='2023-08-27');
load data inpath '/origin_data/db/user_info/2023-08-27' into table ods_user_info partition (dt='2023-08-27');


create external table  dwd_order_info(
id string comment '编号',
total_amount decimal(10,2) comment '总金额',
order_status string comment '订单状态',
user_id string comment '用户id',
payment_way string comment '订单备注',
out_trade_no string comment '订单交易编号（第三方支付用)',
create_time string comment '创建时间',
operate_time string comment '操作时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
stored as parquet
location '/warehouse/month/dwd/dwd_order_info'
tblproperties ('parquet.compression'='snappy');

create external table  dwd_order_detail(
id string comment ' 编号',
order_id string comment '订单编号',
user_id string comment '用户id',
sku_id  string comment  'sku_id',
sku_name string comment 'sku名称（冗余)',
img_url string comment '图片名称（冗余)',
order_price decimal(10,2) comment '购买价格(下单时sku价格）',
sku_num int comment '购买个数',
create_time string comment '创建时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
    stored as parquet
location '/warehouse/month/dwd/dwd_order_detail'
tblproperties ('parquet.compression'='snappy');

create external table  dwd_sku_info(
id string comment 'skuid(itemID)',
spu_id string comment 'spuid',
price decimal(10,2)comment '价格',
sku_name string comment 'sku名称',
sku_desc string comment '商品规格描述',
weight decimal(10,2) comment '重量',
tm_id string comment '品牌(冗余)',
category3_id string comment '三级分类id（冗余)',
create_time string comment '创建时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
    stored as parquet
location '/warehouse/month/dwd/dwd_sku_info'
tblproperties ('parquet.compression'='snappy');

create external table  dwd_user_info(
id string comment '编号',
name string comment '用户姓名',
birthday string comment '用户生日',
gender string comment '性别 M男,F女',
email string comment '邮箱',
user_level string comment '用户级别',
create_time string comment '创建时间'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
    stored as parquet
location '/warehouse/month/dwd/dwd_user_info'
tblproperties ('parquet.compression'='snappy');

insert overwrite table dwd_order_info partition (dt)
select * from ods_order_info where id is not null and dt='2023-08-27';

insert overwrite table dwd_order_detail partition (dt)
select * from ods_order_detail where id is not null and dt='2023-08-27';


insert overwrite table dwd_sku_info partition (dt)
select * from ods_sku_info where id is not null and dt='2023-08-27';

insert overwrite table dwd_user_info partition (dt)
select * from ods_user_info where id is not null and dt='2023-08-27';
drop  table dws_wide_info;
create external table dws_wide_info(
order_id string,
user_id string,
sku_id string,
total_amount decimal(20,2),
order_status string,
sku_name string,
sku_num int,
order_price decimal(20,2),
price decimal(20,2),
tm_id string,
dt string
)
row format delimited fields terminated by '\t'
stored as orc
location '/warehouse/month/dws/dws_wide_info'
tblproperties ('parquet.compression'='lzo');
insert overwrite  table dws_wide_info
select
    od.order_id,
    od.user_id,
    od.sku_id,
    oi.total_amount,
    oi.order_status,
    od.sku_name,
    od.sku_num,
    od.order_price,
    si.price,
    si.tm_id,
    od.dt
from dwd_order_info oi
         left join dwd_order_detail od on oi.id=od.order_id
         left join dwd_sku_info si on od.sku_id=si.id
         left join dwd_user_info ui on od.user_id=ui.id
where oi.id is not null  and  od.id is not null and  si.id is not null and  ui.id is not null
  and oi.dt='2023-08-27'and od.dt='2023-08-27'and si.dt='2023-08-27'and ui.dt='2023-08-27';
-- ①　GMV成交总额 （gmv=销售额+取消订单金额+拒收订单金额+退货订单金额。）  （8分）

create table ads_gmv_sum(
                            dt string,
                            user_count int,
                            order_amount decimal(20,2),
                            py_amount decimal(10,2)
)row format delimited fields terminated by '\t'
location '/warehouse/month/ads/ads_gmv_sum';

insert  overwrite  table ads_gmv_sum
select
    '2023-08-27' dt,
    count(order_id),
    sum(total_amount),
    sum(`if`(order_status='1004',price*sku_num,0)) py_amount
from dws_wide_info group by dt;

-- ②　转化率（用户行为漏斗分析）（8分）
create table ads_user_rate(
                              user_id string,
                              order_id string,
                              user_rate decimal(20,2),
                              py_rate decimal(20,2)
)row format delimited fields terminated by '\t'
location '/warehouse/month/ads/ads_user_rate';

insert  overwrite  table ads_user_rate
select
    user_id,
    order_id,
    cast(count(order_id)/count(user_id)*100 as  decimal(20,2)),
    cast(py_count/count(user_id)*100 as  decimal(20,2))
from
    (select user_id,
            order_id,
            count(order_id),
            count(user_id),
            sum(`if`(order_status='1004',1,0))as py_count
     from dws_wide_info group by user_id, order_id)a
group by user_id, order_id;

-- ③　品牌复购率（复购率计算分析） （8分）
create  table  ads_by_lv(
                            sku_id string,
                            sku_name string,
                            buy1 int,
                            buy2 int,
                            b1b2 decimal(10,2),
                            buy3 int,
                            b3b1 decimal(10,2),
                            dt string
) row format delimited fields terminated by '\t'
 location '/warehouse/month/ads/ads_by_lv';

insert  overwrite  table ads_by_lv
select
    sku_id,
    sku_name,
    sum(`if`(order_id>=1,1,0)) as buy1,
    sum(`if`(order_id>=2,1,0)) as buy2,
    sum(`if`(order_id>=2,1,0))/ sum(`if`(order_id>=1,1,0)) as b1b2,
    sum(`if`(order_id>=3,1,0)) as buy3,
    sum(`if`(order_id>=3,1,0))/  sum(`if`(order_id>=1,1,0)) as b3b1,
    dt
from dws_wide_info where dt='2023-08-27' group by sku_id, sku_name, dt