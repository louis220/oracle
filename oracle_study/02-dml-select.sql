-- ���� ���� ���� �� ���̺� Ȯ��
Select * FROM tab;
-- employees ���̺��� ���� Ȯ��
DESC employees;

-- SELECT : DML

-- �⺻���� SELECT�� :  ��ü �������� ��ȸ
SELECT * FROM employees;
SELECT * FROM departments;

-- projection�� ���� : ���ϴ� Į���� ����� select�� ����
-- ����� �̸�(first_name)�� ��ȭ��ȣ, �Ի���, �޿� ���

SELECT first_name, phone_number, hire_date, salary
FROM employees;

--��� ���� : �⺻���� ��� ���� ����
SELECT 3.14159 * 10 * 10 FROM dual;
SELECT 3.14159 * 10 * 10 FROM employees;
--Ư�� ���̺� ���� ���� ���� ����� dual���� �������� 
--��� ������ �� �� Ư�� �÷��� ��꿡 ���Խ�ų �� �ִ�
SELECT first_name,
    salary,
    salary * 12
FROM employees;

--��������� ������ �� �÷��� ������Ÿ���� number���� �Ѵ�
SELECT first_name, job_id *12 FROM employees;
-- ERROR : job_id�� number�� �ƴϱ� ������ ������� �Ұ�

-- ���ڿ� ����
SELECT first_name+ '' + last_name FROM employees;
-- ERROR ���ڿ��� +�� ������ �� ���� 
SELECT first_name || ' ' ||+ last_name full_name
FROM employees;
-- �÷� Ȥ�� ǥ���Ŀ� ������ �ٿ��� �� �ִ� ���� ���δ� full_name

-- Ŀ�̼Ǳ��� �����ؼ� �޿� ����
SELECT first_name,
    salary, commission_pct,
    salary + salary * commission_pct
    FROM employees;
-- ��� ������� ������ �� null�� ���ԵǾ� ������
-- ����� null

--nvl(exprl, expr2): exprl üũ�ؼ� null�� �ƴϸ� exprl
--                                  null�̸� expr2

SELECT first_name,
    salary,
    salary + salary * nvl(commission_pct,0) paid
FROM employees;


-- WHERE (Selection)
-- �޿��� 15000 �̻��� ����� �̸��� �޿��� ���
SELECT first_name, salary
FROM employees
WHERE salary >= 15000;

-- ��¥�� �� ������ �����ϴ�
-- �Ի����� 85/01/01 ������ ����� �̸��� �Ի���, �޿�
SELECT first_name, hire_date, salary
FROM employees
WHERE hire_date >= '07/01/01';

-- �̸��� Lex�� ����� �̸�, �Ի���, �޿� ���
SELECT first_name, hire_date, salary
FROM employees
where first_name = 'Lex';


--�� ���� OR
-- salary 14000 �����̰ų� 17000�̻��̰ų�
SELECT first_name, salary
FROM employees
WHERE salary <= 14000 OR salary >= 17000;

--AND
salary�� 14000 �̻��̰� 17000������ ����� ���
SELECT first_name,
salary
FROM employees
Where salary >= 14000 AND salary <= 17000;

--BETWEEN ������
-- salary�� 14000 �̻��̰� 17000������ ��� ���
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 14000 and 17000;

-- NULL üũ : is null, is not null
-- Ŀ�̼��� �޴� ����� ���

SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
-- Ŀ�̼��� ���� �ʴ� ����� ���
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NULL;
-- �μ� ID�� 10�̰ų� 20�̰ų� 40�� ������ ���
SELECT first_name, department_id
FROm employees
WHERE department_id = 10 OR
    department_id = 20 OR
    department_id = 40;
