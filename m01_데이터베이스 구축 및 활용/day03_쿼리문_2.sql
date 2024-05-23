SELECT * FROM EMPLOYEES;

--Q. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
SELECT E.employee_id ���, E.first_name ��, E.last_name �̸�, E.job_id ����, J.job_title ������
FROM employees E
INNER JOIN jobs J ON E.job_id=J.job_id
WHERE E.employee_id = 120;

--FIRST_NAME || ' ' || LAST_NAME AS �̸�: FIRST_NAME�� LAST_NAME�� �������� �����Ͽ�
--�ϳ��� ���ڿ��� ��ġ��, �� ����� ��Ī�� '�̸�'���� ����
SELECT
    E.employee_id ���, E.first_name || ' ' || E.last_name as �̸�,
    J.job_id ����, J.job_title
FROM
    EMPLOYEES E, JOBS J
WHERE
    E.employee_id = 120 AND e.Job_id = J.job_id;
    
--����Ŭ���� ���ڿ��� ��ġ�� ���ؼ��� CONCAT �Լ� �Ǵ� "||" ������ �ΰ��� ����Ѵ�.
--SELECT CONCAT('������', '�󸶹�') FROM DUAL;



--Q. 2005�� ��ݱ⿡ �Ի��� ������� �̸�(Full name)�� �Ի��ϸ� ���.
SELECT first_name||' '||last_name "�̸�(Full name)", hire_date "�Ի���"
FROM employees
WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

-- "_" �� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� escape �ɼ��� ���
SELECT * FROM EMPLOYEES WHERE job_id LIKE '%\_A%';      -- escape ������ �������.
SELECT * FROM EMPLOYEES WHERE job_id LIKE '%\_A%' escape '\';
SELECT * FROM EMPLOYEES WHERE job_id LIKE '%#_A%' escape '#';

-- IN : OR ��� ���
SELECT * FROM EMPLOYEES WHERE manager_id=101 or manager_id=102 or manager_id=103;
SELECT * FROM EMPLOYEES WHERE manager_id in ( 101, 102, 103 );

--Q. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT * FROM EMPLOYEES
WHERE job_id IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--IS NULL / IS NOT NULL
--null �� ������ Ȯ���� ��� = �� �����ڸ� ������� �ʰ� is null �� ����Ѵ�.
SELECT * FROM EMPLOYEES WHERE commission_pct is null;
SELECT * FROM EMPLOYEES WHERE commission_pct is not null;

--ORDER BY
--ORDER BY �÷��� [ ASC | DESC ]
SELECT * FROM EMPLOYEES ORDER BY salary asc;
SELECT * FROM EMPLOYEES ORDER BY salary desc;
SELECT * FROM EMPLOYEES ORDER BY salary asc, last_name desc;

--DUAL ���̺�
--mod ������
SELECT * FROM EMPLOYEES WHERE mod( employee_id, 2 ) = 1;
SELECT mod( 10 , 3 ) FROM DUAL;

--round()
SELECT round( 355.95555 ) from DUAL;
SELECT round( 355.95555, 2 ) from DUAL;
SELECT round( 355.95555, -2 ) from DUAL;

--trunc() : ���� �Լ�. ������ �ڸ��� ���ϸ� ���� ��� ����
SELECT trunc( 45.5555, 1 ) FROM DUAL;

--ceil() ������ �ø��� ���� ��ȯ, �ڸ� ���� ����
SELECT ceil( 45.111 ) FROM DUAL;

--Q. HR EMPLOYEES ���̺��� �̸�, �޿�, 10% �λ�� �޿��� ����ϼ���.
SELECT last_name �̸�, salary �޿�, salary*1.1 "�λ�� �޿�"
FROM EMPLOYEES;

--Q. EMPLOYEE_ID�� Ȧ���� ������ EMPLOYEE_ID�� LAST_NAME�� ����ϼ���.
SELECT employee_id, first_name||' '||last_name "Full name"
FROM EMPLOYEES
WHERE mod(employee_id, 2) = 1;
--���������� ����ؼ��� ����
SELECT employee_id, first_name||' '||last_name "Full name"
FROM EMPLOYEES
WHERE employee_id IN ( SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1 );

--Q. EMPLOYEES ���̺��� commission_pct�� null �� ������ ����ϼ���.
SELECT COUNT(*) FROM EMPLOYEES WHERE commission_pct IS NULL;

--Q. EMPLOYEES ���̺��� department_id�� ���� ������ �����Ͽ� position�� '����'���� ����ϼ���. (position ���� �߰�)
SELECT employee_id, first_name||' '||last_name full_name, '����' position
FROM EMPLOYEES

--��¥ ����
SELECT SYSDATE FROM dual;
SELECT SYSDATE +1 FROM dual;
SELECT SYSDATE -1 FROM dual;


--�ٹ��� ��¥ ���
SELECT last_name, hire_date �Ի���, sysdate ����, trunc(sysdate-hire_date) �ٹ��Ⱓ FROM employees
ORDER BY hire_date desc;


--add_months()  Ư�� ���� ���� ���� ��¥�� ���Ѵ�.
SELECT last_name, hire_date, add_months(hire_date,6) rivised_date FROM employees;

--last_day()        �ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
SELECT last_name, hire_date, last_day(hire_date) FROM employees;
SELECT last_name, hire_date, last_day(add_months(hire_date,1)) FROM employees;

--next_day()        �ش� ��¥�� �������� ������ ���� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
--��~��, 1~7�� ǥ������
SELECT hire_date, next_day(hire_date, '��') FROM employees;
SELECT hire_date, next_day(hire_date,2) FROM employees;

