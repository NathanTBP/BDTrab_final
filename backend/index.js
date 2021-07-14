const postgres = require('postgres')
const express = require('express')
const app = express()
const sql = postgres({
    host: 'localhost',
    port: 5432,
    database: 'postgres',
    username: 'postgres',
    password: 'Postgres123!'
})
 
app.get('/api/pais/', async (req, res) => {
    try {
        const paises = await sql `
        SELECT
            P.NOME as "nome",
            P.DESC_GAST as "descricao"
        FROM
            PAIS P;
        `

        res.json({
            "response": paises,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/pais/:nome', async (req, res) => {
    try {
        const nome = req.params.nome
        const cidades = await sql`
        SELECT
            C.NOME_CIDADE as "nome",
            C.NOME_ESTADO as "estado",
            C.DESC_GAST as "descricao"
        FROM
            CIDADE C
        WHERE
            C.NOME_PAIS = ${nome};
        `

        res.json({
            "response": cidades,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade', async (req, res) => {
    try {
        const nomeEstado = req.params.estado
        const nomeCidade = req.params.cidade
        let cidade = await sql`
        SELECT
            C.NOME_CIDADE as "nome",
            C.NOME_ESTADO as "estado",
            C.DESC_GAST as "descricao"
        FROM
            CIDADE C
        WHERE
            C.NOME_ESTADO = ${nomeEstado} AND C.NOME_CIDADE = ${nomeCidade};

        `

        if (cidade.length == 0)
            cidade = [{}]

        res.json({
            "response": cidade[0],
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade/pontos', async (req, res) => {
    try {
        const nomeEstado = req.params.estado
        const nomeCidade = req.params.cidade
        const pontos = await sql`
        SELECT
            EC.CNPJ as "cnpj",
            EC.NOME as "nome",
            CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
            CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
            EC.AVALIACAO as "avaliacao"
        FROM
            ESTABELECIMENTO_COMERCIAL EC
        WHERE
            EC.NOME_ESTADO = ${nomeEstado} AND EC.NOME_CIDADE = ${nomeCidade} AND EC.TIPO = 'PONTO';
        `

        res.json({
            "response": pontos,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade/pontos/:cnpj', async (req, res) => {
    try {
        const nomeEstado = req.params.estado
        const nomeCidade = req.params.cidade
        const cnpjPonto = req.params.cnpj
        const ponto = await sql`
        SELECT
            EC.CNPJ as "cnpj",
            EC.NOME as "nome",
            CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
            CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
            EC.AVALIACAO as "avaliacao"
        FROM
            ESTABELECIMENTO_COMERCIAL EC
        WHERE
            EC.NOME_ESTADO = ${nomeEstado} AND EC.NOME_CIDADE = ${nomeCidade} AND EC.CNPJ = ${cnpjPonto} AND EC.TIPO = 'PONTO';
        `

        if (ponto.length == 0)
            ponto  = [{}]
    
        res.json({
            "response": ponto[0],
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade/hotel', async (req, res) => {
    try {
        const nomeEstado = req.params.estado
        const nomeCidade = req.params.cidade
        const hoteis = await sql`
        SELECT
            EC.CNPJ as "cnpj",
            EC.NOME as "nome",
            CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
            CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
            EC.AVALIACAO as "avaliacao"
        FROM
            ESTABELECIMENTO_COMERCIAL EC
        WHERE
            EC.NOME_ESTADO = ${nomeEstado} AND EC.NOME_CIDADE = ${nomeCidade} AND EC.TIPO = 'HOTEL';
        `

        res.json({
            "response": hoteis,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade/hotel/:cnpj', async (req, res) => {
    try {
        const cnpjHotel = req.params.cnpj
        const quartos = await sql`
        SELECT
            Q.NUMERO_QUARTO as "n",
            Q.PRECO as "preco",
            Q.CAPACIDADE as "capacidade",
            Q.TIPO_QUARTO as "tipo"
        FROM
            QUARTO Q
        WHERE
            Q.CNPJ_HOTEL = ${cnpjHotel};
        `

        res.json({
            "response": quartos,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade/transporte', async (req, res) => {
    try {
        const nomeEstado = req.params.estado
        const nomeCidade = req.params.cidade
        const empresas = await sql`
        SELECT
            EC.CNPJ as "cnpj",
            EC.NOME as "nome",
            CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
            CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
            EC.AVALIACAO as "avaliacao"
        FROM
            ESTABELECIMENTO_COMERCIAL EC
        WHERE
            EC.NOME_ESTADO = ${nomeEstado} AND EC.NOME_CIDADE = ${nomeCidade} AND EC.TIPO = 'TRANSPORTE';
        `

        res.json({
            "response": empresas,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/cidade/:estado/:cidade/transporte/:cnpj', async (req, res) => {
    try {
        const cnpjEmpresa = req.params.cnpj
        const passagens = await sql`
        SELECT
            P.IDPASSAGEM as "id",
            P.NUMERO_ASSENTO as "n",
            P.DATA_PASSAGEM as "data",
            CONCAT(P.HORARIO_SAIDA, ' -> ', P.HORARIO_CHEGADA) as "horario",
            P.PRECO as "preco",
            P.TIPO_PASSAGEM as "tipo",
            ARRAY_TO_STRING(ARRAY_AGG(PPC.NOME_CIDADE), ', ') as "passa_por"
        FROM
            PASSAGEM P
        LEFT JOIN
            PASSA_POR_CIDADE PPC
            ON
                (P.IDPASSAGEM = PPC.IDPASSAGEM)
        WHERE
            P.CNPJ_TRANS = ${cnpjEmpresa}
        GROUP BY
            P.IDPASSAGEM;
        `

        res.json({
            "response": passagens,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/user/', async (req, res) => {
    try {
        const turistas = await sql`
        SELECT
            T.CPF as "cpf",
            T.NOME_TURISTA as "nome"
        FROM
            TURISTA T;
        `

        res.json({
            "response": turistas,
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/user/:cpf', async (req, res) => {
    try {
        const cpfTurista = req.params.cpf
        let turista = await sql`
            SELECT
            T.CPF as "cpf",
            T.NOME_TURISTA as "nome"
        FROM
            TURISTA T
        WHERE
            T.CPF = ${cpfTurista};
        `

        if (turista.length == 0)
            turista = [{}]

        res.json({
            "response": turista[0],
            "status": "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.get('/api/pedido/:id/:cpf', async (req, res) => {
    try {
        const idPedido = req.params.id
        const cpfTurista = req.params.cpf
        const viagem = await sql`
        SELECT
            V.CPF_CRIADOR as "cpf",
            V.IDVIAGEM as "id",
            V.DATA_COMECO as "data_comeco",
            V.DATA_FIM as "data_fim",
            V.VALOR as "valor"
        FROM
            VIAGEM V
        WHERE
            V.IDVIAGEM = '1';
        `
        const turistas = await sql`
        SELECT
            T.CPF as "cpf",
            T.NOME_TURISTA as "nome"
        FROM
            TURISTAS_VIAGEM V
        JOIN
            TURISTA T
            ON
                (T.CPF = V.CPF_ADICIONADO)
        WHERE
            V.IDVIAGEM = '1';
        `
        const quartos = await sql`
        SELECT
            Q.NUMERO_QUARTO as "n",
            Q.PRECO as "preco",
            Q.TIPO_QUARTO as "tipo",
            Q.CAPACIDADE as "capacidade",
            H.NOME as "nome",
            CONCAT(H.RUA, ', ', H.BAIRRO, ', ', H.NUMERO, ' - ', H.CEP) as "endereco"
        FROM
            QUARTOS_VIAGEM V
        JOIN
            QUARTO Q
            ON
                (Q.NUMERO_QUARTO = V.NUMERO_QUARTO) AND (Q.CNPJ_HOTEL = V.CNPJ_HOTEL)
        JOIN
            ESTABELECIMENTO_COMERCIAL H
            ON
                (Q.CNPJ_HOTEL = H.CNPJ)
        WHERE
            V.IDVIAGEM = '1';
        `
        const pontos = await sql`
        SELECT
            P.NOME as "nome",
            CONCAT(P.RUA, ', ', P.BAIRRO, ', ', P.NUMERO, ' - ', P.CEP) as "endereco"
        FROM
            PONTOS_VIAGEM V
        JOIN
            ESTABELECIMENTO_COMERCIAL P
        ON
            (V.CNPJ_ADICIONADO = P.CNPJ);
        `
        const passagens = await sql`
        SELECT
            P.IDPASSAGEM as "id",
            P.NUMERO_ASSENTO as "n",
            P.DATA_PASSAGEM as "data",
            CONCAT(P.HORARIO_SAIDA, ' -> ', P.HORARIO_CHEGADA) as "horario",
            P.PRECO as "preco",
            P.TIPO_PASSAGEM as "tipo",
            ARRAY_TO_STRING(ARRAY_AGG(PPC.NOME_CIDADE), ', ') as "passa_por"
        FROM
            PASSAGENS_VIAGEM V
        JOIN
            PASSAGEM P
            ON
                (P.IDPASSAGEM = V.IDPASSAGEM)
        LEFT JOIN
            PASSA_POR_CIDADE PPC
            ON
                (P.IDPASSAGEM = PPC.IDPASSAGEM)
        WHERE
            V.IDVIAGEM = '1'
        GROUP BY
                P.IDPASSAGEM;
        `

        res.json({
            response: {
                pedido: viagem[0],
                turistas: turistas,
                quartos: quartos,
                pontos: pontos,
                passagens: passagens
            },
            status: "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.post('/api/pedido/:id/:cpf/adicionar/turista/:cpfParaAdicionar', async (req, res) => {
    try {
        const idPedido = req.params.id
        const cpfTurista = req.params.cpf
        const cpfParaAdicionar = req.params.cpfParaAdicionar
        const insert = await sql`
        INSERT INTO
            TURISTAS_VIAGEM (IDVIAGEM, CPF_ADICIONADO)
        VALUES
            ('1', ${cpfParaAdicionar});
        `

        res.json({
            status: "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.post('/api/pedido/:id/:cpf/adicionar/quarto/:numeroQuarto/:cpnj', async (req, res) => {
    try {
        const idPedido = req.params.id
        const cpfTurista = req.params.cpf
        const numeroQuarto = req.params.numeroQuarto
        const cnpj = req.params.cpnj
        const insert = await sql`
        INSERT INTO
            QUARTOS_VIAGEM (IDVIAGEM, NUMERO_QUARTO, CNPJ_HOTEL)
        VALUES
            ('1', ${numeroQuarto}, ${cnpj});
        `

        res.json({
            status: "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.post('/api/pedido/:id/:cpf/adicionar/ponto/:cnpj', async (req, res) => {
    try {
        const idPedido = req.params.id
        const cpfTurista = req.params.cpf
        const cnpj = req.params.cnpj
        const insert = await sql`
        INSERT INTO
            PONTOS_VIAGEM (IDVIAGEM, CNPJ_ADICIONADO)
        VALUES
            ('1', ${cnpj});
        `

        res.json({
            status: "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.post('/api/pedido/:id/:cpf/adicionar/passagem/:idPassagem', async (req, res) => {
    try {
        const idPedido = req.params.id
        const cpfTurista = req.params.cpf
        const idPassagem = req.params.idPassagem
        const insert = await sql`
        INSERT INTO
            PASSAGENS_VIAGEM (IDVIAGEM, IDPASSAGEM)
        VALUES
            ('1', ${idPassagem});
        `

        res.json({
            status: "OK"
        })
    } catch (e) {
        res.json({
            status: "ERROR",
            message: e.message
        })
    }
})

app.listen(8080)

console.log('Listening on port 8080')