--IN �����ڸ� Ȱ��
SELECT first_name, department_id
FROM employees
WHERE department_id IN(10, 20, 30);
-- ANY ������ Ȱ��
SELECT first_name, department_id
FROM employees
WHERE department_id = ANY(10, 20, 30);
--����� �� department_id 10, 20, 30�� �ƴ� �����
SELECT first_name, department_id
FROM employees
WHERE department_id NOT IN (10, 20, 30);
-- LIKE ������
-- ���ϵ�ī�� % : ���̰� �������� ���� ���ڿ�
-- ���ϵ�ī�� _ : 1������ �������� ���� ����
-- first_name�� am�� ���Ե� ������ ���
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%am%';
-- first_name�� �� ��° ���ڰ� a�� ����
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '_a%';
--Selection�� �������� ����
--ASC(default : ��������- ������ -> ū��)
--DESC(�������� ū�� -> ���� ��)
--�μ� ��ȣ ������������ �����ϰ� �̸�, �μ���ȣ �޿�
SELECT first_name, department_id, salary
FROM employees
ORDER BY department_id; --ASC�� ���� ����(�⺻��)
-- �޿��� 15000 �̻��� ������ ���� �޿��� ����
SELECT first_name, salary
FROM employees
WHERE salary >= 15000
ORDER BY salary DESC;
-- �μ� ��ȣ ������������ ������ �� �޿��� �������� ����
SELECT first_name, department_id, salary
FROM employees
ORDER BY department_id ASC, salary DESC;

-- ������ �Լ�
-- ���ڿ� ������ �Լ�
SELECT first_name, last_name,
    first_name || ' ' || last_name,
    CONCAT(first_name, CONCAT(' ', last_name)), --��ħ
    LOWER(first_name), UPPER(first_name) --��ȯ
    ,INITCAP(first_name)
FROM employees;

SELECT LPAD(first_name, 20, '*'), --20�ڸ� ����, �����
    RPAD(first_name, 20, '*')
    FROM employees;

SELECT LTRIM('     ORACLE      '),
    RTRIM('       ORACLE       '),
    TRIM('#'  FROM '######Database######'),
    SUBSTR('Oracle Datavase', 8, 4),
    SUBSTR('Oracle Datavase', -8, 4),
    LENGTH('Oracle Database')
FROM dual;
-- ��ġ�� ������ �Լ�
SELECT ABS(-3.14), --���밪
    CEIL(3.14), -- �ø�( õ���̶�� ��)
    FLOOR(3.14), -- ����
    MOD(7, 3), --7�� 3������/ ������
    POWER(2, 4), --2��4��/���� �Լ�
    ROUND(3.4), --�ݿø�
    ROUND(3.14159, 3), --�Ҽ��� 3°�ڸ����� ǥ�� �Ʒ����� �ݿø�
    TRUNC(3.14159, 3) -- �Ҽ��� 3°¥������ ǥ������ �ڸ��� ����
FROM dual;

--  QUIZ01-------

--Q1
SELECT first_name || ' ' || last_name �̸�,
    salary �޿�,
    phone_number ��ȭ��ȣ,
    hire_date �Ի���,
FROM employees;

--Q2
SELECT job_title, max_salary
FROM jobs
ORDER BY max_salary DESC;

--Q3
SELECT first_name, manager_id, commission_pct, salary
FROM employees
WHERE commission_pct IS NULL AND
    manager_id IS NOT NULL AND
    salary >3000;
    
--Q4
SELECT job_title, max_salary
FROM jobs
WHERE max_salary >= 10000
ORDER BY max_salary DESC;

--Q5
SELECT first_name, salary, commission_pct
FROM employees
WHERE salary >= 10000 AND salary < 14000
    AND Commission_pct IS NULL;
    
--Q6
SELECT department_name
FROM departments
ORDER BY LENGTH(department_name) DESC;

--Q7
SELECT first_name, salary
FROM employees
WHERE first_name LIKE '%s%' OR first_name LIKE '%S%';

--Q8
SELECT UPPER(country_name)
FROM countries
ORDER BY country_name;

--Q9
SELECT first_name, salary, phone_number, hire_date
FROM employees
WHERE hire_date <= '03/12/31';

