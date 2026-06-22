create user 'test_user'@'localhost' identified by 'sql12345';
-- 새로운 아이디와 비밀번호 부여
GRANT select -- GRANT: 권한부여,  select: 조회, 권한
on my_shop.* -- my_shop 데이터베이스 -> 모든 테이블 대상
to 'test_user'@'localhost';

-- 권한 새로고침
FLUSH PRIVILEGES;

revoke select
on my_shop.*
from 'test_user'@'localhost';

FLUSH PRIVILEGES;

show grants for 'test_user'@'localhost';

grant all PRIVILEGES
on my_shop.*
to 'test_user'@'localhost';

flush PRIVILEGES;

revoke all PRIVILEGES
on my_shop.*
from 'test_user'@'localhost';

FLUSH PRIVILEGES;

grant select -- 권한 부여
on my_shop.*
to 'test_user'@'localhost'
WITH GRANT OPTION; -- 다른 사용자에게도 select 권한 줄 수 있게 허용

revoke all PRIVILEGES, grant OPTION
from 'test_user'@'localhost';
-- 다른 권한도 회수

drop user 'test_user'@'localhost';
-- 아이디 삭제





