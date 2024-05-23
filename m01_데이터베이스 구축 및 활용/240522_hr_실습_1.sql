--[실습]
--1) 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.
--2) 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요.

-- TABLE COUNTRIES
SELECT * FROM COUNTRIES;
-- 인사이트 : 국가 단위 지사간 성과지표 비교에 활용.
 
-- TABLE DEPARTMENTS
SELECT * FROM DEPARTMENTS;
-- 인사이트 : 사내인사관리에 활용가능. 
--          부서ID,부서명,관리자ID 활용하여 사내부서 조직도 확인 + 지역ID 분류 통하여 지역별 성과지표 비교에 활용가능

--NO1. 사내부서 조직도 확인
SELECT 
    DEPARTMENT_NAME AS "부서명",
    MANAGER_ID AS "관리자ID",
    LOCATION_ID AS "위치"
FROM 
    DEPARTMENTS;
        
-- 개선방향 : 부서별 구성 인원수, 분기매출을 추가하여 부서별 성과지표 비교에 활용. "Total_members", "Quarter_Sales"
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID, Total_members, Quarter_Sales)
VALUES (10, 'Administration', 200, 1700, 50, 1000000);
--NO1. 지역별 성과지표 비교
SELECT 
    D.DEPARTMENT_NAME AS "부서명",
    L.CITY AS "도시",
    D.Quarter_Sales AS "분기매출액"
FROM 
    DEPARTMENTS D
JOIN 
    LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE 
    D.DEPARTMENT_NAME = 'Administration';

-- TABLE EMPLOYEES
SELECT * FROM EMPLOYEES;
-- 인사이트 : 직원개인정보, 입사일자, 급여, 부서, 부서관리자 확인등 전반적인 인사정보 관리. 인사관리 핵심 테이블

--NO1. 전직원 개인정보 확인
SELECT EMPLOYEE_ID AS 사번,
       FIRST_NAME || ' ' || LAST_NAME AS 이름,
       EMAIL AS 이메일,
       PHONE_NUMBER AS 연락처,
       HIRE_DATE AS 입사일자,
       trunc((sysdate-hire_date)/365) aS 근속연차,
       CASE
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -100) THEN '인턴'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -200) THEN '사원'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -250) THEN '주임'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -280) THEN '선임'
           ELSE '책임'
       END AS 직급,
       decode(department_id,
            10, '관리부',
            20, '마케팅부',
            30, '구매부',
            40, '인사부',
            50, '물류',
            60, '프로그래머',
            70, '홍보부',
            80, '영업부',
            90, '경영지원실',
            100, '재무부',
            110, '회계부',
            170, '제조','기타') 부서
FROM EMPLOYEES;

--NO2. 직원 개인정보 검색
SELECT EMPLOYEE_ID AS 사번,
       FIRST_NAME || ' ' || LAST_NAME AS 이름,
       EMAIL AS 이메일,
       PHONE_NUMBER AS 연락처,
       HIRE_DATE AS 입사일자,
       trunc((sysdate-hire_date)/365) aS 근속연차,
       DEPARTMENT_ID AS 부서명,
       CASE
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -100) THEN '인턴'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -200) THEN '사원'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -250) THEN '주임'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -280) THEN '선임'
           ELSE '책임'
       END AS 직급
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 101;


--NO3. 전직원 급여, 인센티브 확인, 연봉협상 대상여부 구분.
SELECT 
    EMPLOYEE_ID, 
    FIRST_NAME || ' ' || LAST_NAME AS 이름, 
    SALARY AS 급여, 
    NVL(TO_CHAR(COMMISSION_PCT), '없음') AS 상여금,
CASE WHEN salary >= 20000 then '비대상'
     WHEN salary < 20000 and salary > 10000 then '조율필요'
     ELSE '대상'
END AS "급여 협상대상자"
FROM employees;


-- TABLE JOBS
SELECT * FROM JOBS;
-- 인사이트 : 직업 분야별 소득비교, 직업내 소득격차 비교 활용, 비전과 자기계발 목표 수립에 근거자료로 활용.
-- 개선방향 : 해당 분야에 대한 선호도, 현재 해당 직종 종사자 숫자 추가하여 방향성 제시 및 도움*지원 가능. -- 학원등에 제공.

-- TABLE JOB_HISTORY
SELECT * FROM JOB_HISTORY;
-- 인사이트 : 개인 업무이력 확인 및 전배이력을 확인가능.
-- 개선방향 : 개인 KPI 목표 및 성과달성 목표기간 추가하여 개인성과지표에 활용가능. (직원능력평가 활용)
-- 목표 : 개인적 목표 X, 업무 연관도, 난이도에 따라 차등 설정. (언어, 자격증, 근태, 커뮤니케이션등 다방면)
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID,Goal_In) values (102,to_date('01/01/13','RR/MM/DD'),
to_date('06/07/24','RR/MM/DD'),'IT_PROG',60,'JLPT N1 자격증 취득');


-- TABLE LOCATIONS
SELECT * FROM LOCATIONS;
-- 인사이트 : 직원 거주지역 정보 관리.
-- 활용방안 : 개인정보에 추가하여 비상연락망, 동보시스템에 활용. (지역에 따른 재해 발생시 긴급문자 발송등) 

-- TABLE REGIONS
SELECT * FROM REGIONS;
-- 활용방안 : 대륙 단위 성과지표 비교에 활용가능. (미국, 아시아, 유럽지사..)




-- TEACH
--부서별 급여 현황
--테이블생성, 부서별 급여와 총 급여를 확인 할 수 있음.
--(급여의 합 평균 최솟값 최댓값, 총 직원수, 급여전체총합, 직원평균급여, 부서평균급여)
--table 만들기 부서별 급여를 대략적으로 보기
--사용할 테이블 확인
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--부서 목록 확인
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- 부서 목록 department_id : 10,20,30,40,50,60,70,80,90,100,110 그 외 나머지(120~200등..)는 없고 null 값이 있음.
--department_id 가 null 인 사람은 모두 job_id 에 맞는 department_id 를 부여해주려고함(데이터 무결성)
--1. department_id 가 null 값인 사람 찾기
select *
from employees
where department_id IS NULL;
--한명 밖에 없음. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id 가 SA_REP 인 department_id 찾기 (직업에 맞는 부서 찾기)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP 의 department_id 는 80

--3. 수정 전 savepoint 생성
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. 제약조건primary key 인 employee_id 로 찾아서 derpartment_id 를 80으로 수정
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint로 가기
--commit;
--수정끝

--팀구성 및 년차별 샐러리
--각 부서마다 팀원은 몇명이고 어떤 포지션들이 있고 구성은 어떻게 되는지
--ROLLUP은 다차원적인 집계 결과를 도출 : 사용 각 부서 및 직무별 직원 수를 집계
SELECT E.department_id, D.department_name, nvl(E.job_id, 'Total') job_id, count(*) 직원수
FROM employees E
LEFT OUTER JOIN departments D on E.department_id = D.department_id
GROUP BY ROLLUP((E.department_id, D.department_name), E.job_id)
ORDER BY E.department_id;
