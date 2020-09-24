VIEW는 쿼리 이다
==> VIEW 는 물리적 데이터를 갖고 있지 않다
    데이터를 정의하는 SELECT 쿼리이다
    VIEW에서 사용하는 테이블의 데이터가 변경이 되면
    VIEW의 조회 결과에도 영향을 미친다

VIEW를 사용하는 사례
1. 데이터 노출을 방지
    (emp 테이블의 sal, comm을 제외하고 view를 생성, HR게정에게
     view를 조회 할 수 있는 권한을 부여.
     HR 계정에서는 emp 테이블을 직겁 조회하지 못하지만 v_emp는 가능
      ==> V_EMP에는 sal, comm컬럼이 없기 때문에 급여관련 정보는 감출 수 있었다)

2. 자주 사용되는 쿼리를 view로 만들어서 재사용
   ex : emp 테이블은 dept 테이블이랑 조인되서 사용되는 경우가 많음
        view를 만들지 않을경우 매번 조인 쿼리를 작성해야하나, view로 만들면
        재사용이 가능

3. 쿼리가 간당해진다


emp테이블과 dept 테이블을 deptno가 같은 조건으로 조인한 결과를 v_emp_dept 이름으로
view 생성
CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.*, dept.dname, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM v_emp_dept;

view 삭제
DROP VIEW 뷰이름;
DROP VIEW v_emp_dept;

CREATE VIEW v_emp_cnt AS
SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno;

SELECT *
FROM v_emp_cnt;

sequence : 중복되지 않는 정수값을 만들어내는 오라클 객체
    JAVA : UUID 클래스를 통해 중복되지 않는 문자열을 생성 할 수 있다.
    
SEQ_사용할테이블이름;
문법 : CREATE SEQUENCE 시퀀스이름;

CREATE SEQUENCE SEQ_emp;

사용방법 : 함수를 생각하자
함수 테스트 : DUAL
시퀀스 객체명.nextval : 시퀀스 객체에서 마지막으로 사용한 다음 값을 반환
시퀀스 객체명.currval : nextval 함수를 실행하고 나서 사용할 수 있다
                      nextval 함수를 통해 얻어진 값을 반환
SELECT seq_emp.nextval
FROM dual;

SELECT seq_emp.currval
FROM dual;

사용예
INSERT INTO emp (empno, ename, hiredate)
            VALUES (seq_emp.nextval, 'brown', sysdate);
SELECT *
FROM emp;

의미가 있는 값에 대해서는 시퀀스만 갖고는 만들 수 없다.
시퀀스를 통해서는 중복되지 않는 값을 생성 할 수 있다.

시퀀스는 롤백을 하더라도 읽은 값이 복원되지 않는다./읽는 즉시 커밋

INDEX : TABLE의 일부 컬럼을 기준으로 미리 정렬해둔 객체
ROWID : 테이블에 저장된 행의 위치를 나타내는 값

SELECT ROWID empno, ename
FROM emp;

만약 ROWID를 알수만 있으면 해당 테이블의 모든 데이터를 뒤지지 않아도
해당 행에 바로 접근을 할 수가 있다.

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE ROWID='AAAE5eAAFAAAACLAAH';

SELECT

BLOCK : 오라클의 기본 입출력 단위
block의 크기는 데이터베이스 생성시 결정, 기본값 8K byte
DESC emp; 테이블 한행은 최대 54 byte
block 하나에는 emp 테이블을 8000/54 = 160행이 들어갈 수 있음

사용자가 한행을 읽어도 해당 행이 담겨져 있는 block을 전체로 읽는다.

SELECT *
FROM user_constraints
WHERE table_name = 'EMP';

EMP 테이블의 EMPNO 컬럼에 PRIMARY KEY 추가
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

PRIMARY KEY(UNIQUE + NOT NULL), UNIQUE 제약을 생성하면 해당 컬럼으로 인덱스를 생성한다
==>인덱스가 있으면 값을 빠르게 찾을 수 있다.
   해당 컬럼에 중복된 값을 빠르게 찾기 위한 제한사항
   
SELECT ROWID, emp.*
FROM emp
ORDER BY empno;


시나리오0
테이블만 있는경우(제약조건, 인덱스가 없는 경우)
SELECT *
FROM emp
WHERE empno = 7782;
==> 테이블에는 순서가 없기 때문에 emp 테이블의 14건의 데이터를 모두 뒤져보고
    empno값이 7782인 한건에 대해서만 사용자에게 반환을 한다

시나리오1
emp 테이블의 empno 컬럼에 PK_EMP 유니크 인덱스가 생성된경우
(우리는 인덱스를 직접 생성하지 않았고 PRIMARY KEY 제약조건에 의해 자동으로 생성 됨)

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno=7782; 

SELECT *
FROM TABLE(dbms_xplan.display);

필터 : 다 읽고 걸름
엑세스 : 그 데이터만 찾아감

시나리오2
emp 테이블의 empno 컬럼에 PRIMARY KEY 조건이 걸려 있는 경우
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno=7782; 

