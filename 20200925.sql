REPORT GROUP FUNCTION
GROUP BY 의 확장 : SUBGROUP을 자동으로 생성하여 하나의 결과로 합쳐준다.
1. ROLLUP(col1,col2....)
    . 기술된 컬럼을 오른쪽에서 부터 지워 나가며 서브 그룹을 생성

2. GROUPING SET((col1,col2),col3)
    . , 단위로 기술된 서브 그룹을 생성
    
3. CUBE(col1, col2....)
    . 컬럼의 순서는 지키되, 가능한 모든 조합을 생성한다.
    
GROUP BY CUBE(job, deptno) ==> 4개
     job    deptno
      0       0     ==> GROUP BY job, deptno
      0       X     ==> GROUP BY job
      X       0     ==> GROUP BY deptno (ROLLUP에는 없던 서브 그룹)
      X       X     ==> GROUP BY 전체

GROUP BY ROLLUP(job, deptno) ==> 3개

SELECT job, deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY CUBE(job, deptno);

CUBE의 경우 가능한 모든 조합으로 서브그룹을 생성하기 때문에
2의 기술한 컬럼개수 승 만큼의 서브 그룹이 생성된다.
CUBE(col1, col2) : 4
CUBE(col1, col2, col3) : 8
CUBE(col1, col2, col3, col4) : 16

REPORT GROUP FUNCTION 조합
GROUP BY job, ROLLUP(deptno), CUBE(mgr)
              deptno            mgr
               전체              전체
               
         job   deptno, mgr
         job   deptno
         job   mgr
         job   전체

SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);


상호 연관 서브 쿼리를 이용한 업데이트
1. EMP_TEST 테이블 삭제
2. EMP테이블을 사용하여 EMP_TEST 테이블 생성(모든 컬럼, 모든 데이터)
3. EMP_TEST테이블에는 DNAME 컬럼을 추가(VARCHAR2(14))
4. 상호 연관 서브쿼리를 이용하여 EMP_TEST테이블의 DNAME 컬럼을 DEPT을 이용하여 UPDATE

DROP TABlE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

ALTER TABLE emp_test ADD(dname VARCHAR2(14));

SELECT *
FROM emp_test;
UPDATE emp_test e SET dname = (SELECT dname FROM dept WHERE deptno = e.deptno)

COMMIT;


DROP TABLE dept_test;
CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD(empcnt NUMBER(14));

UPDATE dept_test d SET empcnt= (SELECT COUNT(deptno) FROM emp WHERE deptno = d.deptno)

SELECT *
FROM dept_test;

DELETE dept_test
WHERE deptno = 99;

COMMIT;

sub_a2]
INSERT INTO dept_test (deptno, dname, loc) VALUES (99,'it1','daejeon');
INSERT INTO dept_test (deptno, dname, loc) VALUES (98,'it2','daejeon');
COMMiT;

SELECT *
FROM dept_test;

부서에 속한 직원이 없는 부서를 삭제하는 쿼리를 작성하세요
DELETE dept_test d
WHERE deptno  NOT IN (SELECT deptno FROM emp WHERE deptno = d.deptno); 

SELECT *
FROM dept_test;






















