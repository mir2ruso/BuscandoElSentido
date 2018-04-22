-- Generado en Oracle SQL Developer Data Modeler 4.1.1.888
--   autor 			 Miguel Olmo Hernando
--   fecha:        2018-04-19 13:30:57 CEST
--   sitio:      Oracle Database 12c - Puesto A222P12
--   tipo:      Oracle Database 12c
--   version: OPCION 1


--   notas:     faltan que las claves primarias sean autoincrementales y reordenar codigo a mi gusto
--				porque este es el autogenerado, aun asi no ha generado ningun tipo de error al crear





CREATE TABLE ADMINISTRADOR
  (
    COD_ADMIN       VARCHAR2 (10) NOT NULL ,
    NOMBRE          VARCHAR2 (20) NOT NULL ,
    APELLIDO        VARCHAR2 (20) NOT NULL ,
    LOGIN_COD_LOGIN NUMBER (10) NOT NULL ,
    COD_ADMIN1      VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE ADMINISTRADOR ADD CONSTRAINT ADMINISTRADOR_PK PRIMARY KEY ( COD_ADMIN ) ;


CREATE TABLE DUENO
  (
    COD_DUENO         NUMBER (10) NOT NULL ,
    NOMBRE            VARCHAR2 (20) NOT NULL ,
    APELLIDOS         VARCHAR2 (20) NOT NULL ,
    "USER"            VARCHAR2 (8) NOT NULL ,
    PASS              VARCHAR2 (8) NOT NULL ,
    EQUIPO_COD_EQUIPO NUMBER (8) NOT NULL ,
    LOGIN_COD_LOGIN   NUMBER (10) NOT NULL ,
    COD_ADMIN         VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE DUENO ADD CONSTRAINT DUENO_PK PRIMARY KEY ( COD_DUENO ) ;


CREATE TABLE EQUIPO
  (
    COD_EQUIPO           NUMBER (8) NOT NULL ,
    NOMBRE               VARCHAR2 (20) NOT NULL ,
    PRESUPUESTO          NUMBER (6) NOT NULL ,
    ANO_FUNDACION        DATE NOT NULL ,
    CIUDAD               VARCHAR2 (20) NOT NULL ,
    ESTADIO              VARCHAR2 (20) NOT NULL ,
    DUENO_COD_DUENO      NUMBER (10) NOT NULL ,
    PARTIDO_COD_PARTIDO  NUMBER (10) NOT NULL ,
    PARTIDO_COD_PARTIDO1 NUMBER (10) NOT NULL
  ) ;
ALTER TABLE EQUIPO ADD CONSTRAINT EQUIPO_PK PRIMARY KEY ( COD_EQUIPO ) ;


CREATE TABLE JORNADA
  (
    COD_JORNADA      NUMBER (14) NOT NULL ,
    FECHA_INICIO     DATE NOT NULL ,
    FECHA_FIN        DATE NOT NULL ,
    EQUIPO_LOCAL     VARCHAR2 (20) NOT NULL ,
    EQUIPO_VISITANTE VARCHAR2 (20) NOT NULL ,
    NUMERO_TEMPORADA NUMBER (2) NOT NULL
  ) ;
ALTER TABLE JORNADA ADD CONSTRAINT JORNADA_PK PRIMARY KEY ( COD_JORNADA ) ;


CREATE TABLE JUGADOR
  (
    COD_JUGADOR       NUMBER (48) NOT NULL ,
    NOMBRE            VARCHAR2 (20) NOT NULL ,
    APELLIDO          VARCHAR2 (20) NOT NULL ,
    NICKNAME          VARCHAR2 (10) NOT NULL ,
    SUELDO            NUMBER NOT NULL ,
    FECHA_NACIMIENTO  DATE ,
    NACIONALIDAD      VARCHAR2 (20) ,
    POSICION          VARCHAR2 (10) ,
    EQUIPO_COD_EQUIPO NUMBER (8) NOT NULL
  ) ;
ALTER TABLE JUGADOR ADD CONSTRAINT JUGADOR_PK PRIMARY KEY ( COD_JUGADOR ) ;


CREATE TABLE LOGIN
  (
    COD_LOGIN               NUMBER (10) NOT NULL ,
    "USER"                  VARCHAR2 (8) NOT NULL ,
    PASS                    VARCHAR2 (8) NOT NULL ,
    ADMINISTRADOR_COD_ADMIN VARCHAR2 (10) NOT NULL ,
    DUENO_COD_DUENO         NUMBER (10) NOT NULL ,
    USUARIO_USUARIO_ID      NUMBER NOT NULL
  ) ;
ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_PK PRIMARY KEY ( COD_LOGIN ) ;


CREATE TABLE PARTIDO
  (
    COD_PARTIDO         NUMBER (10) NOT NULL ,
    FECHA               DATE NOT NULL ,
    HORA                DATE NOT NULL ,
    PUNTOS_LOCAL        VARCHAR2 (3) NOT NULL ,
    PUNTOS_VISITANTE    VARCHAR2 (3) NOT NULL ,
    EQUIPO_COD_EQUIPO   NUMBER (8) NOT NULL ,
    EQUIPO_COD_EQUIPO1  NUMBER (8) NOT NULL ,
    JORNADA_COD_JORNADA NUMBER (14) NOT NULL
  ) ;
ALTER TABLE PARTIDO ADD CONSTRAINT PARTIDO_PK PRIMARY KEY ( JORNADA_COD_JORNADA, COD_PARTIDO ) ;


CREATE TABLE USUARIO
  (
    COD_USUARIO      NUMBER (10) NOT NULL ,
    NOMBRE           VARCHAR2 (20) NOT NULL ,
    APELLIDO         VARCHAR2 (20) NOT NULL ,
    FECHA_NACIMIENTO DATE NOT NULL ,
    LOGIN_COD_LOGIN  NUMBER (10) NOT NULL ,
    COD_ADMIN        VARCHAR2 (10) NOT NULL
  ) ;
ALTER TABLE USUARIO ADD CONSTRAINT USUARIO_PK PRIMARY KEY ( COD_USUARIO ) ;


ALTER TABLE ADMINISTRADOR ADD CONSTRAINT ADMINISTRADOR_LOGIN_FK FOREIGN KEY ( LOGIN_COD_LOGIN ) REFERENCES LOGIN ( COD_LOGIN ) ;

ALTER TABLE DUENO ADD CONSTRAINT DUENO_EQUIPO_FK FOREIGN KEY ( EQUIPO_COD_EQUIPO ) REFERENCES EQUIPO ( COD_EQUIPO ) ;

ALTER TABLE DUENO ADD CONSTRAINT DUENO_LOGIN_FK FOREIGN KEY ( LOGIN_COD_LOGIN ) REFERENCES LOGIN ( COD_LOGIN ) ;

ALTER TABLE EQUIPO ADD CONSTRAINT EQUIPO_DUENO_FK FOREIGN KEY ( DUENO_COD_DUENO ) REFERENCES DUENO ( COD_DUENO ) ;

ALTER TABLE EQUIPO ADD CONSTRAINT EQUIPO_PARTIDO_FK FOREIGN KEY ( PARTIDO_COD_PARTIDO ) REFERENCES PARTIDO ( JORNADA_COD_JORNADA, COD_PARTIDO ) ;

ALTER TABLE EQUIPO ADD CONSTRAINT EQUIPO_PARTIDO_FKv1 FOREIGN KEY ( PARTIDO_COD_PARTIDO1 ) REFERENCES PARTIDO ( JORNADA_COD_JORNADA, COD_PARTIDO ) ;

ALTER TABLE JUGADOR ADD CONSTRAINT JUGADOR_EQUIPO_FK FOREIGN KEY ( EQUIPO_COD_EQUIPO ) REFERENCES EQUIPO ( COD_EQUIPO ) ;

ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_ADMINISTRADOR_FK FOREIGN KEY ( ADMINISTRADOR_COD_ADMIN ) REFERENCES ADMINISTRADOR ( COD_ADMIN ) ;

ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_DUENO_FK FOREIGN KEY ( DUENO_COD_DUENO ) REFERENCES DUENO ( COD_DUENO ) ;

ALTER TABLE LOGIN ADD CONSTRAINT LOGIN_USUARIO_FK FOREIGN KEY ( USUARIO_USUARIO_ID ) REFERENCES USUARIO ( COD_USUARIO ) ;

ALTER TABLE PARTIDO ADD CONSTRAINT PARTIDO_EQUIPO_FK FOREIGN KEY ( EQUIPO_COD_EQUIPO ) REFERENCES EQUIPO ( COD_EQUIPO ) ;

ALTER TABLE PARTIDO ADD CONSTRAINT PARTIDO_EQUIPO_FKv1 FOREIGN KEY ( EQUIPO_COD_EQUIPO1 ) REFERENCES EQUIPO ( COD_EQUIPO ) ;

ALTER TABLE PARTIDO ADD CONSTRAINT PARTIDO_JORNADA_FK FOREIGN KEY ( JORNADA_COD_JORNADA ) REFERENCES JORNADA ( COD_JORNADA ) ;

ALTER TABLE USUARIO ADD CONSTRAINT USUARIO_LOGIN_FK FOREIGN KEY ( LOGIN_COD_LOGIN ) REFERENCES LOGIN ( COD_LOGIN ) ;

CREATE SEQUENCE USUARIO_COD_USUARIO_SEQ START WITH 1 NOCACHE ORDER ;
CREATE OR REPLACE TRIGGER USUARIO_COD_USUARIO_TRG BEFORE
  INSERT ON USUARIO FOR EACH ROW WHEN (NEW.COD_USUARIO IS NULL) BEGIN :NEW.COD_USUARIO := USUARIO_COD_USUARIO_SEQ.NEXTVAL;
END;
/


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
