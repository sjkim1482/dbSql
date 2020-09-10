
fn4]
SELECT empno, ename, mgr, nvl(mgr, 9999), nvl2(mgr, mgr, 9999), coalesce(mgr, 9999)
FROM emp;

fn5]
SELECT userid, usernm, reg_dt, nvl(reg_dt,SYSDATE)
FROM users
WHERE userid NOT IN ('brown');


SELECT empno, ename,
        CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
        END dname,
        DECODE(deptno, 10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT') dname2
FROM emp;


SELECT empno, ename,hiredate,
        CASE
        WHEN MOD(TO_CHAR(hiredate, 'YYYY'),2)=MOD(TO_CHAR(SYSDATE, 'YYYY'),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM emp;


SELECT userid, usernm ,reg_dt,
        CASE
        WHEN MOD(TO_CHAR(reg_dt, 'YYYY'),2)=MOD(TO_CHAR(SYSDATE, 'YYYY'),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
        END contact_to_doctor
FROM users;



