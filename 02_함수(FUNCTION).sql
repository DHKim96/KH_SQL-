SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

/*
    <ORDER BY ��>
    SELECT�� ���� ������ �ٿ� �ۼ�
    ���� ���� ���� ���� �������� ������
    
    [ǥ����]
    SELECt ��ȸ�� �÷�...
    FROM ��ȸ�� ���̺�
    WHERE ���ǽ�
    ORDER BY ���� ������ �� �÷��� | ��Ī | �÷� ���� [ASC | DESC] [NULLS FIRST | NULLS LAST]
    - ASC : �������� (�⺻��)
    - DESC : ��������
    - NULLS FIRST : ���� ���� �÷����� NULL ���� ��� �ش� ������ �� �տ� ��ġ(DESC�� �� �⺻��)
    - NULLS LAST : ~ ������ �� �ڿ� ��ġ(ASC�϶� �⺻��) ��, NULL �� ���� ū ������ �ν��ϸ� �⺻����
*/

SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; �⺻���� �������� -- ���� �÷��� �����Ͱ��� ���� ��� ���� ������ ���� ������ ��
-- ORDER BY BONUS ASC;
-- ORDER BY BONUS ASC NULLS FIRST; 
-- ORDER BY BONUS DESC;
ORDER BY BONUS DESC, SALARY ASC;
-- ���� ���� �÷����� ������ ��� �� ���� ������ ���ؼ� ���� ���� ���� �÷��� ������ �� ����

-- �� ����� �����, ����(���ʽ� ����) ��ȸ(�� �� ������ �������� ����)
SELECT EMP_NAME, ( SALARY * 12 ) AS "����"
FROM EMPLOYEE
-- ORDER BY ( SALARY * 12 ) DESC;
-- ORDER BY ���� DESC;
ORDER BY 2 DESC; -- ����Ʈ���� �� ��° �÷��� ���� �������� �Ѵٴ� �ǹ� BUT ��ȣ�ϴ� ��Ÿ���� �ƴ�

--========================================================
/*
    <�Լ� FUNCTION>
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ
    
    - ������ �Լ�
        : N���� ���� �о�鿩�� N���� ������� ����(���ึ�� �Լ� ���� ����� ��ȯ)
    - �׷� �Լ�
        : N���� ���� �о�鿩�� 1���� ������� ����(�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    >> SELECT ������ ������ �Լ��� �׷��Լ��� �Բ� ������� ����
    ��? ������� ������ �ٸ��� ������
    
    >> �Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/

--============================<������ �Լ�>====================================
/*
    <���� ó�� �Լ�>
    
    * LENGTH(�÷� | '���ڿ�')
        : �ش� ���ڿ��� ���� �� ��ȯ
    * LENGTHB(�÷� | '���ڿ�')
        : �ش� ���ڿ��� ����Ʈ ���� ��ȯ
        CF) �ѱ��� ���ڴ� 3BYTE
            ������, ����, Ư������ ���ڴ� 1BYTE
*/

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('ORACLE'), LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
        EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;
    

--================================================================

/*
    *INSTR
    ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷� | '���ڿ�', 'ã���� �ϴ� ����', ['ã�� ��ġ�� ���۰�(����Ʈ: 1)', ����(����Ʈ: 1)])
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;  -- ù B�� �� ��° ��ġ�� �ִٰ� ���� => NUMBER�� ��ȯ

SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
-- '-����'�� �ڿ������� ã�� ���ڰ�, �㳪 ���� ���� ������ �о �˷���

SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
-- ���� �����Ϸ��� ã�� ��ġ�� ���۰��� ǥ���ؾ���

SELECT EMAIL, INSTR(EMAIL, '_') AS "LOCATION",
                INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;

--=========================================================================

/*
    *SUBSTR / ���� ����
        : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
    SUBSTR(STRING, POSITION, [LENGTH])
    - STRING : ���� Ÿ���� �÷� | '���ڿ�'
    - POSITION : ���ڿ� ������ ���� ��ġ�� ��
    - LENGTH : ������ ������ ����(�����ϸ� ������)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7��° ��ġ���� ������ ����

--SHOWME�� ���
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ����� �� ������鸸 ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

-- ����� �� ������鸸 ��ȸ
SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1'
ORDER BY EMP_NAME;

-- �Լ� ��ø ��� ����
-- �̸��� ���̵� �κи� ����
-- ��� ��Ͽ��� �����, �̸���, ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, ( INSTR(EMAIL, '@') - 1 )) AS "���̵�"
FROM EMPLOYEE
ORDER BY EMP_NAME;
--==================================================================

/*
    *LPAD / RPAD
        : ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� ���
        
        [ǥ����]
        LPAD / RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����])
        
        ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� N ���̸�ŭ�� ���ڿ� ��ȯ    
*/

