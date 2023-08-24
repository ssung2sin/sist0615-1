--����
select * from emp;
--Q1. emp���� job �������� �ߺ������ʰ�
select DISTINCT job from emp;

--Q2. emp���̺��� ������� A�� S�� �����ϴ� ����� ����غ�����(�����ȣ �����)
select empno �����ȣ, ename ����� from emp where ename like 'A%' or ename like 'S%';

--Q3. emp���� deptno�� 10�κμ��� ����Ͻÿ�
select ename �����, deptno �μ���ȣ from emp where deptno=10;

--Q4.emp���� �޿�(sal)�� ��պ��� �� ���� ����� ����� �޿��� ���
select ename �����,sal �޿� from emp where sal>(select avg(sal) from emp);

--Q5.SCOTT�� �޿��� �����ϰų� �� ���� �޴� ����� ������ �޿��� ����Ͻÿ�.
select ename �����,sal �޿� from emp where sal>=(select sal from emp where ename='SCOTT') order by 2;

--Q6.emp���� hiredate���� ���� 5���� ����� ����� �Ի����ڸ� ����Ͻÿ�(to_char���)
select ename �����,hiredate �Ի����� from emp where to_char(hiredate,'mm')='05';
--to_char(hiredate,'mm')='05' => hiredate�� month�� 5���� 

--7��7��
--1.table ����
--primary key�� �⺻ Ű�� �ǹ� not null+unique�� �ǹ��Ѵ�

--test ���̺�
create table test(num number(5) primary key,
name varchar(20),score number(6,2),birth date);

DESC test;
--��������
select * from test;

--test�� ��ü������ insert
insert into test values(1,'�ռ���',67.2,'1997-11-11');

--test�� �Ϻε����� insert
insert into test (num,name) values (2,'��ȣ��');

--insert ����
--���Ἲ ���� ����(SSUNG2SIN.SYS_C008353) 2���� �Ȱ��� ����
insert into test values(4,'�̿���',68.78,'1989-11-12');

--sysdate ���糯¥ �ǹ�
insert into test values(5,'��ȿ��',88.96,sysdate);

--alter
--���̸� ������ column �߰�, ������ null�� �߰�
--ALTER TABLE ���̺�� ADD �߰���column�� ������Ÿ��;
alter table test add age number(5);
-- �̹� �߰��� ��ϵ��� �� null �̴�.

--�ּҸ� ������ column�� �߰��ϴµ� �ʱⰪ�� ��������� ����
alter table test add addr varchar2(30) default '������';

--�ּ����� column�� 30=>50���� ����
--ALTER TABLE ���̺�� MODIFY �÷��� ������Ÿ��;
alter table test modify addr varchar(50);

--age Ÿ���� ���ڿ�(10)���� �����ϰ� �ʱⰪ�� 20���� �����ϱ�
alter table test modify age varchar2(10) default '20';
--�̷��� �ϸ� �������� null, ���� �߰��ϴ� ���� 20���� �ʱ�ȭ��.

insert into test (num,name) values (10,'��ȣ��');

--num�� �������� ���
select * from test order by num;

--drop(����)
--age��� column�� ����
alter table test drop column age;

--addr ����
alter table test drop column addr;

--column�� ����
--ALTER TABLE ���̺�� RENAME COLUMN OLD�÷��� TO NEW�÷���;
--score=>jumsu
alter table test rename column ���� to jumsu;

--birth=>birthday
alter table test rename column birth to birthday;

--���̺� ���� test
drop table test;

select * from test;




--������ ����
--������ �⺻���� ����, 1���� 1�������ϴ� ������ ������
create sequence seq1;

--��ü������ Ȯ��
select * from seq;

--���� ���������� �߻� �ֿܼ� ���
select seq1.nextval from dual;

--���� �߻��� ������ ��
select seq1.currval from dual;

--seq1����
drop sequence seq1;

--10���� 5�� �����ϴ� ����������-cache�� ���ֱ�
create sequence seq2 start with 10 increment by 5 nocache;
--10���� ���� : start with 10
--5�� ���� : increment by 5
--cache�� ���ֱ� nocache;

--������2 ����
drop sequence seq2;


