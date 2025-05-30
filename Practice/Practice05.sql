-- 문제1. 
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.(45건)
select first_name
	, manager_id
    , commission_pct
    , salary
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000
;
-- 문제2.  
-- 각 부서별로 최고의 월급을 받는 사원의 
-- 직원번호(employee_id), 이름(first_name), 월급 (salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요
-- 조건절비교 방법으로 작성하세요 -월급의 내림차순으로 정렬하세요 -입사일은 2001-01-13 토요일 형식으로 출력합니다. -전화번호는 515-123-4567 형식으로 출력합니다. (11건) 
select employee_id
	, first_name
	, salary
	, concat(hire_date,' ' ,case dayofweek(hire_date)
							   when '1' then '일요일'
							   when '2' then '월요일'
							   when '3' then '화요일'
							   when '4' then '수요일'
							   when '5' then '목요일'
							   when '6' then '금요일'
							   when '7' then '토요일' end ) hire_date
	, replace(phone_number,'.','-') phone_number
	, department_id
from employees
where (department_id, salary) in (select department_id
										, max(salary)
									from employees
									group by department_id)
order by salary desc
;
-- 문제3 
-- 매니저별 담당직원들의 평균월급 최소월급 최대월급을 알아보려고 한다.
-- 통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다. -매니저별 평균월급이 5000이상만 출력합니다. -매니저별 평균월급의 내림차순으로 출력합니다. -매니저별 평균월급은 소수점 첫째자리에서 반올림 합니다.
-- 출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균월급, 매니저별최소월급, 매니저별최대월급 입니다. (9건) 
select manager_id
	, round(avg(salary),0)  avg
	, min(salary) min
	, max(salary) max
from employees
where hire_date >= '2005-01-01'
group by manager_id
having avg > 5000
order by avg desc
;	
-- 문제4. 
-- 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요. 
-- 부서가 없는 직원(Kimberely)은 표시 합니다. 매니저가 없는 직원(Steven) 은 출력하지 않습니다. (106명)
select e.employee_id
	, e.first_name
    , d.department_name
    , em.employee_id m_id
	, em.first_name m_name
from employees e
left join departments d
		on e.department_id = d.department_id
left join employees em
		on e.manager_id = em.employee_id
where e.manager_id is not null
;
-- 문제5. 
-- 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 사번, 이름, 부서명, 월급, 입사일을 입사일 순서로 출력하세요 
select employee_id
	, first_name
    , d.department_name
    , salary
    , hire_date
from employees e
	, departments d
where e.department_id = d.department_id
and hire_Date >= '2005-01-01'
order by hire_Date
limit 10, 10
;
-- 문제6. 
-- 가장 늦게 입사한 직원의 이름(first_name last_name)과 월급(salary)과 근무하는 부서 이름(department_name)은? 
select concat(first_name,' ', last_name) name
	, salary
    , d.department_name
from employees e
	, departments d
where e.department_id = d.department_id
and e.hire_date = (select max(hire_date)
					from employees)
;
-- 문제7. 
-- 평균월급(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 월급(salary)을 조회하시오. 
select em.employee_id
	, em.first_name
    , em.last_name
    , j.job_title
    , em.salary
from employees em
	, (select department_id
			, avg(salary) avg
		from employees
		group by department_id
		order by avg desc
		limit 0, 1) max
	, jobs j
where em.department_id = max.department_id
and em.job_id = j.job_id
;
-- 문제8. 
-- 평균 월급(salary)이 가장 높은 부서명과 월급은? (limt사용하지 말고 그룹함수 사용할 것) 
select d.department_name
	, b.sal
from (select d.department_id, avg(salary) sal
		from employees e
			, departments d
		where e.department_id = d.department_id
		group by d.department_id) b
	, departments d
where b.sal = (select max(a.avg) m
				from (select department_id
							, avg(salary) avg
						from employees
						group by department_id) a)
and d.department_id = b.department_id
;
-- 문제9. 
-- 평균 월급(salary)이 가장 높은 지역과 평균월급은?( limt사용하지 말고 그룹함수 사용할 것)
select rgn.region_name
	, rg.sal
from (select r.region_id, avg(e.salary) sal
		from regions r
			, countries c
			, locations l
			, departments d
			, employees e
		where r.region_id = c.region_id
		and c.country_id = l.country_id
		and l.location_id = d.location_id
		and d.department_id = e.department_id
		group by r.region_id) rg
	, regions rgn
where rg.sal = (select max(a.avg) m
				from (select r.region_id
							, avg(e.salary) avg
						from regions r
							, countries c
							, locations l
							, departments d
							, employees e
						where r.region_id = c.region_id
						and c.country_id = l.country_id
						and l.location_id = d.location_id
						and d.department_id = e.department_id
						group by r.region_id) a )
and rgn.region_id = rg.region_id
;
-- 문제10. 
-- 평균 월급(salary)이 가장 높은 업무와 평균월급은? (limt사용하지 말고 그룹함수 사용할 것)
select jb.job_title
	, job.sal
from (select e.job_id, avg(salary) sal
		from jobs j
			, employees e
		where j.job_id = e.job_id
		group by job_id) job
	, jobs jb
where job.sal = (select max(a.avg) m
				from(select e.job_id
							, avg(salary) avg
					from jobs j
						, employees e
					where j.job_id = e.job_id
					group by job_id) a)
and job.job_id = jb.job_id
;