SELECT *
FROM TABLE(dbms_xplan.display);

UNIQUE 인덱스 : 인덱스 구성의 컬럼의 중복 값을 허용하지 않는 인덱스 (emp.empno)
NON-UNIQUE 인덱스 : 인덱스 구성 컬럼의 중복 값을 허용하는 인덱스   (emp.deptno, emp.job)

시나리오3
emp테이블의 empno컬럼에 non-unique 인덱스가 있는경우
ALTER TABLE emp DROP CONSTRAINT pk_emp;
ALTER TABLE emp DROP CONSTRAINT fk_empm_empe;
CREATE [UNIQUE] INDEX (유니크 붙히면 유니크 디폴트 : 논유니크)
IDX_테이블명_U_01
IDX_테이블명_N_02
CREATE INDEX IDX_emp_N_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno=7782; 

SELECT *
FROM TABLE(dbms_xplan.display);

시나리오4
emp 테이블의 job 컬럼으로 non-unique 인덱스를 생성한 경우
CREATE INDEX idx_emp_n_02 ON emp (job);
ALTER TABLE emp DROP CONSTRAINT IDX_EMP_M_02;

emp 테이블에는 현재 인덱스가 2개 존재
idx_emp_n_01 : empno
idx_emp_n_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);


시나리오4
emp 테이블에는 현재 인덱스가 2개 존재
idx_emp_n_01 : empno
idx_emp_n_02 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
    AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

시나리오6
CREATE INDEX idx_emp_n_03 ON emp(job,ename);
emp 테이블에는 현재 인덱스가 2개 존재
idx_emp_n_01 : empno
idx_emp_m_02 : job
idx_emp_n_03 : job, ename

SELECT job, ename, ROWID
FROM emp
ORDER BY job, ename;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
    AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);


시나리오7
DROP INDEX idx_emp_n_03;
CREATE INDEX idx_emp_n_04 ON emp(ename, job);
emp 테이블에는 현재 인덱스가 3개 존재
idx_emp_n_01 : empno
idx_emp_m_02 : job
idx_emp_n_04 : ename, job

SELECT ename, job, ROWID
FROM emp
ORDER BY ename, job;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
    AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

시나리오8
emp 테이블에 empno 컬럼에 UNIQUE 인덱스 생성
dept 테이블에 deptno 컬럼에 UNIQUE 인덱스 생성

DROP INDEX idx_emp_n_01;
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

emp 테이블에는 현재 인덱스가 3개 존재
pk_emp : empno
idx_emp_m_02 : job
idx_emp_n_04 : ename, job


dept 테이블에는 현재 인덱스가 1개가 존재
pk_dept : deptno
COMMIT;
4       2   8     2      4   8  
emp => dept OR dept => emp

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.empno = 7788;  상수값을 먼저 읽을 확률이 높음

SELECT *
FROM TABLE(dbms_xplan.display);





===========================================
20.09.23


인덱스는 조회에는 빠르지만 삽입에는 느림



인덱스 생성 방법
1. 자동생성
   UNIQUE, PRIMARY KEY 생성시
   해당 컬럼으로 이루어진 인덱스가 없을 경우 해당 제약조건 명으로 인덱스를 자동생성
   ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
   empno 컬럼을 선두컬럼으로 하는 인덱스가 없을 경우 pk_emp이름으로 UNIQUE 인데스를 자동생성
   
   UNIQUE : 컬럼의 중복된 값이 없음을 보장하는 제약조건
   PRIMARY KEY : UNIQUE + NOT NULL
   
   DBMS입장에서는 신규 데이터가 입력되거나 기존 데이터가 수정될 때
   UNIQUE 제약에 문제가 없는지 확인 ==> 무결성을 지키기 위해
   
   빠른 속도로 중복 데이터 검증을 위해 오라클에서는 UNIQUE, PRIMARY KEY 생성시 해당 컬럼으로 인덱스를 강제한다.

   PRIMARY KEY 제약조건 생성 후 해당 인덱스 삭제 시도시 삭제가 불가
   
   FOREIGN KEY : 입력하려는 데이터가 참조하는 테이블의 컬럼에 존재하는 데이터만 입력하도록 제한
   emp 테이블에 brown 사원을 50번 부서에 입력을 하게되면 50번 부서가 dept테이블의 deptno컬럼에 존재여부를
   확인하여 존재할 시에만 emp 테이블에 테이터를 입력.
   
idx 실습 1,2]   
CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1=1;

SELECT *
FROM dept_test2;

DROP INDEX idx_dept_n_02;

CREATE UNIQUE INDEX idx_dept_test2_u_01 ON dept_test2(deptno);
DROP INDEX idx_dept_test2_u_01;


CREATE INDEX idx_dept_test2_n_01 ON dept_test2(dname);
DROP INDEX idx_dept_test2_n_01;

CREATE INDEX idx_dept_test2_n_02 ON dept_test2(deptno,dname);
DROP INDEX idx_dept_test2_n_02;












CREATE TABLE emp_test2 AS
SELECT *
FROM emp
WHERE 1=1;

