--NOTA:
-- É IMPORTANTE RELEMBRAR DAS RETRIÇÕES DE INTEGRIDADE, NESSE CASO, ESSES DADOS ESTÃO ALIMENTANDO AS TABELAS, MAS NÃO EXISTEM VERIFICAÇÕES DO TIPO IF-ELSE PARA SABER SE, POR EXEMPLO,
-- EXISTE UM CNPJ QUE É FEIRA E RESTAURANTE AO MESMO TEMPO, OU EXISTE A COMPATIBILIDADE DESSES VALORES OU SE O TIPO DO ESTABELECIMENTO É COMPATIVEL COM CADA COISA.
-- NAO EXISTE UM SISTEMA QUE CALCULA OS IDS SINTETICOS TAMBEM
-- POR ALGUM MOTIVO O TIPO TIME NAO FUNCIONA P/ MIM, FUI OBRIGADO A FAZER UMA VERIFICAÇÃO PORÉM EST�? INCOMPLETA (HORARIOS DO TIPO 25:00 OU 16:98 SÃO POSS�?VEIS)
-- AVALIACOES, EMBORA SEJA UM ATRIBUTO DERIVADO, NÃO É TRATADO COMO TAL E NÃO HÁ LIMITAÇÃO PARA O VALOR NO "AVALIA"

INSERT INTO PAIS (NOME, DESC_GAST) VALUES ('BRASIL', 'TEM UNS PAPA GOSTOSO COM GOSTO DE CASA');
INSERT INTO PAIS (NOME, DESC_GAST) VALUES ('JAPAO', 'TEM UNS PAPA DIFERENTE CHEIO DE PEIXE');
INSERT INTO PAIS (NOME, DESC_GAST) VALUES ('ESTADOS UNIDOS', 'TEM UNS FAST FOOD BACANA');
-- VIOLANDO UMA PK
-- INSERT INTO PAIS (NOME, DESC_GAST) VALUES ('BRASIL', 'TEM SUSHI');

INSERT INTO CIDADE (NOME_CIDADE, NOME_ESTADO, NOME_PAIS, DESC_GAST) VALUES ('SAO PAULO','SAO PAULO','BRASIL','TEM PAPA DE TODO JEITO E TEM UM VIRADINHO GOSTOSO');
INSERT INTO CIDADE (NOME_CIDADE, NOME_ESTADO, NOME_PAIS, DESC_GAST) VALUES ('BELO HORIZONTE','MINAS GERAIS','BRASIL','TEM PAPA DE CASA NO FOGAO A LENHA E PAO DE QUEIJO');
INSERT INTO CIDADE (NOME_CIDADE, NOME_ESTADO, NOME_PAIS, DESC_GAST) VALUES ('TOKYO','SEI LA','JAPAO','SEI LA');
-- VIOLANDO UMA FK (NAO TEM CANADA)
-- INSERT INTO CIDADE (NOME_CIDADE, NOME_ESTADO, NOME_PAIS, DESC_GAST) VALUES ('TORONTO','SEI LA','CANADA','MAIS MAPLE');
-- INSERIR CANADA PARA TESTAR:
-- INSERT INTO PAIS (NOME, DESC_GAST) VALUES ('CANADA', 'WAFLLE COM MAPLE');

INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('11.222.333/0001-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO','1612345-6789','FRANGOGOSTOSO.COM','12:00','18:00','RUA DO FRANGO','FLANGOPOLIS','12345-678',42,3,'PONTO');
INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('11.222.333/0002-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO REST','1612345-6789','FRANGOGOSTOSO.COM','12:00','18:00','RUA DO FRANGO','FLANGOPOLIS','12345-678',42,3,'PONTO');
INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('11.222.444/0001-01','SAO PAULO','SAO PAULO','HOTEL COM FRANGO','1112345-6789','FRANGODEHOTEL.COM','10:00','19:00','RUA DO FLANGO','FLANGOPOLIS','12345-678',1030,3.5,'HOTEL');
INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('11.222.555/0001-01','SAO PAULO','SAO PAULO','FRANGO TURISMO','5012345-6789','FRANGOPASSEIO.COM','00:00','00:00','RUA DO FRANGASSADO','FLANGOPOLIS','12345-678',120,4.8,'TRANSPORTE');
-- VIOLANDO OS CHECKS:
-- CNPJ
-- INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('22222333000101','SAO PAULO','SAO PAULO','FRANGO GOSTOSO2','1622345-6789','FRANGOGOSTOSO2.COM','12:00','18:00','RUA DO FRANGO','FLANGOPOLIS','12345-678',43,3,'PONTO');
-- TELEFONE
-- INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('22.222.333/0001-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO2','16223456789','FRANGOGOSTOSO2.COM','12:00','18:00','RUA DO FRANGO','FLANGOPOLIS','12345-678',43,3,'PONTO');
-- CEP
-- INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('22.222.333/0001-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO2','1622345-6789','FRANGOGOSTOSO2.COM','12:00','18:00','RUA DO FRANGO','FLANGOPOLIS','12345678',43,3,'PONTO');
-- DATAS
-- INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('22.222.333/0001-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO2','1622345-6789','FRANGOGOSTOSO2.COM','12H','18H','RUA DO FRANGO','FLANGOPOLIS','12345-678',43,3,'PONTO');
-- INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('22.222.333/0001-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO2','1622345-6789','FRANGOGOSTOSO2.COM','1200','1800','RUA DO FRANGO','FLANGOPOLIS','12345-678',43,3,'PONTO');
-- TIPO
-- INSERT INTO ESTABELECIMENTO_COMERCIAL(CNPJ,NOME_CIDADE,NOME_ESTADO,NOME,TELEFONE,SITE,HORARIO_INICIO,HORARIO_FIM,RUA,BAIRRO,CEP,NUMERO,AVALIACAO,TIPO) VALUES ('22.222.333/0001-01','SAO PAULO','SAO PAULO','FRANGO GOSTOSO2','1622345-6789','FRANGOGOSTOSO2.COM','12:00','18:00','RUA DO FRANGO','FLANGOPOLIS','12345-678',43,3,'RESTAURANTE');

INSERT INTO TAGS (CNPJ, TAG) VALUES ('11.222.333/0001-01','FRANGO DE TODOS OS TIPOS');
INSERT INTO TAGS (CNPJ, TAG) VALUES ('11.222.333/0001-01','COMIDA CASEIRA');
INSERT INTO TAGS (CNPJ, TAG) VALUES ('11.222.555/0001-01','PETISCO NA VIAGEM');
-- VIOLANDO FK:
-- INSERT INTO TAGS (CNPJ, TAG) VALUES ('11.222.555/0002-01','PETISCO NA VIAGEM');
-- VIOLANDO CHAVE COMPOSTA:
-- INSERT INTO TAGS (CNPJ, TAG) VALUES ('11.222.333/0001-01','FRANGO DE TODOS OS TIPOS');

INSERT INTO RESTRICOES_ALIMENTARES (CNPJ, RESTRICAO) VALUES ('11.222.333/0001-01','FRANGO SEM SAL');
INSERT INTO RESTRICOES_ALIMENTARES (CNPJ, RESTRICAO) VALUES ('11.222.333/0001-01','FRANGO SEM GLUTEM');
INSERT INTO RESTRICOES_ALIMENTARES (CNPJ, RESTRICAO) VALUES ('11.222.333/0001-01','FRANGO SEM LACTOSE');

--OBS: TANTO AQUI QUANTO NA TABELA EU MUDEI A CHAVE, PQ DA FORMA QUE ESTAVA, CADA ESTABELECIMENTO SÓ PODIA FAZER UM EVENTO
INSERT INTO EVENTO (CNPJ, DESC_EVENTO, NOME_EVENTO, DATA_EVENTO, CUSTO) VALUES ('11.222.333/0001-01','FRANGO VAI PRO ALTO','FRANGO VOADOR','12/12/2025',10);
INSERT INTO EVENTO (CNPJ, DESC_EVENTO, NOME_EVENTO, DATA_EVENTO, CUSTO) VALUES ('11.222.333/0001-01','FRANGO VAI PRA RUA','FRANGO ARRUACEIRO','12/12/2025',10);
INSERT INTO EVENTO (CNPJ, DESC_EVENTO, NOME_EVENTO, DATA_EVENTO, CUSTO) VALUES ('11.222.333/0001-01','FRANGO PELA METADE DO PRECO','MEIO FRANGO','12/12/2025',5);
-- VIOLANDO COMPLETUDE DA TUPLA 
-- INSERT INTO EVENTO (CNPJ, DESC_EVENTO, NOME_EVENTO, DATA_EVENTO, CUSTO) VALUES ('11.222.333/0001-01','FRANGO PELA METADE DO PRECO','MEIO FRANGO','12/12/2025');

