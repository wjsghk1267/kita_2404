--Task1_0523. 
--orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
--�����͸� 5�� �Է��ϼ���.
--�Է��� ������ �� 2���� �����ϼ���.
--������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
--3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.

CREATE TABLE ORDERS(
    order_id NUMBER ,
    customer_id NUMBER PRIMARY KEY,
    amount VARCHAR2(100),
    status VARCHAR2(100)
)