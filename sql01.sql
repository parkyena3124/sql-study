create database my_shop; -- 데이터베이스 생성 
use my_shop; -- 데이터베이스 사용
-- 테이블 정의(설계): 필드 -> 상품ID, 상품이름, 가격, 재고수량, 출시일 
create table sample ( -- 관계형 데이터베이스의 표 생성
	pro_id int primary key, -- 기본키
    p_name varchar(100), -- varchar: 가변길이, 최대 100
    price int,
    quan int,
    re_date date
    );
desc sample; -- 테이블의 구조 확인
show databases; -- 데이터베이스 보기
show tables; -- 테이블 보기
drop table sample; -- 테이블 삭제
drop database my_shop; -- 데이터베이스 삭제
show databases;

-- CRUD(넣고/읽고/수정하고/삭제) 기본작업
-- C(입력): insert
insert into sample (pro_id, p_name, price, quan, re_date)
value (1, '새우깡', 3000, 100, '2026-05-03');
insert into sample (pro_id, p_name, price, quan, re_date)
value (2, '양파링', 2500, 300, '2026-04-01');
-- R(읽기): select
select * from sample;
select pro_id, p_name from sample;
-- U(수정): update
update sample set price = 5000 where pro_id=1;
update sample set quan = 1000 where pro_id=2;
-- D(삭제): delete
delete from sample where pro_id=2;
 