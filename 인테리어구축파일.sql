DROP TABLE 결제;

CREATE TABLE 결제
(
    결제금액    INTEGER NOT NULL,
    결제일자    VARCHAR2(20) NOT NULL,
    결제방법    VARCHAR2(20) NOT NULL,
    쿠폰여부    SMALLINT,
    주문번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 결제.결제금액 IS '결제금액';

COMMENT ON COLUMN 결제.결제일자 IS '결제일자';

COMMENT ON COLUMN 결제.결제방법 IS '결제방법';

COMMENT ON COLUMN 결제.쿠폰여부 IS '쿠폰여부';

COMMENT ON COLUMN 결제.주문번호 IS '주문번호';

COMMENT ON TABLE 결제 IS '결제';

CREATE UNIQUE INDEX 엔터티1_PK115 ON 결제
( 주문번호 );

ALTER TABLE 결제
 ADD CONSTRAINT 결제_PK1 PRIMARY KEY ( 주문번호 )
 USING INDEX 엔터티1_PK115;


DROP TABLE 고객;

CREATE TABLE 고객
(
    고객번호    VARCHAR2(20) NOT NULL,
    휴대폰번호    VARCHAR2(20) NOT NULL,
    주소    VARCHAR2(50),
    고객유형    VARCHAR2(20) NOT NULL,
    고객명    VARCHAR2(20) NOT NULL,
    고객등급    VARCHAR2(20),
    개인,
    사업자
);

COMMENT ON COLUMN 고객.고객번호 IS '고객번호';

COMMENT ON COLUMN 고객.휴대폰번호 IS '휴대폰번호';

COMMENT ON COLUMN 고객.주소 IS '주소';

COMMENT ON COLUMN 고객.고객유형 IS '고객유형';

COMMENT ON COLUMN 고객.고객명 IS '고객명';

COMMENT ON COLUMN 고객.고객등급 IS '고객등급';

COMMENT ON COLUMN 고객.개인 IS '개인';

COMMENT ON COLUMN 고객.사업자 IS '사업자';

COMMENT ON TABLE 고객 IS '고객';

CREATE UNIQUE INDEX 엔터티1_PK13 ON 고객
( 고객번호 );

ALTER TABLE 고객
 ADD CONSTRAINT 고객_PK1 PRIMARY KEY ( 고객번호 )
 USING INDEX 엔터티1_PK13;


DROP TABLE 배송/택배;

CREATE TABLE 배송/택배
(
    무료주소    VARCHAR2(20),
    유료주소    VARCHAR2(20),
    착불    SMALLINT,
    배송번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 배송/택배.무료주소 IS '무료주소';

COMMENT ON COLUMN 배송/택배.유료주소 IS '유료주소';

COMMENT ON COLUMN 배송/택배.착불 IS '착불';

COMMENT ON COLUMN 배송/택배.배송번호 IS '배송번호';

COMMENT ON TABLE 배송/택배 IS '배송/택배';

CREATE UNIQUE INDEX 엔터티1_PK18 ON 배송/택배
( 배송번호 );

ALTER TABLE 배송/택배
 ADD CONSTRAINT 배송/택배_PK1 PRIMARY KEY ( 배송번호 )
 USING INDEX 엔터티1_PK18;


DROP TABLE 시공;

CREATE TABLE 시공
(
    시공번호    VARCHAR2(20) NOT NULL,
    인건비    NVARCHAR2(50) NOT NULL,
    직원번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 시공.시공번호 IS '시공번호';

COMMENT ON COLUMN 시공.인건비 IS '인건비';

COMMENT ON COLUMN 시공.직원번호 IS '직원번호';

COMMENT ON TABLE 시공 IS '시공';

CREATE UNIQUE INDEX 엔터티1_PK114 ON 시공
( 시공번호 );

ALTER TABLE 시공
 ADD CONSTRAINT 시공_PK1 PRIMARY KEY ( 시공번호 )
 USING INDEX 엔터티1_PK114;


DROP TABLE 장바구니;

CREATE TABLE 장바구니
(
    제품번호    VARCHAR2(20) NOT NULL,
    고객번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 장바구니.제품번호 IS '제품번호';

COMMENT ON COLUMN 장바구니.고객번호 IS '고객번호';

COMMENT ON TABLE 장바구니 IS '장바구니';

CREATE UNIQUE INDEX 엔터티1_PK112 ON 장바구니
( 고객번호,제품번호 );

ALTER TABLE 장바구니
 ADD CONSTRAINT 장바구니_PK1 PRIMARY KEY ( 고객번호,제품번호 )
 USING INDEX 엔터티1_PK112;


DROP TABLE 제품;

CREATE TABLE 제품
(
    제품번호    VARCHAR2(20) NOT NULL,
    제품명    VARCHAR2(20),
    제품가격    INTEGER
);

COMMENT ON COLUMN 제품.제품번호 IS '제품번호';

COMMENT ON COLUMN 제품.제품명 IS '제품명';

COMMENT ON COLUMN 제품.제품가격 IS '제품가격';

COMMENT ON TABLE 제품 IS '제품';

CREATE UNIQUE INDEX 엔터티1_PK110 ON 제품
( 제품번호 );

ALTER TABLE 제품
 ADD CONSTRAINT 제품_PK1 PRIMARY KEY ( 제품번호 )
 USING INDEX 엔터티1_PK110;


DROP TABLE 제품종류;

CREATE TABLE 제품종류
(
    제품종류    VARCHAR2(20) NOT NULL,
    직원번호    VARCHAR2(20) NOT NULL,
    제품번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 제품종류.제품종류 IS '제품종류';

COMMENT ON COLUMN 제품종류.직원번호 IS '직원번호';

COMMENT ON COLUMN 제품종류.제품번호 IS '제품번호';

COMMENT ON TABLE 제품종류 IS '제품종류';

CREATE UNIQUE INDEX 엔터티1_PK1 ON 제품종류
( 제품번호 );

ALTER TABLE 제품종류
 ADD CONSTRAINT 엔터티1_PK1 PRIMARY KEY ( 제품번호 )
 USING INDEX 엔터티1_PK1;


DROP TABLE 주문;

CREATE TABLE 주문
(
    주문번호    VARCHAR2(20) NOT NULL,
    주문날짜    VARCHAR2(20) NOT NULL,
    고객번호    VARCHAR2(20) NOT NULL,
    제품수량    INTEGER NOT NULL,
    배송번호    VARCHAR2(20),
    시공번호    VARCHAR2(20),
    제품번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 주문.주문번호 IS '주문번호';

COMMENT ON COLUMN 주문.주문날짜 IS '주문날짜';

COMMENT ON COLUMN 주문.고객번호 IS '고객번호';

COMMENT ON COLUMN 주문.제품수량 IS '제품수량';

COMMENT ON COLUMN 주문.배송번호 IS '배송번호';

COMMENT ON COLUMN 주문.시공번호 IS '시공번호';

COMMENT ON COLUMN 주문.제품번호 IS '제품번호';

COMMENT ON TABLE 주문 IS '주문';

CREATE UNIQUE INDEX 엔터티1_PK111 ON 주문
( 주문번호 );

ALTER TABLE 주문
 ADD CONSTRAINT 주문_PK1 PRIMARY KEY ( 주문번호 )
 USING INDEX 엔터티1_PK111;


DROP TABLE 직원;

CREATE TABLE 직원
(
    직원번호    VARCHAR2(20) NOT NULL,
    이름    VARCHAR2(20) NOT NULL,
    주민번호    VARCHAR2(20) NOT NULL,
    주소    VARCHAR2(50) NOT NULL,
    나이    INTEGER NOT NULL,
    핸드폰번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 직원.직원번호 IS '직원번호';

COMMENT ON COLUMN 직원.이름 IS '이름';

COMMENT ON COLUMN 직원.주민번호 IS '주민번호';

COMMENT ON COLUMN 직원.주소 IS '주소';

COMMENT ON COLUMN 직원.나이 IS '나이';

COMMENT ON COLUMN 직원.핸드폰번호 IS '핸드폰번호';

COMMENT ON TABLE 직원 IS '직원';

CREATE UNIQUE INDEX 엔터티1_PK ON 직원
( 직원번호 );

ALTER TABLE 직원
 ADD CONSTRAINT 엔터티1_PK PRIMARY KEY ( 직원번호 )
 USING INDEX 엔터티1_PK;


DROP TABLE 카운터;

CREATE TABLE 카운터
(
    일일매출액    INTEGER,
    주문건수    INTEGER,
    날짜    VARCHAR2(20),
    직원번호    VARCHAR2(20) NOT NULL
);

COMMENT ON COLUMN 카운터.일일매출액 IS '일일매출액';

COMMENT ON COLUMN 카운터.주문건수 IS '주문건수';

COMMENT ON COLUMN 카운터.날짜 IS '날짜';

COMMENT ON COLUMN 카운터.직원번호 IS '직원번호';

COMMENT ON TABLE 카운터 IS '카운터';