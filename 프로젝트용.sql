DROP TABLE PLAYERS CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_PLAYERS;
CREATE TABLE PLAYERS(
    PLAYER_ID NUMBER PRIMARY KEY,
    PLAYER_NAME VARCHAR2(100) NOT NULL UNIQUE,
    PJOB VARCHAR2(50),
    PLEVEL NUMBER,
    MAX_EXPERIENCE NUMBER,
    EXPERIENCE NUMBER,
    MAX_HP NUMBER,
    HP NUMBER,
    MAX_MP NUMBER,
    MP NUMBER,
    STRENGTH NUMBER,
    INTELLIGENCE NUMBER,
    AGILITY NUMBER,
    MONEY NUMBER
);

CREATE SEQUENCE SEQ_PLAYERS
START WITH 1;

DROP TABLE MAPS CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_MAPS;
CREATE TABLE MAPS (
    MAP_ID NUMBER PRIMARY KEY,
    MAP_NAME VARCHAR2(100) NOT NULL UNIQUE,
    MAP_TYPE VARCHAR2(50),
    REQUIRED_LEVEL NUMBER
);
CREATE SEQUENCE SEQ_MAPS
START WITH 1;

DROP TABLE ENEMIES CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_ENEMIES;
CREATE TABLE ENEMIES (
    ENEMY_ID NUMBER PRIMARY KEY,
    ENEMY_NAME VARCHAR2(100) NOT NULL UNIQUE,
    HEALTH NUMBER,
    STRENGTH NUMBER,
    AGILITY NUMBER,
    EXPERIENCE NUMBER,
    MONEY NUMBER
);

CREATE SEQUENCE SEQ_ENEMIES
START WITH 1;

DROP TABLE MAPS_ENEMIES CASCADE CONSTRAINT;
CREATE TABLE MAPS_ENEMIES (
    MAP_ID NUMBER,
    ENEMY_ID NUMBER,
    PRIMARY KEY (MAP_ID, ENEMY_ID),
    FOREIGN KEY (MAP_ID) REFERENCES MAPS(MAP_ID),
    FOREIGN KEY (ENEMY_ID) REFERENCES ENEMIES(ENEMY_ID)
);

