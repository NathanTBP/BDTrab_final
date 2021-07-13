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
})

app.get('/api/pais/:nome', async (req, res) => {
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
})

app.get('/api/cidade/:estado/:cidade', async (req, res) => {
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
})

app.get('/api/cidade/:estado/:cidade/pontos', async (req, res) => {
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
})

app.get('/api/cidade/:estado/:cidade/pontos/:cnpj', async (req, res) => {
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
})

app.get('/api/cidade/:estado/:cidade/hotel', async (req, res) => {
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
})

app.get('/api/cidade/:estado/:cidade/hotel/:cnpj', async (req, res) => {
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
})

app.post('/api/cidade/:estado/:cidade/hotel/:cnpj/:quarto', (req, res) => {
    
})

app.get('/api/cidade/:estado/:cidade/transporte', async (req, res) => {
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
})

app.get('/api/cidade/:estado/:cidade/transporte/:cnpj', async (req, res) => {
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
})

app.post('/api/cidade/:estado/:cidade/transporte/:cnpj/:passagem', (req, res) => {
    
})

app.get('/api/user/', async (req, res) => {
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
})

app.get('/api/user/:cpf', async (req, res) => {
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
})

app.get('/api/pedido/:id/:cpf', async (req, res) => {
    res.json({
        "response": {
            "cpf": "000.000.000-00",
            "nome": "Nome do turista"
        },
        "status": "OK"
    })
})
 
app.listen(8080)

console.log('Listening on port 8080')