-- 20��ŭ�� ���� �� EMAIL �÷����� ���������� �����ϰ� ������ �κ��� �������� ä���
SELECT EMP_NAME, LPAD(EMAIL, 20) FROM EMPLOYEE; -- ������ ����Ʈ��

SELECT EMP_NAME, RPAD(EMAIL, 20) FROM EMPLOYEE;

SELECT RPAD('910524-1', 14, '*')
FROM DUAL;

-- ������� �����, �ֹε�Ϲ�ȣ ��ȸ(�� ��ȸ ������ "910524-1******" ����)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE
ORDER BY EMP_NO;

--=======================================================================
/*
    *LTRIM / RTRIM
        : ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
        
        [ǥ����]
        LTRIM/RTRIM(STRING, [�����ϰ��� �ϴ� ���ڵ�])
        
        ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
*/

SELECT LTRIM('    K  H') -- ���ʿ��� �ٸ� ���ڰ� ���ö������� ���� ����
FROM DUAL;

SELECT LTRIM('123123KH123', '123') FROM DUAL;
-- '123'�� ������ ���°� �ƴ϶� �� ���ھ� �ν��ؼ� ����

SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
-- �����ϰ��� �ϴ� ���ڵ�! NOT ���ڿ�

SELECT RTRIM('574185KH123', '0123456789')
FROM DUAL;

/*
    *TRIM
        : ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
        [ǥ����]
        TRIM([LEADING | TRAILING | BOTH] �����ϰ����ϴ� ���ڿ� FROM ���ڿ�)
*/

SELECT TRIM('       K   H      ')
FROM DUAL; 
-- (�⺻��)���ʿ� �ִ� ���� ����

SELECT TRIM('Z' FROM 'ZZZZKHZZZZ')
FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZZ')
FROM DUAL;
-- ���ʿ� �ִ� Ư�� ����(��) ����

SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZZ')
FROM DUAL;
-- LTRIM �� ������ ���

SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZZ')
FROM DUAL;
-- RTRIM�� ������ ���

--===================================================================
/*
    *LOWER / UPPER / INITCAP
    
    * LOWER
        : ���ڿ��� �ҹ��ڷ� ������ ���ڿ� ��ȯ
    * UPPER
        : ���ڿ��� �빮�ڷ� ������ ���ڿ� ��ȯ
    * INITCAP
        : ���� ���� ù ���ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

SELECT LOWER('Welcome To My World')
FROM DUAL;

SELECT UPPER('Welcome To My World')
FROM DUAL;

SELECT INITCAP( LOWER('Welcome To My World') ) FROM DUAL;

--=====================================================================

/*
    *CONCAT
       : ���ڿ� �� �� ���� �޾� �ϳ��� ��ģ �� ��ȯ(�� �� �̻��� �ȵ�)
            ���� ||(���Ῥ����) ���� ���
       [ǥ����]
       CONCAT(STRING1, STRING2)
*/

SELECT CONCAT('������', 'ABC') FROM DUAL;

SELECT '������' || 'ABC'
FROM DUAL;

--========================================================================

/*
    *REPLACE
        : Ư�� ���ڿ��� Ư�� �κ��� �ٸ� �κ����� ��ü
        [ǥ����]
        REPLACE(���ڿ�, ã�� ���ڿ�, ������ ���ڿ�)
*/

SELECT EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'gmail.com')
FROM EMPLOYEE;

--======================================================================
/*
    <���� ó�� �Լ�>
    * ABS
        : ������ ���밪�� �����ִ� �Լ�
        [ǥ����]
        ABS(NUMBER)
*/

SELECT ABS(-10), ABS(-6.3) FROM DUAL;


/*
    *MOD
        : �� ���� ���� ������ ���� ��ȯ���ִ� �Լ�
        [ǥ����]
        MOD(NUMBER, NUMBER)
*/

SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

/*
    *ROUND
        : �ݿø��� ����� ��ȯ
        
        [ǥ����]
        ROUND(NUMBER, [��ġ]) 
        
        ��ġ�� �⺻���� 0(�Ҽ��� ù��° �ڸ����� �ݿø�)
        ����� �����Ҽ��� �Ҽ��� �ڷ� �� �ڸ��� �̵��ؼ� �ݿø�
        ������ �����Ҽ��� �Ҽ��� ������ �� �ڸ��� �̵��ؼ� �ݿø�
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL; 
SELECT ROUND(123.456, -1) FROM DUAL;

/*
    *CEIL
        : �ø� ó���� ���� �Լ�
        
        [ǥ����]
        CEIL(NUMBER)
*/
SELECT CEIL(123.456) FROM DUAL;

