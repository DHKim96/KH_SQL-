/*
    <PL / SQL>
        : PROCEDURE LANGUAGE EXTENSION TO SQL
          
           ����Ŭ ��ü�� ����� ������ ���.
           SQL ���� ������ ������ ����, ����(IF), �ݺ�(FOR, WHILE) ���� �����ϸ�
          SQL�� ������ ����.
           �ټ��� SQL ���� �� ���� ���� ����.
           
        * PL /SQL ����
            - [�����]
                : DECLARE �� ����. ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
            - �����
                : BEGIN ���� ����. SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ���� ����ϴ� �κ�
            - [����ó����]
                : EXCEPTION ���� ����. ���ܹ߻� �� �ذ� ���� ����
                
*/
SET SERVEROUTPUT ON;
-- HELLO ORACLE ���
BEGIN
    -- JAVA : SYSTEM.OUT.PRINTLN("HELLO ORACLE");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
--------------------------------------------------------------------------------

/*
    1. DECLARE �����
        : ���� �� ��� �����ϴ� ����(����� ���ÿ� �ʱ�ȭ ����)
           �Ϲ�Ÿ�� ����, ���۷���Ÿ�� ����, ROWŸ�� ����
        1) �Ϲ� Ÿ�� ���� ���� �� �ʱ�ȭ
            [ǥ����]
            ������ [CONSTANT] �ڷ��� [:= ��]; -- ':=' PLSQL�� ���� ������
        2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ
            : � ���̺��� � �÷��� ������Ÿ���� �����ؼ� �� Ÿ������ ����
        3) ROW Ÿ�� ���� ����
            : ���̺��� �� �࿡ ���� ��� �÷����� �� ���� ���� �� �ִ� ����
            [ǥ����]
            ������ ���̺��%ROWTYPE;
    
*/      
--1.1)
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := &��ȣ;
    ENAME := '&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI :' || PI);
END;
/

--------------------------------------------------------------------------------
-- 1.2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ�
    -- �� ������ ����
    --> INTO ��ɾ� ���
    
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('EID :' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME :' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL :' || SAL);
END;
/

-------------------------------------------�ǽ�-------------------------------------
/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE �� �����ϰ�
    �� �ڷ��� EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY),
    DEPARTMENT(DEPT_TITLE) ���� �����ϵ���
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ �� �� ������ ��Ƽ� ���
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &���;    
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
    
END;
/

--------------------------------------------------------------------------------

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS, 0));
END;
/

--------------------------------------------------------------------------------
/* 
    2. BEGIN �����
        <���ǹ�>
        1) IF�� �ܵ� ��� ��
            [ǥ����]
            IF ���ǽ� THEN ���೻��; END IF;
        2) IF ELSE
            [ǥ����]
            IF ���ǽ� THEN ���೻��; ELSE ���೻��; END IF;
        3) ELSE IF
            [ǥ����]
            IF ���ǽ�1 THEN ���೻��1; 
            ELSEF ���ǽ�2 THEN ���೻��2; ... [ELSE ���೻��] 
            END IF;
        4) CASE WHEN THEN
            [ǥ����]
            CASE �񱳴���� 
                WHEN ����񱳰�1 THEN �����
                WHEN �񱳰�2 THEN �����
                ...
                ELSE �����
                END;
*/
-- �Է¹��� ����� �ش��ϴ� ����� ���, �̸�, �޿�, ���ʽ� ���
-- ��, ���ʽ��� ���� ���� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� ���� ����Դϴ�' ���
-- 2.1)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� ���� ����Դϴ�');
    END IF;    
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS);
END;
/

--2.2.
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� ���� ����Դϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || (BONUS * 100) || '%');
    END IF;    
END;
/

------------------------------------�ǽ�----------------------------------------
-- DECLARE
-- ���۷���Ÿ�Ժ���(EID, ENAME, DTITLE, NCODE)
--          �����÷�(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
--          �Ϲ�Ÿ�Ժ���(TEAM ���ڿ�) < == ������ , �ؿ���
-- BEGIN
--  ����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ������ ����
--      NCODE ���� KO �� ��� TEAM '������' ����
                -- �ƴҰ��         �ؿ��� ����
--  ���, �̸�, �μ�, �Ҽ� ���
-- END;
--/
DECLARE
    TEAM VARCHAR2(20);
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
    
END;
/
--------------------------
--2.3)
DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;

    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ ' || GRADE || '�����Դϴ�.');
    
END;
/

---------------------------------�ǽ�---------------------------------------------------------
-- ����ڿ��� �Է¹��� ����� ����� �޿��� ��ȸ�ؼ� SAL ���� ����
-- 500���� �̻��̸� ���
-- 4�鸸�� �̻��̸� �߱�
-- 3�鸸�� �̻��̸� �ʱ�
-- '�ش� ����� �޿������ XX�Դϴ�' ���

DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(6);
BEGIN
    SELECT EMP_NAME, SALARY
    INTO ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL >= 5000000
        THEN GRADE := '���';
    ELSIF SAL >= 4000000
        THEN GRADE := '�߱�';
    ELSE
        GRADE := '�ʱ�';
    END IF;    
    
    DBMS_OUTPUT.PUT_LINE(ENAME || ' ����� �޿������ ' || GRADE || '�Դϴ�.');

END;
/
-----------------------------------------------------------------

-- 2.4)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ���'
                WHEN 'D2' THEN 'ȸ����'
                WHEN 'D3' THEN '��������'
                WHEN 'D4' THEN '����������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�ؿܿ�����'
            END;
            
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '��(��) ' || DNAME || '�Դϴ�.');        
                
END;
/

------------------------------------------------------------------------
/*
    <�ݺ���>
        1) BASIC LOOP��
            [ǥ����]
            LOOP
                �ݺ������� ������ ����;
                *�ݺ����� �������� �� �ִ� ����
            END LOOP;
            
            * �ݺ����� �������� �� �ִ� ����(�б⹮?)
            1) IF ���ǽ� THEN EXIT; END IF;
            2) EXIT WHEN ���ǽ�;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        
       -- IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I = 6;
        
    END LOOP;
END;
/
--------------------------------------------------------------------------------
/*
    2) FOR LOOP��
        [ǥ����]
        FOR ���� IN [REVERSE] �ʱⰪ .. ������
        LOOP
            �ݺ������� ������ ����;
        END LOOP;    
*/
BEGIN
    FOR I IN 1 .. 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/
BEGIN
    FOR I IN REVERSE 1 .. 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST;

/*
    3) WHILE LOOP��
    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP
        �ݺ������ϴ� ����;
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
    END LOOP;
END;
/

-------------------------------------------------------------------------------
/*
    3. ����ó��
    ����(EXCEPTION)
        : ���� �� �߻��ϴ� ����
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        
    * �ý��� ����
        : ����Ŭ���� �̸� �����ص� ����
        - NO_DATA_FOUND
            : SELECT �� ����� �� �൵ ���� ���
        - TOO_MANY_ROWS
            : SELECT �� ����� �ʹ� ���� ���
        - ZERO_DIVIDE
            : 0���� ������
        - DUP_VAR_ON_INDEX
            : UNIQUE �������ǿ� ������� ���
        ...    
*/

-- ����ڰ� �Է��� ���� ������ ������ ��� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
    
EXCEPTION
   -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ���� �� 0���� ���� �� �����ϴ�');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ���� �� 0���� ���� �� �����ϴ�');
END;
/
/*
    UNIQUE �������� ����
    DUP_VAL_ON_INDEX
*/
ALTER TABLE EMPLOYEE MODIFY EMP_ID VARCHAR2(10);

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME = '���ö';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/














