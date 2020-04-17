-- 현재 접속 계정 내 테이블 확인
Select * FROM tab;
-- employees 테이블의 구조 확인
DESC employees;

-- SELECT : DML

-- 기본적인 SELECT문 :  전체 데이터의 조회
SELECT * FROM employees;
SELECT * FROM departments;

-- projection의 제한 : 원하는 칼럼의 목록을 select에 지정
-- 사원의 이름(first_name)과 전화번호, 입사일, 급여 출력

SELECT first_name, phone_number, hire_date, salary
FROM employees;

--산술 연산 : 기본적인 산술 연산 가능
SELECT 3.14159 * 10 * 10 FROM dual;
SELECT 3.14159 * 10 * 10 FROM employees;
--특정 테이블에 연관 없는 단일 결과는 dual에서 수행하자 
--산술 연산을 할 때 특정 컬럼을 계산에 포함시킬 수 있다
SELECT first_name,
    salary,
    salary * 12
FROM employees;

--산술연산을 수행할 때 컬럼의 데이터타입은 number여야 한다
SELECT first_name, job_id *12 FROM employees;
-- ERROR : job_id는 number가 아니기 때문에 산술연산 불가

-- 문자열 연결
SELECT first_name+ '' + last_name FROM employees;
-- ERROR 문자열은 +로 연결할 수 없다 
SELECT first_name || ' ' ||+ last_name full_name
FROM employees;
-- 컬럼 혹은 표현식에 별명을 붙여줄 수 있다 위의 예로는 full_name

-- 커미션까지 포함해서 급여 지급
SELECT first_name,
    salary, commission_pct,
    salary + salary * commission_pct
    FROM employees;
-- 산술 연산식을 수행할 때 null이 포함되어 있으면
-- 결과는 null

--nvl(exprl, expr2): exprl 체크해서 null이 아니면 exprl
--                                  null이면 expr2

SELECT first_name,
    salary,
    salary + salary * nvl(commission_pct,0) paid
FROM employees;


-- WHERE (Selection)
-- 급여가 15000 이상인 사원의 이름과 급여를 출력
SELECT first_name, salary
FROM employees
WHERE salary >= 15000;

-- 잘짜도 비교 연산이 가능하다
-- 입사일이 85/01/01 이후인 사원의 이름과 입사일, 급여
SELECT first_name, hire_date, salary
FROM employees
WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 사원의 이름, 입사일, 급여 출력
SELECT first_name, hire_date, salary
FROM employees
where first_name = 'Lex';


--논리 연산 OR
-- salary 14000 이하이거나 17000이상이거나
SELECT first_name, salary
FROM employees
WHERE salary <= 14000 OR salary >= 17000;

--AND
salary가 14000 이상이고 17000이하인 사원의 목록
SELECT first_name,
salary
FROM employees
Where salary >= 14000 AND salary <= 17000;

--BETWEEN 연산자
-- salary과 14000 이상이고 17000이하인 사원 목록
SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 14000 and 17000;

-- NULL 체크 : is null, is not null
-- 커미션을 받는 사원의 목록

SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
-- 커미션을 받지 않는 사원의 목록
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NULL;
-- 부서 ID가 10이거나 20이거나 40인 직원의 목록
SELECT first_name, department_id
FROm employees
WHERE department_id = 10 OR
    department_id = 20 OR
    department_id = 40;
--IN 연산자를 활용
SELECT first_name, department_id
FROM employees
WHERE department_id IN(10, 20, 30);
-- ANY 연산자 활용
SELECT first_name, department_id
FROM employees
WHERE department_id = ANY(10, 20, 30);
--사원들 중 department_id 10, 20, 30이 아닌 사원들
SELECT first_name, department_id
FROM employees
WHERE department_id NOT IN (10, 20, 30);
-- LIKE 연산자
-- 와일드카드 % : 길이가 정해지지 않은 문자열
-- 와일드카드 _ : 1글자의 정해지지 않은 문자
-- first_name에 am이 포함된 직원의 목록
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '%am%';
-- first_name의 두 번째 글자가 a인 직원
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '_a%';
--Selection된 데이터의 정렬
--ASC(default : 오른차순- 작은값 -> 큰값)
--DESC(내림차순 큰값 -> 작은 값)
--부서 번호 오름차순으로 정렬하고 이름, 부서번호 급여
SELECT first_name, department_id, salary
FROM employees
ORDER BY department_id; --ASC는 생략 가능(기본값)
-- 급여가 15000 이상인 직원을 추출 급여의 역순
SELECT first_name, salary
FROM employees
WHERE salary >= 15000
ORDER BY salary DESC;
-- 부서 번호 오름차순으로 정렬한 후 급여의 역순으로 정렬
SELECT first_name, department_id, salary
FROM employees
ORDER BY department_id ASC, salary DESC;

-- 단일행 함수
-- 문자열 단일행 함수
SELECT first_name, last_name,
    first_name || ' ' || last_name,
    CONCAT(first_name, CONCAT(' ', last_name)), --합침
    LOWER(first_name), UPPER(first_name) --변환
    ,INITCAP(first_name)