/*
    *FLOOR
        : ���� ó�� ���� �Լ�
        
        [ǥ����]
        FLOOR(NUMBER)
*/
SELECT FLOOR(123.955) FROM DUAL;

/*
    *TRUNC
        : ���� ó�� �Լ� 2
        
        [ǥ����]
        TRUNC(NUMBER, [��ġ])
        
        FLOOR �Լ��� �ٸ��� ���� ��ġ ���� ����
*/
SELECT TRUNC(123.952) FROM DUAL;
SELECT TRUNC(123.952, 1) FROM DUAL;
SELECT TRUNC(123.952, -1) FROM DUAL;

--=============================================QUIZ=================================
-- �˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7 �̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰�
-- BONUS�� �ְ� �����̸� �̸��� �ּҴ� _�տ� �� ���ڸ� �ִ� �����
-- �̸�, �ֹε�Ϲ�ȣ, �����ڵ�, �μ��ڵ�, �޿�, ���ʽ��� ��ȸ�ϰ� �ʹ�.
-- ���������� ��ȸ�Ǹ� ����� 2��
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE ( JOB_CODE IN ('J7', 'J6')) AND 
(SALARY >= 2000000) AND 
( BONUS IS NOT NULL ) AND
( SUBSTR(EMP_NO, 8, 1) IN ( '2', '4') ) AND 
( EMAIL LIKE '___\_%' ESCAPE '\' );


--=======================================================================
--    <��¥ ó�� �Լ�>

/*
    *SYSDATE
        : �ý����� ���� ��¥ �� �ð� ��ȯ
*/
SELECT SYSDATE FROM DUAL;

/*
    *MONTHS_BETWEEN
        : �� ���� ������ ���� �� ��ȯ
        
        [ǥ����]
        MONTHS_BETWEEN(A, B)
*/
-- ������� �����, �Ի���, �ٹ��ϼ�, �ٹ��������� ��ȸ
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE),
        FLOOR( MONTHS_BETWEEN(SYSDATE, HIRE_DATE) )
FROM EMPLOYEE;

SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE),
        CEIL( MONTHS_BETWEEN(SYSDATE, HIRE_DATE) ) || '������' AS "�ټӰ�����"
FROM EMPLOYEE;

/*
    *ADD_MONTHS
        : Ư�� ��¥�� NUMBER�������� ���ؼ� ��ȯ
        
        [ǥ����]
        ADD_MONTHS(Ư�� ��¥, NUMBER)
*/
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

-- �ٷ��� ���̺��� �����, �Ի���, �Ի� �� 3������ ��¥ ��ȸ(������ ��ȯ��)
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) AS "������ ��ȯ��"
FROM EMPLOYEE;

/*
    *NEXT_DAY
        : Ư�� ��¥ ���� ���� ����� ������ ��¥ ��ȯ
        
        [ǥ����]
        NEXT_DAY(DATE, ����(���� | ����) )
        ���ڸ� ���ͷ�('')�� ǥ���ϸ� �ȵ�
*/
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;
-- SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL; -- ��� ������� �ѱ���� �ȵ�
--CF) ��� ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

/*
    *LAST_DAY
        : �ش� ���� ������ ��¥ ���ؼ� ��ȯ
        [ǥ����]
        LAST_DAT(DATE)
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ������̺��� �����, �Ի���, �Ի���� ������ ��¥, �Ի���� �ٹ��ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, 
        LAST_DAY(HIRE_DATE) AS "�Ի�� ������ ��¥",
        ( LAST_DAY(HIRE_DATE) - HIRE_DATE ) AS "�Ի�� �ٹ��ϼ�"
FROM EMPLOYEE;

/*
    *EXTRACT
        : Ư�� ��¥�κ��� ���� | �� | �� ��(NUMBER)�� �����ؼ� ��ȯ�ϴ� �Լ�
        
        [ǥ����]
        EXTRACT(YEAR | MONTH | DAY FROM Ư�� ��¥)   
*/
-- �ش� ����� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME, 
    EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",  
    EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��", 
    EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY �Ի�⵵, �Ի��, �Ի���;

--==============================================================================

-- <����ȯ �Լ�>
/*
    *TO_CHAR
        : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ ��ȯ�����ִ� �Լ�
        
        [ǥ����]
        TO_CHAR(���� | ��¥, [����])
*/
-- ���� Ÿ�� => ���� Ÿ��
SELECT TO_CHAR(1234) FROM DUAL;

