--TASK1. 10개의 속성을 구성되는 테이블 2개를 작성하세요. 단 FOREIGN KEY를 적용하여 한쪽 테이블의 데이터를 삭제시 다른 테이블의 관련되는
--데이터도 모두 삭제되도록 하세요. (모든 제약 조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참고하고 있는 속성을 선택하여 데이터를 삭제.
CREATE TABLE customers(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));
FOREIGN KEY(custid) REFERENCES customers(custid) ON DELETE CASCADE);

CREATE TABLE orders(
orderid NUMBER UNIQUE,
orderdate DATE PRIMARY KEY,
custid NUMBER,
price NUMBER DEFAULT 6000 CHECK(price > 3000),
saleprice NUMBER,
menu VARCHAR(20),
FOREIGN KEY(custid) REFERENCES customers(custid) ON DELETE CASCADE);

INSERT INTO customers VALUES(1,'철수','역삼동','010-1234-1234');
INSERT INTO customers VALUES(2,'영희','영통동','010-9021-4324'); 
INSERT INTO customers VALUES(3,'가나','망포동','010-8204-5324'); 
INSERT INTO customers VALUES(4,'다라','원동','010-5664-6844');;

INSERT INTO orders VALUES(1,SYSDATE,1,10000,8000,'크리스피 치킨');
INSERT INTO orders VALUES(2,SYSDATE,1,12000,9000,'양념 치킨');
INSERT INTO orders VALUES(3,SYSDATE,1,11000,8500,'간장 치킨');
INSERT INTO orders VALUES(4,SYSDATE,1,13000,1100,'반반 치킨');

SELECT * FROM customers;
SELECT * FROM orders;

DELETE customers;
DELETE orders;

DROP TABLE customers;
DROP TABLE orders;
DROP TABLE customer;

--teach
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- 방문 빈도
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- 주차여부
    , family number -- 가족 구성원 수
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '고길동', 32, '남', '010-1234-1234', '서울 강남', 5, 1500000, 'N', 3);
insert into mart values(2, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 5, 200000000, 'Y', 4);
insert into mart values(3, '이순신', 57, '남', '010-1592-1234', '경남 통영', 5, 270000, 'N', 1);
insert into mart values(4, '아이유', 30, '여', '010-0516-1234', '서울 서초', 5, 750000000, 'Y', 4);
insert into mart values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- 자주 찾는 매장
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- 발렛파킹 서비스 사용여부
    , rounge varchar2(20) -- vip 라운지 사용여부
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 'LV', 900000000,'','');
insert into department values(2, '아이유', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(3, '박지성', 31, '남', '010-7775-1235', '강원 춘천', 'LV', 900000000,'','');
insert into department values(4, '박세리', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;

--DML 연습
--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
CREATE TABLE Customer(
custid NUMBER,
custname VARCHAR(20),
address VARCHAR(30));

INSERT INTO Customer VALUES(1, '박세리','서울시');
INSERT INTO Customer VALUES(2, '김연아','수원시');

SELECT * FROM customer;
UPDATE customer 
SET address='서울시' 
WHERE address='부산시';

DROP TABLE Customer;
-- TEACH
UPDATE CUSTOMER
SET ADDRESS = (
    SELECT ADDRESS
    FROM CUSTOMER
    WHERE CUSTNAME = '김연아'
)
WHERE CUSTNAME = '박세리';
-- 부산으로 원복
UPDATE CUSTOMER
SET ADDRESS = '부산시'
WHERE CUSTNAME = '박세리';

--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
DROP TABLE BOOK;

CREATE TABLE BOOK(
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR(20),
price NUMBER);

INSERT INTO Book VALUES(1, '축구의 역사', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 13000);


UPDATE BOOK SET bookname = REPLACE(BOOKNAME,'농구','야구')
WHERE BOOKNAME LIKE '%축구%';

SELECT * FROM BOOk;
DROP TABLE BOOK;

-- teach. 조회만하는것. 변경하려면 UPDATE SET 실행 후 커밋까지해야 됨.
SELECT bookid, REPLACE(bookname, '야구','농구') bookname, publisher, price
FROM Book;


--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
CREATE TABLE MADANG_BOOK_STORE(
custid NUMBER(10) PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(50) NOT NULL,
age NUMBER,
gender VARCHAR(10));

INSERT INTO MADANG_BOOK_STORE VALUES(1,'KIM','HongJun', 35, 'male');
INSERT INTO MADANG_BOOK_STORE VALUES(2,'KIM','HyeonDong', 70, 'male');
INSERT INTO MADANG_BOOK_STORE VALUES(3,'Gwon','YeongSuk', 62, 'female');
INSERT INTO MADANG_BOOK_STORE VALUES(4,'Gwon','YeongMi', 60, 'female');
INSERT INTO MADANG_BOOK_STORE VALUES(5,'KIM','SuMeong', 36, 'female');
select * from MADANG_BOOK_STORE;

SELECT gender as 성별, COUNT(*) AS 인원수
FROM MADANG_BOOK_STORE
WHERE gender = 'male'
GROUP BY gender;

drop table MADANG_BOOK_STORE;

-- TEACH. GROUP BY 절에서 별칭(성) 사용불가. 표현식(substr(name,1,1))을 사용해야 함.
SELECT * FROM customer;
SELECT substr(name,1,1) 성, count(*) 인원 FROM customer
GROUP BY substr(name,1,1);


--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
drop table madang_book;

CREATE TABLE MADANG_Book(
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8),
orderdate DATE);

select * from madang_book;

INSERT INTO madang_Book VALUES(1, '축구의 역사', '굿스포츠', 7000, TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(2, '축구아는 여자', '나무수', 13000, TO_DATE('2024-05-11', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(3, '축구의 이해', '대한미디어', 22000, TO_DATE('2024-05-12', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(4, '골프 바이블', '대한미디어', 35000, TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(5, '피겨 교본', '굿스포츠', 8000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000,TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(7, '야구의 추억', '이상미디어', 20000,TO_DATE('2024-05-14', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(8, '야구를 부탁해', '이상미디어', 13000,TO_DATE('2024-05-19', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(9, '올림픽 이야기', '삼성당', 7500,TO_DATE('2024-05-18', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(10, 'Olympic Champions', 'Pearson', 13000,TO_DATE('2024-05-20', 'YYYY-MM-DD'));

SELECT orderdate 주문일, ADD_months(orderdate, 2) from orders;

select orderdate 주문일, TO_CHAR(orderdate + 10, 'YY/MM/DD') 확정일자 from madang_Book;


--teach
SELECT * FROM orders;
SELECT orderid, orderdate 주문일, orderdate + 10 확정일, ADD_months(orderdate, 2) 납품일  FROM orders;


--Task6_0520.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT orderid 주문번호, TO_CHAR(orderdate, 'YYYY-mm-dd day') 주문일, custid 고객번호, bookid 도서번호 FROM orders
WHERE orderdate = '2020-07-07';

--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid 주문번호, saleprice 금액, (SELECT AVG(O2.saleprice) FROM orders O2) 평균가 FROM orders O1
WHERE O1.saleprice <= (SELECT AVG(O2.saleprice) FROM orders O2);

--teach - JOIN 사용, 서브커리를 O2라는 별칭으로 지정,  평균값을 avg_saleprice로 계산.
SELECT orderid, saleprice FROM orders O1
JOIN (SELECT AVG(saleprice) AS avg_saleprice FROM orders) O2
ON O1.saleprice < O2.avg_saleprice;


--Task8_0520. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT sum(saleprice) 총판매액 FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');


--[실습 - 2인 1조]
--학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.





