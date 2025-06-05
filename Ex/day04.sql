-- 단일행 함수(하나의 행만 알아도 됨)
select first_name
	, Upper(first_name)
	, rpad(first_name,10,'*')
from employees
;

/**************************************
*복수행 함수(그룹합수, 집계함수, 전체를 알아야 함)
**************************************/

-- 갯수, 합계 평균, 최고값, 최저값
-- 사용가능
select 	avg(salary)
from employees
;
-- 사용불가능(107개와 평균값 1개를 동시에 출력 불가)
select 	first_name
		,avg(salary)
from employees
;
-- **그룹함수 sum()**
-- 직원의 수를 구하시오
select count(*)		-- 전체 갯수(row수)
from employees
;
select count(commission_pct)	-- 컬럼중 null이 아닌 row 갯수
from employees
;
select count(*)
	, count(commission_pct)
from employees
;
select count(manager_id)
from employees
;
select count(*), sum(salary)
from employees
;
-- 월급이 16000 초과되는 직원의 수는
select count(*)
	, count(salary)
    , count(commission_pct)
    , count(manager_id)
from employees
where salary > 16000
;
-- 전체 직원의 수와 급여의 함
select count(*)
	, sum(salary)
from employees
;
-- **그룹함수 avg()**
-- 월급의 평군을 구하시오
select avg(salary)				-- salary가 null이면 평균에 포함하지 않음
	, avg(ifnull(salary,0))	-- salary가 null이면 0으로 치환해 평균에 포함
from employees
;
-- **그룹함수 max(), min()**
select max(salary)
	, min(salary)
    , sum(salary)
from employees
;

-- **group by 절**
-- 부서별로 월급 합계를 구해랏
select department_id
	, count(*)
	, max(salary)
	, min(salary)
	, sum(salary)
    , avg(salary)
from employees
group by department_id
order by department_id
;
-- 부서별로 부서 번호와 , 인원수, 월급합계를 출력하세요
select department_id
	, count(*)
    , sum(salary)
from employees
group by department_id
order by department_id
;
-- 부서별로 부서 번호와 , 최고월급을 받는 직원의 이름을 출력하세요
select department_id
	, first_name
	, max(salary) 
from employees
group by department_id
	, first_name
order by department_id
;
select department_id
	, job_id			-- 그룹에 참여한 컬럼이나 그룹함수만 올 수 있다
	, sum(salary) 
    , count(*)
from employees
group by department_id
	, job_id
order by department_id
;
-- 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
select department_id
	, count(*)
    , sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
order by department_id
;
-- 월급(salary)의 합계가 20000 이상이고 100번 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
--  having절(그룹전용 where절)
select department_id
	, count(*)
    , sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
order by department_id
;

/**************************************
*if(조건문, 참일때, 거짓일때
**************************************/
-- 모든 직원의 이름, 월급, 수당, 상태(state)을 출력하세요
-- 상태컬럼은 수당이 없으면 0, 수당이 있으면 1 을 state 컬럼에 표시하세요 
select first_name
	, salary
    , commission_pct
    , if(commission_pct is null, '사무직', '영업사원') 'if()'
    , ifnull(commission_pct, '없음') 'ifnull()'
from employees
;
-- 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
-- 실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1
-- 					,'SA_REP' 월급+월급*0.2
-- 					,'ST_CLERK' 면 월급+월급*0.3 
-- 					그외에는 월급으로 계산하세요
select employee_id
	, salary
    , job_id
    , case  when job_id = 'AC_ACCOUNT' 	then salary+salary*0.1
			when job_id = 'SA_REP' 		then salary+salary*0.2
            when job_id = 'ST_CLERK' 	then salary+salary*0.3
			else salary end realSalary
from employees
;
-- 직원의 이름, 부서아이디, 팀을 출력하세요
-- 팀은 코드로 결정하며 부서코드가 
-- 10~50 이면 'A-TEAM'
-- 60~100이면 'B-TEAM'
-- 110~150이면 'C-TEAM'
-- 나머지는 '팀없음' 으로 출력하세요.
select first_name
	, department_id
    , case  when department_id between 10 and 50 then 'A-TEAM'
			when department_id between 60 and 100 then 'B-TEAM'
			when department_id between 110 and 150 then 'C-TEAM'
			else '팀없음' end TEAM
from employees
order by department_id




