/*
    * ��������(SUBQUERY)
        : �ϳ��� SQL �� �ȿ� ���Ե� �� �ٸ� SELECT ��
          ���� SQL ���� ���� ���� ������ �ϴ� ����
*/

-- ������ �������� ���� 1
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ

-- 1) ���ö ����� �μ��ڵ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 D9 �� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 3) �������� ���� ���� �� �ܰ踦 �ϳ��� ���������� ó��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');

-- ������ �������� ����2
-- �� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT ROUND(AVG(SALARY))
                FROM EMPLOYEE);
                
/*
    * �������� ����
        : ���������� ������ ������� ���� ��� ������ ���� ���� �з�
        
        - ������ ��������
            : ���������� ��ȸ ������� ������ 1���� ��
        - ������ ��������
            : ���������� ��ȸ ������� ���� ���� ��(��, �÷��� 1��)
        - ���߿� ��������
            : ���������� ��ȸ ������� ������������ �÷��� ���� ���϶�
              (���� ���߿�)
        - ������ ���߿� ��������
            : ���������� ��ȸ ������� ���� ���̸鼭 ���� ���� ��
            
        >> ���������� ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���
*/

/*
    1. ������ ��������
        : �Ϲ� �� ������ ��� ����(=, !=, >, < ...)
*/
-- 1) �� ������ ��� �޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < ( SELECT ROUND(AVG(SALARY))
                 FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- 2) �����޿��� �޴� ����� ���, �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = ( SELECT MIN(SALARY)
                 FROM EMPLOYEE);

-- 3) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- 4) ���ö ����� �޿����� ���� �޴� ������� ���, �̸�, �μ���, �޿���ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');

-- 5) �μ��� �޿����� ���� ū �μ��� �μ��ڵ� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);


-- 6) ������ ����� ���� �μ��� ������� ���, �����, ��ȭ��ȣ, �Ի���, �μ��� ��ȸ ��, ������ ��� ����
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
    AND EMP_NAME != '������';                    

--------------------------------------------------------------------------------
/*
    2. ������ ��������
       'IN' (��������)
            : ���� ���� ����� �� �� ���� ��ġ�ϴ� ���� �ִٸ� ��ȸ(���� ����)
            
       '> ANY' (��������)
            : ���� ���� ����� �� �� ���� Ŭ ��� ��ȸ
             �񱳴�� > ANY (���������� ����� => ��1, ��2, ��3, ...)
             �񱳴�� > ��1 OR �񱳴�� >  ��2 OR �񱳴�� > ��3, ...
       '< ANY' (��������)
            : ���� ���� ����� �� �� ���� ���� ��� ��ȸ
            
       '> ALL' (��������)
            : ���� ���� ��� ����� ���� Ŭ ��� ��ȸ
             �񱳴�� > ALL (���������� �����  => ��1, ��2, ��3, ... )
             �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3, ...
       '< ALL' (��������)
            : ���� ��� ��ȸ

*/

-- 1) ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿� ��ȸ
-- 1.1) ����� �Ǵ� ������ ����� �����ڵ� ���ϱ�
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('������', '�����');
-- 1.2) J3, J7�� ���� ������ ������� ���, �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');
-- 1.3) �� ������ ���������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('������', '�����'));
                    
-- 2. �븮 �����ӿ��� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ������� ���, �̸�, ����, �޿�

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND( JOB_NAME = '�븮'
    AND SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND JOB_NAME = '����'));

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEE
                    JOIN JOB USING (JOB_CODE)
                    WHERE JOB_NAME = '����');

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND( JOB_NAME = '�븮'
    AND SALARY > ANY (SELECT SALARY
                        FROM EMPLOYEE E, JOB J
                        WHERE E.JOB_CODE = J.JOB_CODE
                        AND JOB_NAME = '����'));

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > ANY (SELECT SALARY
                        FROM EMPLOYEE
                        JOIN JOB USING (JOB_CODE)
                        WHERE JOB_NAME = '����');
--------------------------------------------------------------------------------
/*
    3. ���߿� ��������(����)
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ
-- (�����, �μ��ڵ�, �����ڵ�, �Ի���)
--> ������ ��������
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE DEPT_CODE = (SELECT DEPT_CODE
                       FROM EMPLOYEE
                       WHERE EMP_NAME = '������')
    AND JOB_CODE =  (SELECT JOB_CODE
                       FROM EMPLOYEE
                       WHERE EMP_NAME = '������');

--> ���߿� ���������� �ۼ�
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                   FROM EMPLOYEE
                                   WHERE EMP_NAME = '������');

-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, �����ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE ( JOB_CODE, MANAGER_ID ) = ( SELECT JOB_CODE, MANAGER_ID
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME = '�ڳ���')
AND EMP_NAME != '�ڳ���';                  

----------------------------------------------------------------------------
/*
    4. ������ ���߿� ��������
*/
-- 1. �� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���, �����, �����ڵ�, �޿�)
-- 1.1. �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
-- 1.2. ���޺� �ּұ޿� �޴� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J7' AND SALARY = 1380000
    ...;
    
--1.3. �������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);
                            
-- �� �μ��� �ְ�޿��� �޴� ������� ���, �����, �μ��ڵ�, �޿�
SELECT NVL(DEPT_CODE,'�μ�����') AS "�μ��ڵ�", MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE ;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------

/*
    5. �ζ��� ��
        : FROM ���� ���������� �ۼ��� ��
          ���������� ������ ����� ��ġ ���̺�ó�� ���
*/

-- ������� ���, �̸�, ���ʽ� ���� ����, �μ��ڵ� ��ȸ
-- ��, ���ʽ� ���� ������ NULL �� �Ǹ� �ȵ�
-- ��, ���ʽ� ���� ������ 3õ���� �̻��� ����鸸 ��ȸ

 SELECT ROWNUM, EMP_ID, EMP_NAME, (SALARY + ( SALARY * NVL( BONUS, 0 )))*12 AS "����", DEPT_CODE
 FROM EMPLOYEE
 WHERE  ((SALARY + ( SALARY * NVL( BONUS, 0 )))*12) >= 30000000;
 -- ROWNUM �� ����Ŭ���� �ڵ����� �ο����ִ� ������. �̴� FROM���� �������� �ο�����
 
 --> �ζ��� �並 �ַ� ����ϴ� �� >> TOP_N �м� : ���� �� ���� ��ȸ
 -- �� ���� �� �޿��� ���� ���� �ټ� �� ��ȸ
 /* ROWNUM
        : ����Ŭ���� �������ִ� �÷�.
          ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�(�ڵ�������)
*/        
 SELECT ROWNUM, EMP_NAME, SALARY
 FROM EMPLOYEE
 WHERE ROWNUM <= 5
 ORDER BY SALARY DESC;
  SELECT ROWNUM, EMP_NAME, SALARY
 FROM EMPLOYEE
  ORDER BY SALARY DESC;

 --> ORDER BY ���� ����� ����� ������ ROWNUM �ο� -> ���� 5�� ��ȸ
 SELECT EMP_NAME, SALARY
 FROM(SELECT EMP_NAME, SALARY
         FROM EMPLOYEE
         ORDER BY SALARY DESC)
 WHERE ROWNUM <= 5;
 
 -- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ(�����, �޿�, �Ի���)
 SELECT EMP_NAME, SALARY, HIRE_DATE
 FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC)
 WHERE ROWNUM <= 5;

SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY ��ձ޿� DESC;

-- �� �μ��� ��ձ޿��� ���� 3���� �μ� ��ȸ
SELECT DEPT_CODE, ��ձ޿�
FROM (SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY ��ձ޿� DESC)
WHERE ROWNUM <= 3;
-- > �׷��Լ��� SELECT ������ ���������� ��Ī�� �ο��������

-- �� �μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ����
-- �μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� ����� ��ȸ

SELECT DEPT_CODE, SUM(SALARY) AS "����", ROUND(AVG(SALARY)) AS "���", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE ASC;
--> GROUP BY �����ε� �����ϱ� ��

SELECT *
FROM (SELECT DEPT_CODE, SUM(SALARY) AS "����", ROUND(AVG(SALARY)) AS "���", COUNT(*) AS "�ο���"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        HAVING ROUND(AVG(SALARY)) > 2700000
        ORDER BY DEPT_CODE ASC)
WHERE ��� >= 2700000;

--------------------------------------------------------------------------------
/*
    * ������ �ű�� �Լ�(WINDOW FUNCTION)
    RANK() OVER(���� ����) | DANSE_RANK() OVER(���� ����)
    RANK() OVER(���� ����)
        : ���� ���� ������ ����� ������ �ο� ����ŭ �ǳʶٰ� ���� ���
    DENSE_RANK() OVER(���� ����)
        : ���� ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ
    
    ������  SELECT �������� ��� ����    
*/

-- �޿��� ���� ������� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY, 
        RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
--> ���� 19�� 2��. �� �� ������ 21������ 20��� �ϳ��� �ǳʶ� ���� �� �� ����

SELECT  EMP_NAME, SALARY, 
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
--> ���� ���� �ڿ� �ٷ� �� ���� ������ ������ ���� �� �� ����.

SELECT *
FROM (SELECT  EMP_NAME, SALARY, 
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;



                       


















                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    