--seq1 ���۰�:5 ������:2 ����:30 ĳ��:no, cycle:y
create sequence seq1 start with 5 increment by 2 maxvalue 30 nocache cycle;

--seg2 ���۰�1 ������1 cache:n
create sequence seq2 nocache;
--�⺻�� ����1 ����1�̱⶧���� ���� �Ƚᵵ��

--seq3 ���۰�1 ������2 cache:n
create sequence seq3 start with 1 increment by 2 nocache;

--���
select seq1.nextval,seq2.nextval,seq3.nextval from dual;

--����
drop sequence seq3; 

--------------------������ 1�� ����, ���̺� ����
create sequence seq_start nocache;

create table personinfo (num number(5) primary key,
name varchar2(20), job varchar2(30), gender varchar2(20),
age number(5),hp varchar2(20),birthday date);

desc personinfo;

drop table personinfo;
--birthday=>hiredate
alter table personinfo rename column birthday to hiredate;

--insert
insert into personinfo values (seq_start.nextval,'�ں���','�����Ͼ�','����','26','010-222-3333','2023-02-11');
insert into personinfo values (seq_start.nextval,'�迵��','����','����','28','010-222-4561','2023-01-11');
insert into personinfo values (seq_start.nextval,'�̿���','������','����','26','010-222-3333','2021-02-11');
insert into personinfo values (seq_start.nextval,'���缮','������','����','22','010-222-3333','2021-02-11');
insert into personinfo values (seq_start.nextval,'��ȣ��','����','����','31','010-111-3333','2020-02-11');
insert into personinfo values (seq_start.nextval,'����','�����Ͼ�','����','27','010-222-4444','2020-02-10');
insert into personinfo values (seq_start.nextval,'�迵��','���α׷���','����','29','010-888-3333','2021-01-11');
insert into personinfo values (seq_start.nextval,'�輱��','���','����','25','010-874-3333','2023-02-10');
insert into personinfo values (seq_start.nextval,'�����','�౸����','����','30','010-2242-9235','2022-08-11');
insert into personinfo values (seq_start.nextval,'�̰���','�౸����','����','22','010-3020-3923','2022-05-11');
commit;
--�������� commit�� �ؾ� ���������� �ȴ�. ���ϸ� �Ϸ��Ѱ� �ƴϴ�.


--c�����ο� Ȯ��
select count(*) from personinfo;
--��ȸ����
select * from personinfo order by name asc;
select * from personinfo order by age desc;
select * from personinfo order by 5;
select * from personinfo order by gender,age desc;

select job from personinfo;
select DISTINCT job from personinfo;

--���� ������
select * from personinfo where name like '��%';
--�̸��� �ι�°���ڰ� ���λ�� ���
select * from personinfo where name like '_��%';

--�ڵ��� ������ �ڸ��� 3333 �λ��
select * from personinfo where hp like '%3333';

--�Ի����ڰ� 1���� ���
select * from personinfo where to_char(hiredate,'mm')='01';

--�Ի���� 2023���λ��
select * from personinfo where to_char(hiredate,'yyyy')='2023';

--���̰� 20~30���� ���
select * from personinfo where age between 20 and 30;
select * from personinfo where age>=20 and age<=30;

--������ �������̰ǳ� ���α׷����� ���
select * from personinfo where job in('������','���α׷���');

--������ �������̰ǳ� ���α׷��Ӱ� �ƴ� ���
select * from personinfo where job not in('������','���α׷���');

--��ճ���,�Ҽ��� ���ڸ��� ���ϱ�
select round(avg(age),1) from personinfo;

--DB�������(update)
--3�� ���� ���� ������,�����̾����� ��� �����Ͱ� �����ȴ�. �����ʼ�!!
--update ���̺�� set �÷�1='�����ҵ�����' where �÷�2='�����Ͱ�';
update personinfo set job='��ȣ��',age=35;
--�̷����ϸ� �ٹٲ�!!
rollback;
--commit ������ ������ ���� �� �ִ�.

--3����
update personinfo set job='��ȣ��',age=35 where num=13;

--�߰��̸��� ���� �̸鼭 ��ȣ���� ����� ������ ���ڷ� �����ϱ�
update personinfo set gender='����' where name like '_��%' and job='��ȣ��';