-- IDEM ACIMA
INSERT INTO FEIRA (CNPJ,DATA_FEIRA) VALUES ('11.222.333/0001-01','12/12/2025');
INSERT INTO FEIRA (CNPJ,DATA_FEIRA) VALUES ('11.222.333/0001-01','18/12/2025');
INSERT INTO FEIRA (CNPJ,DATA_FEIRA) VALUES ('11.222.333/0001-01','24/12/2025');
-- MES NAO VALIDO
-- INSERT INTO FEIRA (CNPJ,DATA_FEIRA) VALUES ('11.222.333/0001-01','12/18/2025');

INSERT INTO BARRACA (CNPJ,DATA_FEIRA,NOME_BARRACA,TIPO_COMIDA) VALUES ('11.222.333/0001-01','12/12/2025','FRANGO GIRANDO','FRANGO ASSADO');
INSERT INTO BARRACA (CNPJ,DATA_FEIRA,NOME_BARRACA,TIPO_COMIDA) VALUES ('11.222.333/0001-01','12/12/2025','FRANGO FRITANDO','PASTEL DE FRANGO');
INSERT INTO BARRACA (CNPJ,DATA_FEIRA,NOME_BARRACA,TIPO_COMIDA) VALUES ('11.222.333/0001-01','12/12/2025','FRANGO FRITANDO2','FRANGO FRITO');
-- VIOLANDO CHAVE COMPOSTA 
-- INSERT INTO BARRACA (CNPJ,NOME_BARRACA,TIPO_COMIDA) VALUES ('11.222.333/0001-01','FRANGO FRITANDO','FRANGO FRITO');

INSERT INTO RESTAURANTE (CNPJ_RES,CARDAPIO,CLASSE) VALUES ('11.222.333/0001-01','FRANGO1: AA, FRANGO 2: BB, FRANGO 3: CC...,','B');
INSERT INTO RESTAURANTE (CNPJ_RES,CARDAPIO,CLASSE) VALUES ('11.222.333/0002-01','FRANGO12: AA, FRANGO 2: BB, FRANGO 3: CC...,','B');
-- VIOLANDO TAMANHO DA STRING DE CARACTERES
-- INSERT INTO RESTAURANTE (CNPJ,CARDAPIO,CLASSE) VALUES ('11.222.333/0001-01','FRANGO1: AA, FRANGO 2: BB, FRANGO 3: CC...,','ELITE');

INSERT INTO QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, PRECO, TIPO_QUARTO, CAPACIDADE) VALUES ('11.222.333/0001-01',10,100,'SOLTEIRO',1);
INSERT INTO QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, PRECO, TIPO_QUARTO, CAPACIDADE) VALUES ('11.222.333/0001-01',11,200,'CASAL',2);
INSERT INTO QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, PRECO, TIPO_QUARTO, CAPACIDADE) VALUES ('11.222.333/0001-01',12,250,'FAMILIA',4);
-- VIOLANDO TIPO NUMERO + CHAVE PRIMARIA
-- INSERT INTO QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, PRECO, TIPO_QUARTO, CAPACIDADE VALUES ('11.222.333/0001-01','10',100,'SOLTEIRO',1);

