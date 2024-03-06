/*
    DQL(QUERY ������ ���Ǿ�)
        : SELECT
    DML(DATA MANIPULATION LANGUAGE)
        : INSERT, UPDATE, DELETE
    DDL(DATA DEFINITION LANGUAGE)
        : CREATE, ALTER, DROP, TRUNCATE
    DCL(DATA CONTROL LANGUAGE)
        : GRANT, REVOKE
    TCL(TRANSACTION CONTROL LANGUAGE)
        : COMMIT, ROLLBACK
        
    <DML>
        : ������ ���� ���
          ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ������

*/
/*
    1. INSERT
        : ���̺� ���ο� ���� �߰��ϴ� ����
         
          [ǥ����]
          1)INSERT INTO ���̺�� VALUES(��, ��, ��,...)
              ���̺��� ��� �÷��� ���� ���� ���� ������ �� ���� INSERT �ϰ��� �� ��
              �÷��� ������ ���Ѽ� VALUES�� ���� �����ؾ���
          
          2)INSERT INTO ���̺��(�÷�, �÷�, �÷�) VALUES(��, ��, ��)
            ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
            �׷��� �� �� ������ �߰��Ǳ� ������ ���þȵ� �÷��� �⺻������ NULL �� ��
            => NOT NULL ���� ������ �ɷ��ִ� �÷��� �ݵ�� ���� ���� �־������
                ��, �⺻���� ���������� �� NULL �� �ƴ� �⺻���� ��
            ���� ���� ����    
                
          3)INSERT INTO ���̺�� (��������)
             VALUES�� ���� ����ϴ� �� ��� ���������� ��ȸ�� ������� ��°�� INSERT ���� 
*/
-- 1.1
INSERT INTO EMPLOYEE 
VALUES(900, '�̼ұ�', '880914-1456789', 'SG8809@naver.com', '01075966900',
        'D7', 'J5', 4000000, 0.2, 200, SYSDATE, NULL);
 --       �����ϰ� ���� ������ ��� -> not enough values ���� ����
INSERT INTO EMPLOYEE 
VALUES(900, '�̼ұ�', '880914-1456789', 'SG8809@naver.com', '01075966900',
        'D7', 'J5', 4000000, 0.2, 200, SYSDATE, NULL, 'N', NULL);
-- ���� �ʰ��ϰ� �־ ->  too many values ����
INSERT INTO EMPLOYEE 
VALUES(900, '�̼ұ�', '880914-1456789', 'SG8809@naver.com', '01075966900',
        'D7', 'J5', 4000000, 0.2, 200, SYSDATE, NULL, 'N');

--1.2
INSERT INTO EMPLOYEE
    (
     EMP_ID
    ,EMP_NAME
    ,EMP_NO
    ,JOB_CODE
    ,HIRE_DATE
    ) 
VALUES
    (
    901
    ,'������'
    ,'440701-1234567'
    ,'J7'
    ,SYSDATE
    );

SELECT * FROM EMPLOYEE;

--1.3.
CREATE TABLE EMP_01(
    EMP_ID NUMBER
    ,EMP_NAME VARCHAR(20)
    ,DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

INSERT INTO EMP_01(SELECT EMP_ID, EMP_NAME, DEPT_TITLE 
                   FROM EMPLOYEE
                   LEFT JOIN DEPARTMENT ON (DEPT_CODE =DEPT_ID));
---------------------------------------------------------------------
/*
    2. INSERT ALL
        : �� �� �̻��� ���̺� ���� INSERT�� ��
          �̶� ���Ǵ� ���������� ������ ���
          
          [ǥ����]
          INSERT ALL
          INTO ���̺��1 VALUES(�÷�, �÷�, �÷� ...)
          INTO ���̺��2 VALUES(�÷�, �÷�, ...)
          ��������;
          => ���������� �������� ���� ���̺� �� �Էµ�
*/
--> �׽�Ʈ ���̺�
CREATE TABLE EMP_DEPT
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0);
    -- ���� ������ �� ���� ������ �÷��� ��������
    
CREATE TABLE EMP_MANAGER
AS(SELECT EMP_ID, EMP_NAME, MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0);

-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
        (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
            FROM EMPLOYEE
            WHERE DEPT_CODE = 'D1');
            
SELECT * FROM EMP_DEPT;            
SELECT * FROM EMP_MANAGER;
-------------------------------------------------------------------------------
/*
    3. UPDATE
        : ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ����
        
        [ǥ����]
        1)
        UPDATE ���̺��
        SET �÷� = ��,
            �÷� = ��,
            ... -- AND�� �����ϴ� ���� �ƴ϶� �׳� �޸�(,)�� ����
        [WHERE ����] --> ������ ��� ���� �����Ͱ� ����
        
        * UPDATE �ÿ��� ���� ���� �� Ȯ���ؾ���
        
        2)
        UPDATE �� �������� ��� ����
        
        UPDATE ���̺��
        SET �÷��� = (��������)
        WHERE ����
*/
CREATE TABLE DEPT_TABLE
AS (SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;
-- D9 �μ��� �μ����� '������ȹ������ ����'

UPDATE DEPT_TABLE
SET DEPT_TITLE = '������ȹ��';
--  ��� �μ����� ������ȹ������ ������

UPDATE DEPT_TABLE
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';
-- D9 �μ��� �μ��� ������

CREATE TABLE EMP_SALARY
AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS 
    FROM EMPLOYEE);

-- ���ö ����� �޿��� �鸸������ ����
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '���ö';

-- ������ ����� �޿��� 7�鸸��, ���ʽ��� .2 �� ����
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2
WHERE EMP_NAME = '������';

-- ��ü ����� �޿��� ���� �޿��� 10% �λ�� �ݾ����� ����
UPDATE EMP_SALARY
SET SALARY = SALARY * 1.1;

SELECT * FROM EMP_SALARY;

--3.2.
--���� ����� �޿��� ���ʽ����� ����� ����� �޿��� ���ʽ������� ����
UPDATE EMP_SALARY
    SET SALARY = (SELECT SALARY 
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����'),
        BONUS = (SELECT BONUS 
                    FROM EMP_SALARY
                    WHERE EMP_NAME = '�����')
    WHERE EMP_NAME = '����';
--> ���߿��� ����
UPDATE EMP_SALARY
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                            WHERE EMP_NAME = '�����')
    WHERE EMP_NAME = '����';                    

-- ASIA ������ �ٹ��ϴ� ������� ���ʽ����� 0.3���� ����
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
                FROM EMP_SALARY
                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME LIKE 'ASIA%');

COMMIT;

-------------------------------------------------------------------------------
/*
    4. DELETE
        : ���̺� ��ϵ� �����͸� �����ϴ� ����(�� �� ������ ����)
        
        [ǥ����]
        DELETE FROM ���̺��
        [WHERE ����] --> WHERE �� �������� ������ ��ü �� ����
        
    
*/
DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;

ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '�̼ұ�';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '901';

COMMIT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- D1�� ���� ������ ���� �ڽĵ����Ͱ� �ֱ� ������ �������� ����(�ܷ�Ű ���� �� ON DELETE ����Ʈ)











