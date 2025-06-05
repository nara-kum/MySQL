/*******************************************
*join
*******************************************/
-- 기본
-- 직원의 이름과 직원이 속한 부서명을 출력하세요
-- Steven	90		90	Executive
-- 카디젼 프로덕트 모든 경우의 수의 갯수가 된다
-- 107*27 = 2889건
select first_name, department_name
from employees, departments
;
-- where절을 사용한다
select first_name, department_name
from employees, departments
where employees.department_id = departments.department_id
;

/*******************************************
*inner join(equi join) - null제외
*******************************************/
-- 직원의 이름과 직원이 속한 부서명을 출력하세요
select *
from employees inner join departments
on employees.department_id = departments.department_id
;
-- inner join(equi join) 정식표현
select e.first_name
	, e.department_id
	, d.department_id
    , d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
;
-- inner join(equi join) where절 표현
select e.first_name
	, e.department_id
	, d.department_id
    , d.department_name
from employees e
	, departments d
where e.department_id = d.department_id
;

select e.first_name
	, d.department_name
    , l.city
from employees e
	, departments d
    , locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
;

select e.first_name
	,  d.department_name
    ,  l.city
    ,  l.location_id
from employees e
inner join departments d
		on e.department_id = d.department_id
inner join locations l
		on d.location_id = l.location_id
;
-- 모든 직원이름, 부서이름, 업무명 을 출력하세요   
select e.first_name
	, d.department_name
    , j.job_title
from employees e
	, departments d
    , jobs j
where e.department_id = d.department_id    
and e.job_id = j.job_id
;
select e.first_name
	, d.department_name
    , j.job_title
from employees e
inner join departments d
		on e.department_id = d.department_id    
inner join jobs j
		on e.job_id = j.job_id
;
/*******************************************
*left outer join
*******************************************/
-- 모든 직원의 부서번호, 이름,  부서명를 출력하세요
-- 부서번호가 없는 직원도 표시
-- 왼쪽 테이블을 기준, 기분테이블의 정보는 다 보여줌
-- (Kimberely가 결과에 있어야 함: 소속부서가 없는직원)
select *
from employees e
left join departments d
		on e.department_id = d.department_id
;
/*******************************************
*right outer join
*******************************************/
-- 모든 직원의 부서번호, 이름,  부서번호를 출력하세요
-- 직원이 없는 부서도 표시
select e.employee_id
	, e.first_name
    , d.department_name
from employees e
right join departments d
		on e.department_id = d.department_id
;
/*******************************************
*right outer join --> left outer join
*******************************************/
select e.employee_id
	, e.first_name
    , d.department_name
from departments d
left join employees e
		on e.department_id = d.department_id
;
/*******************************************
*full outer join (union)
*******************************************/
(-- 왼쪽기준
select e.employee_id
	, e.first_name
	, d.department_id
    , d.department_name
from employees e
left join departments d
		on e.department_id = d.department_id
)
union
(-- 오른쪽기준
select e.employee_id
	, e.first_name
	, d.department_id
    , d.department_name
from employees e
right join departments d
		on e.department_id = d.department_id
)
;
select first_name, department_id, count(first_name)
from employees
group by first_name, department_id
having count(first_name) > 1
;
-- 본인(이름, 전화번호, 이메일) 팀장(이름, 전화번호, 이메일)
select e.employee_id
	, e.first_name
	, m.employee_id m_id
	, m.first_name m_name
from employees e
left join employees m
		on m.employee_id = e.manager_id
;

# 조인 연습(equi join, inner join 두가지로 풀어볼것)
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명
   
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명
   
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명, 지역아이디, 지역명

