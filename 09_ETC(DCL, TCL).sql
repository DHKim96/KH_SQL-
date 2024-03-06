/*
    <DCL>
        : ������ ���(DATA CONTROL LANGUAGE)
          �������� �ý��� ���� �Ǵ� ��ü ���� ������ �ο��ϰų� ȸ���ϴ� ����
          
          > �ý��� ����
            : DB ���� ����, ��ü ���� ����
          > ��ü ���� ����
            : Ư�� ��ü���� ������ �� �ִ� ����
        
        <���� ����> ��
        CREATE USER ������ IDENTIFIED BY ��й�ȣ;
        GRANT ����(RESOURCE, CONNECT) TO ����;
*/
SELECT *
FROM ROLE_SYS_PRIVS;

/*
    <TCL>
        : Ʈ����� ���
        
        * Ʈ�����(TRANSACTION)
            : DB �� ���� ���� ����
              �������� �������(DML)���� �ϳ��� Ʈ����ǿ� ��� ó��
              DML�� �� ���� ������ �� Ʈ������� �������� �ʴ´ٸ� Ʈ������� ���� ����
                                    Ʈ������� �����Ѵٸ� �ش� Ʈ����ǿ� ��� ó��
              COMMIT �ϱ� �������� ������׵��� �ϳ��� Ʈ����ǿ� ����
                - Ʈ����� ����� �Ǵ� SQL DML ��ɹ� : INSERT / UPDATE / DELETE
              Ʈ����� ���� ��ɾ� : COMMIT / ROLLBACK / SAVEPOINT
                  COMMIT
                    : Ʈ����� ���� ó�� �� Ȯ��(DB �� �ݿ�)
                      �� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ�
                  ROLLBACK
                    : Ʈ����� ���
                      �� Ʈ����ǿ� ��� ������׵��� ����(���)�� �� ������ COMMIT �������� ���ư�
                  SAVEPOINT ����Ʈ��
                    : �ӽ� ����
                      ���� ������ �ش� ����Ʈ������ �ӽ� ����
            
*/
DROP TABLE EMP_01;

CREATE TABLE EMP_01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID));

SELECT * FROM EMP_01;

-- ����� 200���� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 200;

DELETE FROM EMP_01
WHERE EMP_ID = 201;

ROLLBACK;

SELECT * FROM EMP_01;
-- 200, 201�� �ٽ� ������

-------------------------------------------------------------------------------
-- ����� 200, 201���� ��� ����
DELETE FROM EMP_01 WHERE EMP_ID = 200;
DELETE FROM EMP_01 WHERE EMP_ID = 201;

SELECT * FROM EMP_01;

COMMIT;

ROLLBACK;

SELECT * FROM EMP_01;
-- COMMIT���� Ʈ������� DB�� ������ �ݿ��Ʊ� ������
-- ROLLBACK ���ε� 200, 201���� �������� ����

--------------------------------------------------------------------------------
-- 214, 216, 217 ��� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (214, 216, 217);

SELECT * FROM EMP_01 ORDER BY EMP_ID;

SAVEPOINT SP;

INSERT INTO EMP_01
VALUES(801, '�踻��', '���������');

DELETE FROM EMP_01 WHERE EMP_ID = 210;

SELECT * FROM EMP_01 ORDER BY EMP_ID;

ROLLBACK TO SP;
-- ���̺�����Ʈ�� �ѹ�

COMMIT;

-------------------------------------------------------------------------------
DELETE FROM EMP_01
WHERE EMP_ID = 210;

-- DDL�� ����
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

SELECT * FROM EMP_01;
-- DDL���� ����Ǹ� �����ͺ��̽��� ������ ����Ǳ� ������ ���� ���� �ڵ������� COMMIT �ع���

/*
   �� TCL ��� �� ������ ��
    DDL��(CREATE, ALTER, DROP)�� �����ϴ� ���� ���� Ʈ����ǿ� �ִ� ������׵���
    ������ COMMIT ��(���� DB �� �ݿ���)
    ��, DDL�� ���� �� ������׵��� ���� �� ��Ȯ�ϰ� �Ƚ��ϰ� DDL�� ������ ��
*/