CREATE INDEX idx_emp_test2_n_01 ON emp_test2(deptno);

EXPLAIN PLAN FOR
SELECT *
FROM emp_test2 m, emp_test2 e
WHERE m.mgr = e.empno
AND m.deptno = :deptno;


SELECT *
FROM TABLE(dbms_xplan.display);


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = :empno;

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE UNIQUE INDEX idx_emp_test2_u_01 ON emp_test2(empno);

DELETE emp_test2
WHERE empno = 8;


EXPLAIN PLAN FOR
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'), COUNT(*) cnt
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm');


SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM EMP e, DEPT d
WHERE e.deptno = d.deptno
AND e.deptno = :deptno
AND e.empno LIKE :empno || '%';

SELECT *
FROM TABLE(dbms_xplan.display);


CREATE UNIQUE INDEX idx_emp_u_01 ON emp(empno, deptno);
CREATE INDEX idx_emp_n_02 ON emp(ename);
CREATE INDEX idx_emp_n_04 ON emp(deptno, sal);


실습 idx3]
1) empno(=)
2) ename(=)
3) deptno(=), empno(LIKE :empno || '%')
4) deptno(=), sal(BETWEEN)




FBI : 함수를 가공한 인덱스

인덱스 사용에 있어서 중요한점
인덱스 구성컬럼이 모두 NULL이면 인덱스에 저장을 하지 않는다.
즉 테이블 접근을 해봐야 해당 행에 대한 정보를 알 수 있다.
가급적이면 컬럼에 값이 NULL이 들어오지 않을경우는 NOT NULL 제약을 적극적으로 활용
==> 오라클 입장에서 실행계획을 세우는데 도움이 된다.


synonym : 동의어
오라클 객체에 별칭을 생성한 객체
오라클 객체를 짧은 이름으로 지어줄 수 있다.

생성방법
CREATE [PUBLIC] SYNONYM 동의어_이름 FOR 오라클 객체;
PUBLIC : 공용동의어 생성시 사용하는 옵션.
         시스템 관리자 권한이 있어야 생성가능


emp테이블에 e라는 이름으로 synonym을 생성
CREATE SYNONYM e FOR emp;

SELECT *
FROM emp;

SELECT *
FROM e;


dictionary : 오라클의 객체 정보를 볼수 있는 view
dictionary의 종류는 다음 dictionary view를 통해 조회 가능
SELECT *
FROM dictionary;

dictionary는 크게 4가지로 구분 가능
USER_ : 해당 사용자가 소유한 객체만 조회
ALL_ : 해당 사용자가 소유한 객체 + 다른 사용자로부터 권한을 부여받은 객체
DBA_ : 시스템 관리자만 볼수 있으며 모든 사용자의 객체 조회
V$ : 시스템 성능과 관련된 특수 VIEW

SELECT *
FROM all_tables;

DBA 권한이 있는 계정에서만 조회 가능(SYSTEM, SYS)
SELECT *
FROM dba_tables;

multiple insert : 조건에 따라 여러 테이블에 데이터를 입력하는 INSERT

기존에 배운 쿼리는 하나의 테이블에 여러건의 데이터를 입력하는 쿼리
INSERT INTO emp(empno, ename)
SELECT empno, ename
FROM emp;

multiple insert 구분
 1. unconditional insert : 여러테이블에 insert
 2. conditional all insert : 조건을 만족하는 모든 테이블에 insert
 3. conditional first insert : 조건을 만족하는 첫번째 테이블에 insert


1. unconditional insert : 조건에 관계없이 여러 테이블에 insert
DROP TABLE emp_test;
DROP TABLE emp_test2;

CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp
WHERE 1=2;

CREATE TABLE emp_test2 AS
SELECT empno, ename
FROM emp
WHERE 1=2;

INSERT ALL INTO emp_test
           INTO emp_test2
SELECT 9999, 'brown' FROM dual UNION ALL
SELECT 9998, 'sally' FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

uncondition insert 실행시 테이블 마다 데이터를 입력할 컬럼을 조작하는 것이 가능
위에서 : INSERT INTO emp_test VALUES(....) 테이블의 모든 컬럼에 대해 입력
        INSERT INTO emp_test (empno) VALUES(9999) 특정 컬럼을 지정하여 입력 가능
        
INSERT ALL 
    INTO emp_test (empno) VALUES(eno)
    INTO emp_test2 (empno, ename) VALUES(eno, enm)
SELECT 9999 eno, 'brown' enm FROM dual UNION ALL
SELECT 9998, 'sally' FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;

conditional insert : 조건에 따라 데이터를 입력

ROLLBACK;

INSERT ALL
    WHEN eno >= 9500 THEN
       INTO emp_test VALUES (eno, enm)
       INTO emp_test2 VALUES (eno, enm)
    WHEN eno >= 9900 THEN
       INTO emp_test2 VALUES (eno, enm)
SELECT 9500 eno, 'brown' enm FROM dual UNION ALL
SELECT 9998, 'sally' FROM dual;



SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;















