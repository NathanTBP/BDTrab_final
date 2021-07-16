--Consulta nome e avalia��o de pontos gastron�micos 
--de Nova York, que possuam comida natalina, 
--possam ter comidas vegetarianas inclusas e que estejam na mesma rua
--do hotel Transilv�nia. Os dados devem estar ordenados por avalia��o, da maior para menor.
SELECT P.NOME, P.AVALIACAO
    FROM ESTABELECIMENTO_COMERCIAL P join TAGS T
        on P.CNPJ = T.CNPJ and UPPER(P.TIPO) = 'PONTO'
    join RESTRICOES_ALIMENTARES R
        on P.CNPJ = R.CNPJ
    join ESTABELECIMENTO_COMERCIAL H
        on P.RUA = H.RUA and P.NOME_CIDADE = H.NOME_CIDADE and P.NOME_ESTADO = H.NOME_ESTADO and UPPER(H.TIPO) = 'HOTEL'
    WHERE UPPER(T.TAG) = 'COMIDA NATALINA' and UPPER(R.RESTRICAO) = 'VEGETARIANO'
        and UPPER(H.NOME_CIDADE) = 'NOVA YORK' and UPPER(H.NOME_ESTADO) = 'NOVA YORK' and UPPER(H.NOME) = 'TRANSILV�NIA'
    ORDER BY P.AVALIACAO DESC;
    

--Consulta nome do hotel e avalia��o de todos os hoteis de Paris que possuam pelo menos um restaurante de classe A, 
--e o pre�o do quarto, tipo do quarto, e capacidade, se dispon�veis entre os dias 12/04 e 16/04 de 2022 .
SELECT DISTINCT H.NOME, H.AVALIACAO, Q.PRECO, Q.TIPO_QUARTO, Q.CAPACIDADE
    FROM QUARTO Q right join ESTABELECIMENTO_COMERCIAL H
        on H.CNPJ = Q.CNPJ_HOTEL and NOT EXISTS (SELECT DQ.DATA_INDISPONIVEL
                                                    FROM DISPONIBILIDADE_QUARTO DQ
                                                    WHERE Q.CNPJ_HOTEL = DQ.CNPJ_HOTEL and Q.NUMERO_QUARTO = DQ.NUMERO_QUARTO 
                                                        and DQ.DATA_INDISPONIVEL BETWEEN '12/04/2022' and '16/04/2022')
    join RESTAURANTE_DE_HOTEL RH
        on RH.CNPJ_HOTEL = H.CNPJ
    join RESTAURANTE R
        on R.CNPJ_RES = RH.CNPJ_RES
    WHERE UPPER(H.NOME_CIDADE) = 'PARIS' and UPPER(H.TIPO) = 'HOTEL' and UPPER(R.CLASSE) = 'A';


--Selecionar os estabelecimentos comerciais do Canad� que atendem a todas as 
--restri��es alimentares do turista de CPF 111.222.333-43
SELECT E.NOME, E.AVALIACAO, E.TIPO
    FROM ESTABELECIMENTO_COMERCIAL E join CIDADE C
        on C.NOME_CIDADE = E.NOME_CIDADE and C.NOME_ESTADO = E.NOME_ESTADO
    WHERE C.NOME_PAIS = 'CANADA' and NOT EXISTS ( (SELECT RT.RESTRICAO
                        FROM RESTRICOES_TURISTA RT
                            WHERE RT.CPF = '111.222.333-43')
                        MINUS
                        (SELECT R.RESTRICAO
                         FROM RESTRICOES_ALIMENTARES R
                            WHERE R.CNPJ = E.CNPJ) 
                     );

