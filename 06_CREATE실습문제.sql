--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�

/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ���ȭ��ȣ) -- �������Ǿ���
*/
--���� 3������ ����
DROP TABLE TB_RENT;
DROP TABLE TB_MEMBER;
DROP TABLE TB_BOOK;
DROP TABLE TB_PUBLISHER;



CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUB_PK_NO PRIMARY KEY,
    PUB_NAME VARCHAR2(50) CONSTRAINT PUB_NT_NAME NOT NULL,
    PHONE VARCHAR2(13)
);

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ� ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

DELETE FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER
VALUES(1, 'å�� �Բ�', '02-111-2222');

INSERT INTO TB_PUBLISHER
VALUES(2, '�帧����', '033-222-3333');

INSERT INTO TB_PUBLISHER
VALUES(3, '������Ͽ콺', '031-333-4444');

SELECT * FROM TB_PUBLISHER;

/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/

DROP TABLE TB_BOOK;
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(50) CONSTRAINT BOOK__NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK__NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    CONSTRAINT BOOK_FK FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
);

INSERT INTO TB_BOOK
VALUES(1, '�� 3������', '������L.���̷�', 68400, 1);

INSERT INTO TB_BOOK
VALUES(2, '���� ��� ���� �ּ����� �����', '�Ӽҹ�', 16920, 2);

INSERT INTO TB_BOOK
VALUES(3, '������ �ð�', '�϶�Ʈ ���', 25200, 3);

INSERT INTO TB_BOOK
VALUES(4, '�ڹ�������1', '������', 300000, 3);

INSERT INTO TB_BOOK
VALUES(5, '�ڹ�������2', '������', 2400000, 3);


ALTER TABLE TB_BOOK
RENAME COLUMN KB_PUB_NO TO BK_PUB_NO;

SELECT * FROM TB_BOOK;


--5�� ������ ���� ������ �߰��ϱ�

/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/
--5�� ������ ���� ������ �߰��ϱ�

DROP TABLE TB_MEMBER;

CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK_NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ_ID UNIQUE NOT NULL,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(15) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(1) CONSTRAINT MEMBER_CK_GEN CHECK( GENDER IN('M', 'F')),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(13),
    STATUS CHAR(1) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK (STATUS IN ('N','Y')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL 
);


INSERT INTO TB_MEMBER VALUES(1, 'USER01', 'PASS01', '�赿��', 'M', '���ǵ�', '010-1111-2222', DEFAULT , DEFAULT);
INSERT INTO TB_MEMBER VALUES(2, 'USER02', 'PASS02', 'AAA', 'M', NULL, NULL, DEFAULT , DEFAULT);
INSERT INTO TB_MEMBER VALUES(3, 'USER03', 'PASS03', 'BBB', 'F', NULL, NULL, DEFAULT , DEFAULT);
INSERT INTO TB_MEMBER VALUES(4, 'USER04', 'PASS04', 'CCC', 'F', NULL, NULL, DEFAULT , DEFAULT);
INSERT INTO TB_MEMBER VALUES(5, 'USER05', 'PASS05', 'DDD', 'M', NULL, NULL, DEFAULT , DEFAULT);

/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/

CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER,
    RENT_BOOK_NO NUMBER,
    RENT_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT RENT_FK_MEM FOREIGN KEY(RENT_MEM_NO) REFERENCES TB_MEMBER ON DELETE SET NULL,
    CONSTRAINT RENT_FK_BOOK FOREIGN KEY(RENT_BOOK_NO) REFERENCES TB_BOOK ON DELETE SET NULL
);


--3�� ������ ���� ������ �߰��ϱ�
INSERT INTO TB_RENT VALUES(1, 1, 1, DEFAULT);
INSERT INTO TB_RENT VALUES(2, 2, 2, DEFAULT);
INSERT INTO TB_RENT VALUES(3, 3, 3, DEFAULT);

SELECT * FROM TB_RENT;