INSERT INTO DISPONIBILIDADE_QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, DATA_INDISPONIVEL) VALUES ('11.222.333/0001-01',10,'12/12/2025');
INSERT INTO DISPONIBILIDADE_QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, DATA_INDISPONIVEL) VALUES ('11.222.333/0001-01',11,'12/12/2025');
INSERT INTO DISPONIBILIDADE_QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, DATA_INDISPONIVEL) VALUES ('11.222.333/0001-01',10,'13/12/2025');
-- VIOLANDO CHAVE COMPOSTA POR 3
-- INSERT INTO DISPONIBILIDADE_QUARTO (CNPJ_HOTEL,NUMERO_QUARTO, DATA_INDISPONIVEL) DATA VALUES ('11.222.333/0001-01',10,'12/12/2025');

INSERT INTO RESTAURANTE_DE_HOTEL (CNPJ_HOTEL,CNPJ_RES) VALUES ('11.222.333/0001-01','11.222.333/0002-01');
-- VIOLANDO FKEY
-- INSERT INTO RESTAURANTE_DE_HOTEL (CNPJ_HOTEL,CNPJ_RES) VALUES ('11.222.333/0001-01','11.222.333/0005-01');

INSERT INTO PASSAGEM (CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,HORARIO_CHEGADA,NOME_CIDADE_SAIDA,TIPO_PASSAGEM,PRECO,IDPASSAGEM) VALUES ('11.222.333/0001-01',12,'12/12/2025','12:00','13:00','SAO PAULO','ECONOMICA','15',1);
INSERT INTO PASSAGEM (CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,HORARIO_CHEGADA,NOME_CIDADE_SAIDA,TIPO_PASSAGEM,PRECO,IDPASSAGEM) VALUES ('11.222.333/0001-01',13,'12/12/2025','12:00','13:00','SAO PAULO','ECONOMICA','15',2);
INSERT INTO PASSAGEM (CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,HORARIO_CHEGADA,NOME_CIDADE_SAIDA,TIPO_PASSAGEM,PRECO,IDPASSAGEM) VALUES ('11.222.333/0001-01',12,'12/12/2025','13:00','14:00','SAO PAULO','ECONOMICA','15',3);
INSERT INTO PASSAGEM (CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,HORARIO_CHEGADA,NOME_CIDADE_SAIDA,TIPO_PASSAGEM,PRECO,IDPASSAGEM) VALUES ('11.222.333/0002-01',13,'12/12/2025','12:00','13:00','SAO PAULO','ECONOMICA','15',4);
INSERT INTO PASSAGEM (CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,HORARIO_CHEGADA,NOME_CIDADE_SAIDA,TIPO_PASSAGEM,PRECO,IDPASSAGEM) VALUES ('11.222.333/0001-01',13,'12/12/2025','12:00','13:00','SAO CARLOS','ECONOMICA','15',5);
-- VIOLANDO ID
-- INSERT INTO PASSAGEM (CNPJ_TRANS,NUMERO_ASSENTO,DATA_PASSAGEM,HORARIO_SAIDA,HORARIO_CHEGADA,NOME_CIDADE_SAIDA,TIPO_PASSAGEM,PRECO,IDPASSAGEM) VALUES ('11.222.333/0001-01',13,'22/12/2025',12:00,13:00,'SAO PAULO','ECONOMICA','15',3);

INSERT INTO PASSA_POR_CIDADE (NOME_CIDADE,NOME_ESTADO,IDPASSAGEM) VALUES ('SAO PAULO','SAO PAULO',1);
-- VIOLANDO FK
-- INSERT INTO PASSA_POR_CIDADE (NOME_CIDADE,NOME_ESTADO,IDPASSAGEM) VALUES ('SAO PAULO','MINAS GERAIS',1);

