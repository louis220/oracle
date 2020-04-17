-- ����� ����
-- system �������� ����

--bituser��� �̸����� bituser ��ȣ�� ���� ������ ����
CREATE USER bituser IDENTIFIED BY bituser;
-- ������� ���� : drop user
DROP USER bituser CASCADE;
-- �ٽ� ����� ���ô�
CREATE USER bituser IDENTIFIED BY bituser;

conn bituser/bituser; --login �õ�
--���� �߻� :  ����� ����, ������ ���� -> �α��� �ȵ�
-- ����� ���� Ȯ��
-- user_users :  ���� ����� ���� ����
-- ALL_USERS : DB�� ��� ����� ����
-- DBA_USERS :  DB�� ��� ������� ������
SHOW user

DESC USER_USERS;
--USER_USERS (���� �����)�� username�� ���� ���� Ȯ��
SELECT username, account_status FROM USER_USERS;
DESC ALL_USERS;
SELECT username, created FROM ALL_USERS
WHERE username='BITUSER';
DESC DBA_USERS;

SELECT username, account_status
FROM DB_USERS
WHERE username='BITUSER';

-- GRANT/REVOKE �����ֱ�/ ����
-- ����� bituser ���� ���� ������ �ݽô�
GRANT create session TO bituser;
-- bituser�� �α���
-- �Ϲ������� CONNECT, RESOURCE ����
-- ���� �ο��Ǿ�� �����ͺ��̽��� ����,
-- ���̺��� ����� ����� �� �ִ�
GRANT connect, resource TO bituser;

--hr ��Ű���� employees ���̺��� select ������
-- bituser���� �ο�
GRANT SELECT ON hr.employees TO bituser;
GRANT SELECT ON hr.departments TO bituser;

-- ���Ŀ��� bituser�� �α����ؼ� �ǽ��� ������ ����
SHOW user

-- book ���̺� ����
--  book_id, title, author, pub_date
CREATE TABLE book(
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT sysdate
);
-- �ڽ��� ���̺� ����� Ȯ���� ���ô�
SELECT * FROM tab;
--book ���̺��� ������ Ȯ��
DESC BOOK;

-- �̹� �ִ� ���̺��� ������� �� ���̺��� ����
SELECT * FROM hr.employees;
-- job_id�� IT ���õ� �������� �� ���̺�� ����� ���ô�
SELECT *FROM hr.employees 
WHERE job_id LIKE 'IT_%';

CREATE TABLE it_emps AS (
-- ��������
    SELECT * FROM hr.employees
    WHERE job_id LIKE 'IT_%'
);

SELECT * FROM tab;

SELECT * FROM it_emps;

-- ���̺� ���� : drop table
DROP TABLE it_emps;

--author ���̺� ����
--auther_id : 10�ڸ� ����
-- author_name : 100�ڸ� ���� ���ڿ�
-- author desc : 500�ڸ� ���� ���ڿ�
-- ���� ����
-- author_id : PK
--author_name : not null
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);
DESC author;
-- book ���̺� �� author �÷� ����
-- ���߿� author�� author id�� ����
ALTER TABLE book
DROP COLUMN author;
DESC book;
--author ���̺��� author_id�� �����ų
--author_id �÷� �߰�
ALTER TABLE book
    ADD (author_id NUMBER(10));
DESC book;
-- book ���̺� book_id�� NUMBER(10)
-- primary KEY �Ӽ� �ֱ�
ALTER TABLE book
MODIFY (book_id NUMBER(10));
DESC book;
-- ���������� �ο� ADD CONSTRAINT
ALTER TABLE book
ADD CONSTRAINT pk_book_id PRIMARY KEY (book_id);
DESC book;
-- book ���̺��� author_id �÷��� foreign key �߰�
-- author ���̺��� author_id �÷��� ����
ALTER TABLE book
ADD CONSTRAINT fk_author_id FOREIGN KEY(author_id)
    REFERENCES author(author_id);
DESC book;

--data dictionary
SELECT * FROM DICTIONARY;

-- ����� ��ü Ȯ��
SELECT * FROM user_objects;
-- �������� Ȯ��
SELECT * FROM user_constraints;
--BOOK ���̺��� �������� Ȯ��
SELECT constraint_name,
    constraint_type,
    search_condition
FROM user_constraints
WHERE table_name = 'BOOK';
























