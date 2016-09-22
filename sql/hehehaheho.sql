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

select member_no from asd;

select * from mlec_member

select * from mlec_picture



drop table mlecmember;
insert into asd() values();
select * from asd;

select member_no from asd where increment_key = last_insert_id();

select INSERT_LAST_ID() from asd;

update mlecPicture
   set realpath = '5', oriname = 'asdf'
 where fileno = 3;

select * from mlecMember;

select last_insert_id() from asd limit 1;

select MAX(member_no) as member_no from asd

select id from mlecMember where id = aaaaa;

select * from mlec_Member;

show processlist

create sequence member_no;

select *
		  from mlec_Member;
		  
select member_no as memberNo, id, name, pass, postalCode, address, detailAddress, email, profile
		  from mlec_member
		 where id = 'wwwww'
