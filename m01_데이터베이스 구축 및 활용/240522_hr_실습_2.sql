--[�ǽ�]
--�λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���.

--NO1. �ټӿ����� ���� �󿩱� ����.
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


--���� �μ��̵� �����̷� Ȯ��.
SELECT 
    E.EMPLOYEE_ID,
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

LEFT JOIN JOB_HISTORY JH2 ON E.EMPLOYEE_ID = JH2.EMPLOYEE_ID AND JH.END_DATE = JH2.START_DATE
WHERE E.EMPLOYEE_ID = 101;
