--�б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.
DROP TABLE SCHOOL cascade constraints purge;
DROP TABLE CLASS cascade constraints purge;
DROP TABLE PROFESSOR cascade constraints purge;
DROP TABLE STUDENTS cascade constraints purge;
DROP TABLE GRADE_1 cascade constraints purge;
DROP TABLE GRADE_2 cascade constraints purge;
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

insert into GRADE_2 values(2303001, '�հ��', 0.0, 2.4, 3.2, 1.7, 3.9);
insert into GRADE_2 values(2303002, 'ȫ�浿', 2.8, 3.3, 1.5, 3.0, 2.1);
insert into GRADE_2 values(2303003, '��ö��', 3.2, 2.1, 3.8, 2.5, 2.3);
insert into GRADE_2 values(2303004, '�̿���', 3.4, 2.0, 2.6, 3.2, 2.7);
insert into GRADE_2 values(2303005, '�ڹ���', 1.5, 3.7, 2.9, 3.5, 1.8);
insert into GRADE_2 values(2303006, '������', 2.3, 3.4, 3.0, 1.9, 3.3);
insert into GRADE_2 values(2303007, '����ȣ', 3.1, 2.6, 2.8, 3.6, 2.2);
insert into GRADE_2 values(2303008, '������', 2.0, 2.9, 3.3, 2.7, 2.5);
insert into GRADE_2 values(2303009, '������', 3.6, 2.3, 2.7, 0.0, 2.8);
insert into GRADE_2 values(2303010, '��ξ�', 2.2, 2.8, 3.1, 2.4, 3.0);
insert into GRADE_2 values(2303011, '����ȣ', 3.9, 3.5, 2.6, 3.8, 2.3);
insert into GRADE_2 values(2303012, '�̼���', 2.7, 3.3, 2.4, 3.1, 3.4);
insert into GRADE_2 values(2303013, '�ֹμ�', 3.5, 3.1, 3.2, 2.8, 2.9);
insert into GRADE_2 values(2303014, '������', 3.3, 2.6, 2.9, 3.3, 2.1);
insert into GRADE_2 values(2303015, '������', 2.6, 3.2, 0.0, 3.6, 2.4);
insert into GRADE_2 values(2303016, '���ؼ�', 2.9, 2.4, 3.1, 2.2, 3.3);
insert into GRADE_2 values(2303017, '������', 2.4, 0.0, 2.5, 2.8, 3.1);
insert into GRADE_2 values(2303018, '��μ�', 3.8, 2.7, 3.4, 2.9, 3.2);
insert into GRADE_2 values(2303019, '������', 2.3, 3.6, 2.9, 3.1, 2.6);
insert into GRADE_2 values(2303020, '�ڼҿ�', 2.7, 3.1, 2.8, 2.4, 3.5);
insert into GRADE_2 values(2303021, '������', 2.8, 3.5, 2.1, 3.2, 2.9);
insert into GRADE_2 values(2303022, '������', 3.2, 2.9, 3.3, 2.7, 2.5);
insert into GRADE_2 values(2303023, '�̹�ȣ', 2.5, 3.2, 2.6, 3.0, 3.1);
insert into GRADE_2 values(2303024, '������', 3.3, 2.4, 3.5, 2.9, 2.6);
insert into GRADE_2 values(2303025, '�ּ���', 2.9, 3.4, 2.7, 3.3, 3.2);
insert into GRADE_2 values(2303026, '�����', 0.0, 0.0, 0.0, 0.0, 0.0);
insert into GRADE_2 values(2303027, '������', 3.1, 2.8, 3.5, 2.6, 3.0);
insert into GRADE_2 values(2303028, '������', 2.8, 3.3, 2.1, 3.4, 2.7);
insert into GRADE_2 values(2303029, '������', 3.2, 2.5, 3.0, 2.9, 2.6);
insert into GRADE_2 values(2303030, '�����', 2.5, 3.0, 2.4, 3.1, 3.3);