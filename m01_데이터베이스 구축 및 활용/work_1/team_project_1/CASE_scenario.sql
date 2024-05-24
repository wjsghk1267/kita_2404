--[�ǽ� - 2�� 1��]
--�б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.
--����/��� - �л���Ϻ�  -- case ������ȸ.(2023�⵵ 1/2�б�). ������¥���, ��������з�'F'
SELECT * FROM GRADE_1;
SELECT * FROM GRADE_2;
SELECT * FROM STUDENTS;


-- NO1. 1�б� Ư������ ������ ��ȸ
SELECT std_id �й�, name �̸�, math
FROM GRADE_1
WHERE math = 0.0;


-- NO2. 1�б� ���� ����� Ȯ��
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
