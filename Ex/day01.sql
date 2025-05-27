/***********************
select 문 조회
***********************/
-- ---------------------
-- select절 + from절
-- ---------------------
select * from employees;	-- ; 마침표
select * from Employees;	-- 대소문자 구분하지 않음

-- 테이블 전체 조회하기
select * from employees;	-- 직원
select * from locations;	-- 도시
select * from regions;		-- 지역
select * from countries;	-- 나라
select * from job_history;	-- 업무현황
select * from jobs;			-- 업무
select * from departments;	-- 부서

-- 전체
select * from employees;

-- employee_id, first_name, last_name
select employee_id, first_name, last_name
from employees
;
-- 모든 직원의 이름(fisrt_name)과 전화번호 입사일 월급을 출력하세요
select first_name
	, phone_number
	, hire_date
	, salary
from employees
;
-- 모든 직원의 이름(first_name)과 성(last_name), 월급, 전화번호, 이메일, 입사일을 출력하세요
select first_name
	, last_name
	, salary
	, phone_number
    , email
	, hire_date 
from employees
;
-- 직원의 이름(fisrt_name)과 전화번호, 입사일, 월급 으로 표시되도록 출력하세요
select first_name '이름'
	, phone_number '전화번호'
	, hire_date '입사일'
	, salary '월급'
from employees
;
-- 직원의 직원아이디를 사 번, 이름(first_name), 성(last_name), 월급, 전화번호, 이메일, 입사일로 표시되도록 출력하세요
select employee_id	'사 번'
	, first_name '이름'
	, last_name '성'
	, salary '월급'
	, phone_number '전화번호'
	, email '이메일'
	, hire_date '입사일'
from employees
;
-- 산술 연산자 사용하기
select first_name
	, salary '월급'
	, salary-100 '월급-식대'
	, salary*12 '연봉'
	, salary*12+5000 '보너스포함'
	, salary/30 '일급'
	, employee_id%3 '워크삽 팀'
	, employee_id/2		-- 정수 계산 소수점까지 해줌(java는 정수형 맞춰줘야함)
from employees
;
-- 문자열은 0으로 처리함****주의****
select job_id
from employees
;
select first_name, last_name
	, concat(first_name,last_name) '전체이름'
	, concat(first_name,' ',last_name) '전체 이름'
	, concat(first_name,'-',last_name) '전체-이름'
	, concat(first_name,' ',last_name,' 입사일은 ', hire_date,' 입니다') '문장' -- 김나라 입사일은 2024-01-01 입니다
from employees
;
-- 전체직원의 정보를 다음과 같이 출력하세요
select concat(first_name,'-',last_name) '성명'
	, salary '월급'
	, salary*12 '연봉'
	, salary*12+5000 '보너스'
	, phone_number '전화번호'
from employees
;
-- 테이블의 컬럼명테이블의 데이터,  문자열,숫자는 그대로 출력 
select '(주)개발자' company
	, first_name
	, salary
	, 3+3 no
from employees
;
-- MySQL은 테이블명을 생략할 수 있다. (오라클은 안됨)
select 	'(주)개발자' company from employees;	-- 데이터의 갯수만큼 출력
select 	'(주)개발자' company from dual;		-- 가상의 테이블 사용
select 	'(주)개발자' company ;				-- from절 생략 가능

