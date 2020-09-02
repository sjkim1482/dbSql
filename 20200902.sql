==SELECT 쿼리 문법==
SELECT * | {column} | expression [alias]}
FROM 테이블 이름;

SQL 실행 방법
1. 실행하려고 하는 SQL을 선택 후 cntl + enter;
2. 실행하려는 sql 구문에 커서를 위치시키고 cntl + enter;

SELECT *
FROM emp;

select empno, ename
from emp;



SELECT *
FROM dept;

SQL 의 경우 KEY워드의 대소문자를 구분하지 않는다

실습 select1

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SELECT sal, sal + 100
FROM emp;

SELECT 쿼리는 테이블의 데이터에 영향을 주지 않는다.
SELECT 쿼리를 잘못 작성 했다고 해서 데이터가 망가지지 않음
데이터 타입
DESC 테이블명 (테이블 구조를 확인)

DESC emp;

hiredate에서 365일 미래의 일자
SELECT ename, hiredate, hiredate + 365 after_1year, hiredate - 365 before_1year
FROM emp;

==중요하지는 않음==
별칭 : 컬럼, expression에 새로운 이름을 부여
별칭 부여
        컬럼 | expression [AS] [컬럼명]
별칭 부여 주의점
1. 공백이나, 특수문자가 있는경우 더블 쿼테이션으로 감싸줘야한다.
ex)
SELECT ename "emp name"
FROM emp;
2. 별칭명은 기본적으로 대문자로만 취급되지만 소문자로 지정하고 싶으면
   더블 쿼테이션을 적용한다.
ex)
SELECT empno emp_no, empno "emp_no2"
FROM emp;

자바에서 문자열 : "Hello World"
SQL에서 문자열 : 'Hello World'

==매우중요==
NULL : 아직 모르는 값
숫자 타입 : 0이랑 NULL은 다르다
문자 타입 : ' ' 공백문자와 NULL은 다르다

**** NULL을 포함한 연산의 결과는 항상 NULL

emp 테이블 컬럼 정리
1. empno : 사원번호
2. ename : 사원이름
3. job : (담당)업무
4. mgr : 매니저 사번번호
5. hiredate : 입사일자
6. sal : 급여
7. comm : 성과금
8. deptno : 부서번호

emp 테이블에서 NULL값을 확인
SELECT ename, sal, comm, sal + comm AS total_sal
FROM emp;

SELECT *
FROM dept;

SELECT userid, usernm, reg_dt, reg_dt + 5
FROM users;

SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS 바이어아이디, buyer_name AS 이름
FROM buyer;


literal : 값 자체
literal 표기법 : 값을 표현하는 방법

숫자 10이라는 숫자 값을
java : int a = 10;
sql : SELECT empno, 10
      FROM emp;
      
문자 Hello, Wrold 라는 문자 값을
java : String str = "Hello World";
sql : SELECT empno, 'Hello, World', "Hello, World"
      FROM emp;
      
날짜 2020년 9월 2일이라는 날짜 값을..
java : primitive type(원시타입) : 8개
       날짜 ==> Date class
sql : 나중에

문자열 연산
java + ==> 결합 연산
    "Hello, " +"World" ==> "Hello,World"
    "Hello, " -"World" ==> "연산자가 정의되어 있지 않다"
    "Hello, " *"World" ==> "연산자가 정의되어 있지 않다"
python
    "Hello, " * 3 ==> "Hello, "Hello, "Hello, "
sql ||, CONCAT 함수 ==> 결합 연사
    emp테이블의 ename, job 컬럼이 문자열
SELECT ename|| ' ' || job
FROM emp;

CONCAT(문자열1, 문자열2) : 문자열1과 문자열2를 합쳐서 만들어진 새로운 문자열을 반환해준다
SELECT CONCAT(ename, CONCAT(' ', job))
FROM emp;

USER_TABLES : 오라클에서 관리하는 테이블(뷰)
              접속한 사용자가 보유하고 있는 테이블 정보를 관리
            
SELECT table_name, CONCAT('SELECT * FROM ' ,CONCAT(table_name,';')) AS QUERY 
FROM user_tables;

















