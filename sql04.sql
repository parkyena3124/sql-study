use my_shop;

-- 주문테이블
create table orders(
   order_id int auto_increment primary key,
    customer_id int not null,
    product_id int not null,
    
    quantity int not null -- 주문 수량
    constraint chk_order_quan check(quantity >= 1),
    -- constraint : 제약조건/ chk_order_quan(이름 명명)
    -- check(quantity >= 1) : 수량이 1개 이상 체크
    
    order_date datetime  default current_timestamp,
    o_status varchar(20) not null default '주문접수',
    
    constraint fk_orders_customers foreign key (customer_id)
      references customers(customer_id)
      -- 주문테이블의 customer_id(외래키) - customers(customer_id) 연결
      on update cascade,
      -- cascade: 부모테이블이 갱신(수정)/ 삭제되면 다른 자식테이블도 같이 수정/삭제
    
    constraint fk_orders_products foreign key (product_id)
      references products(product_id)
       -- 주문테이블의 product_id(외래키) - 상품테이블의 product_id 연결
       -- fk_orders_products: 제약조건마다 이름을 정함(우리가 만든 이름)
      on update cascade
  );
  desc orders;
  desc products;
  desc customers;
  
  -- alter table: 이미 만든 테이블 구조 변경
  -- 열추가: add column
  alter table customers
  add column point int not null default 0; -- 속성 추가
  desc customers;
  select * from customers;
  
  -- 열(속성, 필드) 변경: modify column 
  alter table customers
  modify column address varchar(300) not null;
  desc customers;
  
  -- 열 삭제: drop column
  alter table customers
  drop column point;
  desc customers;
  
  alter table orders
  alter o_status set default '주문접수 완료';
  desc orders;
  
  insert into customers
  (c_name, email, c_password, address, join_date) values
  ('이순신', 'sunsin@naver.com', 'password123', '서울특별시 중구 세종대로', '2026-05-01 10:30:00'),
('세종대왕', 'sejong@naver.com', 'password456', '서울특별시 종로구 사직로', '2025-04-01'),
('장영실', 'young@naver.com', 'password789', '부산광역시 동래구 복천동', '2026-03-10');

