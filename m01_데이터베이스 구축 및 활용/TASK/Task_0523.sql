--Task1_0523. 
--orders라는 테이블을 생성하고, order_id, customer_id, order_date, amount, status라는 속성을 설정하세요.
--데이터를 5개 입력하세요.
--입력한 데이터 중 2개를 수정하세요.
--수정한 데이터를 취소하기 위해 롤백을 사용하세요.
--3개의 새로운 데이터를 입력하고, 그 중 마지막 데이터 입력만 취소한 후 나머지를 커밋하세요.
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