--num�� 18���� ����� ������ ����� �Ի����� 2000-12-24�μ� ����
update personinfo set job='����',hiredate='2000-12-24' where num=18;

commit;

--����
--DELETE FROM ���̺��;
delete from personinfo;
rollback;

--13�� ����
delete  from personinfo where num=13;

--�����߿��� ���̰� 26���̻� ��� ����
delete from personinfo where gender='����' and age>=26;

--�ڵ����� ***-****-**** tnwjd
update personinfo set hp='***-****-****';


-���̺����
drop table personinfo;
drop sequence seq_start;

select * from personinfo;



--dept���� 30�� �μ��� �þ�Ʋ�� ����
select * from dept;
update dept set loc='�þ�Ʋ' where deptno='30'; 

--emp���̺�Totalsal���� �ϳ� �� �߰�(number(20)���� �ٰ�)
alter table emp add Totalset number(20);

--emp���̺� Totalset�� sal�� comm�� ���� ������ �����Ͻÿ�
update emp set totalset=sal+nvl(comm,0);

--emp���� WARD ����
delete from emp where ename='WARD';

--product���̺��� 100���� �������̷� ����
update product set p_name='��������' where p_code=100;
select * from product;



--Group by
--professor���� �а����� �������� ��ձ޿��� ����Ͻÿ�.
select deptno, avg(pay) "��� �޿�"
from professor group by deptno;

--select���� ���� �׷��Լ� �̿��� �÷��̳� ǥ������ �ݵ�� group by�� ���Ǿ����.

--professor���� ���޺� ��պ��ʽ�
select position ����,avg(nvl(bonus,0)) "��� ���ʽ�" from professor group by position;

--�а��� ���޺��� �������� ��ձ޿�
select deptno,position,avg(pay) "��� �޿�" from professor
group by deptno,position;

--student���� �г⺰ �ְ�Ű�� �ְ������ ���
select grade,max(height) "�ְ� ����",max(weight) "�ְ� ������" from student
group by grade;

--������ ���޺� �ѱ޿��� �ְ��ʽ��� ���Ͻÿ�
select position,sum(pay) "�� �޿�",max(bonus) "�ְ� ���ʽ�"
from professor group by position;

--emp���� ������ ���������� ��� �� ���ϱ�
select job ����,count(job) "��� ��" from emp
group by job;

--Having��_�����ְ� �˻��ϱ�_�ݵ�� GROUP BY �ڿ�!!....
--��� �޿��� 2000�̻��� �μ��� �μ���ȣ�� ��� �޿��� ���Ͻÿ�
--where���� �׷��Լ��� ���������� �� �� ����.
--group�Լ��� ���������� ������ having �ʿ�!
select deptno �μ���ȣ,avg(sal) "��� �޿�"
from emp group by deptno
having avg(sal)>2000;

--professor���� ��ձ޿��� 300�̻��� �а���ȣ�� ��ձ޿��� ���Ͻÿ�.
select deptno �а���ȣ,avg(pay) "��� �޿�"
from professor group by deptno
having avg(pay)>425;

--emp���� job���� sal�� ��ձ޿��� ���Ͻÿ�
select job ����,round(avg(sal),2) ��ձ޿�
from emp
group by job;

--profecssor���� ���޺� �ѱ޿��� ���Ͻÿ�
select position ����,sum(pay)
from professor
group by position;


--emp���� ������ �ο� �� �ִ�޿� �ּұ޿� ����ϼ���(job�� ��������)
select job ����,count(*) "�ο� ��",max(sal) "�ִ� �޿�",min(sal) "�ּ� �޿�"
from emp group by job order by job;