insert into customers
  (c_name, email, c_password, address) values
  ('강감찬', 'kang@naver.com', 'password777', '인천 남동구 구월동'); 
  
  select * from customers;
  -- 이름 바꾸는 거: alter table customers
  -- rename column name to c_name;
  
  desc products;
  insert into products
  (p_name, descr, price, stock_quantity) values
  ('갤럭시', '최신 AI 기능이 탑재된 고성능 스마트폰', 1000000, 55);
  
  INSERT INTO products (p_name, descr, price, stock_quantity) VALUES
  ('LG 그램', '초경량 디자인과 강력한 성능을 자랑하는 노트북', 500000, 35),
  ('아이폰', '직관적인 사용자 경험을 제공하는 스마트폰', 800000, 55),
  ('에어팟', '편리한 사용성의 무선 이어폰', 200000, 110),
  ('알뜰폰', NULL, 300000, 100);

  select * from products;
  
  desc orders;
  insert into orders
  (customer_id, product_id, quantity) values
  (1, 1, 1);
  
  insert into orders
  (customer_id, product_id, quantity) values
  (2, 2, 1), 
  (3, 3, 1), 
  (1, 4, 2), 
  (2, 2, 1);

  select * from orders;
  select * from customers;
  select * from products;
  
   -- 1. 외래키 체크 비활성화
   -- SET FOREIGN_KEY_CHECKS = 0;
   -- 2. 테이블 비우기
   -- TRUNCATE TABLE products;
   -- 3. 외래키 체크 다시 활성화 (필수!)
   -- SET FOREIGN_KEY_CHECKS = 1;
  
  update customers set customer_id=10 
  where customer_id=4;
  
  update customers set c_password='password100'
  where customer_id=10;
  
  -- delete from customers
  -- where customer_id=10;
  -- set으로 지정되어 있지않아서 customers table에 있는 내용 다 삭제됨
  
  -- insert into customers (email,c_password, address)
  -- value('aaa@naver.com', 'pass111', '인천 미추홀구 용현동');
  -- NULL값인 c_name이 없음
  
  -- insert into customers(c_name, email, c_pass, address)
  -- value('홍길동', 'kang@naver.com', 'pass9999', '인천 남동구 논현동');
  -- 이메일 중복
  
  -- insert into orders(customer_id, product_id, quantity)
  -- value(12, 1, 1);
  -- 없는 고객임
  
  select * from customers;
  update customers set c_password='password333'
  where c_name='장영실';
  
  -- 기본키로만 조건을 작성(일반 필드로도 조건 작성)
  SET SQL_SAFE_UPDATES = 0; -- 안전 모드 해제 (0 = OFF)
  SET SQL_SAFE_UPDATES = 1;  
  
  -- 인덱스 생성
  create index i_price on products(price);
  select * from products where price >= 500000;
  
  -- view(뷰): 데이터를 따로 저장 안함, 필요한 것만 꺼내와서 사용자에게 보여줌
  create view v_masking as 
	select 
	 customer_id,
     c_name,
     email,
     join_date
	from customers;
  select * from v_masking;
  
  create view v_seoul as
	select customer_id, c_name, address
    from customers
    where address like '%서울%'; -- 서울 포함
    -- like: ~와 같다, %: 모든 문자 대체(공백도 대체)
  select * from v_seoul;
  select * from products;
  
  create view v_des as
	select p_name, descr, price
    from products
    where descr like '%ai%';
  select * from v_des;

  create view v_order_details as
  select
		o.order_id,
        c.c_name as 고객이름,
        p.p_name as 상품명,
		o.order_date as 주문일시,
        o.o_status as 주문상태
        from orders o
        join customers c on o.customer_id = c.customer_id
        join products  p on o.product_id = p.product_id;
	
    select * from v_order_details;
	
	create view v_order_test as 
    select
		  a.order_id as 주문번호,
          b.customer_id as 고객번호,
		  b.c_name as 고객명,
          a.quantity as 수량
          from orders a
          join customers b on a.customer_id = b.customer_id;
        
	select * from v_order_test;
        
	drop view v_masking;
	
    select c_name, address from customers;
    select * from products where price >=700000;
    
    select * from customers
    where join_date >= '2026-01-01';
    
    select * from products
    where price >= 500000 and stock_quantity >= 50;
	
    -- where: 조건, between 0~ and 10: 범위 
	select * from products
    where price not between 500000 and 1000000;
	
    -- in: 포함,	not in: 포함 안됨
	select * from products
    where p_name not in ('갤럭시', '아이폰', '아이폰18');
    
	select * from customers
    where c_name like '강%';
    
    -- _(밑줄): 한글자
    select * from customers
    where address not like '서울특별시%';
    
    
	select * from customers;
    select * from products;
    select * from orders;
    -- products 상품명이 아로 시작 3글자
    
    select * from products
    where p_name like '아__'; -- 밑줄(_): 글자 1자리 의미
    
	select * from products
    where p_name like '아%';
    
    select * from products
    where price < 500000 or price > 800000;
    
    -- between 이용 예) between 300000 and 500000 (300000~500000)
    select * from products
    where price not between 300000 and 500000;
    
    -- 상품명이 ('갤럭시', '아이폰', '에어팟') 일치하면 조회
    select * from products
    where p_name in ('갤럭시', '아이폰', '에어팟');
    
    -- 정렬(order by): asc(오름차순(작->큰) a-z 가-하, 기본으로 생략 가능), desc(내림차순)
    select * from customers
    order by join_date desc;
    
    select * from products 
    order by price asc;
    
    -- 다중 열 정렬(stock_quantity(재고수량) 큰거부터 price(가격)은 작은 거 부터
    select * from products
    order by stock_quantity desc, price asc;
    
    -- 가격이 가장 비싼 상품 2개 나열
    select * from products
    order by price desc limit 2; -- limit: 개수 제한
    
    -- 재고 수량이 작은 상품 3개 나열
    select * from products
    order by stock_quantity asc limit 3;
    
	select * from products
    order by product_id asc limit 2,2; -- limit 2,2: 2개 건너뜀, 2개 보여줌
    
    -- DISTINCT: 중복 제거(대소문자 상관 X)
	select distinct customer_id from orders;
    SELECT DISTINCT product_id FROM orders;
    
    -- null 값을 검사하기 위해서는 is null 사용 (not: is랑 null 사이에 들어감)
    SELECT * FROM products
    where descr is null; -- null: 알수 없음
    
    select product_id, p_name, descr is null from products;
    -- descr is null: null 참이면 1 거짓이면 0
    
    -- descr(설명)을 오름차순으로 정렬 (ㄱㄴㄷ~,abc~)(null 값은 가장 작은 값)
    select * from products
    order by descr asc;
    
    -- 주소가 인천인 고객에 대해 고객테이블에서 이름과 주소 검색
    select c_name, address from customers
    where c_name in (select c_name from customers
					  where address like '인천%');
    
    -- 상품명, 가격 (상품테이블) -> 조건 상품코드 일치(in)
    -- 주문 테이블에서 상품코드 3인 것의 상품코드
    select p_name, price from products
    where product_id in
    (select product_id from orders where product_id =3);
    
    select p_name, price, stock_quantity
    from products
    where p_name not in ('갤럭시', '아이패드');
    
    -- 상품테이블의 상품코드를 주문테이블의 상품코드와 일치
    select * from products
    where product_id
    in (select product_id from orders);
    
    
    