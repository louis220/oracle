--view
--����
desc myemp;
SELECT * FROM myemp;
--��� ���̺� ����
DROP TABLE myemp;
CREATE TABLE myemp
AS SELECT * FROM hr.employees;
SELECT * FROM myemp;

--view ����
--view ������ ���ؼ��� create view ������ �־�� �Ѵ�
--system, sys ��������
-- grant create view TO bituser�� �ؾ���
--department_id =1�� �������� ���
CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, hire_date, salary
    FROM myemp
    Where department_id=10;
--���� ���̺��� �ܼ� �÷��� ������� �ۼ��� view : simpleview
--simpleview�� �������ǿ� �ɸ��� ������ insert, update, delete ����
--view�� �Ϲ� tableó�� select �� �� �ִ�
SELECT * FROM myemp_10;

UPDATE myemp_10 SET salary = salary *2;
-- �����ϸ� view�� read only(��ȸ ����)�� ����ϵ��� �սô�

CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, salary
    FROM myemp
    WHERE department_id=10
WITH READ ONLY; --�б� ������ view ����

UPDATE myemp_10 SET salary = salary *2; --read only view�� insert, update, delete �Ұ�

--complex view
-- �� �� �̻��� ���̺� Ȥ�� view�� ������� ����
-- ǥ����, �Լ��� �����ϱ⵵ �Ѵ�
-- book ���̺�� author ���̺��� join�ؼ� book_detail view ����
CREATE OR REPLACE VIEW book_detail
    (book_id, title, author_name, pub_date)
    AS SELECT book_id, title, author_name, pub_date
    FROM book b, author a
    WHERE b.author_id = a.author_id;
DESC book_detail;

SELECT * FROM book_detail;
SELECT * FROM book;

INSERT INTO book 
VALUES(1, '����', sysdate, 1);
INSERT INTO book
VALUES(2, '�������� ����', sysdate, 2);
COMMIT;

SELECT * FROM book_detail;
-- complex view�� �⺻�����δ� insert, update, delete�� ������� �ʴ´�

-- view�� ���� dictionary
--user views
SELECT * FROM user_views;

--user objects�� �̿��� view Ȯ��
SELECT object_name, status, object_type FROM user_objects
WHERE object_type='VIEW';

--view �����
DROP VIEW myemp_10;
SELECT * FROM user_views;

--index : ���� ���� ����� ���� ���
SELECT * FROM myemp;
--myemp ���̺��� employess_id �÷��� unique �ε����� ����� ���ô�
CREATE UNIQUE INDEX myemp_id_unique
ON myemp(employee_id);
CREATE INDEX myemp_dept_id
ON myemp(department_id);

 -- ����ڰ� ������ �ִ� index Ȯ��
 SELECT * FROM user_indexes;
 -- ��� �÷��� �ε����� �ִ��� Ȯ��
 SELECT * FROM user_ind_columns;
 
 --��� �ε����� ��� �÷��� �ɷ� �ִ��� join�ؼ� Ȯ��
 SELECT t.index_name, c.column_name, c.column_position
FROM user_indexes t, user_ind_columns c
WHERE t.index_name = c.index_name
    AND t.table_name = 'MYEMP';
    
--index ����
DROP INDEX myemp_dept_id;
DROP INDEX myemp_id_unique;

SELECT * FROM user_indexes;

--sequence : ������ �������� �߻���Ű�� ��ü
SELECT * FROM author;

-- ���ο� author ���ڵ带 �߰��Ѵٰ� ����
-- pk �ߺ� ������ ���ؼ� author_id�� ���� ū ���� Ȯ��
SELECT max(author_id)+1 max_id FROM author;

--���ο� author�� �߰��� ���ô�
INSERT INTO author (author_id, author_name)
VALUES((SELECT max(author_id)+1 FROM author), '��Ƽ�� ŷ');
SELECT * FROM author;
COMMIT;
-- �� ����� �������� ���� �� �ֽ��ϴ�.
--sequence�� ���� primary key�� ������ �� Ȱ��

-- �� ������ ���� ����
CREATE SEQUENCE test_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10;
    
    --���������� ���� �޾ƿ� ���ô�
SELECT test_seq.NEXTVAL FROM dual;  --�� �� ����
SELECT test_seq.CURRVAL FROM dual;
SELECT test_seq.NEXTVAL FROM dual;

--�������� ������ ���ô�
ALTER SEQUENCE test_seq
    INCREMENT BY 3 --������ 3
    MAXVALUE 10000000;

SELECT test_seq.NEXTVAL FROM dual;

-- ����� ������ Ȯ��
SELECT * FROM user_sequences;
SELECT * FROM user_objects
WHERE object_type='SEQUENCE';

--author�� pk�� ���� seq �ۼ�
SELECT max(author_id) FROM author;
CREATE SEQUENCE seq_author_pk
    START WITH 4
    INCREMENT BY 1;

-- SEQUENCE�� Ȱ���� ���ڵ��� �߰�
INSERT INTO author(author_id, author_name)
VALUES(seq_author_pk.NEXTVAL, '���ù�');
SELECT * FROM author;
COMMIT;

--book ���̺��� pk�� ���� sequence ����
SELECT max(book_id) FROM book;
CREATE SEQUENCE seq_book_pk
    START WITH 3
    INCREMENT BY 1;
    SELECT * FROM user_sequences;

--������ ����
DROP SEQUENCE test_seq;



