--months_between() ��¥�� ��¥ ������ �������� ���Ѵ�.
SELECT hire_date, round(months_between(sysdate,hire_date),1) FROM employees;

--�� ��ȯ �Լ�: to_date()        ���ڿ��� ��¥�� ��ȯ.
--'2023-01-02'�̶�� ���ڿ��� ��¥ Ÿ�Է� ��ȯ
SELECT TO_DATE('2023-01-02', 'YYYY-mm-dd') FROM dual;

--TO CHAR(��¥)        ��¥�� ���ڷ� ��ȯ
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual;


--����
--YYYY       �� �ڸ� ����
--YY         �� �ڸ� ����
--YEAR       ���� ���� ǥ��
--MM         ���� ���ڷ�
--MON        ���� ���ĺ�����
--DD         ���� ���ڷ�
--DAY        ���� ǥ��
--DY         ���� ��� ǥ��
--D          ���� ���� ǥ��
--AM �Ǵ� PM  ���� ����
--HH �Ǵ� HH12    12�ð�
--HH24           24�ð�
--MI             ��
--SS             ��


--Q. ���� ��¥(SYSDATE)�� 'YYYY/MM/DD' ������ ���ڿ��� ��ȯ�ϼ���.
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') as "���� ��¥" FROM dual;

--Q.  '01-01-2023'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���.
SELECT TO_DATE('01-01-2023', 'MM-DD-YYYY') FROM dual;

--Q. ���� ��¥�� �ð�(SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��� ��ȯ�ϼ���.
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

--Q. '2023-01-01 15:30:00' �̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���.
SELECT TO_DATE('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS') ��¥ FROM dual;


--to_char( ���� )   ���ڸ� ���ڷ� ��ȯ
--9      �� �ڸ��� ���� ǥ��          ( 1111, ��99999�� )      1111   
--0      �� �κ��� 0���� ǥ��         ( 1111, ��099999�� )      001111
--$      �޷� ��ȣ�� �տ� ǥ��        ( 1111, ��$99999�� )      $1111
--.      �Ҽ����� ǥ��               ( 1111, ��99999.99�� )      1111.00
--,      Ư�� ��ġ�� , ǥ��           ( 1111, ��99,999�� )      1,111
--MI      �����ʿ� - ��ȣ ǥ��        ( 1111, ��99999MI�� )      1111-
--PR      �������� <>�� ǥ��          ( -1111, ��99999PR�� )      <1111>
--EEEE      ������ ǥ��              ( 1111, ��99.99EEEE�� )      1.11E+03
--V      10�� n�� ���Ѱ����� ǥ��      ( 1111, ��999V99�� )      111100
--B      ������ 0���� ǥ��            ( 1111, ��B9999.99�� )      1111.00
--L      ������ȭ                    ( 1111, ��L9999�� )

SELECT salary, TO_CHAR(salary, '0999999') FROM employees;
SELECT salary, TO_CHAR(-salary, '999999PR') FROM employees;
-- �Ҽ��� ���� E������ŭ �ø���.
SELECT TO_CHAR(11111, '9.999EEEE') FROM dual;
SELECT TO_CHAR(-1111111, '9999999MI') FROM dual;

--width_bucket()        ������, �ּҰ�, �ִ밪, bucket ����. �����ϰ� �������
SELECT width_bucket(99, 0, 100, 10) FROM dual;
SELECT width_bucket(100, 0, 100, 10) FROM dual;

SELECT salary FROM employees;
SELECT max(salary) max, min(salary) min FROM employees;
SELECT width_bucket(salary,2100,24001,5) "ǰ�� ���" FROM employees;

--���� �Լ� Character Function
--upper()   �빮�ڷ� ����
SELECT upper('Heoolo World') FROM dual;
--lower()
SELECT lower('Heoolo World') FROM dual;

--Q. last_name�� Seo�� ������ last name�� salary�� ���ϼ���. (Seo, SEO, seo ��ΰ���)
SELECT last_name, salary
FROM employees
WHERE upper(last_name) = 'SEO';

--initcap()             ù���ڸ� �빮��, ������ �ҹ��ڷ� ��ȯ
SELECT job_id, initcap(job_id) FROM employees;

--length()          ���ڿ��� ����
SELECT job_id, length(job_id) FROM employees;

--instr()          ���ڿ�, ã�� ����, ã�� ��ġ, ���° ���ڸ� ã����
SELECT instr('Hello World', 'o',5,1) FROM dual;

--substr()          ���ڿ�, ������ġ, ����
SELECT substr('Hello World', 3, 3) FROM dual;
SELECT substr('Hello World', 9, 3) FROM dual;
SELECT substr('Hello World', -3,3) FROM dual;

--lpad()            ������ ���� �� ���ʿ� ���ڸ� ä���.
SELECT lpad('Hello World', 20, ' ') FROM dual;

--rpad()            ���� ���� �� �����ʿ� ���ڸ� ä��.
SELECT rpad('Hello World', 20, ' ') FROM dual;

--ltrim()       ���ʿ� �ش� ����, ������ ����.
SELECT ltrim('aaaHello Worldaaa', 'a') FROM dual;
SELECT ltrim('   Hello World   ') FROM dual;

--rtrim()       �����ʿ� �ش� ����, ������ ����.
SELECT rtrim('aaaHello Worldaaa', 'a') FROM dual;
SELECT rtrim('   Hello World   ') FROM dual;

SELECT last_name FROM employees;
SELECT last_name, ltrim(last_name, 'A') FROM employees;

--trim          ���� �ش繮��, ���� ����.
SELECT trim('     Hello World    ') FROM dual;
SELECT last_name, trim('a' FROM last_name) FROM employees;

select manager_id FROm employees;

--nul()         null�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
SELECT last_name, manager_id,




