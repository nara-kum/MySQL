/*******************************************
* SubQuery
*******************************************/
-- 'Den' 보다 월급을 많이 받는 사람의 이름과 월급은?
-- 딘의 월급
select salary
from employees
where first_name = 'Den'
;
-- 11000보다 많이 받는 사람 리스트
select first_name
	, salary
from employees
where salary > 11000
;
-- 합친다
select first_name
	, salary
from employees
where salary > (select salary
				from employees
				where first_name = 'Den') 
;
-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
select min(salary)
from employees
;
select first_name
	, salary
    , employee_id
from employees
where salary = (select min(salary)
				from employees)
;
-- 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?
select avg(salary)
from employees
;
select first_name
	, salary
from employees
where salary < (select avg(salary)
				from employees)
;
-- 부서번호가 110인 직원의 월급와 같은 월급을 받는 모든 직원의 사번, 이름, 월급를 출력하세요
select salary
from employees
where department_id = 110
;
select employee_id
	, first_name
    , salary
from employees
where salary in (select salary
					from employees
					where department_id = 110)
;
-- 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요
select department_id
	, max(salary)
from employees
group by department_id
;
select first_name
    , department_id
 	, salary
from employees
where (department_id, salary) in (select department_id
										, max(salary) salary
									from employees
									group by department_id)
order by department_id
;
-- 부서번호가 110인 직원의 월급 중 
-- 가장 작은 월급 보다 월급이 많은 모든 직원의 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
select salary
from employees
where department_id = 110
;
select first_name
	, salary
from employees
where salary > any (select salary
					from employees
					where department_id = 110)
order by salary 
;
-- 부서번호가 110인 직원의 월급 중 
-- 가장 많은 월급 보다 월급이 많은 모든 직원의 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
select first_name
	, salary
from employees
where salary > all (select salary
					from employees
					where department_id = 110)
order by salary 
;
-- 조건절에서 비교 vs 테이블에서 조인
-- 각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
select department_id
	, max(salary)
from employees e
group by department_id
;
select e.department_id
	, e.employee_id
    , first_name
    , e.salary
from employees e
	, (select department_id
			, max(salary) salary
		from employees e
		group by department_id) m
where e.department_id = m.department_id
and e.salary = m.salary
order by department_id
;
/*******************************************
* SubQuery
*******************************************/
-- 직원관리 페이지
-- 사번이 작은 직원이 위쪽에 출력(요구사항)
-- -->자동으로 정렬되더라도 꼭 order by절로 정렬
-- (0,5) --> 첫번째부터 5개
-- (5,5) --> 여섯번째부터 5개
-- (10,5) --> 열한번째부터 5개
select employee_id
	, first_name
    , salary
from employees
order by employee_id
limit 0, 10			-- 첫번째부터 10개
;
select employee_id
	, first_name
    , salary
from employees
order by employee_id
limit 10 offset 0	-- 첫번째부터 10개
;
-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
select first_name
	, salary
    , hire_date
from employees
where hire_date like '2007%'
-- and date_format(hire_date, '%Y') = '2007'
-- and hire_date between '2007-01-01' and '2007-12-31'
-- and hire_date >= '2007-01-01'
-- and hire_date < '2008-01-01'
order by salary desc
limit 2 , 5 
;
-- 부서번호가 100인 직원중 월급을 가장 많이 받은 직원의 이름, 급여, 부서번호를 출력하세요
select first_name
	, salary
    , department_id
from employees
where (department_id,salary) in (select department_id
										, max(salary)
									from employees
									where department_id = '100')
;
-- limit로 줄세워서 1번만 가져오기
select first_name
	, salary
    , department_id
from employees
where department_id = '100'
order by salary desc
-- limit 0, 1 

-- max()는 한번만 수행함, order by는 비교해서 줄을 세워야 함
