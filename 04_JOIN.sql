/*
    <JOIN>
        : �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� ����
          ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
          
    ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺� ��� ����
    (�ߺ� ������ �ּ�ȭ�ϱ� ���ؼ� �ִ��� �ɰ��� ������)
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺� "����"�� �δ� ���
    (������ �� ��ȸ�� ���°� �ƴ϶� �� ���̺� �� �����(�ܷ�Ű)�� ���� �����͸� ��Ī���� ��ȸ�ؾ� ��)
    
    JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����"(ANSI: �̱�����ǥ����ȸ)
    
    [�������]
    
                ����Ŭ ���� ����               |           ANSI ����
    ---------------------------------------------------------------------------
                � ����                      |             ���� ����
            (EQUAL JOIN)                     |  (INNER JOIN) => JOIN USING / ON
    ----------------------------------------------------------------------------
                ���� ����                      |         ���� �ܺ� ����(LEFT OUTER JOIN)
            (LEFT OUTER)                     |         ������ �ܺ� ����(RIGHT OUTER JOIN)
            (RIGHT OUTER)                    |         ��ü �ܺ� ����(FULL OUTER JOIN)
    --------------------------------------------------------------------------------
                ��ü ����(SELF JOIN)            |         JOIN ON
                �� ����(NON EQUAL JOIN)     |  
    --------------------------------------------------------------------------------            
*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

-- �����ڵ�, ���޸�
SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. � ����(EQUAL JOIN) / ���� ����(INNER JOIN)
        : �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ(== ��ġ�ϴ� ���� ���� ���� ��ȸ ����)
        
        1.1. ����Ŭ ���� ����
            FROM ���� ��ȸ�ϰ��� �ϴ� ���̺� ����(','�� ����)
            WHERE ���� ��Ī��ų �÷��� ���� ������ ����
        
        1.2. ANIS ����
            FROM ���� ������ �Ǵ� ���̺� �ϳ� ���
            JOIN ���� ���� �����ϰ��� �ϴ� ���̺� ��� && ��Ī��ų �÷��� ���� ���� ���
            JOIN USING / JOIN ON
            JOIN USING �� �����ϴ� �÷����� ���� ���� ��� ����
*/
--1.1. ����Ŭ ���� ����
--1.1.1.������ �� �÷����� �ٸ� ���(EMPLOYEE.DEPT_CODE / DEPARTMENT.DEPT_ID)
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- NULL, D3, D4, D7 �����ʹ� �� ���̺����� �����ϱ� ������ ���ܵ���
-- ��, ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ�

--1.1.2. ������ �� Į������ ���� ���(EMPLOYEE.JOB_CODE / JOB.JOB_CODE)
-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- ��Ī ��� ����


--1.2. ANSI ����

--1.2.1. ������ �� �÷����� �ٸ� ���(EMPLOYEE.DEPT_CODE / DEPARTMENT.DEPT_ID)

-- JOIN ON
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ��ȣ �ʼ�
--1.2.2. ������ �� �÷����� ���� ���(EMPLOYEE.JOB_CODE / JOB.JOB_CODE)
-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- JOIN USING
-- ��ü ������� ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- �߰����� ���ǵ� ����
-- ������ �븮�� ����� ���, �����, ���޸�, �޿� ��ȸ
-- ����Ŭ ���� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE ( E.JOB_CODE = J.JOB_CODE ) 
    AND JOB_NAME = '�븮';
-- ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

--=======================================����===================================
-- 1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
-- ����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
    AND DEPT_TITLE = '�λ������';
-- ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- 2. DEPARTMENT �� LOCATION ���̺� �����Ͽ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
    AND BONUS IS NOT NULL;

SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
    AND DEPT_TITLE != '�ѹ���';

SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';


-------------------------------------------------------------------------------
/*
    2. �������� / �ܺ�����(OUTER JOIN)
        : �� ���̺� �� JOIN �� ��ġ���� �ʴ� �൵ ���Խ��� ��ȸ ����
          ��, �ݵ�� LEFT / RIGHT �����ؾߵ�(�������̺��� ���ؾ���)
          
          2.1.LEFT [OUTER] JOIN
            : �� ���̺� �� ���� ����� ���̺��� �������� JOIN
          
          2.2.RIGHT [OUTER] JOIN
            : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
            
          2.3.FULL [OUTER] JOIN
            : �� ���̺��� ���� ��� ���� ��ȸ�� �� ����
              ����Ŭ ������ �������� ����
*/

-- �����, �μ���, �޿�, ����
-- ���� ���� �� �μ���ġ�� ���� ���� 2���� ��� ������ ������
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- DEPT_CODE NULL �� �ϵ���, �̿��� ����

-- 2.1.
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- DEPT_CODE �� �������� DEPT_ID �� �ְڴ�
-- �������̺��� ������ ������ ������ NULL �� ������ ��
-- ���ؿ� ���ʿ� �ֱ⿡ LEFT JOIN(�����ʿ� ������ RIGHT JOIN' WHERE DEPT_CODE(+) = DEPT_ID)

SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- ������ LEFT [OUTER] JOIN

-- 2.2.
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID );

-- 2.3
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 AS "����"
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON ( DEPT_CODE = DEPT_ID );

---------------------------------------------------------------------------------
/*
    3. �� ����(NON EQUAL JOIN)
        : ��Ī��ų �÷��� ���� ���� �ۼ��� '='�� ������� �ʴ� ���ι�
          ANSI �������δ� JOIN ON
          ������ ��Ī��Ŵ
*/
-- �����, �޿�, �޿�����
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL
ORDER BY SAL_LEVEL;

SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL )
ORDER BY SAL_LEVEL, SALARY DESC;

--------------------------------------------------------------------------------
/*
    4. ��ü ����(SELF JOIN)
        : ���� ���̺��� �ٽ� �� �� �����ϴ� ���
*/
-- ��ü ������� ���, �����, �μ��ڵ�
--              ������, �����, ����μ��ڵ�
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON ( E.MANAGER_ID = M.EMP_ID );

------------------------------------------------------------------------------------
/*
    <��������>
        : 2�� �̻��� ���̺��� ������ join �� ��
*/

-- ���, �����, �μ���, ���޸�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID 
    AND E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

-- ���, �����, �μ���, ������
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
ORDER BY LOCAL_NAME;    

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

----------------------����-----------------------------------------

-- 1. ���, �����, �μ���, ������, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE
WHERE (DEPT_CODE = DEPT_ID)
    AND (E.JOB_CODE = J.JOB_CODE)
    AND (LOCATION_ID = LOCAL_CODE)
    AND (L.NATIONAL_CODE = N.NATIONAL_CODE)
    AND (SALARY BETWEEN MIN_SAL AND MAX_SAL);

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);













