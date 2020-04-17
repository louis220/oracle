-- 사용자 생성
-- system 계정으로 수행

--bituser라는 이름으로 bituser 암호를 가진 계정을 생성
CREATE USER bituser IDENTIFIED BY bituser;
-- 사용자의 삭제 : drop user
DROP USER bituser CASCADE;
-- 다시 만들어 봅시다
CREATE USER bituser IDENTIFIED BY bituser;

conn bituser/bituser; --login 시도
--오류 발생 :  사용자 생성, 권한이 없음 -> 로그인 안됨
-- 사용자 정보 확인
-- user_users :  현재 사용자 관련 정보
-- ALL_USERS : DB내 모든 사용자 정보
-- DBA_USERS :  DB내 모든 사용자의 상세정보
SHOW user

DESC USER_USERS;
--USER_USERS (현재 사용자)의 username과 계정 상태 확인
SELECT username, account_status FROM USER_USERS;
DESC ALL_USERS;
SELECT username, created FROM ALL_USERS
WHERE username='BITUSER';
DESC DBA_USERS;

SELECT username, account_status
FROM DB_USERS
WHERE username='BITUSER';

-- GRANT/REVOKE 권한주기/ 뺏기
-- 사용자 bituser 에게 접속 권한을 줍시다
GRANT create session TO bituser;
-- bituser로 로그인
-- 일반적으로 CONNECT, RESOURCE 역할
-- 까지 부여되어야 데이터베이스에 접속,
-- 테이블을 만들고 사용할 수 있다
GRANT connect, resource TO bituser;

--hr 스키마의 employees 테이블의 select 권한을
-- bituser에게 부여
GRANT SELECT ON hr.employees TO bituser;
GRANT SELECT ON hr.departments TO bituser;

-- 향후에는 bituser로 로그인해서 실습을 진행할 예정
SHOW user

-- book 테이블 생성
--  book_id, title, author, pub_date
CREATE TABLE book(
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT sysdate
);
-- 자신의 테이블 목록을 확인해 봅시다
SELECT * FROM tab;
--book 테이블의 구조를 확인
DESC BOOK;

-- 이미 있는 테이블을 기반으로 새 테이블을 생성
SELECT * FROM hr.employees;
-- job_id가 IT 관련된 직원들을 새 테이블로 만들어 봅시다
SELECT *FROM hr.employees 
WHERE job_id LIKE 'IT_%';

CREATE TABLE it_emps AS (
-- 서브쿼리
    SELECT * FROM hr.employees
    WHERE job_id LIKE 'IT_%'
);

SELECT * FROM tab;

SELECT * FROM it_emps;

-- 테이블 삭제 : drop table
DROP TABLE it_emps;

--author 테이블 생성
--auther_id : 10자리 숫자
-- author_name : 100자리 가변 문자열
-- author desc : 500자리 가변 문자열
-- 제약 조건
-- author_id : PK
--author_name : not null
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);
DESC author;
-- book 테이블 내 author 컬럼 삭제
-- 나중에 author의 author id와 연결
ALTER TABLE book
DROP COLUMN author;
DESC book;
--author 테이블의 author_id와 연결시킬
--author_id 컬럼 추가
ALTER TABLE book
    ADD (author_id NUMBER(10));
DESC book;
-- book 테이블 book_id를 NUMBER(10)
-- primary KEY 속성 주기
ALTER TABLE book
MODIFY (book_id NUMBER(10));
DESC book;
-- 제약조건의 부여 ADD CONSTRAINT
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id);
DESC book;
-- book 테이블의 author_id 컬럼에 foreign key 추가
-- author 테이블의 author_id 컬럼을 참조
ALTER TABLE book
ADD CONSTRAINT fk_author_id FOREIGN KEY(author_id)
    REFERENCES author(author_id);
DESC book;

--data dictionary
SELECT * FROM DICTIONARY;

-- 사용자 객체 확인
SELECT * FROM user_objects;
-- 제약조건 확인
SELECT * FROM user_constraints;
--BOOK 테이블의 제약조건 확인
SELECT constraint_name,
    constraint_type,
    search_condition
FROM user_constraints
WHERE table_name = 'BOOK';
























