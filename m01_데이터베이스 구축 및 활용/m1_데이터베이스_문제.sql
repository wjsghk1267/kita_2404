--교과목명 : 데이터베이스 구축 및 활용
--
--- 평가일 : 24.05.24
--- 성명 : 김홍준
--- 점수 :

--※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
--Q1. EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
SELECT e.first_name||' '||e.last_name,e.salary, e.salary*1.1
FROM employees e;

--Q2. EMPLOYEES 테이블에서 2005년 상반기에 입사한 사람들만 출력	
SELECT employee_id, hire_date
FROM employees
WHERE hire_date > '05/01/01' AND hire_date < '05/07/01'
ORDER BY hire_date;

--Q3. EMPLOYEES 테이블에서 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
SELECT employee_id, job_id
FROM employees 
WHERE job_id = 'SA_MAN' or job_id = 'IT_PROG' or job_id = 'ST_MAN';
-- WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN')
   
--Q4. EMPLOYEES 테이블에서 manager_id 가 101에서 103인 사람만 출력
SELECT employee_id, manager_id 
FROM employees
WHERE manager_id BETWEEN 101 and 103;


--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
SELECT LAST_NAME, HIRE_DATE, next_day(ADD_months(HIRE_DATE, 6),'월') as "입사일의 6개월 후 첫 번째 월요일"
FROM employees;


--Q6. EMPLOYEES 테이블에서 EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, trunc((SYSDATE-HIRE_DATE)/30) W_MONTH
FROM employees
ORDER BY hire_date desc;
-- months_between(sysdate, hire_date)), order by w_month desc;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, trunc((SYSDATE-HIRE_DATE)/365) W_YEAR
FROM employees
ORDER BY hire_date desc;
--order by w_year desc;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
SELECT EMPLOYEE_ID, LAST_NAME
FROM employees
WHERE mod(employee_id, 2) = 1;


--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
SELECT EMPLOYEE_ID, LAST_NAME, salary, round(SALARY/12,2) M_SALARY
FROM employees;
select * from employees;


--Q10. employees 테이블에서 salary가 10000원 이상인 직원만을 포함하는 뷰 special_employee를 생성하는 SQL 명령문을 작성하시오.
DROP VIEW special_employee;
CREATE VIEW special_employee AS
SELECT employee_id, first_name||' '||last_name NAME, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary;
SELECT * FROM special_employee;


--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;


--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
SELECT employee_id, department_id, '신입' Position 
FROM employees
where department_id IS NULL;


--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
SELECT e.employee_id 사번, e.first_name 이름, j.job_id 업무, j.job_title 업무명
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.employee_id = 120;

SELECT e.employee_id 사번, e.first_name 성, e.last_name 이름, e.job_id 업무, j.job_title 업무명
FROM employees e, jobs j
WHERE e.job_id = j.job_id AND e.employee_id = 120;


--Q14. HR EMPLOYEES 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
SELECT first_name||' '||last_name NAME
FROM employees;


--Q15. HR EMPLOYEES 테이블에서 근속기간이 10년 이상인 직원을 포함하는 뷰를 생성하세요.
DROP VIEW employee_view;
CREATE VIEW employee_view AS
SELECT e.EMPLOYEE_ID, e.LAST_NAME, trunc((SYSDATE-HIRE_DATE)/365) W_YEAR
FROM employees e
WHERE trunc((SYSDATE-HIRE_DATE)/365) > 10
ORDER BY W_YEAR;
SELECT * FROM employee_view;


--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
SELECT * FROM employees
WHERE job_id like '%\_A%' escape '\';


--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
SELECT * FROM employees
ORDER BY SALARY, LAST_NAME ASC;
   
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
SELECT e.last_name, d.department_name 부서명
FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE last_name = 'Seo';


--Q19. JOB ID 별 몇년차는 얼마 받는지 각 년차별로 샐러리 평균을 구하세요.
SELECT EMPLOYEE_ID, first_name||' '||last_name 이름, JOB_ID, trunc((SYSDATE-HIRE_DATE)/365) 근속연차, AVG(SALARY) 평균연봉
FROM employees
GROUP BY EMPLOYEE_ID, first_name||' '||last_name, JOB_ID, trunc((SYSDATE-HIRE_DATE)/365)
ORDER BY JOB_ID;


