-- ���밪, ���̺� �ȸ���� ������ ���̺��� �� ��� FROM dual
SELECT ABS(-78), ABS(+78)
FROM DUAL;

-- �ݿø�, ����.
SELECT ROUND(4.875, 1)
FROM DUAL;

--Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT * FROM ORDERS;

SELECT custid ����ȣ, ROUND(AVG(saleprice), -2) ����ֹ��ݾ�
FROM orders
GROUP BY custid;

--Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, publisher, length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
FROM book WHERE publisher = '�½�����';

--Q. DBMS ������ �������� ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1
FROM DUAL;

--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ��.
--NVL �Լ��� ���� NULL�� ���, �������� �������. NVL("��","������")
SELECT NAME �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

--Q. ����Ͽ��� ����ȣ,�̸�,��ȭ��ȣ�� ���� �θ� ���̽�.
--ROWNUM : ����Ŭ���� �ڵ����� �����ϴ� ���� ���� ������ ����Ǵ� ���� �� �࿡ �Ϸù�ȣ�� �ڵ��Ҵ�.
SELECT rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE rownum < 3;


