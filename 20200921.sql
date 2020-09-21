PRIMARY KEY : PK_테이블명
FOREIGN KEY : FK_소스테이블명_참조테이블명

제약조건 삭제
ALTER TABLE 테이블몇 DROP CONSTRAINT 제약조건명;

1. 부서 테이블에 PRIMARY KEY 제약조건 추가
2. 사원 테이블에 PRIMARY KEY 제약조건 추가
3. 사원 테이블-부서테이블간 FOREIGN KEY 제약조건 추가

제약조건 삭제시는 데이터 입력과 반대로 자식부터 먼저 삭제
3 - (1,2)

ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
ALTER TABLE emp_test DROP CONSTRAINT FK_emp_test_dept_test;
ALTER TABLE dept_test DROP CONSTRAINT PK_dept_test;
ALTER TABLE emp_test DROP CONSTRAINT PK_emp_test;

SELECT *
FROM user_constraints
WHERE table_name IN('EMP_TEST', 'DEPT_TEST');

ALTER TABLE dept_test ADD CONSTRAINT PK_dept_test PRIMARY KEY (deptno);

     
SELECT *
FROM user_tables;

SELECT *
FROM user_constraints
WHERE table_name IN('EMP_TEST', 'DEPT_TEST');


ALTER TABLE dept_test ADD CONSTRAINT PK_dept_test PRIMARY KEY (deptno);
ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno)
REFERENCES dept_test(deptno);

제약조건 조회
SELECT *
FROM user_constraints
WHERE table_name IN('EMP_TEST', 'DEPT_TEST');

제약조건 활성화-비활성화 테스트
테스트 데이터 준비 : 부모 - 자식 관계가 있는 테이블에서는 부모 테이블에 데이터를 먼저입력
dept_test ==> emp_test
INSERT INTO dept_test VALUES (10, 'ddit');

SELECT *
FROM dept_test;

SELECT *
FROM emp_test;

dept_test와 emp_test 테이블간 FK가 설정되어 있지만 10번 부서는 dept_test에 존재하기 때문에
정상입력
INSERT INTO emp_test VALUES (9999, 'brown',10);
20번 부서는 dept_test 테이블에 존재하지 않는 데이터이기 떄문에
FK에 의해 입력불가
INSERT INTO emp_test VALUES (9998, 'sally',20);

FK를 비활성화 한 후 다시 입력
SELECT *
FROM user_constraints
WHERE table_name IN('EMP_TEST', 'DEPT_TEST');

ALTER TABLE emp_test DISABLE CONSTRAINT FK_emp_test_dept_test;
INSERT INTO emp_test VALUES (9998, 'sally',20);
COMMIT;

dept_test : 10
emp_test : 9999(99) 10, 9998(98) 20 ==> 10, NULL, 삭제

FK 제약조건 재 활성화
ALTER TABLE emp_test ENABLE CONSTRAINT FK_emp_test_dept_test;

테이블, 커럼 주석(comments) 생성가능
테이블 주석 정보확인
user_tables, user_constraint, user_tab_comments (제약조건들)
SELECT *
FROM user_tab_comments;

테이블 주석 작성 방법
COMMENT ON TABLE 테이블명 IS '주석';

EMP 테이블 주석(사원) 생성하기;
COMMENT ON TABLE emp IS '사원';

컬럼 주석 확인
SELECT *
FROM user_col_comments
WHERE table_name = 'EMP';

컬럼 주석 다는 문법
COMMENT ON COLUMN 테이블명.컬럼명 IS '주석';

COMMENT ON COLUMN emp.EMPNO IS '사번';            
COMMENT ON COLUMN emp.ENAME IS '사원이름';            
COMMENT ON COLUMN emp.JOB IS '담당역할';              
COMMENT ON COLUMN emp.MGR IS '매니저 사번';              
COMMENT ON COLUMN emp.HIREDATE IS '입사일자';         
COMMENT ON COLUMN emp.SAL IS '급여';              
COMMENT ON COLUMN emp.COMM IS '성과금';             
COMMENT ON COLUMN emp.DEPTNO IS '소속부서번호';           


SELECT *
FROM
(SELECT *
FROM user_tab_comments
WHERE table_name IN ('CYCLE','CUSTOMER','PRODUCT','DAILY'))a
,
(SELECT *
FROM user_col_comments
WHERE column_name IN ('PID','DT','PNM','CID','DAY','CNM','CNT'))b
WHERE a.table_name=b.table_name;

SELECT *
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name
 AND c.table_name IN ('CYCLE','CUSTOMER','PRODUCT','DAILY');



SELECT *
FROM user_tab_comments
WHERE table_name = 'PRODUCT';

SELECT *
FROM user_tab_comments
WHERE table_name = 'DAILY';

SELECT *
FROM user_col_comments
WHERE column_name = 'CID';

SELECT *
FROM user_col_comments
WHERE column_name = 'DAY';

SELECT *
FROM user_col_comments
WHERE column_name = 'CNT';

SELECT *
FROM user_col_comments
WHERE column_name = 'PID';

SELECT *
FROM user_col_comments
WHERE column_name = 'DT';


SELECT *
FROM user_constraints
WHERE table_name IN ('EMP','DEPT');



SELECT *
FROM user_constraints
WHERE table_name IN ('DEPT');




DESC dept;

SELECT *
FROM dept;

DELETE dept
WHERE deptno = 90;


ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT FK_empm_empe FOREIGN KEY (mgr) REFERENCES emp(empno);
ALTER TABLE emp ADD CONSTRAINT FK_emp_dept FOREIGN KEY (deptno) REFERENCES dept(deptno);


SELECT *
FROM user_constraints
WHERE table_name IN ('EMP','DEPT');

SELECT *
FROM emp;

VIEW : VIEW는 쿼리이다. (VIEW 테이블은 잘못된 표현)
 . 물리적인 데이터를 갖고 있지 않고, 논리적인 데이터 정의 집합이다(SELECT 쿼리)
 . VIEW가 사용하고 있는 테이블의 데이터가 바뀌면 VIEW 조회 결과도 같이 바뀐다.
문법
CREATE OR REPLACE VIEW 뷰이름 AS
SELECT 쿼리;

EMP테이블에서 sal, comm 컬럼 두개를 제외한 나머지 6개 컬럼으로 v_emp이름으로 VIEW 생성
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

SELECT *
FROM v_emp;

GRANT CONNECT, RESOURCE TO 계정명;
VIEW에 대한 생성권한은 RESOURCE에 포함되지 않는다;


VIEW 는 쿼리를 저장했다 생각 하면 됨


SJK 계정에 있는 V_EMP 뷰를 HR계정에 조회할 수 있도록 권한 부여

GRANT SELECT ON v_emp TO HR;