--Q20. HR EMPLOYEES 테이블에서 salary가 20000 이상이면 'a', 10000과 20000 미만 사이면 'b', 그 이하면 'c'로 표시하는 쿼리를 
--작성하시오.(case)
SELECT first_name||' '||last_name 이름, salary 급여,
    CASE WHEN salary > 20000 THEN 'a'
         WHEN salary BETWEEN 10000 AND 20000 THEN 'b'
    ELSE 'c' 
    END 소득수준
FROM employees;


--Q21. 학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.(20점)
--(실습 - 2인 1조)
--학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.
DROP TABLE SCHOOL;
DROP TABLE CLASS;
DROP TABLE PROFESSOR;
DROP TABLE STUDENTS;
DROP TABLE GRADE_1;
DROP TABLE GRADE_2;
--SCHOOL 테이블 생성
CREATE TABLE SCHOOL (
    sc_id       NUMBER PRIMARY KEY,
    sc_name     VARCHAR2(50) NOT NULL,
    sc_phone    VARCHAR2(50) DEFAULT '02-XXX-XXXX',
    location    VARCHAR2(100)
);
--CLASS 테이블 생성
CREATE TABLE CLASS (
    sc_id       NUMBER NOT NULL,
    cls_id      NUMBER PRIMARY KEY,
    cls_name    VARCHAR(20) NOT NULL,
    cls_major   VARCHAR2(50) NOT NULL,
    cls_phone   VARCHAR2(50) DEFAULT '02-XXX-XXXX',
    cls_loc     VARCHAR2(20) NOT NULL,
    FOREIGN KEY(sc_id) REFERENCES SCHOOL(sc_id) ON DELETE CASCADE
);
--PROFESSOR 테이블 생성
CREATE TABLE PROFESSOR (
    cls_id      NUMBER NOT NULL,
    pro_id      NUMBER(7) PRIMARY KEY,
    pro_name    VARCHAR2(50) NOT NULL,
    pro_phone   VARCHAR2(50) NOT NULL,
    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE
);
--STUDENTS 테이블 생성 
CREATE TABLE STUDENTS (
    cls_id      NUMBER NOT NULL,
    pro_id      NUMBER(7) NOT NULL,
    std_id      NUMBER(7) PRIMARY KEY,
    name        VARCHAR2(50) NOT NULL,
    sex         CHAR(6) DEFAULT '남자' CHECK(sex IN ('남자', '여자')),
    age         NUMBER NOT NULL,
    height      NUMBER(4,1),
    weight      NUMBER(4,1),
    phone       VARCHAR2(20) DEFAULT '010-xxxx-xxxx',
    enrollment  DATE,
    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE,
    FOREIGN KEY(pro_id) REFERENCES PROFESSOR(pro_id) ON DELETE CASCADE
);

