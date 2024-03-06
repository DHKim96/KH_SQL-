/*
    <Ʈ����>
        : ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
          (���̺� �̺�Ʈ�� �߻����� ��)
          �ڵ����� �Ź� ������ ������ �̸� ������ �� �� �ִ�.
          
          EX)1. ȸ�� Ż�� �� ���� ȸ�� ���̺� ������ DELETE �� ��ٷ� Ż����
              ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ���Ѿ���
             2. �Ű�Ƚ���� ���� �� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ���
             3. ����� ���� �����Ͱ� ���(INSERT)�ɶ����� �ش� ��ǰ�� ���� �������� �Ź�
                ����(UPDATE)�ؾ���
          
          * Ʈ���� ����
            - SQL�� ���� �ñ⿡ ���� �з�
                > BEFORE TRIGGER
                    : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
                > AFTER TRIGGER
                    : ���� ������ ���̺� �̺�Ʈ�� �߻��� �� Ʈ���� ����
                
               �̺�Ʈ �߻��̶�? Ʈ������� COMMIT �� ����?
                
            - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
                > ���� Ʈ����
                    : �̺�Ʈ�� �߻��� SQL���� ���� �� �� ���� Ʈ���� ����
                > ��Ʈ����
                    : �ش� SQL�� ����ø��� �Ź� Ʈ���� ����
                      (FOR EACH ROW�ɼ� ����ؾ���)
                      > :OLD - BEFORE UPDATE(�������ڷ�), BEFORE DELETE(������ �ڷ�)
                      > :NEW - AFTER UPDATE(�������ڷ�), AFTER DELETE(���� �� �ڷ�)
            
            * Ʈ���� ���� ����
                [ǥ����]
                CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
                BEFORE | AFTER   INSERT | UPDATE | DELETE ON ���̺��
                [FOR EACH ROW]
                [DECLARE ���� ����]
                BEGIN
                    ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ���������� ������ ����)
                [EXCEPTION ����ó��]
                END;
                /  
*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT�� ������ �ڵ����� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');
END;
/
-- EMPLOYEE ���̺� INSERT �� �Ŀ� ����~ ȯ�� ���� ���

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(500, '�̼���', '111111-1111111', 'D7', 'J7', SYSDATE);

--------------------------------------------------------------------------------

-- ��ǰ�԰� �� ��� ���� ����
--> �ʿ��� ���̺� �� ������ ����
-- 1. ��ǰ�� ���� �����͸� ������ ���̺�(TB_PRODUCT)
DROP TABLE TB_PRODUCT;
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY, -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL, --��ǰ��
    BRAND VARCHAR2(30) NOT NULL, -- �귣���
    PRICE NUMBER, -- ��ǰ����
    STOCK NUMBER DEFAULT 0 -- ���
);

-- ��ǰ��ȣ �ߺ����� �ʰ� �Ź� ���ο� ��ǰ��ȣ �߻���Ű�� ������ ����
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���õ����� �߰�
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������24', '����', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������15', '�ֻ�', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, 'ȫ��2', '���ȴ�', 700000, 20);

COMMIT;

-- 2. ��ǰ ����� �� �̷� ���̺� ����(TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǵ��� ������ ���
CREATE TABLE TB_PRODETAIL(
    DECODE NUMBER PRIMARY KEY, -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT, -- ��ǰ��ȣ
    PDATE DATE NOT NULL, -- �������
    AMOUNT NUMBER NOT NULL, --��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���')) --����� ����
);

-- �̷¹�ȣ �ڵ� ������ ������
CREATE SEQUENCE SEQ_DECODE
NOCACHE;

DROP TABLE TB_PRODETAIL;

-- 200�� ��ǰ�� �������ڷ� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
INSERT INTO TB_PRODETAIL VALUES (SEQ_DECODE.NEXTVAL, 210, SYSDATE, 5, '�԰�');

-- 200�� ��ǰ�� ������ 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

UPDATE TB_PRODUCT
SET STOCK = STOCK + 5
WHERE PCODE = 210;

COMMIT;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� �ۼ�
/*
    ��ǰ �԰�� �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + ���� �԰�� ����(INSERT�� �ڷ��� AMOUNT)
    WHERE PCODE = �԰�� ��ǰ��ȣ(INSERT�� �ڷ��� PCODE)
    
    ��ǰ ���� �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - ���� ���� ����(INSERT�� �ڷ��� AMOUNT)
    WHERE PCODE = ���� ��ǰ��ȣ(INSERT�� �ڷ��� PCODE)
*/

DROP TRIGGER TRG_PRODUCTDETAIL;

CREATE OR REPLACE TRIGGER TRG_PRODUCTDETAIL
AFTER INSERT ON TB_PRODETAIL
DECLARE
    AMOUNT TB_PRODETAIL.AMOUNT%TYPE;
    STATUS TB_PRODETAIL.STATUS%TYPE;
    STOCK TB_PRODUCT.STOCK%TYPE;
BEGIN
    SELECT AMOUNT, STATUS
    INTO AMOUNT, STATUS
    FROM TB_PRODETAIL;
     
    IF STATUS = '�԰�'
        THEN STOCK := STOCK + AMOUNT;
    ELSIF STATUS = '���'    
        THEN STOCK := STOCK - AMOUNT;    
    END IF;

        UPDATE TB_PRODUCT
        SET STOCK
        WHERE PCODE := &��ǰ��ȣ;


END;
/

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF(:NEW.STATUS = '�԰�')
        THEN UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT 
            WHERE PCODE = :NEW.PCODE;
    ELSIF(:NEW.STATUS = '���')
        THEN UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT 
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ �������ڷ� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 210, SYSDATE, 7, '���');

-- 200�� ��ǰ�� �������ڷ� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');














