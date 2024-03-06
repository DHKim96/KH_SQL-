/*
    <������SEQUENCE>
        : �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü
          �������� ���������� �������� ������Ű�鼭 ��������
          
          EX) ȸ����ȣ, �����ȣ, �Խñ۹�ȣ, ...
          
          [ǥ����]
          CREATE SEQUENCE ��������
          [START WITH ���ۼ���] -- > ó�� �߻��� ���۰� ����(�⺻�� : 1)
          [INCREMENT BY ����] --> � �������� ����(�⺻�� : 1)
          [MAXVALUE ����] --> �ִ밪 ����(�⺻�� : �ſ� ū ��)
          [MINVALUE ����] --> �ּҰ� ����(�⺻�� : 1)
          (�ּҰ��� ��ȯ�� ���� ����)
          [CYCLE | NOCYCLE] --> ���� ��ȯ ���� ����(�⺻�� : NOCYCLE)
          [NOCACHE | CACHE ����Ʈũ��] --> ĳ�ø޸� �Ҵ�(�⺻�� : CACHE 20)
          
            * ĳ�ø޸�
                : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                  �Ź� ȣ��� ������ ���� ��ȣ �����ϴ� ���� �ƴ϶�
                  ĳ�ø޸� ������ �̸� ������ ������ ������ �� �� ����
                  (�ӵ� ���)
                  
            ���̺�� : TB_
            ��� : VW_
            �������� : SEQ_
            Ʈ���� : TRG_
*/
CREATE SEQUENCE SEQ_TEST;

-- [����] ���� ������ �����ϰ� �ִ� ���������� ���� ������ �� �� USER_SEQUENCES
SELECT * FROM USER_SEQUENCES;
-- ��, �ý��� ���̺�

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    2. ������ ���
        
        ��������.CURRVAL
            : (CURRENT VALUE ���)
               ���� ��������(���������� ������ NEXTVALUE�� ��)
        ��������.NEXTVAL
            : ���������� �������� �������� �߻��� ��
              ���� ������ ������ INCREMENT BY ����ŭ ������ ��
*/

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- ���� �߻�
-- WHY? NEXTVAL �� ���� �������� �ʾұ⿡ CURRVAL ���� �Ұ�
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.CURRVAL FROM DUAL;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 315�� ���� ���������� MAXVALUE 310 �̱⿡ ���� �߻�

/*
    3. �������� ���� ����
        
        [ǥ����]
        ALTER SEQUENCE ��������
         [INCREMENT BY ����] --> � �������� ����(�⺻�� : 1)
         [MAXVALUE ����] --> �ִ밪 ����(�⺻�� : �ſ� ū ��)
         [MINVALUE ����] --> �ּҰ� ����(�⺻�� : 1)
         [CYCLE | NOCYCLE] --> ���� ��ȯ ���� ����(�⺻�� : NOCYCLE)
         [NOCACHE | CACHE ����Ʈũ��] --> ĳ�ø޸� �Ҵ�(�⺻�� : CACHE 20)
        (START WITH : �̹� ������ �������̱⿡ ���� ���� ���� �Ұ�)
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 310 ���� 400���� 10�� �����ϵ��� �����߱⿡ 320 ��ȯ

/*
    4. ������ ����
        : DROP SEQUENCE ��������
*/
DROP SEQUENCE SEQ_EMPNO;

--------------------------------------------------------------------------------

CREATE SEQUENCE SEQ_EID
START WITH 400;

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES (SEQ_EID.NEXTVAL, '�踻��', '111111-2222222', 'J6', SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
        VALUES (SEQ_EID.NEXTVAL, '�����', '111111-2222222', 'J6', SYSDATE);


SELECT * FROM EMPLOYEE;