FROM employees;

SELECT LPAD(first_name, 20, '*'), --20자리 공간, 빈공간
    RPAD(first_name, 20, '*')
    FROM employees;

SELECT LTRIM('     ORACLE      '),
    RTRIM('       ORACLE       '),
    TRIM('#'  FROM '######Database######'),
    SUBSTR('Oracle Datavase', 8, 4),
    SUBSTR('Oracle Datavase', -8, 4),
    LENGTH('Oracle Database')
FROM dual;
-- 수치형 단일행 함수
SELECT ABS(-3.14), --절대값
    CEIL(3.14), -- 올림( 천장이라는 뜻)
    FLOOR(3.14), -- 내림
    MOD(7, 3), --7에 3나누고/ 나머지
    POWER(2, 4), --2의4승/제곱 함수
    ROUND(3.4), --반올림
    ROUND(3.14159, 3), --소수점 3째자리까지 표시 아래에서 반올림
    TRUNC(3.14159, 3) -- 소수점 3째짜리까지 표시이하 자리는 버림
FROM dual;

--  QUIZ01-------

--Q1
SELECT first_name || ' ' || last_name 이름,
    salary 급여,
    phone_number 전화번호,
    hire_date 입사일,
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
--DATE 기본 포맷 확인
SELECT * FROM nls_session_parameters
WHERE parameter='NLS_DATE_FORMAT';

--현재 날짜 구하기 : SYSDATE
SELECT sysdate FROM dual; --현재 시스템 날짜
SELECT sysdate FROM employees;

--날짜 관련 연산
-- date +,- Number -> 날짜의 일수 더하기,빼기
-- date - date -> 날짜 일수 차이(number)
SELECT sysdate + 1,
    sysdate -1,
    sysdate -TO_DATE('1999-12-31'),
    sysdate + 12/24 --0.5일 더한것
    FROM dual;
-- 날짜 관련 함수
SELECT sysdate,
    ADD_MONTHS(sysdate, 2),
    LAST_DAY(sysdate),
    MONTHS_BETWEEN(
        TO_DATE('1999-12-31', 'YYYY-MM_DD'),
        sysdate),
        ROUND(sysdate, 'MONTH'),
        TRUNC(sysdate, 'MONTH')
FROM dual;

-- 현재 날짜를 기준으로 employees 테이블에서
-- 입사한지 몇 개월이 지났는지 확인
SELECT first_name, hire_date,
   ROUND( MONTHS_BETWEEN(sysdate, hire_date) )
FROM employees;
--변환 함수
--TO_CHAR : 날짜, 숫자 -> 문자열로
--TO_DATE : 문자열 -> 날짜로
--TO_NUMBER : 문자열- -> 숫자로
-- 변환 포맷을 잘 지정해야 한다

-- employees 테이블에서 입사일을 YYYY-MM_DD HH24:MI:SS
SELECT first_name, hire_date,
    TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;

-- employees 테이블에서 salary 정보를 -> 연봉
SELECT first_name,  
    TO_CHAR(salary *12, '$999,999.99') SAL
FROM employees;

-- TO_NUMBER : 문자열->숫자로
SELECT TO_NUMBER('1999'),
    TO_NUMBER('$1,234.567', '$999,999.999')
FROM dual;

-- TO_DATE : 문자열 -> 날짜로
SELECT TO_DATE('1991-12-31 23:59:59',
        'YYYY-MM-DD HH24:MI:SS')
FROM dual;
--NULL 관련
-- NVL (expr1,expr2) -> expr1이 null 이면 expr1,
                        --아니면 expr2
SELECT first_name, salary,
    salary * nvl(commission_pct, 0) commision
FROM employees;
--nvl2(expr1, expr2, expr3)
-- expr1이 null인지 체크
--  null이 아ㄴ니면 ->expr2
-- null 이면 -> expr3
SELECT first_name, salary,
    nvl2(commission_pct, commission_pct * salary, 0) commission
FROM employees;

-- CASE 함수
-- 보너스 지급 결정
-- AD 관련 직원에게는 20%, SA관련 직원에게는 10%, 
--IT관련 직원에게는 8%, 나머지 직원들에게는 5% 지급
SELECT job_id FROM employees;
SELECT first_name, job_id, salary,
    CASE SUBSTR(job_id, 1,2) 
        WHEN 'AD' THEN salary * 0.2
        WHEN 'SA' THEN salary * 0.1
        WHEN 'IT' THEN salary * 0.08
        ELSE salary * 0.05
    END bonus
FROM employees;

-- decode 함수

SELECT first_name, job_id, salary,
    DECODE(SUBSTR(job_id, 1, 2),
        'AD', salary * 0.2,
        'SA', salary * 0.1,
        'IT', salary * 0.08,
        0.05) bonus
FROM employees;

--연습문제
SELECT first_name, department_id,
    CASE WHEN department_id <= 30 THEN 'A-Group'
        WHEN department_id <= 50 THEN 'B-Group'
        WHEN department_id <= 100 THEN'C-Group'
        ELSE 'REMAINDER'
    END team
FROM employees
ORDER BY team ASC;



































































