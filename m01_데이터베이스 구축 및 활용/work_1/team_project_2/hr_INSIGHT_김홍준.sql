--[실습]
--1) 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.

--NO1. 사내부서 조직도 확인
-- 인사이트 : 사내인사관리에 활용가능. 
--          부서ID,부서명,관리자ID 활용하여 사내부서 조직도 확인 + 지역ID 분류 통하여 지역별 성과지표 비교에 활용가능
SELECT DEPARTMENT_NAME AS "부서명", MANAGER_ID AS "관리자ID", LOCATION_ID AS "위치"
FROM DEPARTMENTS;

--NO2-1. 지사별 인건비 지출 비교
--인사이트 : 부서,도시,대륙 지사별 인건비 도출, 비교를 통해 인건비 예산, 목표 설정하여 비용절감 가능. 
SELECT  d.department_name AS "부서명", l.city AS 도시, l.location_id AS "지사 No", SUM(e.salary) as "인건비 지출"
FROM departments d
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN employees e ON d.department_id = e.department_id
WHERE D.location_id = '1700' --지사 No 입력.
GROUP BY d.department_name, l.city, l.location_id; 


--NO2-2. 도시별 인건비 지출 비교
SELECT l.city AS 도시, l.country_id AS 국가코드, l.location_id AS "지사 No", SUM(e.salary) as "인건비 지출"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE l.country_id = 'US' --country code 입력.
GROUP BY l.city, l.country_id, l.location_id;


--NO2-3. 나라별 인건비 지출 비교
SELECT c.country_name AS 국가, c.country_id AS 국가코드, r.region_name AS 대륙No, SUM(e.salary) as "인건비 지출"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON l.country_id = c.country_id
INNER JOIN regions r ON c.region_id = r.region_id
WHERE c.country_id = 'US' --country code 입력.
GROUP BY c.country_name, c.country_id, r.region_name;


--NO3-1. 전직원 개인정보 확인
-- 인사이트 : 직원개인정보, 입사일자, 급여, 부서, 부서관리자 확인등 전반적인 인사정보 관리.
--           인적자원 구성 및 배분 상태 파악 및 효율 분석시 활용가능 
SELECT EMPLOYEE_ID AS 사번, FIRST_NAME || ' ' || LAST_NAME AS 이름, EMAIL AS 이메일, PHONE_NUMBER AS 연락처, HIRE_DATE AS 입사일자,
       trunc((sysdate-hire_date)/365) AS 근속연차,
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

--NO3-2. 직원 개인정보 검색.
SELECT EMPLOYEE_ID AS 사번, FIRST_NAME || ' ' || LAST_NAME AS 이름, EMAIL AS 이메일,PHONE_NUMBER AS 연락처,HIRE_DATE AS 입사일자,
       trunc((sysdate-hire_date)/365) aS 근속연차, DEPARTMENT_ID AS 부서명,
       CASE
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -100) THEN '인턴'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -200) THEN '사원'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -250) THEN '주임'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -280) THEN '선임'
           ELSE '책임'
       END AS 직급
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 101;


--NO4. 전직원 급여, 인센티브 수령여부 확인, 연봉 인상,협상 대상자 여부 확인.
-- 인사이트 : 임직원 급여 수준 파악하여 직원 간 형편성 검토가능, 
--           상여금 지급여부를 통해 성과에 따른 보상체계을 투명성으로 경쟁력 강화 및 성과중심 사내 문화 조성에 도움.
SELECT EMPLOYEE_ID AS 사번, FIRST_NAME || ' ' || LAST_NAME AS 이름, SALARY AS 급여, NVL(TO_CHAR(COMMISSION_PCT), '없음') AS 상여금,
CASE WHEN salary >= 20000 then '비대상'
     WHEN salary < 20000 and salary > 10000 then '조율필요'
     ELSE '인상 대상자'
END AS "협상대상자"
FROM employees;


--NO5.직원 거주지역 정보 관리.
-- 개인정보와 연계하여 비상연락망에 연계하여 지역 재난사고 발생시 비상연락망 통하여 긴급알림문자 발송.
SELECT e.employee_id AS 사번, e.FIRST_NAME || ' ' || LAST_NAME AS 이름, e.phone_number 전화번호, d.department_name 부서, l.city 거주지
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;



--NO6. 근속연수에 따른 상여금 지급.
--| INSIGHT | : 장기근속에 대한 포상을 통한 조직 충성도, 만족도 증가 -> 이직률 감소
SELECT CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 15 THEN '15년 이하'
        WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 15 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 20 THEN '15년 초과 20년 이하'
        WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 20 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 25 THEN '20년 초과 25년 이하'
        ELSE '25년 초과'
    END AS 근속연수, COUNT(*) AS "대상자", 
    TO_CHAR(ROUND(SUM(e.SALARY), -4), '$9999999') AS 총금액
FROM
    EMPLOYEES e
GROUP BY CASE 
            WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 15 THEN '15년 이하'
            WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 15 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 20 THEN '15년 초과 20년 이하'
            WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 20 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 25 THEN '20년 초과 25년 이하'
            ELSE '25년 초과' END;


--NO7. 과거 부서이동 업무이력 확인.
--| INSIGHT | : 이력 확인을 통하여 업무 적합성 및 적성 확인, 가장 효율적인 인사배치 가능.
--                    주기적인 전환배치를 통한 멀티플레이어 양성, 팀 프로젝트 퀄리티 UP 기대 -> 성과 상승 효과기대.
SELECT 
    E.EMPLOYEE_ID AS 사번, E.FIRST_NAME || ' ' || E.LAST_NAME AS 이름, JH.START_DATE "전환배치 시작", JH.END_DATE "전환배치 종료",
    J.JOB_TITLE 업무명, D.DEPARTMENT_NAME 부서명,
          decode(D.department_id,
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
FROM EMPLOYEES E

INNER JOIN JOB_HISTORY JH ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID
INNER JOIN JOBS J ON JH.JOB_ID = J.JOB_ID
INNER JOIN DEPARTMENTS D ON JH.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 101; -- 사번 : 101,176,200




--NO5. 전직원 급여, 인센티브 수령여부 확인, 연봉 인상,협상 대상자 여부 확인.
--     인사이트 : 임직원 급여 수준 파악하여 직원 간 형편성 검토가능, 
--               상여금 지급여부를 통해 성과에 따른 보상체계을 투명성으로 경쟁력 강화 및 성과중심 사내 문화 조성에 도움.
SELECT EMPLOYEE_ID AS 사번, FIRST_NAME || ' ' || LAST_NAME AS 이름, SALARY AS 급여, NVL(TO_CHAR(COMMISSION_PCT), '없음') AS 상여금,
CASE WHEN salary >= 20000 then '비대상'
     WHEN salary < 20000 and salary > 10000 then '조율필요'
     ELSE '인상 대상자'
END AS "협상대상자"
FROM employees;