-- Seleciona todos os itens que a comp�em uma viagem (turistas participantes, passagens compradas, quartos reservados e pontos gastron�micos indicados).
SELECT 
TUR_VI.CPF_ADICIONADO AS CPF, 
PASS_VI.IDPASSAGEM AS PASSAGEM, 
QUARTO_VI.CNPJ_HOTEL AS HOTEL, 
QUARTO_VI.NUMERO_QUARTO AS QUARTO, 
PONTO_VI.CNPJ_ADICIONADO AS PONTO_GASTRONOMICO
FROM VIAGEM VI
    LEFT JOIN TURISTAS_VIAGEM TUR_VI  
    ON TUR_VI.IDVIAGEM = VI.IDVIAGEM
        LEFT JOIN PASSAGENS_VIAGEM PASS_VI  
        ON PASS_VI.IDVIAGEM = VI.IDVIAGEM
            LEFT JOIN QUARTOS_VIAGEM QUARTO_VI  
            ON QUARTO_VI.IDVIAGEM = VI.IDVIAGEM
                LEFT JOIN PONTOS_VIAGEM PONTO_VI  
                ON PONTO_VI.IDVIAGEM = VI.IDVIAGEM
WHERE VI.IDVIAGEM = 1; -- Seleciona a viagem desejada.


-- Conta quantos estabelecimentos comerciais com dada tag cada cidade tem.
SELECT EC.NOME_CIDADE AS CIDADE, T.TAG, COUNT(*) AS QUANTIDADE
FROM ESTABELECIMENTO_COMERCIAL EC 
    JOIN TAGS T 
    ON T.CNPJ = EC.CNPJ
GROUP BY EC.NOME_CIDADE, T.TAG
ORDER BY EC.NOME_CIDADE, T.TAG;


-- ANTIGO: Seleciona, para cada viagem, os pontos gastron�micos inclusos em que pelo menos um turista participante da viagem n�o deveria frequentar, por motivos de restri��es alimentares. 
SELECT VI.IDVIAGEM AS VIAGEM, RA.CNPJ
FROM VIAGEM VI
    JOIN TURISTAS_VIAGEM TUR_VI  
    ON TUR_VI.IDVIAGEM = VI.IDVIAGEM
        JOIN PONTOS_VIAGEM PONTO_VI  
        ON PONTO_VI.IDVIAGEM = VI.IDVIAGEM
            JOIN RESTRICOES_ALIMENTARES RA
            ON RA.CNPJ = PONTO_VI.CNPJ_ADICIONADO
                JOIN RESTRICOES_TURISTA RT
                ON RT.CPF = TUR_VI.CPF_ADICIONADO
WHERE TUR_VI.IDVIAGEM = PONTO_VI.IDVIAGEM
AND RT.RESTRICAO = RA.RESTRICAO
ORDER BY VI.IDVIAGEM;


-- REVISADO: Seleciona, para cada viagem, os pontos gastron�micos inclusos em que pelo menos um turista participante da viagem n�o deveria frequentar, por motivos de restri��es alimentares.
SELECT RA.CNPJ
FROM TURISTAS_VIAGEM TUR_VI
    JOIN PONTOS_VIAGEM PONTO_VI  
    ON PONTO_VI.IDVIAGEM = TUR_VI.IDVIAGEM
        JOIN RESTRICOES_ALIMENTARES RA
        ON RA.CNPJ = PONTO_VI.CNPJ_ADICIONADO
            JOIN RESTRICOES_TURISTA RT
            ON RT.CPF = TUR_VI.CPF_ADICIONADO
WHERE TUR_VI.IDVIAGEM = 1 -- Seleciona a viagem desejada.
AND EXISTS (
        (SELECT RT.RESTRICAO 
        FROM TURISTAS_VIAGEM TUR_VI
            JOIN RESTRICOES_TURISTA RT
            ON RT.CPF = TUR_VI.CPF_ADICIONADO
        WHERE TUR_VI.IDVIAGEM = 1) -- Seleciona a viagem desejada.
    MINUS
        (SELECT RA.RESTRICAO 
        FROM PONTOS_VIAGEM PONTO_VI  
            JOIN RESTRICOES_ALIMENTARES RA
            ON RA.CNPJ = PONTO_VI.CNPJ_ADICIONADO
        WHERE TUR_VI.IDVIAGEM = 1) -- Seleciona a viagem desejada.
)
GROUP BY RA.CNPJ;


-- Conta quantas vezes cada pais � visitado em todas as viagens registradas.
SELECT C.NOME_PAIS AS PAIS, COUNT(*) AS POPULARIDADE
FROM CIDADES_VIAGEM CV
    JOIN CIDADE C
    ON C.NOME_CIDADE = CV.NOME_CIDADE
GROUP BY C.NOME_PAIS;
    
