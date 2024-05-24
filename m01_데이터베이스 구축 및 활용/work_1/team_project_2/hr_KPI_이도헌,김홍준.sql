-----------------------------------------------------------------------------------------------------------
--                       [ �ǽ� ]

-- * ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���.
-- * �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� ����

-----------------------------------------------------------------------------------------------------------

--KPI NO.1
--COMMISSION_PCT�� �ִ� ���� �߿�
--�ش� ������ MIN_SALARY MAX_SALARY �� ��� �߿� ��� ���� ������ ���ϴ��� (WIDTH_BUCKET)
--���� 10��

--KPI NO.2
--(SYSDATE-HIREDATE) �� ���, �׸��� ������ (MIN_SALARY MAX_SALARY) �� ��տ� ���� ������� ���ų� ������

--KPI NO.3
--JOB_HISTORY �� �̿��Ͽ� BETWEEN ST_DATE AND END_DATE ������/ �� ������ * 100 ���� �������� ���� �� 10% �������� Ȯ��.


--------------------------------------    CASE 1. �μ� ��, ���� ��, ���� ��ȸ

-- �� �μ� �̸��� �μ� �� ���� ��ȸ
SELECT
    D.department_id,
    D.department_name, 
    E.first_name||' '||last_name "Full name"
FROM
    DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E
    ON D.department_id=E.department_id;

-- �� ���� �̸��� ���� �� ���� ��ȸ
SELECT
    J.job_id,
    J.job_title, 
    E.employee_id,
    E.first_name||' '||last_name "Full name"
FROM
    JOBS J
LEFT OUTER JOIN EMPLOYEES E
    ON J.job_id=E.job_id;

    

--------------------------------------    CASE 2. �μ� ��, ���� ��, ���� ��
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



--------------------------------------    CASE 3. �μ��� �Ҵ���� ���� ���Կ��� ������ �μ� �����ϱ�

-- department_id �� null�� ������ ��ȸ�� �� �ִ� �� ����.
DROP VIEW dept_id_null;
CREATE VIEW dept_id_null AS
SELECT *
FROM EMPLOYEES
WHERE department_id IS NULL;


SELECT * FROM dept_id_null;

-- null ���� �ٲ��ֱ� ���� ���� ������ ������ ���� SAVEPOINT ����.
SAVEPOINT before_replace_null;

-- UPDATE ���� ����Ͽ� job_id �� �´� department_id �� ����
UPDATE EMPLOYEES
SET department_id = (
    SELECT department_id
    FROM JOB_HISTORY
    WHERE job_id in ( SELECT job_id FROM dept_id_null )
)
WHERE department_id IS NULL;

-- �� ��ȸ
SELECT * FROM dept_id_null;
-- EMP_ID 170 ~ 180 ���� ����� ���̺� ��ȸ
SELECT employee_id, first_name, job_id, department_id 
FROM EMPLOYEES 
WHERE employee_id between 170 and 180
ORDER BY employee_id;

-- ���� ���̺�� �ٽ� �ѹ����ְ� �ѹ� �� ��� ���̺� Ȯ���غ���
ROLLBACK TO before_replace_null;

--------------------------------------    CASE 4. ���纰 �ΰǺ� ����

SELECT  d.department_name AS "�μ���", l.city AS ����, l.location_id AS "���� No", SUM(e.salary) as "�ΰǺ� ����"
FROM departments d
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN employees e ON d.department_id = e.department_id
--WHERE D.location_id = '1700' --���� No �Է�.
GROUP BY d.department_name, l.city, l.location_id; 


--------------------------------------    CASE 5. �μ��� ���� �м�
--Employees ���̺�� Departments ���̺��� Ȱ���Ͽ� �μ��� ��� �ټ� ����, ��� �޿� ���� �м��մϴ�.

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



---------------------------     KPI NO.1  ���� ��� ������ �󸶳� �������� ���Ͽ�
---------------------------------         �ش� ������ �󸶳� ���� ������ ���̴°��� ��.


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
-- ��տ����� ��տ����� JOIN ���� ������ ���� ��
-- ������ ��տ� ���� �������� ������ ��տ� ���� �������� ���� ���·� score Į�� ����
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

