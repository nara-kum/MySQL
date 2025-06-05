-- -------------------------------------------------------------
-- web 계정
-- -------------------------------------------------------------

-- #테이블 만들기
create table book(
	book_id int, 
    title varchar(50), 
    author varchar(20), 
    pub_date datetime
);

select * from book;
select * from article;

-- 테이블에 컬럼 추가
alter table book add pub varchar(50);

-- 테이블 컬럼 수정
alter table book modify title varchar(100); -- varchar(50) -> varchar(100)
alter table book rename column title to subject;

-- 테이블 컬럼 삭제
alter table book drop author;

-- 테이블명 수정
rename table book to article;

-- 테이블 삭제
drop table article;

-- #작가 테이블 생성
create table author(
	author_id		int				primary key,
    author_name 	varchar(100)	not null,
    author_desc		varchar(500)
);
select * from author
;
-- #작가 데이터 insert
-- insert문
insert into author values(1, '박경리','토지작가');
insert into author values(2, '이문열');			-- 컬럼수와 데이터수가 맞지 않음
insert into author values(2, '이문열','');		-- 작가설명에 null이 아닌 ''데이터가 입력된 것
insert into author values(3, '김나라','학생');
insert into author(author_id, author_name) values(4, '정우성');
insert into author(author_name, author_desc) values(5, '런닝맨');
insert into author(author_id, author_name, author_desc) values(5, '유재석', '런닝맨');

-- #book 테이블 생성
create table book(
	book_id		int				primary key,
    title		varchar(100)	not null,
    pubs		varchar(100),
    pub_date	datetime,
    author_id 	int
);
select * from book;