--emp���� �Ի�⵵ �׷캰�� ���(�Ի�⵵,�ο���,�޿���(�Ҽ�÷1�ڸ�) _ �Ի�⵵ ��������
select to_char(hiredate,'yyyy') �Ի�⵵,count(*) �ο���, round(avg(sal),1) �޿����
from emp group by to_char(hiredate,'yyyy') 
order by to_char(hiredate,'yyyy');

--Rollup�Լ�
--�ڵ����� �Ұ�/�հ� �����ִ� �Լ�
--group by���� �־��� �������� �Ұ谪�� �����ش�
select deptno �а���ȣ,position ����,sum(pay) �ѱ޿� 
from professor
group by position,rollup(deptno);

select deptno �а���ȣ,position ����,sum(pay) �ѱ޿� 
from professor
group by deptno,rollup(position);

select deptno,position,count(*),sum(pay)
from professor
group by rollup(deptno,position);

--cube�Լ�
--rollupó�� ���Ұ迡 ��ü�Ѱ���� �����ش�

select deptno,position, count(*),sum(pay)
from professor
group by cube(deptno,position);

--������ �Ѻ���
--Q1. emp���� ��տ����� 2000�̻��� �μ��� �μ���ȣ�� ��ձ޿��� ���Ͻÿ�
select deptno �μ���ȣ, round(avg(sal),1)
from emp group by deptno
 having avg(sal)>2000;
 
 --Q2. emp���� deptno�� deptno�� 10,20,30�� �μ��� ������?
 select deptno, count(*)
 from emp group by deptno;

--Q3. emp���� job�� �ο����� ���Ͻÿ�(�� �ο��� 2���̻��ΰ��� ���Ұ�)
select job, count(*) from emp
group by job having count(*)>=2;

--Q4. emp���� job���� �޿��հ踦 ���ϴµ�(president�� �����Ұ�) �޿��հ谡 5000�̻� ���Ͻð� �޿��հ谡 �����ͺ��� ���
select job, sum(sal) from emp
where job not in ('PRESIDENT')
group by job
having sum(sal)>=5000
order by sum(sal);

--��������
--���̺� ���� pk = primary key
create table sawon(num number(5) CONSTRAINT sawon_pk_num primary key,
name varchar2(20),
gender varchar2(10),
buseo varchar2(20) CONSTRAINT sawon_ck_buseo check(buseo in('ȫ����','�λ��','������')),
pay number(10) default 2000000);

--������ ����
create sequence seq_sawon nocache;

--������ 10���� insert
--insert into swaon values(seq_sawon.nextval,'�̿���','����','���Ӱ��ߺ�',3500000);
insert into sawon values(seq_sawon.nextval,'�̿���','����','�λ��',3500000);
insert into sawon values(seq_sawon.nextval,'�迵ö','����','ȫ����',3100000);
insert into sawon values(seq_sawon.nextval,'�̰���','����','������',2900000);
insert into sawon values(seq_sawon.nextval,'����ö','����','ȫ����',2800000);
insert into sawon values(seq_sawon.nextval,'���ҹ�','����','�λ��',4200000);
insert into sawon values(seq_sawon.nextval,'�ſ���','����','�λ��',3800000);
insert into sawon values(seq_sawon.nextval,'���ǿ�','����','ȫ����',3200000);
insert into sawon values(seq_sawon.nextval,'�賲��','����','������',2600000);
insert into sawon values(seq_sawon.nextval,'ȫ�̳�','����','������',3000000);
insert into sawon values(seq_sawon.nextval,'�̼���','����','������',3500000);
commit;

--�μ��� �ο����� �ְ�޿�,�����޿� ��ȸ
select buseo �μ�,count(*) ,max(pay) �ְ�޿�,min(pay) �����޿�
from sawon group by buseo;

--���� ���������� �ְ�޿�,�����޿��� ȭ����� ������ 3�ڸ� �ĸ��� ������ ���ּ���
select buseo �μ�,count(*) ,to_char(max(pay),'L999,999,999') �ְ�޿�,
to_char(min(pay),'L999,999,999') �����޿�
from sawon group by buseo;

--���� �ο����� ��ձ޿��� ����Ͻÿ�(�ο��� �ڿ� �� �̶�� ��������..)
select gender ����,count(*)||'��' ���ο�, avg(pay) from sawon
group by gender;

--�μ��� �ο����� ��ձ޿��� ���ϵ� �ο��� 4���̻��� ��쿡�� ��µǵ��� �ϼ���
select buseo, count(*)||'��',round(avg(pay),2) from sawon
group by buseo
having count(*)>=4;

select * from sawon;

desc sawon;
