-- 데이타베이스(스키마) 리스트 보기
show databases;

-- web_db 접속
use web_db;

-- 테이블 리스트 보기
show tables;

-- 작가 테이블 데이타 조회
select * from author;

-- 데이터 추가
insert into author values(null,'김나라','강동리버스트 6단지');

select *
from author
where author_id = 8
;
delete 
from author
where author_id = 8
;
select *
from author
where author_id = 8
;
select *
from author
where author_id = 5
;
update author
set author_desc = '무빙'
where author_id = 5
;
select author_id
	, author_name
    , author_desc
from author
;