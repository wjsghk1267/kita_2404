--������� : �����ͺ��̽� ���� �� Ȱ��
--
--- ���� : 24.05.24
--- ���� : ��ȫ��
--- ���� :

--�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.
--Q1. EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
SELECT e.first_name||' '||e.last_name,e.salary, e.salary*1.1
FROM employees e;

--Q2. EMPLOYEES ���̺��� 2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
SELECT employee_id, hire_date
FROM employees
WHERE hire_date > '05/01/01' AND hire_date < '05/07/01'
ORDER BY hire_date;

--Q3. EMPLOYEES ���̺��� ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT employee_id, job_id
FROM employees 
WHERE job_id = 'SA_MAN' or job_id = 'IT_PROG' or job_id = 'ST_MAN';
-- WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN')
   
--Q4. EMPLOYEES ���̺��� manager_id �� 101���� 103�� ����� ���
SELECT employee_id, manager_id 
FROM employees
WHERE manager_id BETWEEN 101 and 103;


--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
SELECT LAST_NAME, HIRE_DATE, next_day(ADD_months(HIRE_DATE, 6),'��') as "�Ի����� 6���� �� ù ��° ������"
FROM employees;


--Q6. EMPLOYEES ���̺��� EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, trunc((SYSDATE-HIRE_DATE)/30) W_MONTH
FROM employees
ORDER BY hire_date desc;
-- months_between(sysdate, hire_date)), order by w_month desc;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, trunc((SYSDATE-HIRE_DATE)/365) W_YEAR
FROM employees
ORDER BY hire_date desc;
--order by w_year desc;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
SELECT EMPLOYEE_ID, LAST_NAME
FROM employees
WHERE mod(employee_id, 2) = 1;


--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
SELECT EMPLOYEE_ID, LAST_NAME, salary, round(SALARY/12,2) M_SALARY
FROM employees;
select * from employees;


--Q10. employees ���̺��� salary�� 10000�� �̻��� �������� �����ϴ� �� special_employee�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
DROP VIEW special_employee;
CREATE VIEW special_employee AS
SELECT employee_id, first_name||' '||last_name NAME, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary;
SELECT * FROM special_employee;


--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;


--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
SELECT employee_id, department_id, '����' Position 
FROM employees
where department_id IS NULL;


--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
SELECT e.employee_id ���, e.first_name �̸�, j.job_id ����, j.job_title ������
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE e.employee_id = 120;

SELECT e.employee_id ���, e.first_name ��, e.last_name �̸�, e.job_id ����, j.job_title ������
FROM employees e, jobs j
WHERE e.job_id = j.job_id AND e.employee_id = 120;


--Q14. HR EMPLOYEES ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
SELECT first_name||' '||last_name NAME
FROM employees;


--Q15. HR EMPLOYEES ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���.
DROP VIEW employee_view;
CREATE VIEW employee_view AS
SELECT e.EMPLOYEE_ID, e.LAST_NAME, trunc((SYSDATE-HIRE_DATE)/365) W_YEAR
FROM employees e
WHERE trunc((SYSDATE-HIRE_DATE)/365) > 10
ORDER BY W_YEAR;
SELECT * FROM employee_view;


--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
SELECT * FROM employees
WHERE job_id like '%\_A%' escape '\';


--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
SELECT * FROM employees
ORDER BY SALARY, LAST_NAME ASC;
   
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
SELECT e.last_name, d.department_name �μ���
FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE last_name = 'Seo';


--Q19. JOB ID �� ������� �� �޴��� �� �������� ������ ����� ���ϼ���.
SELECT EMPLOYEE_ID, first_name||' '||last_name �̸�, JOB_ID, trunc((SYSDATE-HIRE_DATE)/365) �ټӿ���, AVG(SALARY) ��տ���
FROM employees
GROUP BY EMPLOYEE_ID, first_name||' '||last_name, JOB_ID, trunc((SYSDATE-HIRE_DATE)/365)
ORDER BY JOB_ID;


--Q20. HR EMPLOYEES ���̺��� salary�� 20000 �̻��̸� 'a', 10000�� 20000 �̸� ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ 
--�ۼ��Ͻÿ�.(case)
SELECT first_name||' '||last_name �̸�, salary �޿�,
    CASE WHEN salary > 20000 THEN 'a'
         WHEN salary BETWEEN 10000 AND 20000 THEN 'b'
    ELSE 'c' 
    END �ҵ����
