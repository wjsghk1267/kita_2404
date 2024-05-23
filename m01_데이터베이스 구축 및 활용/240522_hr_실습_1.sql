--[�ǽ�]
--1) ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���.
--2) �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���.

-- TABLE COUNTRIES
SELECT * FROM COUNTRIES;
-- �λ���Ʈ : ���� ���� ���簣 ������ǥ �񱳿� Ȱ��.
 
-- TABLE DEPARTMENTS
SELECT * FROM DEPARTMENTS;
-- �λ���Ʈ : �系�λ������ Ȱ�밡��. 
--          �μ�ID,�μ���,������ID Ȱ���Ͽ� �系�μ� ������ Ȯ�� + ����ID �з� ���Ͽ� ������ ������ǥ �񱳿� Ȱ�밡��

--NO1. �系�μ� ������ Ȯ��
SELECT 
    DEPARTMENT_NAME AS "�μ���",
    MANAGER_ID AS "������ID",
    LOCATION_ID AS "��ġ"
FROM 
    DEPARTMENTS;
        
-- �������� : �μ��� ���� �ο���, �б������ �߰��Ͽ� �μ��� ������ǥ �񱳿� Ȱ��. "Total_members", "Quarter_Sales"
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID, Total_members, Quarter_Sales)
VALUES (10, 'Administration', 200, 1700, 50, 1000000);
--NO1. ������ ������ǥ ��
SELECT 
    D.DEPARTMENT_NAME AS "�μ���",
    L.CITY AS "����",
    D.Quarter_Sales AS "�б�����"
FROM 
    DEPARTMENTS D
JOIN 
    LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE 
    D.DEPARTMENT_NAME = 'Administration';

-- TABLE EMPLOYEES
SELECT * FROM EMPLOYEES;
-- �λ���Ʈ : ������������, �Ի�����, �޿�, �μ�, �μ������� Ȯ�ε� �������� �λ����� ����. �λ���� �ٽ� ���̺�

--NO1. ������ �������� Ȯ��
SELECT EMPLOYEE_ID AS ���,
       FIRST_NAME || ' ' || LAST_NAME AS �̸�,
       EMAIL AS �̸���,
       PHONE_NUMBER AS ����ó,
       HIRE_DATE AS �Ի�����,
       trunc((sysdate-hire_date)/365) aS �ټӿ���,
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

--NO2. ���� �������� �˻�
SELECT EMPLOYEE_ID AS ���,
       FIRST_NAME || ' ' || LAST_NAME AS �̸�,
       EMAIL AS �̸���,
       PHONE_NUMBER AS ����ó,
       HIRE_DATE AS �Ի�����,
       trunc((sysdate-hire_date)/365) aS �ټӿ���,
       DEPARTMENT_ID AS �μ���,
       CASE
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -100) THEN '����'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -200) THEN '���'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -250) THEN '����'
           WHEN HIRE_DATE >= ADD_MONTHS(SYSDATE, -280) THEN '����'
           ELSE 'å��'
       END AS ����
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 101;


--NO3. ������ �޿�, �μ�Ƽ�� Ȯ��, �������� ��󿩺� ����.
SELECT 
    EMPLOYEE_ID, 
    FIRST_NAME || ' ' || LAST_NAME AS �̸�, 
    SALARY AS �޿�, 
    NVL(TO_CHAR(COMMISSION_PCT), '����') AS �󿩱�,
CASE WHEN salary >= 20000 then '����'
     WHEN salary < 20000 and salary > 10000 then '�����ʿ�'
     ELSE '���'
END AS "�޿� ��������"
FROM employees;


-- TABLE JOBS
SELECT * FROM JOBS;
-- �λ���Ʈ : ���� �оߺ� �ҵ��, ������ �ҵ���� �� Ȱ��, ������ �ڱ��� ��ǥ ������ �ٰ��ڷ�� Ȱ��.
-- �������� : �ش� �о߿� ���� ��ȣ��, ���� �ش� ���� ������ ���� �߰��Ͽ� ���⼺ ���� �� ����*���� ����. -- �п�� ����.

-- TABLE JOB_HISTORY
SELECT * FROM JOB_HISTORY;
-- �λ���Ʈ : ���� �����̷� Ȯ�� �� �����̷��� Ȯ�ΰ���.
-- �������� : ���� KPI ��ǥ �� �����޼� ��ǥ�Ⱓ �߰��Ͽ� ���μ�����ǥ�� Ȱ�밡��. (�����ɷ��� Ȱ��)
-- ��ǥ : ������ ��ǥ X, ���� ������, ���̵��� ���� ���� ����. (���, �ڰ���, ����, Ŀ�´����̼ǵ� �ٹ��)
Insert into JOB_HISTORY (EMPLOYEE_ID,START_DATE,END_DATE,JOB_ID,DEPARTMENT_ID,Goal_In) values (102,to_date('01/01/13','RR/MM/DD'),
to_date('06/07/24','RR/MM/DD'),'IT_PROG',60,'JLPT N1 �ڰ��� ���');


-- TABLE LOCATIONS
SELECT * FROM LOCATIONS;
-- �λ���Ʈ : ���� �������� ���� ����.
-- Ȱ���� : ���������� �߰��Ͽ� ��󿬶���, �����ý��ۿ� Ȱ��. (������ ���� ���� �߻��� ��޹��� �߼۵�) 

-- TABLE REGIONS
SELECT * FROM REGIONS;
-- Ȱ���� : ��� ���� ������ǥ �񱳿� Ȱ�밡��. (�̱�, �ƽþ�, ��������..)




-- TEACH
--�μ��� �޿� ��Ȳ
--���̺����, �μ��� �޿��� �� �޿��� Ȯ�� �� �� ����.
--(�޿��� �� ��� �ּڰ� �ִ�, �� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿�)
--table ����� �μ��� �޿��� �뷫������ ����
--����� ���̺� Ȯ��
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--�μ� ��� Ȯ��
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- �μ� ��� department_id : 10,20,30,40,50,60,70,80,90,100,110 �� �� ������(120~200��..)�� ���� null ���� ����.
--department_id �� null �� ����� ��� job_id �� �´� department_id �� �ο����ַ�����(������ ���Ἲ)
--1. department_id �� null ���� ��� ã��
select *
from employees
where department_id IS NULL;
--�Ѹ� �ۿ� ����. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id �� SA_REP �� department_id ã�� (������ �´� �μ� ã��)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP �� department_id �� 80

--3. ���� �� savepoint ����
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. ��������primary key �� employee_id �� ã�Ƽ� derpartment_id �� 80���� ����
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint�� ����
--commit;
--������

--������ �� ������ ������
--�� �μ����� ������ ����̰� � �����ǵ��� �ְ� ������ ��� �Ǵ���
--ROLLUP�� ���������� ���� ����� ���� : ��� �� �μ� �� ������ ���� ���� ����
SELECT E.department_id, D.department_name, nvl(E.job_id, 'Total') job_id, count(*) ������
FROM employees E
LEFT OUTER JOIN departments D on E.department_id = D.department_id
GROUP BY ROLLUP((E.department_id, D.department_name), E.job_id)
ORDER BY E.department_id;
