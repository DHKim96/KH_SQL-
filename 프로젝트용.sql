CREATE TABLE TB_STARBUCS_BVG (
    BNO NUMBER PRIMARY KEY,
    BTYPE VARCHAR2(50) DEFAULT '에스프레소' NOT NULL,
    BNAME VARCHAR2(50) NOT NULL UNIQUE,
    BPRICE NUMBER NOT NULL,
    BENROLLDATE DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE TB_STARBUCS_FOOD (
    FNO NUMBER PRIMARY KEY,
    FTYPE VARCHAR2(50) DEFAULT '에스프레소' NOT NULL,
    FNAME VARCHAR2(50) NOT NULL UNIQUE,
    FPRICE NUMBER NOT NULL,
    FENROLLDATE DATE DEFAULT SYSDATE NOT NULL
);

CREATE SEQUENCE SEQ_BNO 
START WITH 1
NOCACHE;

CREATE SEQUENCE SEQ_FNO 
START WITH 1
NOCACHE;


