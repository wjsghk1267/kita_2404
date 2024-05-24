--[실습]
--인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요.

--NO1. 근속연수에 따른 상여금 지급.
--기대효과 : 조직 충성도, 만족도 증가 -> 이직률 감소
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


--NO2. 과거 부서이동 업무이력 확인.
--기대효과 : 업무 적합성 및 적성 확인, 가장 효율적인 인사배치 가능, 멀티플레이어 양성되어 프로젝트 퀄리티 UP 기대 -> 성과 상승
SELECT 
    E.EMPLOYEE_ID AS 사번,
    E.FIRST_NAME || ' ' || E.LAST_NAME AS 이름,
    JH.START_DATE "전환배치 시작",
    JH.END_DATE "전환배치 종료",
    J.JOB_TITLE 업무명,
    D.DEPARTMENT_NAME 부서명,
    decode(D.department_id,
            10, 'Administration',
            20, 'Marketig',
            30, 'Purchasing',
            40, 'Human Resources',
            50, 'Shipping',
            60, 'IT',
            70, 'Public Relations',
            80, 'Sales',
            90, 'Executive',
            100, 'Finance',
            110, 'Accounting',
            170, '제조','기타') 현재부서
FROM EMPLOYEES E

JOIN JOB_HISTORY JH ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID
JOIN JOBS J ON JH.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON JH.DEPARTMENT_ID = D.DEPARTMENT_ID

LEFT JOIN JOB_HISTORY JH2 
ON E.EMPLOYEE_ID = JH2.EMPLOYEE_ID AND JH.END_DATE = JH2.START_DATE
WHERE E.EMPLOYEE_ID = 101; --사번 : 101,176,200




--NO3. 연차 대비 연봉이 얼마나 높은가를 통하여 해당 직원이 얼마나 좋은 성과를 보이는가를 평가.
--기대효과 : 전체 업계 연봉 동향을 파악하여 현재 임직원들의 능력 대비 적합한 연봉을 받는지 평가
--         연봉 협상시 데이터로 활용가능.

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

-- 평균연차와 평균연봉을 JOIN 시켜 비율을 구한 뒤 연봉은 평균에 비해 높을수록 연차는 평균에 비해 낮을수록 좋은 형태로 score 칼럼 저장
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
    