FROM employees;


--Q21. �б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.(20��)
--(�ǽ� - 2�� 1��)
--�б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.
DROP TABLE SCHOOL;
DROP TABLE CLASS;
DROP TABLE PROFESSOR;
DROP TABLE STUDENTS;
DROP TABLE GRADE_1;
DROP TABLE GRADE_2;
--SCHOOL ���̺� ����
CREATE TABLE SCHOOL (
    sc_id       NUMBER PRIMARY KEY,
    sc_name     VARCHAR2(50) NOT NULL,
    sc_phone    VARCHAR2(50) DEFAULT '02-XXX-XXXX',
    location    VARCHAR2(100)
);
--CLASS ���̺� ����
CREATE TABLE CLASS (
    sc_id       NUMBER NOT NULL,
    cls_id      NUMBER PRIMARY KEY,
    cls_name    VARCHAR(20) NOT NULL,
    cls_major   VARCHAR2(50) NOT NULL,
    cls_phone   VARCHAR2(50) DEFAULT '02-XXX-XXXX',
    cls_loc     VARCHAR2(20) NOT NULL,
    FOREIGN KEY(sc_id) REFERENCES SCHOOL(sc_id) ON DELETE CASCADE
);
--PROFESSOR ���̺� ����
CREATE TABLE PROFESSOR (
    cls_id      NUMBER NOT NULL,
    pro_id      NUMBER(7) PRIMARY KEY,
    pro_name    VARCHAR2(50) NOT NULL,
    pro_phone   VARCHAR2(50) NOT NULL,
    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE
);
--STUDENTS ���̺� ���� 
CREATE TABLE STUDENTS (
    cls_id      NUMBER NOT NULL,
    pro_id      NUMBER(7) NOT NULL,
    std_id      NUMBER(7) PRIMARY KEY,
    name        VARCHAR2(50) NOT NULL,
    sex         CHAR(6) DEFAULT '����' CHECK(sex IN ('����', '����')),
    age         NUMBER NOT NULL,
    height      NUMBER(4,1),
    weight      NUMBER(4,1),
    phone       VARCHAR2(20) DEFAULT '010-xxxx-xxxx',
    enrollment  DATE,
    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE,
    FOREIGN KEY(pro_id) REFERENCES PROFESSOR(pro_id) ON DELETE CASCADE
);

--2023�� 1�б� ������Ϻ�
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
--2023�� 2�б� ������Ϻ�
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
--���̺� ������Ÿ�� Ȯ��
DESC STUDENTS;
--SCHOOL ���̺� ������
INSERT INTO SCHOOL VALUES (1, '������б�', '02-880-5114','����Ư���� ���Ǳ� ���Ƿ� 1');
--CLASS ���̺� ������
INSERT INTO CLASS VALUES (1, 1, '1-A', '���а�', '02-880-6001', '301ȣ');
INSERT INTO CLASS VALUES (1, 2, '1-B', '���а�', '02-880-6002', '302ȣ');
INSERT INTO CLASS VALUES (1, 3, '2-A', '���а�', '02-880-6003', '303ȣ');
INSERT INTO CLASS VALUES (1, 4, '2-B', '���а�', '02-880-6004', '304ȣ');
INSERT INTO CLASS VALUES (1, 5, '3-A', '���а�', '02-880-6005', '305ȣ');
INSERT INTO CLASS VALUES (1, 6, '3-B', '���а�', '02-880-6006', '306ȣ');
INSERT INTO CLASS VALUES (1, 7, '4-A', '���а�', '02-880-6007', '307ȣ');
INSERT INTO CLASS VALUES (1, 8, '4-B', '���а�', '02-880-6008', '308ȣ');
INSERT INTO CLASS VALUES (1, 9, '1-A', '��ǻ�Ͱ��а�', '02-880-6009', '309ȣ');
INSERT INTO CLASS VALUES (1, 10, '1-B', '��ǻ�Ͱ��а�', '02-880-60010', '310ȣ');
INSERT INTO CLASS VALUES (1, 11, '2-A', '��ǻ�Ͱ��а�', '02-880-6011', '311ȣ');
INSERT INTO CLASS VALUES (1, 12, '2-B', '��ǻ�Ͱ��а�', '02-880-6012', '312ȣ');
INSERT INTO CLASS VALUES (1, 13, '3-A', '��ǻ�Ͱ��а�', '02-880-6013', '313ȣ');
INSERT INTO CLASS VALUES (1, 14, '3-B', '��ǻ�Ͱ��а�', '02-880-6014', '314ȣ');
INSERT INTO CLASS VALUES (1, 15, '4-A', '��ǻ�Ͱ��а�', '02-880-6015', '315ȣ');
INSERT INTO CLASS VALUES (1, 16, '4-B', '��ǻ�Ͱ��а�', '02-880-6016', '316ȣ');

