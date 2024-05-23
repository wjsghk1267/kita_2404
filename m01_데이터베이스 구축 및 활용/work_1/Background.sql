DROP table SCHOOL cascade constraints purge;
DROP table CLASS cascade constraints purge;
DROP table PROFESSOR cascade constraints purge;
DROP table GRADE_1 cascade constraints purge;
DROP table GRADE_2 cascade constraints purge;
DROP table STUDENTS cascade constraints purge;

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
    height      NUMBER(4, 1) DEFAULT NULL,
    weight      NUMBER(4, 1) DEFAULT NULL,
    phone       VARCHAR2(20) DEFAULT '010-xxxx-xxxx',
    enrollment  DATE
--    FOREIGN KEY(cls_id) REFERENCES CLASS(cls_id) ON DELETE CASCADE,
--    FOREIGN KEY(pro_id) REFERENCES PROFESSOR(pro_id) ON DELETE CASCADE
);
--2023�⵵ 1�б� ������Ϻ�
CREATE TABLE GRADE_1(
    std_id       NUMBER(7) NOT NULL,
    name        VARCHAR2(20),
    math        NUMBER NOT NULL,
    english     NUMBER NOT NULL,
    science      NUMBER NOT NULL,
    music     NUMBER NOT NULL,
    social     NUMBER NOT NULL,
    FOREIGN KEY (std_id) REFERENCES STUDENTS(std_id) ON DELETE CASCADE
);

--2023�⵵ 2�б� ������Ϻ�
CREATE TABLE GRADE_2(
    std_id       NUMBER(7) NOT NULL,
    name        VARCHAR2(20),
    math        NUMBER NOT NULL,
    english     NUMBER NOT NULL,
    science      NUMBER NOT NULL,
    music     NUMBER NOT NULL,
    social     NUMBER NOT NULL,
    FOREIGN KEY (std_id) REFERENCES STUDENTS(std_id) ON DELETE CASCADE
);

