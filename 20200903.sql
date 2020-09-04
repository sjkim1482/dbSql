SELECT empno "test"
FROM emp;

SELECT 'SELECT * FROM' || table_name || ';'
FROM user_tables;

테이블의 구조(컬럼명, 데이터타입) 확인하는 방법
1. DESC 테이블명 : DESCRIBE
2. 컬럼 이름만 알 수 있는 방법(데이터 타입은 유추)
    SELECT *
    FROM 테이블명;
3. 툴에서 제공해주는 메뉴 이용
    접속 정보 - 테이블 - 확인 하고자하는 테이블 클릭
NULLABLE : no, yes로 null값의 허용 여부를 정함


SELECT 절: 컬럼을 제한

***********매우매우매우 중요**********
WHERE 절 : 조건에 만족하는 행들만 조회되도록 제한 (행을 제한)
           ex ) sal 컬럼의 값이 1500보다 큰 사람들만 조회 ==> 7명
           
*WHERE절에 기술된 조건을 참(TRUE)으로 만족하는 행들만 조회가 된다.*
           
조건 연산자
    동등 비교(equal)
        java : int a = 5;
                primitive type : == ex ) a == 5;
                object : "+".equals("-")
        sql : sal = 1500
    not equal
        java : !=
        sql : !=, <>
        
    대입연산자
        java : =
        pl/sql : (:=)
        
users테이블에는 총 5명의 캐릭터가 등록이 되어있는데
그중에서 userid 컬럼의 값이 'brown'인 행만 조회하도록
WHERE절에 조건을 기술
SELECT userid, usernm, alias, reg_dt
FROM users
WHERE 1 = 2;

SQL은 대소문자를 가리지 않는다 : 키워드, 테이블명, 컬럼명
데이터는 대소문자를 가린다.

컬럼과 문자열 상수를 구분하여 사용

emp테이블에서 부서번호가(dept)가 30보다 크거나 같은 사원들만 조회
SELECT *
FROM emp
WHERE deptno>=30;

날짜 비교
1982년 1월 1일 이후에 입사한 사람들만 조회(이름, 입사일자)
hiredate type : date
문자 리터럴 표기법 : '문자열'
숫자 리터럴 표기법 : 숫자
날짜 리터럴 표기법 : 항상 정해진 표기법이 아니다. 
                  서버 설정마다 다르다.
                  한국 : yy/mm/dd
                  미국 : mm/dd/yy
날짜 리터럴 결론 : 문자열 형태로 표현하는 것이 가능하나
                서버 설정마다 다르게 해석할 수 있기 때문에
                서버 설정과 관계없이 동일하게 해석할 수 있는 방법으로 사용
                TO_DATE('날짜문자열','날짜문자열형식')
                    : 문자열 ==> 날짜 타입으로 변경
SELECT ename, hiredate
FROM emp
WHERE hiredate >= '82/01/01';

년도 : yyyy
월 : mm
일 : dd
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982-01-01','yyyy-mm-dd');

BETWEEN AND 연산자
WHERE 비교대상 BETWEEN 시작값 AND 종료값;
비교대싱의 값이 시작값과 종료값 사이에 있을 때 참(TRUE)으로 인식
(시작값과, 종료값을 포함 비교대상 >= 시작값, 비교대상 <= 종료값)

emp테이블에서 sal 컬럼값이 1000이상 2000이하인 사원들의 모든 컬럼 조회
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


SELECT *
FROM emp
WHERE sal >= 1000 AND sal<= 2000;

(실습 WHERE 1)
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982-01-01','yyyy-mm-dd') AND TO_DATE('1983-01-01','yyyy-mm-dd');

(실습 WHERE 2)
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982-01-01','yyyy-mm-dd') AND hiredate <=TO_DATE('1983-01-01','yyyy-mm-dd');
TO_DATE 함수를 적용하는게 나중에 좋음

IN 연산자
특정 값이 집합(여러개의 값을 포함)에 포함되어 있는지 여부를 확인
OR연산자로 대체하는 것이 가능

WHERE 비교대상 IN (값1, 값2.....)
==> 비교대상이 값1 이거나(=)
    비교대상이 값2 이거나(=)
    
WHERE 비교대상 = 값1
   OR 비교대상 = 값2

emp테이블에서 사원이 10번 부서 혹은 30번 부서에 속한 사원들 정보를 조회(모든 컬럼)
SELECT *
FROM emp
WHERE deptno IN(10,30);

AND ==> 그리고
OR ==> 또는

조건1 AND 조건2 ==> 조건1과 조건2를 동시에 만족
조건1 OR 조건2 ==> 조건1을 만족하거나, 조건2를 만족하거나
                  조건1과 조건2를 동시에 만족하거나

SELECT *
FROM emp
WHERE deptno =10 OR deptno = 30;

DESC users;

(WHERE3)
users
SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users
WHERE userid IN('brown','cony','sally');

SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users
WHERE userid ='brown' OR userid ='cony' OR userid = 'sally';


LIKE 연산자 : 문자열 매칭
WHERE userid = 'brown'
userid가 b로 시작하는 캐릭터만 조회
% : 문자가 없거나, 여러개의 문자열
_ : 하나의 임의의 문자

ename이 W로 시작하고 이어서 3개의 글자가 있는 사원
SELECT *
FROM emp
WHERE ename LIKE 'W___';

실습 WHERE
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

SELECT *
FROM emp
WHERE comm IS NOT NULL;






SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982-01-01','yyyy-mm-dd') AND TO_DATE('1983-01-01','yyyy-mm-dd');

SELECT ename, hiredate
FROM emp
WHERE TO_DATE('1982-01-01','yyyy-mm-dd')<= hiredate AND hiredate <= TO_DATE('1983-01-01','yyyy-mm-dd');


SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users
WHERE userid IN('brown', 'cony', 'sally');



SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('신%');


SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('%은%');

SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981-06-01','yyyy-mm-dd');

SELECT *
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('1981-06-01','yyyy-mm-dd');































