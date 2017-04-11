SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS hs_images;
DROP TABLE IF EXISTS hs_album;
DROP TABLE IF EXISTS hs_article;
DROP TABLE IF EXISTS hs_leave_word;
DROP TABLE IF EXISTS hs_share;
DROP TABLE IF EXISTS hs_dictionary;
DROP TABLE IF EXISTS hs_userinfo;
DROP TABLE IF EXISTS hs_visit_count;




/* Create Tables */

-- 相册表，用来管理图片（相片）表
-- 删除就真删除了，免得浪费资源
CREATE TABLE hs_album
(
	album_id varchar(32) NOT NULL,
	-- 相册的描述
	description varchar(255) COMMENT '相册的描述',
	-- 统计相册的访问次数，以点击打开相册一次为一次
	visit_count int(8) COMMENT '统计相册的访问次数，以点击打开相册一次为一次',
	create_time timestamp NOT NULL,
	user_id varchar(32) NOT NULL,
	PRIMARY KEY (album_id)
) COMMENT = '相册表，用来管理图片（相片）表
删除就真删除了，免得浪费资源';


-- 个人文章表，用于存储个人在网站的发表的文章
CREATE TABLE hs_article
(
	article_id varchar(32) NOT NULL,
	title varchar(32) NOT NULL,
	digest varchar(256),
	content text NOT NULL,
	create_time timestamp NOT NULL,
	update_time timestamp NOT NULL,
	user_id varchar(32) NOT NULL,
	PRIMARY KEY (article_id)
) COMMENT = '个人文章表，用于存储个人在网站的发表的文章';


CREATE TABLE hs_dictionary
(
	-- 类型
	dictionary_id int(2) NOT NULL COMMENT '类型',
	-- 1-阅读分享
	-- 2-心得体会
	-- 3-留言于主页
	-- 4-留言于个人文章
	-- 5-留言于分享
	-- 6-留言于相册
	type varchar(20) NOT NULL COMMENT '1-阅读分享
2-心得体会
3-留言于主页
4-留言于个人文章
5-留言于分享
6-留言于相册',
	-- 对类型的描述
	-- 
	remark varchar(256) COMMENT '对类型的描述
',
	PRIMARY KEY (dictionary_id)
);


-- 用来存储图片
CREATE TABLE hs_images
(
	image_id varchar(32) NOT NULL,
	image_name varchar(16),
	image_url varchar(256) NOT NULL,
	upload_time timestamp NOT NULL,
	album_id varchar(32) NOT NULL,
	PRIMARY KEY (image_id)
) COMMENT = '用来存储图片';


-- 用户留言，分为首页留言，图片留言，文章留言之类的
CREATE TABLE hs_leave_word
(
	lw_id varchar(32) NOT NULL,
	content varchar(512) NOT NULL,
	-- 对于留言表，指明留言对象
	-- 
	vc_id varchar(32) NOT NULL COMMENT '对于留言表，指明留言对象
',
	-- 类型
	dictionary_id int(2) NOT NULL COMMENT '类型',
	-- 留言处的对象的ID，如果是主页就没有ID
	belong_id varchar(32) COMMENT '留言处的对象的ID，如果是主页就没有ID',
	PRIMARY KEY (lw_id)
) COMMENT = '用户留言，分为首页留言，图片留言，文章留言之类的';


-- 阅读分享，也可以是随记
CREATE TABLE hs_share
(
	share_id varchar(32) NOT NULL,
	-- 类型
	dictionary_id int(2) NOT NULL COMMENT '类型',
	content text NOT NULL,
	-- 分享内容的出处，心得体会；阅读笔记
	-- 心得体会 -- 用户的昵称
	-- 阅读笔记 -- 《莎士比亚选集》
	conten_from varchar(100) NOT NULL COMMENT '分享内容的出处，心得体会；阅读笔记
心得体会 -- 用户的昵称
阅读笔记 -- 《莎士比亚选集》',
	user_id varchar(32) NOT NULL,
	PRIMARY KEY (share_id)
) COMMENT = '阅读分享，也可以是随记';


-- 存储个人信息
CREATE TABLE hs_userinfo
(
	user_id varchar(32) NOT NULL,
	-- 使用ifnull,或者在插入数据的时候，没有昵称就设置为邮箱
	-- 
	nick_name varchar(16) COMMENT '使用ifnull,或者在插入数据的时候，没有昵称就设置为邮箱
',
	email varchar(128) NOT NULL,
	password varchar(16) NOT NULL,
	create_time timestamp DEFAULT NOW(), SYSDATE() NOT NULL,
	-- 应当设置激活码失效时间
	active_code varchar(64) NOT NULL COMMENT '应当设置激活码失效时间',
	PRIMARY KEY (user_id),
	UNIQUE (nick_name),
	UNIQUE (email)
) COMMENT = '存储个人信息';


-- 网站访问统计
CREATE TABLE hs_visit_count
(
	vc_id varchar(32) NOT NULL,
	-- 固定格式   visit_编号
	visitor_num varchar(16) NOT NULL COMMENT '固定格式   visit_编号',
	-- 访问者的ip，通过ip，判断他以前访问过没有
	ip varchar(16) NOT NULL COMMENT '访问者的ip，通过ip，判断他以前访问过没有',
	PRIMARY KEY (vc_id)
) COMMENT = '网站访问统计';



/* Create Foreign Keys */

ALTER TABLE hs_images
	ADD FOREIGN KEY (album_id)
	REFERENCES hs_album (album_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hs_leave_word
	ADD FOREIGN KEY (dictionary_id)
	REFERENCES hs_dictionary (dictionary_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hs_share
	ADD FOREIGN KEY (dictionary_id)
	REFERENCES hs_dictionary (dictionary_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE hs_leave_word
	ADD FOREIGN KEY (vc_id)
	REFERENCES hs_visit_count (vc_id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



