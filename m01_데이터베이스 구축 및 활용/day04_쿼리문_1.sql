--NVL() NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
SELECT last_name, manager_id,
nvl(to_char(manager_id), 'CEO') revised_id from employees;

--decode()    if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���

SELECT last_name, department_id,
decode(department_id,
    90, '�濵������',
    60, '���α׷���',
    100, '�λ��','��Ÿ') �μ�
FROM employees;

--Q. employees ���̺��� commission_pct�� null�� �ƴ� ���, 'A' null �� ��� 'N'�� ǥ���ϴ� ������ �ۼ�
SELECT commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') AS ��ȯ
FROM employees
order by ��ȯ desc;

--case()
--decode() �Լ��� �����ϳ� decode() �Լ��� ������ ������ ��츸 ����������
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ������ �� �ִ�.
--CASE ���� ���ǿ� ���� �ٸ� ���� ��ȯ�ϴ� �� ���Ǹ�, DECODE���� ������ ������ ǥ���� �� �ִ�. 
--������ CASE WHEN condition THEN result ... ELSE default END�̴�. 

SELECT last_name, department_id,
CASE WHEN department_id = 90 then '�濵������'
     WHEN department_id = 60 then '���α׷���'
     WHEN department_id = 100 then '�λ��'
else '��Ÿ'
end as �Ҽ�
FROM employees;

--Q. employees ���̺��� salary�� 20000 �̻��̸� 'a', 10000~20000 �̸� 'B', �� ���ϸ� 'C'�� ǥ���ϴ� ���� �ۼ�.(case)
SELECT last_name, salary,
CASE WHEN salary >= 20000 then 'A'
     WHEN salary < 20000 and salary > 10000 then 'B'
     ELSE 'C'
END AS ���
FROM employees;

--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);

-- Concatenation : �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ��µȴ�.
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name || 'is a' || job_id FROM employees;


--UNION(������) INTERSECT(������) MINUS(������) UNION ALL(��ġ�� �ͱ��� ����)
--�� ���� �������� ����ؾ� �Ѵ�. ������ Ÿ���� ��ġ ���Ѿ� �Ѵ�.
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
union
SELECT first_name �̸�, salary �޿� FROM employees
where hire_date < '99/01/01';

SELECT first_name �̸�, salary �޿�, hire_date from employees
where salary < 5000
union all
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
where hire_date < '05/01/01';

SELECT first_name �̸�, salary �޿�, hire_date from employees
where salary < 5000
minus
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
where hire_date < '05/01/01';

SELECT first_name �̸�, salary �޿�, hire_date from employees
where salary < 5000
intersect
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
where hire_date < '05/01/01';


--CREATE VIEW ��ɾ�� ����Ŭ SQL���� ���̺��� Ư�� �κ��̳� ���ε� ����� ������ ��(view)�� ���� �� ���
--��� �����͸� ����ϰų� ������ ������ �ܼ�ȭ�ϸ�, ����ڿ��� �ʿ��� �����͸��� �����ִ� �� ����
--��� ���� ���̺� �����͸� �������� �ʰ�, ��� ���� ����� ����
--���� �ֿ� Ư¡
--���� �ܼ�ȭ: ������ ������ ��� ���������ν� ����ڴ� ������ �������� �ݺ��ؼ� �ۼ��� �ʿ� ���� �����ϰ� �並 ������ �� �ִ�.
--������ �߻�ȭ: ��� �⺻ ���̺��� ������ ����� ����ڿ��� �ʿ��� �����͸��� ������ �� �־�, ������ �߻�ȭ�� ����.
--���� ��ȭ: �並 ����ϸ� Ư�� �����Ϳ� ���� ������ ������ �� ������, ����ڰ� �� �� �ִ� �������� ������ ������ �� �ִ�.
--������ ���Ἲ ����: �並 ����Ͽ� �����͸� �����ϴ���, �� ��������� �⺻ ���̺��� ������ ���Ἲ ��Ģ�� �������� �ʵ��� ������ �� �ִ�.