--2023년 1학기 성적기록부
CREATE TABLE GRADE_1 (
    std_id       NUMBER(7) NOT NULL,
    name        VARCHAR2(50),
    math        NUMBER DEFAULT 0,
    english     NUMBER DEFAULT 0,
    science     NUMBER DEFAULT 0,
    music       NUMBER DEFAULT 0,
    social      NUMBER DEFAULT 0,
    FOREIGN KEY (std_id) REFERENCES students(std_id) ON DELETE CASCADE
);
--2023년 2학기 성적기록부
CREATE TABLE GRADE_2 (
    std_id       NUMBER(7) NOT NULL,
    name        VARCHAR2(50),
    math        NUMBER DEFAULT 0,
    english     NUMBER DEFAULT 0,
    science     NUMBER DEFAULT 0,
    music       NUMBER DEFAULT 0,
    social       NUMBER DEFAULT 0,
    FOREIGN KEY (std_id) REFERENCES students(std_id) ON DELETE CASCADE
);
--테이블 데이터타입 확인
DESC STUDENTS;
--SCHOOL 테이블 데이터
INSERT INTO SCHOOL VALUES (1, '서울대학교', '02-880-5114','서울특별시 관악구 관악로 1');
--CLASS 테이블 데이터
INSERT INTO CLASS VALUES (1, 1, '1-A', '수학과', '02-880-6001', '301호');
INSERT INTO CLASS VALUES (1, 2, '1-B', '수학과', '02-880-6002', '302호');
INSERT INTO CLASS VALUES (1, 3, '2-A', '수학과', '02-880-6003', '303호');
INSERT INTO CLASS VALUES (1, 4, '2-B', '수학과', '02-880-6004', '304호');
INSERT INTO CLASS VALUES (1, 5, '3-A', '수학과', '02-880-6005', '305호');
INSERT INTO CLASS VALUES (1, 6, '3-B', '수학과', '02-880-6006', '306호');
INSERT INTO CLASS VALUES (1, 7, '4-A', '수학과', '02-880-6007', '307호');
INSERT INTO CLASS VALUES (1, 8, '4-B', '수학과', '02-880-6008', '308호');
INSERT INTO CLASS VALUES (1, 9, '1-A', '컴퓨터공학과', '02-880-6009', '309호');
INSERT INTO CLASS VALUES (1, 10, '1-B', '컴퓨터공학과', '02-880-60010', '310호');
INSERT INTO CLASS VALUES (1, 11, '2-A', '컴퓨터공학과', '02-880-6011', '311호');
INSERT INTO CLASS VALUES (1, 12, '2-B', '컴퓨터공학과', '02-880-6012', '312호');
INSERT INTO CLASS VALUES (1, 13, '3-A', '컴퓨터공학과', '02-880-6013', '313호');
INSERT INTO CLASS VALUES (1, 14, '3-B', '컴퓨터공학과', '02-880-6014', '314호');
INSERT INTO CLASS VALUES (1, 15, '4-A', '컴퓨터공학과', '02-880-6015', '315호');
INSERT INTO CLASS VALUES (1, 16, '4-B', '컴퓨터공학과', '02-880-6016', '316호');

--PROFESSOR 테이블 데이터
INSERT INTO PROFESSOR VALUES (1, 1240301, '김수현', '010-2940-9985');
INSERT INTO PROFESSOR VALUES (2, 1240302, '수지', '010-5487-4566');
INSERT INTO PROFESSOR VALUES (3, 1240303, '강세훈', '010-5673-0166');
INSERT INTO PROFESSOR VALUES (4, 1240304, '정승효', '010-4489-5074');
INSERT INTO PROFESSOR VALUES (5, 1240305, '박민지', '010-7731-9246');
INSERT INTO PROFESSOR VALUES (6, 1240306, '이재현', '010-1692-8035');
INSERT INTO PROFESSOR VALUES (7, 1240307, '최지훈', '010-3126-7325');
INSERT INTO PROFESSOR VALUES (8, 1240308, '한영희', '010-8462-1853');
INSERT INTO PROFESSOR VALUES (9, 1240309, '이지수', '010-9085-6234');
INSERT INTO PROFESSOR VALUES (10, 1240310, '신영수', '010-7405-6857');
INSERT INTO PROFESSOR VALUES (11, 1240311, '김지민', '010-6317-2934');
INSERT INTO PROFESSOR VALUES (12, 1240312, '이준호', '010-4025-6708');
INSERT INTO PROFESSOR VALUES (13, 1240313, '김영희', '010-2875-3496');
INSERT INTO PROFESSOR VALUES (14, 1240314, '장현우', '010-5918-7264');
INSERT INTO PROFESSOR VALUES (15, 1240315, '박지영', '010-8352-1496');
INSERT INTO PROFESSOR VALUES (16, 1240316, '김태희', '010-1094-5685');

