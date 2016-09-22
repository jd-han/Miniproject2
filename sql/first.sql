create table mlec_member(
	member_no int primary key auto_increment,
	id varchar(20) unique,
	name varchar(30),
	pass varchar(20),
	postalCode varchar(10),
	address varchar(300),
	detailAddress varchar(400),
	email varchar(100),
	faceBook varchar(2),
	major int(2),
	regDate Date,
	profile varchar(400)
);
create table mlec_picture(
	member_no int,
	fileno int primary key auto_increment,
	realpath varchar(300),
	oriname varchar(300),
	realname varchar(300),
	filepath varchar(300)
);
create table asd (
	member_no int primary key auto_increment
);