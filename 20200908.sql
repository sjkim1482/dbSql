날짜 데이터 : emp.hiredate
            SYSDATE
            
TO_CHAR(날짜타입, '변경할 문자열 포맷')
TO_DATE('날짜문자열', '첫번째 인자의 날짜 포맷')
TO_CHAR, TO_DATE 첫번째 인자 값을 넣을 때 문자열인지, 날짜인지 구분
현재 설정된 NLS DATE FORMAT : YYYY/MM/DD HH24:MI:SS 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD-MM-YYYY'),
       TO_CHAR(SYSDATE, 'D'), TO_CHAR(SYSDATE, 'IW')
FROM dual;


'20200908' ==> '2020/09/08'
SELECT
ename, hiredate, TO_CHAR(hiredate, 'yyyy/mm/dd hh24:mi:ss') h1,
TO_CHAR(hiredate +1, 'yyyy/mm/dd hh24:mi:ss') h2,
TO_CHAR(hiredate +1/24, 'yyyy/mm/dd hh24:mi:ss') h3,
TO_CHAR(TO_DATE('20200908','YYYYMMDD'), 'YYYY/MM/DD') h4, TO_DATE('20200908','YYYY/MM/DD')
FROM emp;

날짜 : 일자 + 시분초
2020년 9월 8일 14시 10분 5초 ==>'20200908' ==> 2020년 9월 8일 0시 0분 0초
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD')


SELECT TO_CHAR(SYSDATE , 'yyyy-mm-dd') DT_DASH, TO_CHAR(SYSDATE , 'yyyy-mm-dd hh24-mi-ss') DT_DASH_WHIT_TIME,
TO_CHAR(SYSDATE , 'dd-mm-yyyy') DT_DD_MM_YYYY
FROM dual;


날짜 조작 함수
..MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월수를 반환
                               두 날짜의 일정보가 틀리면 소수점이 나오기 때문에 잘 사용하지는 않는다.
***ADD_MONTHS(DATE, NUMBER) : 주어진 날짜에 개월수를 더하거나 뺀 날짜를 반환
                           한달이라는 기간이 월마다 다름 - 직접 구현이 힘듬
**NEXT_DAY(DATE, NUMBER(주간요일 : 1-7)) : DATE이후에 등장하는 첫번째 주간요일을 갖는 날짜
NEXT_DAY(DATE, 6) : SYSDATE이 후에 등장하는 첫번째 금요일에 해당하는 날짜
*****LAST_DAY(DATE) : 주어진 날짜가 속한 월의 마지막 일자를 날짜로 반환
LAST_DAY(SYSDATE) : SYSDATE(2020/09/08)가 속한 9월의 마지막 날짜 : 2020/09/30
                    월마다 마지막 일자가 다르기 때문에 해당 함수를 통해서 편하게 마지막 일자를 구할 수 있다.
해당월의 가장 첫 날짜를 반환하는 함수는 없다 ==> 모든 월의 첫 날짜는 1일이다
SELECT MONTHS_BETWEEN(TO_DATE('20200915','YYYYMMDD'), TO_DATE('20200808','YYYYMMDD')),
       ADD_MONTHS(SYSDATE, 5),
       NEXT_DAY(SYSDATE, 6),
       LAST_DAY(SYSDATE)
       SYSDATE 가 속한 월의 첫날 짜 구하기
       (2020년 9월 8일 ==> 2020년 9월 1일의 날짜 타입으로 어떻게든 구하기)
SELECT SYSDATE, TO_DATE(TO_CHAR(SYSDATE, 'YYYY/MM'), 'YYYY/MM') AS FIRST_DAY 
, CONCAT(TO_CHAR(SYSDATE, 'YYYY/MM'),'/01'),
 ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1 ),
 SYSDATE - TO_CHAR(SYSDATE,'DD') +1
FROM dual;

EXPLAIN PLAN FOR
SELECT :yyyymm AS PARAM, 
        LAST_DAY(TO_DATE(:yyyymm, 'yyyymm'))-LAST_DAY(TO_DATE(:yyyymm, 'yyyymm')-1) AS dt,
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'yyyymm')), 'DD') dt2
FROM dual;


TO_DATE(문자
TO_CHAR(날짜

형변환
명시적 형변환
    TO_CHAR, TO_DATE, TO_NUMBER
묵시적 형변환
    ....ORACLE DBMS가 상황에 맞게 알아서 해주는것
    
두가지 가능한 경우
1. empno(숫자)를 문자로 묵시적 형변환
2. '7369'(문자)를 숫자로 묵시적 형변환


알면 매우 좋음, 몰라도 수업 진행하는데 문제 없고, 추후 취업해서도 큰 지장은 없음
다만 고급 개발자 와 일반 개발자를 구분하는 차이점이 됨.

==> 하드웨어가 엄청 좋아짐

실행계획 : 오라클에서 요청받은 SQL을 처리하기 위한 절차를 수립한 것
실행계획 보는 방법
1. EXPLAIN PLAN FOR
   실행계획을 분석할 SQL;
2. SELECT *
   FROM TABLE(dbms_xplan.display);
   
실행계획의 operation을 해석하는 방법
1. 위에서 아래로
2. 단 자식노드(들여쓰기가 된 노드)있을 경우 자식부터 실행하고 본인 노드를 실행

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

TABLE 함수 : PL/SQL의 테이블 타입 자료형을 테이블로 변환
SELECT *
FROM TABLE(dbms_xplan.display);

java의 class full name : 패키지명.클래스명
java : String class : java.lang.String

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(dbms_xplan.display);




7거지악
7. 결과에만 만족하지말고 실행계획에 관심을 가지고 절차형 로직을 버리고 집합적으로 완수토록 하라.

1600 ==> 1,600
숫자를 문자로 포맷팅 : DB보다는 국제화(i18n) 에서 더 많이 활용
                        I nternationalizatio(18글자) n
SELECT empno, ename, sal, TO_CHAR(sal, '00009,999L')
FROM emp;

함수
    문자열
    날짜
    숫자
    null과 관련된 함수 : 4가지 (다 못외워도 괜찮음, 한가지를 주로 사용)
    오라클의 NVL 함수와 동일한 역할을 하는 MS-SQL SERVER의 함수이름은?
    
NULL의 의미 ? 아직 모르는 값, 할당되지 않은 값
              0과, '' 문자와는 다르다
NULL의 특징 : NULL을 포함한 연산의 결과는 항상 NULL

sal 컬럼에는 null이 없지만, comm에는 4개의 행을 제외하고 10개의 행이 null값을 갖는다.
SELECT ename, sal, comm, sal+comm
FROM emp;


NULL과 관련된 함수
1. NVL(컬럼 || 익스프레션, 컬럼 || 익스프레션)
   NVL(expr1, expr2)
   if(exp1 == null)
        System.out.println(expr2);
   else
        System.out.println(expr1);
        
     
SELECT empno, sal, comm, NVL(comm, 0)+sal
FROM emp;

SELECT *
FROM TABLE(dbms_xplan.display);



