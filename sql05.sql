use my_shop;

-- 주문 통계 테이블
CREATE TABLE order_stat ( 
    order_id INT PRIMARY KEY AUTO_INCREMENT, 
    customer_name VARCHAR(50),
    category VARCHAR(50), -- 카테고리
    product_name VARCHAR(100),
    price INT,
    quantity INT,
    order_date DATE
);

INSERT INTO order_stat (customer_name, category, product_name, price, quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17'); 
-- 카테고리가 NULL인 데이터 추가
select *from order_stat;
select count(customer_name) from order_stat;
-- count(표현식): 개수 (null 제외)
select count(category) from order_stat; 
select count(*) from order_stat;
-- count(*): 전체 개수
-- sum() avg()
select 
sum(price*quantity) as `총 매출액`,
round(avg(price*quantity),1) as `평균 매출액`
from order_stat;
-- truncate table: 테이블 구조는 그대로 내용만 전부 삭제
-- truncate(AVG(price * quantity),1): 소수이하 버리는 함수
-- 집계함수(count, sum, avg, max, min~~)
select
min(order_date) as `최초 주문일`,
max(order_date) as `가장 최근 주문일`
from order_stat;

select
count(customer_name) as `총 주문건수`,
count(distinct customer_name) as `순수고객 수`
from order_stat;
select DISTINCT customer_name from order_stat;

-- group by: 그룹으로 묶기
select 
	category,
    count(*) as `카테고리별 주문 건수`
from order_stat 
group by category;

--  고객별로 총 몇번 주문했는지(주문 횟수)
select
	customer_name,
    count(*) as `주문 횟수`,
    sum(quantity) as `총 구매 수량`,
    sum(quantity*price) as `총 구매 금액`
from order_stat
group by customer_name
order by `총 구매 금액` desc;

-- 1단계: 고객별 총 주문 횟수 집계하기
-- 2단계: having절을 추가하여 주문 횟수 3회 이상인 그룹 필터링하기
-- having: 그룹에 대한 조건을 필터링(걸러냄)

select
	customer_name,
    count(*) as `주문 횟수`
from order_stat
group by customer_name
having count(*) >=  3;
-- 순서: from -> where -> group by -> having -> select -> order by
-- where: 전체를 대상으로 한 조건
-- having: group by와 같이 사용, 그룹에 대한 조건
select -- (5) 카테고리, 횟수 조회
	category,
    count(*) as `카테고리 주문 횟수` 
from order_stat -- (1) 
where price >= 100000 -- (2): 가격이 10만 이상
group by category -- (3): 카테고리별로 그룹
having count(*) >=2; -- (4): 그룹 별로 개수가 2개 이상

select -- 5
	customer_name,
	sum(price*quantity) as `총 구매 금액`
from order_stat -- 1
where order_date <= '2025-05-14' -- 2
group by customer_name -- 3
having count(*) >= 2 -- 4
order by `총 구매 금액` desc -- 6
limit 1; -- 7

-- group by 나올때 select에 나오는 필드명은 반드시 group by 뒤에 나오는 필드명이거나 집계함수만 가능
select * from order_stat;

















