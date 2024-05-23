--Task1_0523. 
--orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
--�����͸� 5�� �Է��ϼ���.
--�Է��� ������ �� 2���� �����ϼ���.
--������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
--3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.
DROP TABLE ORDERS;

CREATE TABLE ORDERS(
    order_id NUMBER,
    customer_id NUMBER PRIMARY KEY,
    amount VARCHAR2(100),
    status VARCHAR2(100)
);

INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (1, 101, '100.00', 'completed');
INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (2, 102, '50.00', 'pending');
INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (3, 103, '75.00', 'completed');
INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (4, 104, '120.00', 'pending');
INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (5, 105, '90.00', 'completed');

SAVEPOINT sp1

UPDATE ORDERS
SET amount = '80.00', status = 'completed'
WHERE order_id = 2;

ROLLBACK TO SAVEPOINT sp1

INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (6, 106, '110.00', 'pending');
INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (7, 107, '80.00', 'completed');
INSERT INTO ORDERS(order_id, customer_id, amount, status) VALUES (8, 108, '130.00', 'pending');

DELETE FROM orders
WHERE order_id = 8;

COMMIT;