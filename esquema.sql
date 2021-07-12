CREATE TABLE PAIS (
   NOME VARCHAR2(20),
   DESC_GAST VARCHAR2(100),
   CONSTRAINT PK_PAIS PRIMARY KEY(NOME)
);

CREATE TABLE CIDADE (
   NOME_CIDADE VARCHAR2(30),
   NOME_ESTADO VARCHAR2(20),
   NOME_PAIS VARCHAR2(20),
   DESC_GAST VARCHAR2(100),
   CONSTRAINT PK_CIDADE PRIMARY KEY(NOME_CIDADE),
   CONSTRAINT FK_PAIS FOREIGN KEY(NOME_PAIS) REFERENCES PAIS(NOME) ON DELETE CASCADE
);

CREATE TABLE ESTABELECIMENTO_COMERCIAL (
   CNPJ CHAR(18),
   NOME_CIDADE VARCHAR2(30) NOT NULL,
   NOME_ESTADO VARCHAR2(20) NOT NULL,
   NOME VARCHAR2(30) NOT NULL,
   TELEFONE CHAR(14),
   SITE VARCHAR2(100),
   HORARIO_INICIO TIME(0), -- SEM PRECISAO NA CASA DOS SEGUNDOS
   HORARIO_FIM TIME(0),
   RUA VARCHAR2(30),
   BAIRRO VARCHAR2(30),
   CEP CHAR(9),
   NUMERO NUMBER(4,0),
   AVALIACAO NUMBER(1,1),
   TIPO VARCHAR2(10) NOT NULL,
   CONSTRAINT PK_ESTABELECIMENTO PRIMARY KEY(CNPJ),
   CONSTRAINT CK_CNPJ CHECK(REGEXP_LIKE(CNPJ, '[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/000[1-2]{1}\-[0-9]{2}')), -- CNPJ DO TIPO XX.XXX.XXX/000X-XX
   CONSTRAINT CK_TEL CHECK(REGEXP_LIKE(TELEFONE, '([0-9]{2})\[0-9]{5}\-[0-9]{4}')), -- TELEFONE DO TIPO (XX)99999-9999
   CONSTRAINT CK_CEP CHECK(REGEXP_LIKE(CEP, '[0-9]{5}\-[0-9]{3}')),
   CONSTRAINT CK_TIPO CHECK(UPPER(TIPO) IN ('PONTO', 'HOTEL', 'TRANSPORTE')),
   CONSTRAINT FK_CIDADE FOREIGN KEY(NOME_CIDADE) REFERENCES CIDADE(NOME_CIDADE) ON DELETE CASCADE,
   CONSTRAINT FK_ESTADO FOREIGN KEY(NOME_ESTADO) REFERENCES CIDADE(NOME_ESTADO) ON DELETE CASCADE
);