SELECT TO_CHAR(1234, '99999') AS "NUMBER" FROM DUAL; 
-- ����Ȯ���ϰڴٴ� �ǹ�('999...' 9�� �ڸ� �� ��ŭ ��ĭ���� ����), ������ ����
SELECT TO_CHAR(1234, '00000') AS "NUMBER" FROM DUAL;
-- 0�� �ڸ�����ŭ ���� Ȯ��, ������ ����, ��ĭ�� 0���� ä��
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
-- ��ȭ ǥ�ð� �پ �����(���� ������ ������ ���� ȭ����� ����)
-- �޷��� �׳� '$99999' ǥ���ϸ� ��(�޷��� ������ȭ�̱� ������)
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(3500000, 'L9,999,999') FROM DUAL;

-- ������� �����, ����, ������ ��ȸ
SELECT EMP_NAME, 
    TRIM ( TO_CHAR(SALARY,'L9,999,999') )AS "����", 
    TRIM ( TO_CHAR( ( SALARY * 12 ), 'L99,999,999') ) AS "����"
FROM EMPLOYEE;

-- ��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL; -- ��¥Ÿ�� ������
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- �����ϸ� ����
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
-- AM, PM �� � ���� ���� �������� �´� ���Ŀ� ���缭 ����
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
-- 24�ð� �������� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
-- "DAY" : ���ϱ��� �پ ����
-- "DY" : ���� �̸��� ����
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

-- �����, �Ի糯¥(YYYY�� MM�� DD��) ��ȸ
SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') 
FROM EMPLOYEE;
-- ū����ǥ�� ��Ʈ�� ǥ�ø� ����� ������ ���� ������ �߰������� ���ڸ� �ν��� �� ����


-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'), 
        TO_CHAR(SYSDATE, 'YY'),
        TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'RR')
FROM DUAL;
-- RR���� ���� ������ -> 50�� �̻� ���� + 100 -> EX) 1954
SELECT HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'RRRR') FROM EMPLOYEE;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'), -- �̹����� ���° ������
        TO_CHAR(SYSDATE, 'MON'), -- �̹����� �������
        TO_CHAR(SYSDATE, 'MONTH') 
FROM DUAL;


-- �ϰ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), -- ������ �̹��⵵���� ���° �ϼ�
        TO_CHAR(SYSDATE, 'DD'), -- ������ ��ĥ����
        TO_CHAR(SYSDATE, 'D') -- ���° ��������
FROM DUAL;

--=========================================================================

/*
    TO_DATE
        : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �����ϴ� �Լ�
    [ǥ����]
        TO_DATE(���� | ����, [����])
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(650219) FROM DUAL;
-- 50�� ���ķδ� 1900���� ���ư�
-- ���� 2000����� 50�� ���ĸ� ���� �ʹٸ� �⵵�� õ, �����ڸ��� ����ؾ� ��
SELECT TO_DATE(20650219) FROM DUAL;
SELECT TO_DATE(020505) FROM DUAL;
-- ���ڴ� 0���� �����ϸ� �ȵ�
SELECT TO_DATE('020505') FROM DUAL;
-- �ú��ʴ� ���� 000000
-- �ú��ʸ� �����ϱ� ���ؼ��� ������ ������� ��
SELECT TO_DATE('20240219 120800', 'YYYYMMDD HH24MISS') FROM DUAL;

--============================================================================

/*
    TO_NUMBER
        : ���� Ÿ���� �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�
        
        [ǥ����]
        TO_NUMBER(����, [����])
*/

SELECT TO_NUMBER('05123456789') FROM DUAL;

SELECT '100000' + '55000' FROM DUAL; -- ���ϱ��϶��� �ڵ����� ����ȯ����

SELECT '100000' + '55,000' FROM DUAL;  -- �޸������� ���ڷ� �ν��ؼ� �ȵ�

SELECT  TO_NUMBER('100,000', '999,999') + TO_NUMBER('55,000', '99,999')
-- ������ �������� ��
FROM DUAL;

--===============================================================================

-- <NULL ó�� �Լ�>

/*
    *NVL
        :
        [ǥ����]
        NVL(�÷�, �ش� �÷����� NULL�� ��� ������ ��ȯ��)
        
    *NVL2
        [ǥ����]
        NVL2(�÷�, ��ȯ��1, ��ȯ��2)
        ��ȯ�� 1: �ش� �÷��� ������ ��� ������ ��
        ��ȯ�� 2: �ش� �÷��� NULL�� ��� ������ ��
*/
-- ������� �̸�, ���ʽ� ���� ����(NULL ó�� ��)
SELECT EMP_NAME,
       ( SALARY + (SALARY * NVL( BONUS, 0 )) ) * 12 AS "����"
