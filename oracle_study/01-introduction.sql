-- APEX port
-- APEX�� HTTPPORT Ȯ��

SELECT DBMS_XDB.gethttpport() FROM DUAL;

-- APEX ��Ʈ ����(Apache Tomcat ����)
exec dbms_xdb.sethttpport(8090);

-- hr ���� ��� �����ϰ� (unlock)
select username, account_status from dba_users where username='HR';

-- hr  ���� ��� ����
alter user hr identified by hr account unlock; 