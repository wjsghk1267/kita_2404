--[실습]
--인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요.

--NO1. 근속연수에 따른 상여금 지급.
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


--과거 부서이동 업무이력 확인.
SELECT 
    E.EMPLOYEE_ID,
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

LEFT JOIN JOB_HISTORY JH2 ON E.EMPLOYEE_ID = JH2.EMPLOYEE_ID AND JH.END_DATE = JH2.START_DATE
WHERE E.EMPLOYEE_ID = 101;