--DATE
--DATE �⺻ ���� Ȯ��
SELECT * FROM nls_session_parameters
WHERE parameter='NLS_DATE_FORMAT';

--���� ��¥ ���ϱ� : SYSDATE
SELECT sysdate FROM dual; --���� �ý��� ��¥
SELECT sysdate FROM employees;

--��¥ ���� ����
-- date +,- Number -> ��¥�� �ϼ� ���ϱ�,����
-- date - date -> ��¥ �ϼ� ����(number)
SELECT sysdate + 1,
    sysdate -1,
    sysdate -TO_DATE('1999-12-31'),
    sysdate + 12/24 --0.5�� ���Ѱ�
    FROM dual;
-- ��¥ ���� �Լ�
SELECT sysdate,
    ADD_MONTHS(sysdate, 2),
    LAST_DAY(sysdate),
    MONTHS_BETWEEN(
        TO_DATE('1999-12-31', 'YYYY-MM_DD'),
        sysdate),
        ROUND(sysdate, 'MONTH'),
        TRUNC(sysdate, 'MONTH')
FROM dual;

-- ���� ��¥�� �������� employees ���̺���
-- �Ի����� �� ������ �������� Ȯ��
SELECT first_name, hire_date,
   ROUND( MONTHS_BETWEEN(sysdate, hire_date) )
FROM employees;
--��ȯ �Լ�
--TO_CHAR : ��¥, ���� -> ���ڿ���
--TO_DATE : ���ڿ� -> ��¥��
--TO_NUMBER : ���ڿ�- -> ���ڷ�
-- ��ȯ ������ �� �����ؾ� �Ѵ�

-- employees ���̺��� �Ի����� YYYY-MM_DD HH24:MI:SS
SELECT first_name, hire_date,
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;

-- employees ���̺��� salary ������ -> ����
SELECT first_name,  
    TO_CHAR(salary *12, '$999,999.99') SAL
FROM employees;

-- TO_NUMBER : ���ڿ�->���ڷ�
SELECT TO_NUMBER('1999'),
    TO_NUMBER('$1,234.567', '$999,999.999')
FROM dual;

-- TO_DATE : ���ڿ� -> ��¥��
SELECT TO_DATE('1991-12-31 23:59:59',
        'YYYY-MM-DD HH24:MI:SS')
FROM dual;
--NULL ����
-- NVL (expr1,expr2) -> expr1�� null �̸� expr1,
                        --�ƴϸ� expr2
SELECT first_name, salary,
    salary * nvl(commission_pct, 0) commision
FROM employees;
--nvl2(expr1, expr2, expr3)
-- expr1�� null���� üũ
--  null�� �Ƥ��ϸ� ->expr2
-- null �̸� -> expr3
SELECT first_name, salary,
    nvl2(commission_pct, commission_pct * salary, 0) commission
FROM employees;

-- CASE �Լ�
-- ���ʽ� ���� ����
-- AD ���� �������Դ� 20%, SA���� �������Դ� 10%, 
--IT���� �������Դ� 8%, ������ �����鿡�Դ� 5% ����
SELECT job_id FROM employees;
SELECT first_name, job_id, salary,
    CASE SUBSTR(job_id, 1,2) 
        WHEN 'AD' THEN salary * 0.2
        WHEN 'SA' THEN salary * 0.1
        WHEN 'IT' THEN salary * 0.08
        ELSE salary * 0.05
    END bonus
FROM employees;

-- decode �Լ�

SELECT first_name, job_id, salary,
    DECODE(SUBSTR(job_id, 1, 2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        0.05) bonus
FROM employees;

--��������
SELECT first_name, department_id,
    CASE WHEN department_id <= 30 THEN 'A-Group'
        WHEN department_id <= 50 THEN 'B-Group'
        WHEN department_id <= 100 THEN'C-Group'
        ELSE 'REMAINDER'
    END team
FROM employees
ORDER BY team ASC;



































