INSERT INTO STUDENTS VALUES (1, 1, 1, '�հ��', '����', 21, 175.5, 68.2, '010-1234-5678', TO_DATE('2023-03-15', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 2, 'ȫ�浿', '����', 22, 180.0, 70.5, '010-2345-6789', TO_DATE('2023-03-16', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 3, '��ö��', '����', 20, 172.0, 65.3, '010-3456-7890', TO_DATE('2023-03-17', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 4, '�̿���', '����', 21, 165.8, 55.9, '010-4567-8901', TO_DATE('2023-03-18', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 5, '�ڹ���', '����', 20, 167.5, 58.2, '010-5678-9012', TO_DATE('2023-03-19', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 6, '������', '����', 22, 163.0, 50.6, '010-6789-0123', TO_DATE('2023-03-20', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 7, '����ȣ', '����', 23, 178.3, 72.1, '010-7890-1234', TO_DATE('2023-03-21', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 8, '������', '����', 20, 170.2, 60.5, '010-8901-2345', TO_DATE('2023-03-22', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 9, '������', '����', 21, 166.7, 54.8, '010-9012-3456', TO_DATE('2023-03-23', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 10, '��ξ�', '����', 22, 172.5, 63.4, '010-0123-4567', TO_DATE('2023-03-24', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 11, '����ȣ', '����', 20, 177.8, 71.2, '010-1234-5678', TO_DATE('2023-03-25', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 12, '�̼���', '����', 21, 168.5, 57.3, '010-2345-6789', TO_DATE('2023-03-26', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 13, '�ֹμ�', '����', 23, 164.0, 49.7, '010-3456-7890', TO_DATE('2023-03-27', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 14, '������', '����', 20, 169.2, 56.8, '010-4567-8901', TO_DATE('2023-03-28', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 15, '������', '����', 21, 170.8, 59.2, '010-5678-9012', TO_DATE('2023-03-29', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 16, '���ؼ�', '����', 22, 176.3, 70.4, '010-6789-0123', TO_DATE('2023-03-30', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 17, '������', '����', 20, 168.7, 58.1, '010-7890-1234', TO_DATE('2023-03-31', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 18, '��μ�', '����', 21, 180.5, 75.6, '010-8901-2345', TO_DATE('2023-04-01', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 19, '������', '����', 22, 173.6, 62.5, '010-9012-3456', TO_DATE('2023-04-02', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 20, '�ڼҿ�', '����', 20, 165.4, 53.9, '010-0123-4567', TO_DATE('2023-04-03', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 21, '������', '����', 21, 179.2, 73.0, '010-1234-5678', TO_DATE('2023-04-04', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 22, '������', '����', 22, 170.9, 61.7, '010-2345-6789', TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 23, '�̹�ȣ', '����', 20, 175.0, 69.8, '010-3456-7890', TO_DATE('2023-04-06', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 24, '������', '����', 21, 166.3, 55.6, '010-4567-8901', TO_DATE('2023-04-07', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 25, '�ּ���', '����', 22, 168.0, 57.2, '010-5678-9012', TO_DATE('2023-04-08', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 26, '�����', '����', 20, 171.5, 60.3, '010-6789-0123', TO_DATE('2023-04-09', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 27, '������', '����', 21, 177.4, 71.8, '010-7890-1234', TO_DATE('2023-04-10', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 28, '������', '����', 22, 169.8, 57.5, '010-8901-2345', TO_DATE('2023-04-11', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 29, '������', '����', 20, 165.0, 52.8, '010-9012-3456', TO_DATE('2023-04-12', 'YYYY-MM-DD'));
INSERT INTO STUDENTS VALUES (1, 1, 30, '�����', '����', 21, 174.2, 67.1, '010-0123-4567', TO_DATE('2023-04-13', 'YYYY-MM-DD'));

insert into GRADE_1 values(1, '�հ��', 0.0, 3.1, 2.3, 4.0, 3.5);
insert into GRADE_1 values(2, 'ȫ�浿', 3.2, 0.0, 3.3, 2.0, 1.5);
insert into GRADE_1 values(3, '��ö��', 2.5, 3.2, 2.8, 3.6, 2.9);
insert into GRADE_1 values(4, '�̿���', 3.1, 2.7, 3.5, 2.4, 3.2);
insert into GRADE_1 values(5, '�ڹ���', 1.8, 2.9, 3.1, 3.0, 2.6);
insert into GRADE_1 values(6, '������', 2.7, 3.4, 2.5, 3.3, 3.1);
insert into GRADE_1 values(7, '����ȣ', 0.0, 2.6, 3.2, 2.8, 3.4);
insert into GRADE_1 values(8, '������', 3.4, 3.1, 0.0, 3.5, 2.7);
insert into GRADE_1 values(9, '������', 3.3, 2.5, 3.0, 2.6, 3.2);
insert into GRADE_1 values(10, '��ξ�', 2.8, 3.0, 2.7, 3.1, 2.9);
insert into GRADE_1 values(11, '����ȣ', 4.2, 3.8, 4.1, 3.9, 4.0);
insert into GRADE_1 values(12, '�̼���', 3.6, 4.3, 3.8, 4.2, 3.8);
insert into GRADE_1 values(13, '�ֹμ�', 3.1, 2.7, 3.1, 2.9, 3.3);
insert into GRADE_1 values(14, '������', 2.9, 3.0, 2.6, 3.4, 2.7);
insert into GRADE_1 values(15, '������', 3.4, 2.4, 3.2, 2.7, 3.1);
insert into GRADE_1 values(16, '���ؼ�', 2.7, 3.1, 2.8, 3.0, 2.9);
insert into GRADE_1 values(17, '������', 3.0, 2.0, 3.3, 2.6, 3.2);
insert into GRADE_1 values(18, '��μ�', 3.8, 4.2, 3.9, 4.1, 4.2);
insert into GRADE_1 values(19, '������', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(20, '�ڼҿ�', 2.9, 3.0, 2.7, 3.3, 2.8);
insert into GRADE_1 values(21, '������', 3.1, 2.8, 3.1, 2.5, 3.1);
insert into GRADE_1 values(22, '������', 2.7, 3.1, 2.6, 3.2, 2.9);
insert into GRADE_1 values(23, '�̹�ȣ', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_1 values(24, '������', 2.8, 3.0, 2.8, 3.1, 2.8);
insert into GRADE_1 values(25, '�ּ���', 4.1, 3.8, 4.2, 4.0, 4.1);
insert into GRADE_1 values(26, '�����', 2.9, 3.0, 2.7, 3.2, 2.7);
insert into GRADE_1 values(27, '������', 3.0, 2.8, 3.0, 2.6, 3.0);
insert into GRADE_1 values(28, '������', 2.8, 3.1, 2.7, 3.0, 2.8);
insert into GRADE_1 values(29, '������', 3.1, 2.7, 3.1, 2.5, 3.1);
insert into GRADE_1 values(30, '�����', 2.9, 3.0, 2.6, 3.1, 2.9);

insert into GRADE_2 values(1, '�հ��', 0.0, 2.4, 3.2, 1.7, 3.9);
insert into GRADE_2 values(2, 'ȫ�浿', 2.8, 3.3, 1.5, 3.0, 2.1);
insert into GRADE_2 values(3, '��ö��', 3.2, 2.1, 3.8, 2.5, 2.3);
insert into GRADE_2 values(4, '�̿���', 3.4, 2.0, 2.6, 3.2, 2.7);
insert into GRADE_2 values(5, '�ڹ���', 1.5, 3.7, 2.9, 3.5, 1.8);
insert into GRADE_2 values(6, '������', 2.3, 3.4, 3.0, 1.9, 3.3);
insert into GRADE_2 values(7, '����ȣ', 3.1, 2.6, 2.8, 3.6, 2.2);
insert into GRADE_2 values(8, '������', 2.0, 2.9, 3.3, 2.7, 2.5);
insert into GRADE_2 values(9, '������', 3.6, 2.3, 2.7, 0.0, 2.8);
insert into GRADE_2 values(10, '��ξ�', 2.2, 2.8, 3.1, 2.4, 3.0);
insert into GRADE_2 values(11, '����ȣ', 3.9, 3.5, 2.6, 3.8, 2.3);
insert into GRADE_2 values(12, '�̼���', 2.7, 3.3, 2.4, 3.1, 3.4);
insert into GRADE_2 values(13, '�ֹμ�', 3.5, 3.1, 3.2, 2.8, 2.9);
insert into GRADE_2 values(14, '������', 3.3, 2.6, 2.9, 3.3, 2.1);
insert into GRADE_2 values(15, '������', 2.6, 3.2, 0.0, 3.6, 2.4);
insert into GRADE_2 values(16, '���ؼ�', 2.9, 2.4, 3.1, 2.2, 3.3);
insert into GRADE_2 values(17, '������', 2.4, 0.0, 2.5, 2.8, 3.1);
insert into GRADE_2 values(18, '��μ�', 3.8, 2.7, 3.4, 2.9, 3.2);
insert into GRADE_2 values(19, '������', 2.3, 3.6, 2.9, 3.1, 2.6);
insert into GRADE_2 values(20, '�ڼҿ�', 2.7, 3.1, 2.8, 2.4, 3.5);
insert into GRADE_2 values(21, '������', 2.8, 3.5, 2.1, 3.2, 2.9);
insert into GRADE_2 values(22, '������', 3.2, 2.9, 3.3, 2.7, 2.5);
insert into GRADE_2 values(23, '�̹�ȣ', 2.5, 3.2, 2.6, 3.0, 3.1);
insert into GRADE_2 values(24, '������', 3.3, 2.4, 3.5, 2.9, 2.6);
insert into GRADE_2 values(25, '�ּ���', 2.9, 3.4, 2.7, 3.3, 3.2);
insert into GRADE_2 values(26, '�����', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(27, '������', 3.1, 2.8, 3.5, 2.6, 3.0);
insert into GRADE_2 values(28, '������', 2.8, 3.3, 2.1, 3.4, 2.7);
insert into GRADE_2 values(29, '������', 3.2, 2.5, 3.0, 2.9, 2.6);
insert into GRADE_2 values(30, '�����', 2.5, 3.0, 2.4, 3.1, 3.3);
