/*
    <GROUP BY��>
        : �׷������ ������ �� �ִ� ����(�ش� �׷���غ��� ���� �׷����� ���� �� ����)
          ���� ���� ������ �ϳ��� �׷����� ��� ó���ϴ� ����
*/
SELECT SUM(SALARY)
FROM EMPLOYEE;
-- ��ü ����� �ϳ��� �׷����� ��� �� ���� ���� ���

-- �� �μ��� �� �޿�
-- �� �μ����� ���� �׷���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC NULLS FIRST;

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*) AS "�����", SUM(SALARY) -- 3
FROM EMPLOYEE -- 1
GROUP BY DEPT_CODE  -- 2
ORDER BY DEPT_CODE ASC NULLS FIRST; -- 4

-- �� ���޺� �ѻ����, ���ʽ��� �޴� ��� ��, �޿���, ��ձ޿�, �����޿�, �ְ�޿�
-- ���� �������� ����
SELECT JOB_CODE AS "����", 
        COUNT(*) AS "�����",
        COUNT(BONUS) AS "���ʽ����",
        TO_CHAR(SUM(SALARY) , 'L99,999,999'),
        LPAD((TO_CHAR( SUM(SALARY) , '99,999,999')), '11') AS "�޿��հ�(��)",
        LPAD((TO_CHAR( ROUND(AVG(SALARY)), '9,999,999')), '10') AS "��ձ޿�(��)",
        LPAD((TO_CHAR( MIN(SALARY), '9,999,999')), '10') AS "�����޿�(��)",
        LPAD((TO_CHAR( MAX(SALARY), '9,999,999')), '10')AS "�ְ�޿�(��)"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--GROUP BY ���� �Լ��� ��� ����
SELECT  DECODE( SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') AS "����",
        COUNT(*) AS "�����",
        COUNT(BONUS) AS "���ʽ����",
        LPAD((TO_CHAR( SUM(SALARY) , 'FML99,999,999')), '12') AS "�޿��հ�(��)",
        LPAD((TO_CHAR( ROUND(AVG(SALARY)), 'FML9,999,999')), '11') AS "��ձ޿�(��)",
        LPAD((TO_CHAR( MIN(SALARY), 'FML9,999,999')), '11') AS "�����޿�(��)",
        LPAD((TO_CHAR( MAX(SALARY), 'FML9,999,999')), '11')AS "�ְ�޿�(��)"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);
-- TO_CHAR�� ����� ��ȭ ǥ�ø� �����ϸ� ������ ���ܹ����� �ش� ������ LPAD�� ����ص� �������� ����
-- ���� TO_CHAR�� ����� ��ȭ�� ǥ���� ��� FM�� �߰������� ����Ͽ� ������ ������ ������ �� �ۿ� ����
-- ���� �ڸ������� 4�� ������� ����� ����

-- GROUP BY ���� ���� �÷� ��� ����
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE;

--------------------------------------------------------------------------------
/*
    <HAVING ��>
        : "�׷쿡 ���� ����" ������ �� ���Ǵ� ����(�ַ� �׷��Լ����� ������ ���� ����)
*/
-- �� �μ��� ��� �޿� ��ȸ(�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC NULLS FIRST;

-- �� �μ��� ��ձ޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

/*
    WHERE �� HAVING ����
    �� GROUP BY ����� �� HAVING ��� WHERE �� ������� ���ұ�?
        : ���� �������� WHERE�� GROUP BY ������ ����Ǳ� ������ �׷캰�� ������ �������� ���ϰ�
          ��� �࿡�� ����Ǳ� ������ ����� �� ����
*/

--=======================================================================
-- ���޺� �����ڵ�, �� �޿���(��, ���޺� �޿����� 1000���� �̻��� ���޸� ��ȸ)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000
ORDER BY JOB_CODE;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ��� �μ��ڵ�
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0
ORDER BY DEPT_CODE;

------------------------------------------------------------------------
/*
    SELECT * | �÷� | �÷� AS ��Ī | �Լ��� | ��������------5
    FROM ���̺� | DUAL -----------------------------------1
    WHERE ���ǽ�(�����ڵ��� Ȱ���Ͽ� ���) -------------------2
    GROUP BY �׷� ������ �Ǵ� �÷� | �Լ��� -----------------3
    HAVING ���ǽ�(�׷��Լ��� ���� ���) --------------------4
    ORDER BY �÷� | ��Ī | �÷�����(NUMBER) ----------------6
                [ASC | DESC] [NULLS FIRST | NULLS LAST]
*/

--========================================================================
/*
    <���� ������(SET OPERATION)>
        : ���� ���� �������� �ϳ��� ���������� ����� ������
        
    - UNION : OR | ������
                �� ������ ������ ������� ���Ѵ�.
    - INTERSECT : AND | ������
                    �� �������� ������ ������� �ߺ��� �����
    - UNION ALL : ������ + ������
                    �ߺ��Ǵ°� �� �� ǥ���� �� �ִ�.
    - MINUS : ������
                ���������� ���������� �� ������
*/

-- 1. UNION
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- �μ��ڵ尡 D5�� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- �޿��� 300���� �ʰ��� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION���� ���ϱ�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 2. INTERSECT(������)
-- �μ��ڵ尡 D5�̸鼭 �޿��� 300���� �ʰ��� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--------------------------------------------------------------------------------
-- ���տ����� ���� ���ǻ���
-- 1. �÷��� ������ �����ؾ���
-- 2. �÷��ڸ����� ������ Ÿ������ ����ؾ� ��
-- 3. ���� ��� �� ORDER BY �� �������� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_ID;

--------------------------------------------------------------------------------------
-- 3. UNION ALL
--      : ���� ���� ���� ����� ������ �� ���ϴ� ������(�ߺ� ���� �ȵ�)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_ID;
-------------------------------------------------------------------------------
-- 4. MINUS
--      : ���� SELECT ������� ���� SELECT ����� �� ������(������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_ID;
-- �μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ������� �����ϰ� ��ȸ