CREATE TABLE TAGS(
    CNPJ CHAR(18),
    TAG VARCHAR2(30),
    CONSTRAINT PK_TAGS PRIMARY KEY(CNPJ,TAG),
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE RESTRICOES_ALIMENTARES(
    CNPJ CHAR(18),
    RESTRICAO VARCHAR2(30),
    CONSTRAINT PK_RESTRICOES PRIMARY KEY(CNPJ,RESTRICAO),
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE EVENTO(
    CNPJ CHAR(18),
    DESC_EVENTO VARCHAR2(100) NOT NULL,
    NOME_EVENTO VARCHAR2(30) NOT NULL,
    DATA_EVENTO DATE,
    CUSTO NUMBER(5,2),
    CONSTRAINT PK_EVENTO PRIMARY KEY(CNPJ),
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE FEIRA(
    CNPJ CHAR(18),
    DATA_FEIRA DATE,
    CONSTRAINT PK_FEIRA PRIMARY KEY(CNPJ),
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE BARRACA(
    CNPJ CHAR(18),
    NOME_BARRACA VARCHAR2(30),
    TIPO_COMIDA VARCHAR2(30),
    CONSTRAINT PK_BARRACA PRIMARY KEY(CNPJ,NOME_BARRACA),
    CONSTRAINT FK_CNPJ_FEIRA FOREIGN KEY(CNPJ) REFERENCES FEIRA(CNPJ) ON DELETE CASCADE
);

CREATE TABLE RESTAURANTE(
    CNPJ_RES CHAR(18),
    CARDAPIO VARCHAR2(1000),
    CLASSE CHAR(1),
    CONSTRAINT PK_RESTAURANTE PRIMARY KEY(CNPJ_RES),
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ_RES) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE QUARTO(
    CNPJ_HOTEL CHAR(18),
    NUMERO_QUARTO NUMBER(4,0),
    PRECO NUMBER(5,2) NOT NULL,
    TIPO_QUARTO VARCHAR2(30),
    CAPACIDADE NUMBER(2,0) NOT NULL,
    CONSTRAINT PK_QUARTO PRIMARY KEY(CNPJ_HOTEL,NUMERO_QUARTO),
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ_HOTEL) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE DISPONIBILIDADE_QUARTO(
    CNPJ_HOTEL CHAR(18),
    NUMERO_QUARTO NUMBER(4,0),
    DATA_INDISPONIVEL DATE,
    CONSTRAINT PK_DISPONIBILIDADE PRIMARY KEY(CNPJ_HOTEL,NUMERO_QUARTO,DATA_INDISPONIVEL),
    CONSTRAINT FK_QUARTO FOREIGN KEY(CNPJ_HOTEL,NUMERO_QUARTO) REFERENCES QUARTO(CNPJ_HOTEL,NUMERO_QUARTO) ON DELETE CASCADE
);

CREATE TABLE RESTAURANTE_DE_HOTEL(
    CNPJ_RES CHAR(18),
    CNPJ_HOTEL CHAR(18),
    CONSTRAINT PK_QUARTO PRIMARY KEY(CNPJ_RES,CNPJ_HOTEL),
    CONSTRAINT FK_CNPJ_RES FOREIGN KEY(CNPJ_RES) REFERENCES RESTAURANTE(CNPJ_RES) ON DELETE CASCADE
    CONSTRAINT FK_CNPJ_HOTEL FOREIGN KEY(CNPJ_HOTEL) REFERENCES QUARTO(CNPJ_HOTEL) ON DELETE CASCADE
);

CREATE TABLE PASSAGEM(
    CNPJ_TRANS CHAR(18) NOT NULL,
    NUMERO_ASSENTO NUMBER(4,0) NOT NULL,
    DATA_PASSAGEM DATE NOT NULL,
    HORARIO_SAIDA TIME(0) NOT NULL,
    HORARIO_CHEGADA TIME(0) NOT NULL,
    NOME_CIDADE_SAIDA VARCHAR2(30) NOT NULL,
    TIPO_PASSAGEM VARCHAR2(30),
    PRECO NUMBER(5,2) NOT NULL,
    IDPASSAGEM NUMBER,
    CONSTRAINT CHAVE_PASSAGEM UNIQUE(CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,NOME_CIDADE_SAIDA),
    CONSTRAINT PK_PASSAGEM PRIMARY KEY(IDPASSAGEM)
);

CREATE TABLE PASSA_POR_CIDADE(
    NOME_CIDADE VARCHAR2(30),
    NOME_ESTADO VARCHAR2(20),
    IDPASSAGEM NUMBER,
    CONSTRAINT PK_PASSA_POR PRIMARY KEY(NOME_CIDADE,NOME_ESTADO,IDPASSAGEM),
    CONSTRAINT FK_CIDADE FOREIGN KEY (NOME_CIDADE,NOME_ESTADO) REFERENCES CIDADE(NOME_CIDADE,NOME_ESTADO) ON DELETE CASCADE,
    CONSTRAINT FK_PASSAGEM FOREIGN KEY (IDPASSAGEM) REFERENCES PASSAGEM(IDPASSAGEM) ON DELETE CASCADE
);

CREATE TABLE TURISTA(
    CPF CHAR(14),
    NOME_TURISTA VARCHAR2(30) NOT NULL,
    RUA VARCHAR2(30),
    BAIRRO VARCHAR2(30),
    CEP CHAR(9),
    NUMERO NUMBER(4,0),
    EMAIL VARCHAR(30) NOT NULL,
    SENHA VARCHAR(30) NOT NULL,
    CONSTRAINT PK_TURISTA PRIMARY KEY(CPF),
    CONSTRAINT CK_CPF CHECK(REGEXP_LIKE(CPF, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}')),
    CONSTRAINT CK_CEP CHECK(REGEXP_LIKE(CEP, '[0-9]{5}\-[0-9]{3}'))
);

CREATE TABLE RESTRICOES_TURISTA(
    CPF CHAR(14),
    RESTRICAO VARCHAR2(30),
    CONSTRAINT PK_RESTRICOES PRIMARY KEY(CPF,RESTRICAO),
    CONSTRAINT FK_TURISTA FOREIGN KEY (CPF) REFERENCES TURISTA(CPF) ON DELETE CASCADE,
);

CREATE TABLE AVALIAR(
    CPF_AVALIADOR CHAR(14),
    CNPJ_AVALIADO CHAR(18),
    AVALIACAO NUMBER(1,1) NOT NULL
    CONSTRAINT PK_AVALIACAO PRIMARY KEY(CPF_AVALIADOR,CNPJ_AVALIADO),
    CONSTRAINT FK_TURISTA FOREIGN KEY (CPF_AVALIADOR) REFERENCES TURISTA(CPF) ON DELETE CASCADE,
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ_AVALIADO) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE VIAGEM(
    CPF_CRIADOR CHAR(14),
    DATA_COMECO DATE,
    DATA_FIM DATE,
    VALOR NUMBER(5,2)
    IDVIAGEM NUMBER,
    CONSTRAINT CHAVE_VIAGEM UNIQUE(CPF_CRIADOR,DATA_COMECO,DATA_FIM),
    CONSTRAINT PK_VIAGEM PRIMARY KEY(IDVIAGEM)
);

CREATE TABLE TURISTAS_VIAGEM(
    IDVIAGEM NUMBER,
    CPF_ADICIONADO CHAR(14),
    CONSTRAINT PK_TURISTAS_VIAGEM PRIMARY KEY(IDVIAGEM,CPF_ADICIONADO),
    CONSTRAINT FK_VIAGEM FOREIGN KEY(IDVIAGEM) REFERENCES VIAGEM(IDVIAGEM) ON DELETE CASCADE,
    CONSTRAINT FK_TURISTA FOREIGN KEY (CPF_ADICIONADO) REFERENCES TURISTA(CPF) ON DELETE CASCADE
);

CREATE TABLE PONTOS_VIAGEM(
    IDVIAGEM NUMBER,
    CNPJ_ADICIONADO CHAR(18),
    CONSTRAINT PK_PONTOS_VIAGEM PRIMARY KEY (IDVIAGEM,CNPJ_ADICIONADO),
    CONSTRAINT FK_VIAGEM FOREIGN KEY(IDVIAGEM) REFERENCES VIAGEM(IDVIAGEM) ON DELETE CASCADE,
    CONSTRAINT FK_CNPJ_ESTABELECIMENTO FOREIGN KEY(CNPJ_ADICIONADO) REFERENCES ESTABELECIMENTO_COMERCIAL(CNPJ) ON DELETE CASCADE
);

CREATE TABLE PASSAGENS_VIAGEM(
    IDVIAGEM NUMBER,
    IDPASSAGEM NUMBER,
    CONSTRAINT PK_PASSAGENS_VIAGEM PRIMARY KEY (IDVIAGEM,IDPASSAGEM),
    CONSTRAINT FK_VIAGEM FOREIGN KEY(IDVIAGEM) REFERENCES VIAGEM(IDVIAGEM) ON DELETE CASCADE,
    CONSTRAINT FK_VIAGEM FOREIGN KEY(IDPASSAGEM) REFERENCES PASSAGEM(IDPASSAGEM) ON DELETE CASCADE
);

CREATE TABLE QUARTOS_VIAGEM(
    IDVIAGEM NUMBER,
    CNPJ_HOTEL CHAR(18),
    NUMERO_QUARTO NUMBER(4,0),
    CONSTRAINT PK_QUARTOS_VIAGEM PRIMARY KEY (IDVIAGEM,CNPJ_HOTEL,NUMERO_QUARTO),
    CONSTRAINT FK_VIAGEM FOREIGN KEY(IDVIAGEM) REFERENCES VIAGEM(IDVIAGEM) ON DELETE CASCADE
    CONSTRAINT FK_QUARTO FOREIGN KEY(CNPJ_HOTEL,NUMERO_QUARTO) REFERENCES QUARTO(CNPJ_HOTEL,NUMERO_QUARTO) ON DELETE CASCADE
);

CREATE TABLE CIDADES_VIAGEM(
    IDVIAGEM NUMBER,
    NOME_CIDADE VARCHAR2(30),
    NOME_ESTADO VARCHAR2(20),
    CONSTRAINT FK_CIDADE FOREIGN KEY (NOME_CIDADE,NOME_ESTADO) REFERENCES CIDADE(NOME_CIDADE,NOME_ESTADO) ON DELETE CASCADE,
    CONSTRAINT FK_VIAGEM FOREIGN KEY(IDVIAGEM) REFERENCES VIAGEM(IDVIAGEM) ON DELETE CASCADE
);

commit;




