FROM EMPLOYEE;  

SELECT EMP_NAME,
        BONUS,
        NVL2(BONUS, 'O', 'X')
FROM EMPLOYEE;

-- ������� ������ �μ���ġ����(�����Ϸ� �Ǵ� �̹��� ǥ��) ��ȸ
SELECT EMP_NAME,
        NVL2(DEPT_CODE, '�����Ϸ�', '�̹���')
FROM EMPLOYEE;

/*
    *NULLIF
        [ǥ����]
        NULLOF(�񱳴��1, �񱳴��2)
        : �񱳴�� ��ġ�� NULL, ����ġ�� �񱳴�� 1��ȯ

*/
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

--=============================================================================

-- <�����Լ�>

/*
    *DECODE
        [ǥ����]
        DECODE(�񱳴��(�÷�, �����, �Լ���), 
                �񱳰�1, �����1, 
                �񱳰�2, �����2, ...)
                -- �񱳰��� ���� ������� ��� ����Ʈ���� ��
        
        CF) �ڹٿ����� SWITCH���� ����
*/
-- ���, �����, �ֹι�ȣ, ���� ��ȸ
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE( SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����"
FROM EMPLOYEE;        

-- ������, �޿� ��ȸ. �ٸ�, �� ���� ���� �λ��ؼ� ��ȸ
-- J7 : 10% �λ�
-- J6 : 10% �λ�
-- J5 : 20% �λ�
-- �׿� ������� �޿��� 5% �λ�
SELECT EMP_NAME,
        SALARY AS "�λ���",
        DECODE(JOB_CODE, 
                'J7', SALARY * 1.1, 
                'J6', SALARY * 1.1, 
                'J5', SALARY * 1.2, 
                      SALARY * 1.05)  AS "�λ���"
FROM EMPLOYEE;

/*
    *CASE WHEN THEN
    
    CASE
        WHEN ���ǽ�1 THEN �����1
        WHEN ���ǽ�2 THEN �����2
        ...
        ELSE �����
    END    
*/
SELECT EMP_NAME, SALARY,
        CASE 
            WHEN SALARY >= 5000000 THEN '���'
            WHEN SALARY >= 3500000 THEN '�߱�'
            ELSE '�ʱ�'
        END AS "���� ����"
FROM EMPLOYEE;        

-----------------------------�׷��Լ�-------------------------------------------

/* 
    1. SUM(����Ÿ���÷�)
        : �ش� �÷������� �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�
*/
-- �ٷ������̺��� ������� �� �޿��� ���ض�
SELECT SUM(SALARY) -- �������Լ�
FROM EMPLOYEE;

-- ���ڻ������ �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

--�μ��ڵ尡 D5�� ������� �� ����(�޿� * 12)
SELECT SUM(SALARY * 12)
FROM EMPLOYEE
WHERE SUBSTR(DEPT_CODE, 1) = 'D5';

/*
    2. AVG(NUMBER)
        : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
*/
SELECT ROUND( AVG(SALARY) )
FROM EMPLOYEE;

/*
    3.MIN(���Ÿ�԰���)
        : �ش� �÷��� �� ���� ���� �� ���ؼ� ��ȯ
          (���ڿ����� ���������� ���� ���� �����ϴ� ���� ���� ���� ����)
*/
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

/*
    4. MAX(���Ÿ�԰���)
        : �ش� �÷��� �� ���� ū ���� ��ȯ
*/
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

/*
    5.COUNT( * | �÷� | DISTINCT �÷�)
        : �ش� ������ �����ϴ� ���� ������ ��ȯ
        COUNT(*)
            : ��ȸ ����� ��� ���� ������ ��ȯ
        COUNT(�÷�)
            : �ش� �÷����� NULL�� �ƴ� ���� ������ ��ȯ
        COUNT(DISTINCT �÷�)
            : �ش� �÷��� �ߺ� ���� �� ���� ���� ��ȯ
*/
-- ��ü ��� ��
SELECT COUNT(*) FROM EMPLOYEE;

-- ���ڻ�� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4') ;

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS)
FROM EMPLOYEE;
-- �μ���ġ ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;
-- ���� ������� �� �� ���� �μ��� �����Ǿ� �ִ��� ��ȸ
SELECT COUNT(DISTINCT DEPT_CODE) AS "�μ� ����"
FROM EMPLOYEE;