INSERT INTO TURISTA (CPF,NOME_TURISTA,RUA,BAIRRO,CEP,NUMERO,EMAIL,SENHA) VALUES ('111.222.333-42','ANDRE','PEQUENA','PEQUENOLANDIA','12345-011',3,'ANDRE@GMAIL.COM','COXINHA13');
INSERT INTO TURISTA (CPF,NOME_TURISTA,RUA,BAIRRO,CEP,NUMERO,EMAIL,SENHA) VALUES ('111.222.333-43','TONINHO','PEQUENA','PEQUENOLANDIA2','12345-011',3,'TONINHO@GMAIL.COM','COXINHA13');
INSERT INTO TURISTA (CPF,NOME_TURISTA,RUA,BAIRRO,CEP,NUMERO,EMAIL,SENHA) VALUES ('111.222.333-44','CLARA','PEQUENA','PEQUENOLANDIA3','12345-011',3,'CLARA@GMAIL.COM','COXINHA13');
INSERT INTO TURISTA (CPF,NOME_TURISTA,RUA,BAIRRO,CEP,NUMERO,EMAIL,SENHA) VALUES ('111.222.333-45','GEMA','PEQUENA','PEQUENOLANDIA4','12345-011',3,'GEMA@GMAIL.COM','COXINHA13');
-- VIOLANDO CPF
-- INSERT INTO TURISTA (CPF,NOME_TURISTA,RUA,BAIRRO,CEP,NUMERO,EMAIL,SENHA) VALUES ('111.222.33342','ANDRE','PEQUENA','PEQUENOLANDIA','12345-011',3,'ANDRE@GMAIL.COM','COXINHA13');
-- VIOLANDO CEP
-- INSERT INTO TURISTA (CPF,NOME_TURISTA,RUA,BAIRRO,CEP,NUMERO,EMAIL,SENHA) VALUES ('111.222.333-42','ANDRE','PEQUENA','PEQUENOLANDIA','12345011',3,'ANDRE@GMAIL.COM','COXINHA13');


INSERT INTO RESTRICOES_TURISTA (CPF, RESTRICAO) VALUES ('111.222.333-42','FRANGO SEM SAL');
INSERT INTO RESTRICOES_TURISTA (CPF, RESTRICAO) VALUES ('111.222.333-42','FRANGO SEM GLUTEM');

INSERT INTO AVALIAR (CPF_AVALIADOR, CNPJ_AVALIADO, AVALIACAO) VALUES ('111.222.333-42','11.222.333/0001-01',5);
INSERT INTO AVALIAR (CPF_AVALIADOR, CNPJ_AVALIADO, AVALIACAO) VALUES ('111.222.333-43','11.222.333/0001-01',4.8);
INSERT INTO AVALIAR (CPF_AVALIADOR, CNPJ_AVALIADO, AVALIACAO) VALUES ('111.222.333-42','11.222.333/0002-01',4);
-- ATENCAO NA INTEGRIDADE

INSERT INTO VIAGEM (CPF_CRIADOR, DATA_COMECO, DATA_FIM, VALOR, IDVIAGEM) VALUES ('111.222.333-42','12/12/2025','12/12/2025',0,1);
INSERT INTO VIAGEM (CPF_CRIADOR, DATA_COMECO, DATA_FIM, VALOR, IDVIAGEM) VALUES ('111.222.333-42','12/12/2025','15/12/2025',100,2);
INSERT INTO VIAGEM (CPF_CRIADOR, DATA_COMECO, DATA_FIM, VALOR, IDVIAGEM) VALUES ('111.222.333-43','12/12/2025','15/12/2025',100,3);
-- ATENCAO NA INTEGRIDADE

INSERT INTO TURISTAS_VIAGEM (IDVIAGEM,CPF_ADICIONADO) VALUES (1,'111.222.333-44');
-- VIAGEM SEM ID ATRIBUIDO
-- INSERT INTO TURISTAS_VIAGEM (IDVIAGEM,CPF_ADICIONADO) VALUES (100,'111.222.333-44');

INSERT INTO PONTOS_VIAGEM (IDVIAGEM,CNPJ_ADICIONADO) VALUES (1,'11.222.333/0001-01');

INSERT INTO PASSAGENS_VIAGEM (IDVIAGEM,CNPJ_ADICIONADO) VALUES (1,1);

INSERT INTO QUARTOS_VIAGEM (IDVIAGEM,CNPJ_HOTEL,NUMERO_QUARTO) VALUES (1,'11.222.333/0001-01',10);
-- QUARTO NAO VALIDO
-- INSERT INTO QUARTOS_VIAGEM (IDVIAGEM,CNPJ_HOTEL,NUMERO_QUARTO) VALUES (1,'11.222.333/0001-01',100);

INSERT INTO CIDADES_VIAGEM (IDVIAGEM,NOME_CIDADE,NOME_ESTADO) VALUES (1,'SAO PAULO','SAO PAULO');