--STUDENTS 테이블 데이터 입력
INSERT INTO STUDENTS VALUES (1, 1240301, 2303001, '손경수', '남자', 21, 175.5, 68.2, '010-1234-5678', TO_DATE('2023-03-15', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303002, '홍길동', '남자', 22, 180.0, 70.5, '010-2345-6789', TO_DATE('2023-03-16', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303003, '김철수', '남자', 20, 172.0, 65.3, '010-3456-7890', TO_DATE('2023-03-17', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303004, '이영희', '여자', 21, 165.8, 55.9, '010-4567-8901', TO_DATE('2023-03-18', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303005, '박민지', '여자', 20, 167.5, 58.2, '010-5678-9012', TO_DATE('2023-03-19', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303006, '최지수', '여자', 22, 163.0, 50.6, '010-6789-0123', TO_DATE('2023-03-20', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303007, '강민호', '남자', 23, 178.3, 72.1, '010-7890-1234', TO_DATE('2023-03-21', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303008, '정수진', '여자', 20, 170.2, 60.5, '010-8901-2345', TO_DATE('2023-03-22', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303009, '이지은', '여자', 21, 166.7, 54.8, '010-9012-3456', TO_DATE('2023-03-23', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303010, '김민아', '여자', 22, 172.5, 63.4, '010-0123-4567', TO_DATE('2023-03-24', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303011, '박준호', '남자', 20, 177.8, 71.2, '010-1234-5678', TO_DATE('2023-03-25', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303012, '이수현', '여자', 21, 168.5, 57.3, '010-2345-6789', TO_DATE('2023-03-26', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303013, '최민서', '여자', 23, 164.0, 49.7, '010-3456-7890', TO_DATE('2023-03-27', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303014, '김지혜', '여자', 20, 169.2, 56.8, '010-4567-8901', TO_DATE('2023-03-28', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303015, '박은비', '여자', 21, 170.8, 59.2, '010-5678-9012', TO_DATE('2023-03-29', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303016, '이준서', '남자', 22, 176.3, 70.4, '010-6789-0123', TO_DATE('2023-03-30', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303017, '최지원', '여자', 20, 168.7, 58.1, '010-7890-1234', TO_DATE('2023-03-31', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303018, '김민수', '남자', 21, 180.5, 75.6, '010-8901-2345', TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303019, '이지현', '여자', 22, 173.6, 62.5, '010-9012-3456', TO_DATE('2023-04-02', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303020, '박소연', '여자', 20, 165.4, 53.9, '010-0123-4567', TO_DATE('2023-04-03', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303021, '최준혁', '남자', 21, 179.2, 73.0, '010-1234-5678', TO_DATE('2023-04-04', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303022, '김지수', '여자', 22, 170.9, 61.7, '010-2345-6789', TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303023, '이민호', '남자', 20, 175.0, 69.8, '010-3456-7890', TO_DATE('2023-04-06', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303024, '박지은', '여자', 21, 166.3, 55.6, '010-4567-8901', TO_DATE('2023-04-07', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303025, '최서윤', '여자', 22, 168.0, 57.2, '010-5678-9012', TO_DATE('2023-04-08', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303026, '김민지', '여자', 20, 171.5, 60.3, '010-6789-0123', TO_DATE('2023-04-09', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303027, '이준혁', '남자', 21, 177.4, 71.8, '010-7890-1234', TO_DATE('2023-04-10', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303028, '박지현', '여자', 22, 169.8, 57.5, '010-8901-2345', TO_DATE('2023-04-11', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303029, '최지민', '여자', 20, 165.0, 52.8, '010-9012-3456', TO_DATE('2023-04-12', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303030, '김수현', '남자', 21, 174.2, 67.1, '010-0123-4567', TO_DATE('2023-04-13', 'YYYY-MM-DD'));

insert into GRADE_1 values(2303001, '손경수', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_1 values(2303002, '홍길동', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_1 values(2303003, '김철수', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_1 values(2303004, '이영희', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_1 values(2303005, '박민지', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_1 values(2303006, '최지수', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_1 values(2303007, '강민호', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_1 values(2303008, '정수진', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_1 values(2303009, '이지은', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_1 values(2303010, '김민아', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_1 values(2303011, '박준호', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_1 values(2303012, '이수현', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_1 values(2303013, '최민서', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_1 values(2303014, '김지혜', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_1 values(2303015, '박은비', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_1 values(2303016, '이준서', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_1 values(2303017, '최지원', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_1 values(2303018, '김민수', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_1 values(2303019, '이지현', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(2303020, '박소연', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_1 values(2303021, '최준혁', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_1 values(2303022, '김지수', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_1 values(2303023, '이민호', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(2303024, '박지은', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_1 values(2303025, '최서윤', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_1 values(2303026, '김민지', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_1 values(2303027, '이준혁', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_1 values(2303028, '박지현', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_1 values(2303029, '최지민', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_1 values(2303030, '김수현', 2.9, 3.0, 2.6, 3.1, 2.9);

insert into GRADE_2 values(2303001, '손경수', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_2 values(2303002, '홍길동', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_2 values(2303003, '김철수', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_2 values(2303004, '이영희', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_2 values(2303005, '박민지', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_2 values(2303006, '최지수', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_2 values(2303007, '강민호', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_2 values(2303008, '정수진', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_2 values(2303009, '이지은', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_2 values(2303010, '김민아', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_2 values(2303011, '박준호', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_2 values(2303012, '이수현', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_2 values(2303013, '최민서', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_2 values(2303014, '김지혜', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_2 values(2303015, '박은비', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_2 values(2303016, '이준서', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_2 values(2303017, '최지원', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_2 values(2303018, '김민수', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_2 values(2303019, '이지현', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303020, '박소연', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_2 values(2303021, '최준혁', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_2 values(2303022, '김지수', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_2 values(2303023, '이민호', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303024, '박지은', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_2 values(2303025, '최서윤', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_2 values(2303026, '김민지', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_2 values(2303027, '이준혁', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_2 values(2303028, '박지현', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_2 values(2303029, '최지민', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_2 values(2303030, '김수현', 2.9, 3.0, 2.6, 3.1, 2.9);


SELECT * FROM CLASS;
SELECT * FROM PROFESSOR;
SELECT * FROM STUDENTS;
SELECT * FROM GRADE_1;
SELECT * FROM GRADE_2;


-- NO1. 특정과목 낙제자 조회
SELECT std_id 학번, name 이름, math 수학
FROM GRADE_1
WHERE math = 0.0; -- 해당 과목명 입력


-- NO2. 낙제 과목명 확인
SELECT std_id 학번, name 이름, 
    CASE 
        WHEN math = 0.0 THEN '수학'
        WHEN english = 0.0 THEN '영어'
        WHEN science = 0.0 THEN '과학'
        WHEN music = 0.0 THEN '음악'
        WHEN social = 0.0 THEN '사회'
    END 낙제과목
FROM GRADE_1
WHERE math = 0.0 OR english = 0.0 OR science = 0.0 OR music = 0.0 OR social = 0.0;


-- NO3. 전과목 낙제 포함 조회
SELECT std_id 학번, name 이름, math 수학, english 영어, science 국어, music 과학, social 역사 
FROM GRADE_1
WHERE math = 0.0 or english = 0.0 or science = 0.0 or music = 0.0 or social = 0.0;


-- NO4. 개인 성적 조회
SELECT std_id 학번, name 이름, G1.math 수학, G1.science 과학, G1.english 영어, G1.music 음악, G1.social 사회, 
    (SELECT AVG(G1.math + G1.science + G1.English + G1.music + G1.social)/5 FROM GRADE_1 G2) 평균
FROM GRADE_1 G1
WHERE std_id = 2303001;


-- NO5. 전체 성적 조회
SELECT std_id 학번, name 이름, G1.math 수학, G1.science 과학, G1.english 영어, G1.music 음악, G1.social 사회, 
    (math + english + science + music + social)/5 평균학점 
FROM GRADE_1 G1;


-- NO6. 학기별 장학금 대상자 선별 (상위 2명)
SELECT * FROM(
    SELECT std_id 학번, name 이름, (math + english + science + music + social)/5 평균학점 
    FROM GRADE_1 G1
    WHERE G1.math + english + music + science + social >= (SELECT AVG(G2.math + G2.english + G2.music + G2.science + G2.social) FROM GRADE_1 G2)
    order by 평균학점 DESC)
WHERE rownum < 3;


-- NO7. 학기별 학사경고 여부 조회 (기준 : 전과목 낙제)
SELECT std_id 학번, name 이름, (math + english + music + science + social)/5 취득학점,
    CASE 
        WHEN (math + english + music + science + social) = 0.0 THEN '전과목'
    END 낙제과목
FROM GRADE_1 G1
WHERE math = 0.0 AND english = 0.0 AND music = 0.0 AND science = 0.0 AND social = 0.0;


-- NO8. 1,2학기 연속 낙제 과목 조회
SELECT S.NAME, G1.math as "1학기", G2.math as "2학기"
FROM STUDENTS S
JOIN GRADE_1 G1 ON S.std_id = G1.std_id
JOIN GRADE_2 G2 ON S.std_id = G2.std_id
WHERE G1.math = 0.0 AND G2.math = 0.0;


-- NO9. 입학년도에 따른 졸업연도 확인
SELECT std_id "학번", name "이름", enrollment "입학날짜", TO_CHAR(ADD_MONTHS(enrollment, 3 * 12 + 11), 'YYYY-mm') "졸업연도"
FROM STUDENTS;


-- NO10. 군대 현역 예정자 확인
--BMI 계산기
SELECT std_id "학번", name "이름", height "키", weight "몸무게"
FROM STUDENTS
WHERE sex='남자' and std_id in (
    SELECT std_id 
    from students
    where weight / power(height/100, 2) between 15 and 40);
    

--Q22. 다음 실습과제를 수행하세요.(20점)
-- 1. 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.
-- 2. 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요. 

-----------------------------------------------------------------------------------------------------------
--                       [ 실습 ]

-- * 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.
-- * 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증

-----------------------------------------------------------------------------------------------------------

--KPI NO.1
--COMMISSION_PCT가 있는 직원 중에
--해당 직무의 MIN_SALARY MAX_SALARY 의 평균 중에 어느 정도 구간에 속하는지 (WIDTH_BUCKET)
--상위 10퍼

--KPI NO.2
--(SYSDATE-HIREDATE) 의 평균, 그리고 직무의 (MIN_SALARY MAX_SALARY) 의 평균에 비해 어느정도 높거나 낮은지

--KPI NO.3
--JOB_HISTORY 를 이용하여 BETWEEN ST_DATE AND END_DATE 직원수/ 총 직원수 * 100 으로 이직률을 추출 후 10% 이하인지 확인.


--------------------------------------    CASE 1. 부서 별, 직무 별, 직원 조회

-- 각 부서 이름과 부서 별 직원 조회
SELECT
    D.department_id,
    D.department_name, 
    E.first_name||' '||last_name "Full name"
FROM
    DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E
    ON D.department_id=E.department_id;

-- 각 직무 이름과 직무 별 직원 조회
SELECT
    J.job_id,
    J.job_title, 
    E.employee_id,
    E.first_name||' '||last_name "Full name"
FROM
    JOBS J
LEFT OUTER JOIN EMPLOYEES E
    ON J.job_id=E.job_id;

    

--------------------------------------    CASE 2. 부서 별, 직무 별, 직원 수
SELECT
    D.department_id AS dept_id,
    D.department_name as dept_name,
    COUNT(E.employee_id) AS count
FROM
    DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E 
    ON D.department_id = E.department_id
GROUP BY
    D.department_id, D.department_name
ORDER BY dept_id;

SELECT
    J.job_id,
    J.job_title,
    COUNT(E.employee_id) AS count
FROM
    JOBS J
LEFT OUTER JOIN EMPLOYEES E 
    ON J.job_id = E.job_id
GROUP BY
    J.job_id, J.job_title
ORDER BY job_id;



--------------------------------------    CASE 3. 부서를 할당받지 않은 신입에게 적합한 부서 배정하기

-- department_id 가 null인 직원을 조회할 수 있는 뷰 생성.
DROP VIEW dept_id_null;
CREATE VIEW dept_id_null AS
SELECT *
FROM EMPLOYEES
WHERE department_id IS NULL;


SELECT * FROM dept_id_null;

-- null 값을 바꿔주기 전에 원본 데이터 보존을 위해 SAVEPOINT 설정.
SAVEPOINT before_replace_null;

-- UPDATE 문을 사용하여 job_id 에 맞는 department_id 로 설정
UPDATE EMPLOYEES
SET department_id = (
    SELECT department_id
    FROM JOB_HISTORY
    WHERE job_id in ( SELECT job_id FROM dept_id_null )
)
WHERE department_id IS NULL;

-- 뷰 조회
SELECT * FROM dept_id_null;
-- EMP_ID 170 ~ 180 까지 변경된 테이블 조회
SELECT employee_id, first_name, job_id, department_id 
FROM EMPLOYEES 
WHERE employee_id between 170 and 180
ORDER BY employee_id;

-- 원본 테이블로 다시 롤백해주고 한번 더 뷰랑 테이블 확인해보기
ROLLBACK TO before_replace_null;




--------------------------------------    CASE 4. 지사별 인건비 지출

SELECT  d.department_name AS "부서명", l.city AS 도시, l.location_id AS "지사 No", SUM(e.salary) as "인건비 지출"
FROM departments d
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN employees e ON d.department_id = e.department_id
--WHERE D.location_id = '1700' --지사 No 입력.
GROUP BY d.department_name, l.city, l.location_id; 




--------------------------------------    CASE 5. 부서별 성과 분석
--Employees 테이블과 Departments 테이블을 활용하여 부서별 평균 근속 연수, 평균 급여 등을 분석합니다.

SELECT
    d.department_id,
    d.department_name,
    TRUNC(AVG(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12)) AS avg_tenure_years,
    TRUNC(AVG(e.salary)) AS avg_salary
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
GROUP BY
    d.department_id,
    d.department_name;


---------------------------     KPI NO.1  연차 대비 연봉이 얼마나 높은가를 통하여
---------------------------------         해당 직원이 얼마나 좋은 성과를 보이는가를 평가.


WITH Avg_Job_Stats AS (      -- 직무 별 평균 연차와 평균 연봉을 EMPLOYEES 테이블에서 추출하는 쿼리
    SELECT 
        job_id, 
        AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))) AS avg_tenure, 
        AVG(SALARY) AS avg_salary
    FROM 
        EMPLOYEES
    GROUP BY 
        job_id
),
-- 평균연차와 평균연봉을 JOIN 시켜 비율을 구한 뒤
-- 연봉은 평균에 비해 높을수록 연차는 평균에 비해 낮을수록 좋은 형태로 score 칼럼 저장
Employee_Scores AS (    
    SELECT 
        E.EMPLOYEE_ID,
        E.JOB_ID,
        E.FIRST_NAME || ' ' || E.LAST_NAME AS FULL_NAME,
        TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)) AS tenure,
        E.SALARY,
        (TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)) - AJS.avg_tenure) AS tenure_diff,
        (E.SALARY - AJS.avg_salary) AS salary_diff,        
        ((E.SALARY - AJS.avg_salary) / AJS.avg_salary - 
         (TRUNC(MONTHS_BETWEEN(SYSDATE, E.HIRE_DATE)) - AJS.avg_tenure) / AJS.avg_tenure) AS score
    FROM 
        EMPLOYEES E
    JOIN 
        Avg_Job_Stats AJS ON E.JOB_ID = AJS.JOB_ID
),
-- 각 직무 별 상위 10%를 도출하기 위해 percent_rank() 함수 사용
Ranked_Employees AS (
    SELECT 
        ES.*,
        PERCENT_RANK() OVER (PARTITION BY ES.JOB_ID ORDER BY ES.score DESC) AS percentile_rank
    FROM 
        Employee_Scores ES
)
SELECT 
    EMPLOYEE_ID,
    JOB_ID,
    FULL_NAME,
    trunc(tenure/12) AS "연차(년)",
    TO_CHAR(SALARY, 'L999,999') AS "연봉",
    round(score, 2) AS "점수",
    round(percentile_rank, 2) AS "상위"
FROM 
    Ranked_Employees
WHERE 
    percentile_rank <= 0.1;
