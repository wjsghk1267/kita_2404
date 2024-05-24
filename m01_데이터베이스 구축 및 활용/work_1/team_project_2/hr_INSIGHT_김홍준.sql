--[�ǽ�]
--1) ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���.

--NO1. �系�μ� ������ Ȯ��
-- �λ���Ʈ : �系�λ������ Ȱ�밡��. 
--          �μ�ID,�μ���,������ID Ȱ���Ͽ� �系�μ� ������ Ȯ�� + ����ID �з� ���Ͽ� ������ ������ǥ �񱳿� Ȱ�밡��
SELECT DEPARTMENT_NAME AS "�μ���", MANAGER_ID AS "������ID", LOCATION_ID AS "��ġ"
FROM DEPARTMENTS;

--NO2-1. ���纰 �ΰǺ� ���� ��
--�λ���Ʈ : �μ�,����,��� ���纰 �ΰǺ� ����, �񱳸� ���� �ΰǺ� ����, ��ǥ �����Ͽ� ������� ����. 
SELECT  d.department_name AS "�μ���", l.city AS ����, l.location_id AS "���� No", SUM(e.salary) as "�ΰǺ� ����"
FROM departments d
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN employees e ON d.department_id = e.department_id
WHERE D.location_id = '1700' --���� No �Է�.
GROUP BY d.department_name, l.city, l.location_id; 


--NO2-2. ���ú� �ΰǺ� ���� ��
SELECT l.city AS ����, l.country_id AS �����ڵ�, l.location_id AS "���� No", SUM(e.salary) as "�ΰǺ� ����"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE l.country_id = 'US' --country code �Է�.
GROUP BY l.city, l.country_id, l.location_id;


--NO2-3. ���� �ΰǺ� ���� ��
SELECT c.country_name AS ����, c.country_id AS �����ڵ�, r.region_name AS ���No, SUM(e.salary) as "�ΰǺ� ����"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON l.country_id = c.country_id
INNER JOIN regions r ON c.region_id = r.region_id
WHERE c.country_id = 'US' --country code �Է�.
GROUP BY c.country_name, c.country_id, r.region_name;


--NO3-1. ������ �������� Ȯ��
-- �λ���Ʈ : ������������, �Ի�����, �޿�, �μ�, �μ������� Ȯ�ε� �������� �λ����� ����.
--           �����ڿ� ���� �� ��� ���� �ľ� �� ȿ�� �м��� Ȱ�밡�� 
SELECT EMPLOYEE_ID AS ���, FIRST_NAME || ' ' || LAST_NAME AS �̸�, EMAIL AS �̸���, PHONE_NUMBER AS ����ó, HIRE_DATE AS �Ի�����,
       trunc((sysdate-hire_date)/365) AS �ټӿ���,
       CASE
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -100) THEN '����'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -200) THEN '���'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -250) THEN '����'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -280) THEN '����'
           ELSE 'å��'
       END AS ����,
       decode(department_id,
            10, '������',
            20, '�����ú�',
            30, '���ź�',
            40, '�λ��',
            50, '����',
            60, '���α׷���',
            70, 'ȫ����',
            80, '������',
            90, '�濵������',
            100, '�繫��',
            110, 'ȸ���',
            170, '����','��Ÿ') �μ�
FROM EMPLOYEES;

--NO3-2. ���� �������� �˻�.
SELECT EMPLOYEE_ID AS ���, FIRST_NAME || ' ' || LAST_NAME AS �̸�, EMAIL AS �̸���,PHONE_NUMBER AS ����ó,HIRE_DATE AS �Ի�����,
       trunc((sysdate-hire_date)/365) aS �ټӿ���, DEPARTMENT_ID AS �μ���,
       CASE
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -100) THEN '����'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -200) THEN '���'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -250) THEN '����'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -280) THEN '����'
           ELSE 'å��'
       END AS ����
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 101;


--NO4. ������ �޿�, �μ�Ƽ�� ���ɿ��� Ȯ��, ���� �λ�,���� ����� ���� Ȯ��.
-- �λ���Ʈ : ������ �޿� ���� �ľ��Ͽ� ���� �� ���� ���䰡��, 
--           �󿩱� ���޿��θ� ���� ������ ���� ����ü���� �������� ����� ��ȭ �� �����߽� �系 ��ȭ ������ ����.
SELECT EMPLOYEE_ID AS ���, FIRST_NAME || ' ' || LAST_NAME AS �̸�, SALARY AS �޿�, NVL(TO_CHAR(COMMISSION_PCT), '����') AS �󿩱�,
CASE WHEN salary >= 20000 then '����'
     WHEN salary < 20000 and salary > 10000 then '�����ʿ�'
     ELSE '�λ� �����'
END AS "��������"
FROM employees;


--NO5.���� �������� ���� ����.
-- ���������� �����Ͽ� ��󿬶����� �����Ͽ� ���� �糭��� �߻��� ��󿬶��� ���Ͽ� ��޾˸����� �߼�.
SELECT e.employee_id AS ���, e.FIRST_NAME || ' ' || LAST_NAME AS �̸�, e.phone_number ��ȭ��ȣ, d.department_name �μ�, l.city ������
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;



--NO6. �ټӿ����� ���� �󿩱� ����.
--| INSIGHT | : ���ټӿ� ���� ������ ���� ���� �漺��, ������ ���� -> ������ ����
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


--NO7. ���� �μ��̵� �����̷� Ȯ��.
--| INSIGHT | : �̷� Ȯ���� ���Ͽ� ���� ���ռ� �� ���� Ȯ��, ���� ȿ������ �λ��ġ ����.
--                    �ֱ����� ��ȯ��ġ�� ���� ��Ƽ�÷��̾� �缺, �� ������Ʈ ����Ƽ UP ��� -> ���� ��� ȿ�����.
SELECT 
    E.EMPLOYEE_ID AS ���, E.FIRST_NAME || ' ' || E.LAST_NAME AS �̸�, JH.START_DATE "��ȯ��ġ ����", JH.END_DATE "��ȯ��ġ ����",
    J.JOB_TITLE ������, D.DEPARTMENT_NAME �μ���,
          decode(D.department_id,
            10, '������',
            20, '�����ú�',
            30, '���ź�',
            40, '�λ��',
            50, '����',
            60, '���α׷���',
            70, 'ȫ����',
            80, '������',
            90, '�濵������',
            100, '�繫��',
            110, 'ȸ���',
            170, '����','��Ÿ') �μ�
FROM EMPLOYEES E

INNER JOIN JOB_HISTORY JH ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID
INNER JOIN JOBS J ON JH.JOB_ID = J.JOB_ID
INNER JOIN DEPARTMENTS D ON JH.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 101; -- ��� : 101,176,200




--NO5. ������ �޿�, �μ�Ƽ�� ���ɿ��� Ȯ��, ���� �λ�,���� ����� ���� Ȯ��.
--     �λ���Ʈ : ������ �޿� ���� �ľ��Ͽ� ���� �� ���� ���䰡��, 
--               �󿩱� ���޿��θ� ���� ������ ���� ����ü���� �������� ����� ��ȭ �� �����߽� �系 ��ȭ ������ ����.
SELECT EMPLOYEE_ID AS ���, FIRST_NAME || ' ' || LAST_NAME AS �̸�, SALARY AS �޿�, NVL(TO_CHAR(COMMISSION_PCT), '����') AS �󿩱�,
CASE WHEN salary >= 20000 then '����'
     WHEN salary < 20000 and salary > 10000 then '�����ʿ�'
     ELSE '�λ� �����'
END AS "��������"
FROM employees;