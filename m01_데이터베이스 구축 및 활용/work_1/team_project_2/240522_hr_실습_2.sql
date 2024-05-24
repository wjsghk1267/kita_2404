--[�ǽ�]
--�λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���.

--NO1. �ټӿ����� ���� �󿩱� ����.
--���ȿ�� : ���� �漺��, ������ ���� -> ������ ����
SELECT CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 15 THEN '15�� ����'
        WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 15 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 20 THEN '15�� �ʰ� 20�� ����'
        WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 20 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 25 THEN '20�� �ʰ� 25�� ����'
        ELSE '25�� �ʰ�'
    END AS �ټӿ���, COUNT(*) AS "�����", 
    TO_CHAR(ROUND(SUM(e.SALARY), -4), '$9999999') AS �ѱݾ�
FROM
    EMPLOYEES e
GROUP BY CASE 
            WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 15 THEN '15�� ����'
            WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 15 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 20 THEN '15�� �ʰ� 20�� ����'
            WHEN MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 > 20 AND MONTHS_BETWEEN(SYSDATE, e.HIRE_DATE) / 12 <= 25 THEN '20�� �ʰ� 25�� ����'
            ELSE '25�� �ʰ�' END;    


--NO2. ���� �μ��̵� �����̷� Ȯ��.
--���ȿ�� : ���� ���ռ� �� ���� Ȯ��, ���� ȿ������ �λ��ġ ����, ��Ƽ�÷��̾� �缺�Ǿ� ������Ʈ ����Ƽ UP ��� -> ���� ���
SELECT 
    E.EMPLOYEE_ID AS ���,
    E.FIRST_NAME || ' ' || E.LAST_NAME AS �̸�,
    JH.START_DATE "��ȯ��ġ ����",
    JH.END_DATE "��ȯ��ġ ����",
    J.JOB_TITLE ������,
    D.DEPARTMENT_NAME �μ���,
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
            170, '����','��Ÿ') ����μ�
FROM EMPLOYEES E

JOIN JOB_HISTORY JH ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID
JOIN JOBS J ON JH.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON JH.DEPARTMENT_ID = D.DEPARTMENT_ID

LEFT JOIN JOB_HISTORY JH2 
ON E.EMPLOYEE_ID = JH2.EMPLOYEE_ID AND JH.END_DATE = JH2.START_DATE
WHERE E.EMPLOYEE_ID = 101; --��� : 101,176,200




--NO3. ���� ��� ������ �󸶳� �������� ���Ͽ� �ش� ������ �󸶳� ���� ������ ���̴°��� ��.
--���ȿ�� : ��ü ���� ���� ������ �ľ��Ͽ� ���� ���������� �ɷ� ��� ������ ������ �޴��� ��
--         ���� ����� �����ͷ� Ȱ�밡��.

WITH Avg_Job_Stats AS (      -- ���� �� ��� ������ ��� ������ EMPLOYEES ���̺��� �����ϴ� ����
    SELECT 
        job_id, 
        AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))) AS avg_tenure, 
        AVG(SALARY) AS avg_salary
    FROM 
        EMPLOYEES
    GROUP BY 
        job_id
),

-- ��տ����� ��տ����� JOIN ���� ������ ���� �� ������ ��տ� ���� �������� ������ ��տ� ���� �������� ���� ���·� score Į�� ����
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

-- �� ���� �� ���� 10%�� �����ϱ� ���� percent_rank() �Լ� ���
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
    trunc(tenure/12) AS "����(��)",
    TO_CHAR(SALARY, 'L999,999') AS "����",
    round(score, 2) AS "����",
    round(percentile_rank, 2) AS "����"
FROM 
    Ranked_Employees
WHERE 
    percentile_rank <= 0.1;
    
