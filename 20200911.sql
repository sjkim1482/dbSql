Java
Alt + Shift 엔터 : 리팩터 => 함수를 바꿀 때 해당되는 함수도 다 바꿔줌

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod , lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT *
FROM prod;

SELECT *
FROM lprod;

SELECT *
FROM buyer;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod , buyer
WHERE prod.prod_buyer=buyer.buyer_id;



join3]
join 시 생각할 부분
1. 테이블 기술
2. 연결조건
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member m JOIN cart c ON(m.mem_id = c.cart_member)
JOIN prod p ON(c.cart_prod = p.prod_id);

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member m , cart c, prod p 
WHERE m.mem_id = c.cart_member and c.cart_prod = p.prod_id;

SELECT *
FROM member; 

SELECT *
FROM cart; 


SELECT NVL(mgr , empno)
FROM emp;

SELECT *
FROM (SELECT ROWNUM rn, a.*
      FROM (SELECT empno, ename
            FROM emp
            ORDER BY hiredate,ename)a)
WHERE rn BETWEEN (:page-1)*:pageSize+1 AND :page * :pageSize;


SELECT *
FROM emp
ORDER BY mgr;

SELECT 


