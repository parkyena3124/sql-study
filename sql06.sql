create database db_ex;
use db_ex;

-- 학생 테이블
create table 학생(
	학번 int primary key,
    이름 varchar(30) not null,
    학과코드 varchar(50),
    선배 int,
    성적 int
    );
    
create table 학과(
	학과코드 varchar(30) PRIMARY key,
    학과명 varchar(50) not null
    );
    
create table 성적등급(
	등급 char primary key,
    최저 int not null,
    최고 int not null
	);
    
    desc 학생;
    desc 학과;
    desc 성적등급;
    
    -- 학생 데이터 
INSERT INTO 학생 VALUES (15, '한다맨', 'com', NULL, 83);
INSERT INTO 학생 VALUES (16, '이서영', 'han', NULL, 96);
INSERT INTO 학생 VALUES (17, '장효정', 'com', 15, 95);
INSERT INTO 학생 VALUES (19, '주연국', 'han', 16, 75);
INSERT INTO 학생 VALUES (37, '신동진', null, 17, 55);

-- 학과 데이터 
INSERT INTO 학과 VALUES ('com', '컴퓨터');
INSERT INTO 학과 VALUES ('han', '국어');
INSERT INTO 학과 VALUES ('eng', '영어');

-- 성적 데이터
INSERT INTO 성적등급 VALUES ('A',90,100);
INSERT INTO 성적등급 VALUES ('B',80,89);
INSERT INTO 성적등급 VALUES ('C',60,79);
INSERT INTO 성적등급 VALUES ('D',0,59);

	select * from 학생;
	select * from 학과;
	select * from 성적등급;

-- EQUI 조인
-- where절
select 학번, 이름, 학생.학과코드, 학과명 
from 학생, 학과
where 학생.학과코드= 학과.학과코드;
-- natural join: 반드시 해당 테이블들에 같은 값(속성)이 있어야함
-- 조건을 쓰지 않아도 자동으로 같은 것끼리 연결
select 학번, 이름, 학생.학과코드, 학과명 
from 학생 
natural join 학과;
-- join ~ using절
select 학번, 이름, 학생.학과코드, 학과명 
from 학생 
join 학과 
using(학과코드);    

-- NON-EQUI 조인
select 학번, 이름, 성적, 등급 from 학생, 성적등급
where 학생.성적 between 성적등급.최저 and 성적등급.최고;
-- 같은 결과
select 학번, 이름, 성적, 등급 from 학생, 성적등급
where 성적 between 최저 and 최고;

-- OUTER JOIN
-- LEFT OUTER JOIN
-- 왼쪽 테이블(학생) 전부 가져옴,
-- 오른쪽 테이블(학과)는 학과코드가 같은 것만 추출
select 학번, 이름, 학생.학과코드, 학과명 
from 학생 
left outer join 학과
on 학생.학과코드 = 학과.학과코드;

-- select 학번, 이름, 학생.학과코드, 학과명
-- from 학생, 학과
-- where 학생.학과코드 = 학과.학과코드(+);

-- RIGHT OUTER JOIN
-- 오른쪽테이블(학과) 전부 가져오고 왼쪽테이블은 학과코드 같은 것만 추출
select 학번, 이름, 학생.학과코드, 학과명 
from 학생 
right outer join 학과
on 학과.학과코드 = 학생.학과코드;

-- select 학번, 이름, 학생.학과코드, 학과명 
-- from 학생, 학과
-- where 학과.학과코드(+)= 학생.학과코드;

-- FULL OUTER JOIN
-- 왼쪽테이블과 오른쪽테이블 전부 가져옴
select 학번, 이름, 학생.학과코드, 학과명 
from 학생 
left outer join 학과
on 학과.학과코드 = 학생.학과코드
union
select 학번, 이름, 학생.학과코드, 학과명 
from 학생
right outer join 학과
on 학과.학과코드 = 학생.학과코드;

-- SELF JOIN: 같은 테이블에서 2개의 속성을 연결하여 EQUI JOIN 하는 JOIN 방법
-- 하나의 테이블로 조인
-- 학생테이블을 가상으로 하나 복사하여 사용하는 것처럼 사용
-- 학생테이블 a/b
-- 학생 a -> 후배테이블
-- 학생 b -> 선배테이블
select a.학번, a.이름, b.이름 as 선배
from 학생 a 
join 학생 b
on a.선배=b.학번;










