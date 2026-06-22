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
  