--PROFESSOR ���̺� ������
INSERT INTO PROFESSOR VALUES (1, 1240301, '�����', '010-2940-9985');
INSERT INTO PROFESSOR VALUES (2, 1240302, '����', '010-5487-4566');
INSERT INTO PROFESSOR VALUES (3, 1240303, '������', '010-5673-0166');
INSERT INTO PROFESSOR VALUES (4, 1240304, '����ȿ', '010-4489-5074');
INSERT INTO PROFESSOR VALUES (5, 1240305, '�ڹ���', '010-7731-9246');
INSERT INTO PROFESSOR VALUES (6, 1240306, '������', '010-1692-8035');
INSERT INTO PROFESSOR VALUES (7, 1240307, '������', '010-3126-7325');
INSERT INTO PROFESSOR VALUES (8, 1240308, '�ѿ���', '010-8462-1853');
INSERT INTO PROFESSOR VALUES (9, 1240309, '������', '010-9085-6234');
INSERT INTO PROFESSOR VALUES (10, 1240310, '�ſ���', '010-7405-6857');
INSERT INTO PROFESSOR VALUES (11, 1240311, '������', '010-6317-2934');
INSERT INTO PROFESSOR VALUES (12, 1240312, '����ȣ', '010-4025-6708');
INSERT INTO PROFESSOR VALUES (13, 1240313, '�迵��', '010-2875-3496');
INSERT INTO PROFESSOR VALUES (14, 1240314, '������', '010-5918-7264');
INSERT INTO PROFESSOR VALUES (15, 1240315, '������', '010-8352-1496');
INSERT INTO PROFESSOR VALUES (16, 1240316, '������', '010-1094-5685');

