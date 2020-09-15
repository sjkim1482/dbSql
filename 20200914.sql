customer : 고객
cid : customer id
cnm : customer name
SELECT *
FROM customer;

product : 제품
pid : produt id : 제품번호
pnm : product name : 제품 이름
SELECT *
FROM product;

cycle : 고객애음주기
cid : customer id 고객 id
pid : product id 제품 id
day : 1-7(일-토)
cnt : count, 수량
SELECT *
FROM cycle;


SELECT customer.* , pid, day, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
WHERE cnm IN('brown','sally');


SELECT cid, cnm , pid, day, cnt
FROM customer NATURAL JOIN cycle 
WHERE customer.cnm IN('brown','sally');


SELECT customer.* , pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid AND cnm IN('brown','sally');


join 5]

SQL : 실행에 대한 순서가 없다.
      조인할 테이블에 대해서 FROM 절에 기술한 순으로
      테이블을 읽지 않는다.
      FROM customer, cycle, product ==> 오라클에서는 product 테이블부터 읽을 수 도 있다.
oracle
EXPLAIN PLAN FOR
SELECT customer.cid, cnm , product.pid,pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND product.pid = cycle.pid
 AND cnm IN('brown','sally');

SELECT *
FROM TABLE(dbms_xplan.display);
 
 SELECT customer.cid, cnm , product.pid,pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid AND product.pid = cycle.pid
 AND cnm IN('brown','sally');
 
ansi
SELECT customer.cid, cnm , product.pid,pnm, day, cnt
FROM customer JOIN  cycle ON(customer.cid = cycle.cid) 
     JOIN product ON(product.pid = cycle.pid)
WHERE cnm IN('brown','sally');


JOIN구분
1. 문법에 따른 구분 : ANSI-SQL, ORACLE
2. join의 형태에 따른 구분 : SELF-JOIN, NONEQUI-JOIN, CROSS-JOIN
3. join 성공여부에 따라 데이터 표시여부 
        : INNER JOIN - 조인이 성공했을 때 데이터를 표시
        : OUTER JOIN - 조인이 실패해도 기준으로 정한 테이블의 컬럼 정보는 표시
    

사번, 사원의이름, 관리자 사번, 관리자 이름

SELECT e.empno, e.ename, m.empno mgrno, m.ename mgrname
FROM emp e JOIN emp m ON(e.mgr = m.empno);

KING(PRESIDENT)의 경우 MGR 컬럼의 값이 NULL 이기 때문에
조인에 실패. ==> 13건 조회
SELECT e.empno, e.ename, m.empno mgrno, m.ename mgrname
FROM emp e , emp m 
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT e.empno, e.ename, m.empno mgrno, m.ename mgrname
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.empno, e.ename, m.empno mgrno, m.ename mgrname
FROM emp m RIGHT OUTER JOIN emp e ON(m.empno = e.mgr);

ORACLE-SQL : 데이터가 없는 쪽의 컬럼에 (+) 기호를 붙인자
             ANSI-SQL 기준 테이블 반대편 테이블의 컬럼에 (+)을 붙인다
             WHERE절 연결 조건에 적용
SELECT e.empno, e.ename, e.mgr, m.ename mgrname
FROM emp e ,emp m 
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, m.empno mgrno, m.ename mgrname
FROM emp m RIGHT OUTER JOIN emp e ON(m.empno = e.mgr);


행에 대한 제한 조건 기술시 WHERE절에 기술 했을 때와 ON 절에 기술 했을 때
결과가 다르다.

사원의 부서가 10번인 사람들만 조회 되도록 부서 번호 조건을 추가
SELECT e.empno, e.ename, e.empno mgrno, m.ename mgrname
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno =10);

조건을 WHERE 절에 기술한 경우 ==> OUTER JOIN이 아닌 INNER 조인 결과가 나온다
SELECT e.empno, e.ename, e.deptno, e.mgr, m.ename mgrname, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE e.deptno =10;

SELECT e.empno, e.ename, e.deptno, e.mgr, m.ename mgrname, m.deptno
FROM emp e JOIN emp m ON(e.mgr = m.empno)
WHERE e.deptno =10;


UNION(합집합) : 중복제거
SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
UNION
SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno)
MINUS
SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr = m.empno);


SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
UNION
SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno)
INTERSECT
SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT *
FROM buyprod
WHERE BUY_DATE = TO_DATE('2005/01/25', 'YYYY-MM-DD');

SELECT *
FROM prod;

SELECT buy_date,buy_prod, prod_id,prod_name, buy_qty
FROM prod p LEFT OUTER JOIN buyprod b ON(p.prod_id = b.buy_prod AND BUY_DATE = TO_DATE('2005/01/25', 'YYYY-MM-DD'));

SELECT buy_date,buy_prod, prod_id,prod_name, buy_qty
FROM prod p , buyprod b 
WHERE p.prod_id = b.buy_prod(+) AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY-MM-DD');







