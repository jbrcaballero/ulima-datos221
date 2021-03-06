-- PREGUNTA 4)
-- CREACION DE ESQUEMA DE BD E INSERCION DE REGISTROS
DROP TABLE JORNADA;
DROP TABLE CORREO_USUARIO;
DROP TABLE PARTICIPACION;
DROP TABLE USUARIO;
DROP TABLE CAMPEONATO;
DROP TABLE CLUB;


CREATE TABLE CLUB(
    COD_CLUB NUMBER(5) PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL
);

INSERT INTO CLUB VALUES(1, 'LAS AGUILAS');
INSERT INTO CLUB(COD_CLUB, NOMBRE) VALUES (40, 'AVENGERS');


CREATE TABLE USUARIO(
    CODIGO NUMBER(5) PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    OPERADOR_TELEFONO VARCHAR2(50),
    NUMERO_TELEFONO VARCHAR2(20),
    COD_EQUIPO REFERENCES CLUB
);

INSERT INTO USUARIO VALUES(100, 'JUAN PEREZ', 'MOVISTAR', '984999599', 1);
INSERT INTO USUARIO(CODIGO, NOMBRE) VALUES(200, 'CESAR PERALES');
INSERT INTO USUARIO VALUES(300, 'MARIA VALENCIA', 'CLARO', '985868889', 40);
INSERT INTO USUARIO VALUES(350, 'VALERIA PERALTA', 'ENTEL', '934425349', 1);


CREATE TABLE CAMPEONATO(
    CODIGO NUMBER(5) PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    FECHA_INICIO DATE,
    FECHA_FIN DATE
);

INSERT INTO CAMPEONATO VALUES(1, 'NACIONAL ARGENTINA', SYSDATE, SYSDATE + 6);
INSERT INTO CAMPEONATO VALUES(2, 'CAMPEONATO MUNDIAL', '01-JAN-20', '07-JAN-20');
INSERT INTO CAMPEONATO VALUES(3, 'ELIMINATORIAS EUROPA', TO_DATE('10/05/2008', 'DD/MM/YYYY'), TO_DATE('30/05/2008', 'DD/MM/YYYY'));
INSERT INTO CAMPEONATO VALUES(4, 'CAMPEONATO PERUANO', TO_DATE('01/02/2010', 'DD/MM/YYYY'), TO_DATE('07/02/2010', 'DD/MM/YYYY'));


CREATE TABLE PARTICIPACION(
    COD_USUARIO REFERENCES USUARIO,
    COD_CAMPEONATO REFERENCES CAMPEONATO,
    RESULTADO VARCHAR2(40),
    PRIMARY KEY(COD_USUARIO, COD_CAMPEONATO)
);

INSERT INTO PARTICIPACION VALUES(100, 1, 'GANADOR');
INSERT INTO PARTICIPACION VALUES(200, 1, 'PARTICIPANTE');
INSERT INTO PARTICIPACION VALUES(200, 2, 'GANADOR');
INSERT INTO PARTICIPACION VALUES(300, 1, 'PARTICIPANTE');
INSERT INTO PARTICIPACION VALUES(300, 2, 'PARTICIPANTE');
INSERT INTO PARTICIPACION VALUES(100, 3, 'PARTICIPANTE');
INSERT INTO PARTICIPACION VALUES(200, 3, 'PARTICIPANTE');
INSERT INTO PARTICIPACION VALUES(300, 3, 'GANADOR');
INSERT INTO PARTICIPACION VALUES(100, 4, 'PARTICIPANTE');
INSERT INTO PARTICIPACION VALUES(200, 4, 'GANADOR');
INSERT INTO PARTICIPACION VALUES(300, 4, 'PARTICIPANTE');


CREATE TABLE JORNADA(
    COD_CAMPEONATO REFERENCES CAMPEONATO,
    NRO_JORNADA NUMBER(2),
    FECHA DATE,
    PRIMARY KEY(COD_CAMPEONATO, NRO_JORNADA)
);

INSERT INTO JORNADA VALUES(1, 1, TO_DATE('10/05/2008', 'DD/MM/YYYY'));
INSERT INTO JORNADA VALUES(1, 2, TO_DATE('20/05/2008', 'DD/MM/YYYY'));
INSERT INTO JORNADA VALUES(1, 3, TO_DATE('30/05/2008', 'DD/MM/YYYY'));



CREATE TABLE CORREO_USUARIO(
    COD_USUARIO REFERENCES USUARIO,
    DIRECCION_CORREO VARCHAR2(80),
    PRIMARY KEY(COD_USUARIO, DIRECCION_CORREO)
);

INSERT INTO CORREO_USUARIO VALUES (100, 'JPEREZ@GMAIL.COM');
INSERT INTO CORREO_USUARIO VALUES (100, 'JPEREZ@YAHOO.ES');
INSERT INTO CORREO_USUARIO VALUES (200, 'CPERALES@HOTMAIL.COM');