--STUDENTS ���̺� ������ �Է�
INSERT INTO STUDENTS VALUES (1, 1240301, 2303001, '�հ��', '����', 21, 175.5, 68.2, '010-1234-5678', TO_DATE('2023-03-15', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303002, 'ȫ�浿', '����', 22, 180.0, 70.5, '010-2345-6789', TO_DATE('2023-03-16', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303003, '��ö��', '����', 20, 172.0, 65.3, '010-3456-7890', TO_DATE('2023-03-17', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303004, '�̿���', '����', 21, 165.8, 55.9, '010-4567-8901', TO_DATE('2023-03-18', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303005, '�ڹ���', '����', 20, 167.5, 58.2, '010-5678-9012', TO_DATE('2023-03-19', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303006, '������', '����', 22, 163.0, 50.6, '010-6789-0123', TO_DATE('2023-03-20', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303007, '����ȣ', '����', 23, 178.3, 72.1, '010-7890-1234', TO_DATE('2023-03-21', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303008, '������', '����', 20, 170.2, 60.5, '010-8901-2345', TO_DATE('2023-03-22', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303009, '������', '����', 21, 166.7, 54.8, '010-9012-3456', TO_DATE('2023-03-23', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303010, '��ξ�', '����', 22, 172.5, 63.4, '010-0123-4567', TO_DATE('2023-03-24', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1240301, 2303011, '����ȣ', '����', 20, 177.8, 71.2, '010-1234-5678', TO_DATE('2023-03-25', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303012, '�̼���', '����', 21, 168.5, 57.3, '010-2345-6789', TO_DATE('2023-03-26', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303013, '�ֹμ�', '����', 23, 164.0, 49.7, '010-3456-7890', TO_DATE('2023-03-27', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303014, '������', '����', 20, 169.2, 56.8, '010-4567-8901', TO_DATE('2023-03-28', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303015, '������', '����', 21, 170.8, 59.2, '010-5678-9012', TO_DATE('2023-03-29', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303016, '���ؼ�', '����', 22, 176.3, 70.4, '010-6789-0123', TO_DATE('2023-03-30', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303017, '������', '����', 20, 168.7, 58.1, '010-7890-1234', TO_DATE('2023-03-31', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303018, '��μ�', '����', 21, 180.5, 75.6, '010-8901-2345', TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (2, 1240302, 2303019, '������', '����', 22, 173.6, 62.5, '010-9012-3456', TO_DATE('2023-04-02', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303020, '�ڼҿ�', '����', 20, 165.4, 53.9, '010-0123-4567', TO_DATE('2023-04-03', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303021, '������', '����', 21, 179.2, 73.0, '010-1234-5678', TO_DATE('2023-04-04', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303022, '������', '����', 22, 170.9, 61.7, '010-2345-6789', TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303023, '�̹�ȣ', '����', 20, 175.0, 69.8, '010-3456-7890', TO_DATE('2023-04-06', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303024, '������', '����', 21, 166.3, 55.6, '010-4567-8901', TO_DATE('2023-04-07', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303025, '�ּ���', '����', 22, 168.0, 57.2, '010-5678-9012', TO_DATE('2023-04-08', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303026, '�����', '����', 20, 171.5, 60.3, '010-6789-0123', TO_DATE('2023-04-09', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303027, '������', '����', 21, 177.4, 71.8, '010-7890-1234', TO_DATE('2023-04-10', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303028, '������', '����', 22, 169.8, 57.5, '010-8901-2345', TO_DATE('2023-04-11', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303029, '������', '����', 20, 165.0, 52.8, '010-9012-3456', TO_DATE('2023-04-12', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (3, 1240303, 2303030, '�����', '����', 21, 174.2, 67.1, '010-0123-4567', TO_DATE('2023-04-13', 'YYYY-MM-DD'));

insert into GRADE_1 values(2303001, '�հ��', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_1 values(2303002, 'ȫ�浿', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_1 values(2303003, '��ö��', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_1 values(2303004, '�̿���', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_1 values(2303005, '�ڹ���', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_1 values(2303006, '������', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_1 values(2303007, '����ȣ', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_1 values(2303008, '������', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_1 values(2303009, '������', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_1 values(2303010, '��ξ�', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_1 values(2303011, '����ȣ', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_1 values(2303012, '�̼���', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_1 values(2303013, '�ֹμ�', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_1 values(2303014, '������', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_1 values(2303015, '������', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_1 values(2303016, '���ؼ�', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_1 values(2303017, '������', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_1 values(2303018, '��μ�', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_1 values(2303019, '������', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(2303020, '�ڼҿ�', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_1 values(2303021, '������', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_1 values(2303022, '������', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_1 values(2303023, '�̹�ȣ', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(2303024, '������', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_1 values(2303025, '�ּ���', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_1 values(2303026, '�����', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_1 values(2303027, '������', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_1 values(2303028, '������', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_1 values(2303029, '������', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_1 values(2303030, '�����', 2.9, 3.0, 2.6, 3.1, 2.9);

insert into GRADE_2 values(2303001, '�հ��', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_2 values(2303002, 'ȫ�浿', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_2 values(2303003, '��ö��', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_2 values(2303004, '�̿���', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_2 values(2303005, '�ڹ���', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_2 values(2303006, '������', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_2 values(2303007, '����ȣ', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_2 values(2303008, '������', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_2 values(2303009, '������', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_2 values(2303010, '��ξ�', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_2 values(2303011, '����ȣ', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_2 values(2303012, '�̼���', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_2 values(2303013, '�ֹμ�', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_2 values(2303014, '������', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_2 values(2303015, '������', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_2 values(2303016, '���ؼ�', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_2 values(2303017, '������', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_2 values(2303018, '��μ�', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_2 values(2303019, '������', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303020, '�ڼҿ�', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_2 values(2303021, '������', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_2 values(2303022, '������', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_2 values(2303023, '�̹�ȣ', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303024, '������', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_2 values(2303025, '�ּ���', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_2 values(2303026, '�����', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_2 values(2303027, '������', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_2 values(2303028, '������', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_2 values(2303029, '������', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_2 values(2303030, '�����', 2.9, 3.0, 2.6, 3.1, 2.9);


SELECT * FROM CLASS;
SELECT * FROM PROFESSOR;
SELECT * FROM STUDENTS;
SELECT * FROM GRADE_1;
SELECT * FROM GRADE_2;


-- NO1. Ư������ ������ ��ȸ
SELECT std_id �й�, name �̸�, math ����
FROM GRADE_1
WHERE math = 0.0; -- �ش� ����� �Է�


-- NO2. ���� ����� Ȯ��
SELECT std_id �й�, name �̸�, 
    CASE 
        WHEN math = 0.0 THEN '����'
        WHEN english = 0.0 THEN '����'
        WHEN science = 0.0 THEN '����'
        WHEN music = 0.0 THEN '����'
        WHEN social = 0.0 THEN '��ȸ'
    END ��������
FROM GRADE_1
WHERE math = 0.0 OR english = 0.0 OR science = 0.0 OR music = 0.0 OR social = 0.0;


-- NO3. ������ ���� ���� ��ȸ
SELECT std_id �й�, name �̸�, math ����, english ����, science ����, music ����, social ���� 
FROM GRADE_1
WHERE math = 0.0 or english = 0.0 or science = 0.0 or music = 0.0 or social = 0.0;


-- NO4. ���� ���� ��ȸ
SELECT std_id �й�, name �̸�, G1.math ����, G1.science ����, G1.english ����, G1.music ����, G1.social ��ȸ, 
    (SELECT AVG(G1.math + G1.science + G1.English + G1.music + G1.social)/5 FROM GRADE_1 G2) ���
FROM GRADE_1 G1
WHERE std_id = 2303001;


-- NO5. ��ü ���� ��ȸ
SELECT std_id �й�, name �̸�, G1.math ����, G1.science ����, G1.english ����, G1.music ����, G1.social ��ȸ, 
    (math + english + science + music + social)/5 ������� 
FROM GRADE_1 G1;


-- NO6. �б⺰ ���б� ����� ���� (���� 2��)
SELECT * FROM(
    SELECT std_id �й�, name �̸�, (math + english + science + music + social)/5 ������� 
    FROM GRADE_1 G1
    WHERE G1.math + english + music + science + social >= (SELECT AVG(G2.math + G2.english + G2.music + G2.science + G2.social) FROM GRADE_1 G2)
    order by ������� DESC)
WHERE rownum < 3;


-- NO7. �б⺰ �л��� ���� ��ȸ (���� : ������ ����)
SELECT std_id �й�, name �̸�, (math + english + music + science + social)/5 �������,
    CASE 
        WHEN (math + english + music + science + social) = 0.0 THEN '������'
    END ��������
FROM GRADE_1 G1
WHERE math = 0.0 AND english = 0.0 AND music = 0.0 AND science = 0.0 AND social = 0.0;


-- NO8. 1,2�б� ���� ���� ���� ��ȸ
SELECT S.NAME, G1.math as "1�б�", G2.math as "2�б�"
FROM STUDENTS S
JOIN GRADE_1 G1 ON S.std_id = G1.std_id
JOIN GRADE_2 G2 ON S.std_id = G2.std_id
WHERE G1.math = 0.0 AND G2.math = 0.0;


-- NO9. ���г⵵�� ���� �������� Ȯ��
SELECT std_id "�й�", name "�̸�", enrollment "���г�¥", TO_CHAR(ADD_MONTHS(enrollment, 3 * 12 + 11), 'YYYY-mm') "��������"
FROM STUDENTS;


-- NO10. ���� ���� ������ Ȯ��
--BMI ����
SELECT std_id "�й�", name "�̸�", height "Ű", weight "������"
FROM STUDENTS
WHERE sex='����' and std_id in (
    SELECT std_id 
    from students
    where weight / power(height/100, 2) between 15 and 40);
    

--Q22. ���� �ǽ������� �����ϼ���.(20��)
-- 1. ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���.
-- 2. �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���. 

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
