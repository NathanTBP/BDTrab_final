--Consulta nome e avaliação de pontos gastronômicos 
--de Nova York na semana do Natal, que possuam comida natalina, 
--possam ter comidas vegetarianas inclusas e que estejam na mesma rua
--do hotel Transilvânia. Os dados devem estar ordenados por avaliação, da maior para menor.
SELECT P.NOME, P.AVALIACAO
    FROM ESTABELECIMENTO_COMERCIAL P join TAGS T
        on P.CNPJ = T.CNPJ and UPPER(P.TIPO) = 'PONTO'
    join RESTRICOES_ALIMENTARES R
        on P.CNPJ = R.CNPJ
    join ESTABELECIMENTO_COMERCIAL H
        on P.RUA = H.RUA and P.NOME_CIDADE = H.NOME_CIDADE and P.NOME_ESTADO = H.NOME_ESTADO and UPPER(H.TIPO) = 'HOTEL'
    WHERE UPPER(T.TAG) = 'COMIDA NATALINA' and UPPER(R.RESTRICAO) = 'VEGETARIANO' and UPPER(H.NOME) = 'TRANSILVÂNIA'
    ORDER BY P.AVALIACAO DESC;
    

--Consulta nome do hotel e avaliação de todos os hoteis de Paris que possuam pelo menos um restaurante de classe A, 
--e o preço do quarto, tipo do quarto, e capacidade, se disponíveis entre os dias 12/04 e 16/04 de 2022 .
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

--Selecionar os estabelecimentos comerciais do Canadá que atendem a todas as 
--restrições alimentares do turista de CPF 111.222.333-43
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

SELECT E.NOME, E.AVALIACAO, E.TIPO
    FROM ESTABELECIMENTO_COMERCIAL E join RESTRICOES_ALIMENTARES R
        on R.CNPJ = E.CNPJ
    join CIDADE C
        on C.NOME_CIDADE = E.NOME_CIDADE and C.NOME_ESTADO = E.NOME_ESTADO
    WHERE C.NOME_PAIS = 'CANADA' and R.RESTRICAO IN (SELECT RT.RESTRICAO
                          FROM RESTRICOES_TURISTA RT
                          WHERE RT.CPF = '111.222.333-43')
    GROUP BY E.NOME, E.AVALIACAO, E.TIPO
    HAVING count(*) = (SELECT count(*)
                       FROM RESTRICOES_TURISTA RT
                       WHERE RT.CPF = '111.222.333-42');

    