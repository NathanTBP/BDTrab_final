const express = require('express')
const app = express()
 
app.get('/api/pais/', (req, res) => {
    res.json({
        "response": [
            {
                "nome": "Brasil",
                "descricao": "Alguma descrição"
            },
            {
                "nome": "Brasil 2",
                "descricao": "Alguma descrição"
            },
            {
                "nome": "Brasil 3",
                "descricao": "Alguma descrição"
            },
            {
                "nome": "Brasil 4",
                "descricao": "Alguma descrição"
            }
        ],
        "status": "OK"
    })
})

app.get('/api/pais/:nome', (req, res) => {
    res.json({
        "response": [
            {
                "nome": "Cidade 1",
                "estado": "Estado",
                "descricao": "Alguma descrição"
            }
        ],
        "status": "OK"
    })
})

app.get('/api/cidade/:estado/:cidade', (req, res) => {
    res.json({
        "response": {
            "nome": "Cidade 1",
            "estado": "Estado",
            "descricao": "Alguma descrição"
        },
        "status": "OK"
    })
})

app.get('/api/cidade/:estado/:cidade/pontos', (req, res) => {
    res.json({
        "response": [
            {
                "nome": "Ponto 1",
                "horario": "Horário",
                "endereco": "Endereço",
                "avaliacao": 4.5
            }
        ],
        "status": "OK"
    })
})

app.get('/api/cidade/:estado/:cidade/pontos/:nome', (req, res) => {
    res.json({
        "response": {
            "nome": "Ponto 1",
            "horario": "Horário",
            "endereco": "Endereço",
            "avaliacao": 4.5
        },
        "status": "OK"
    })
})

app.get('/api/cidade/:estado/:cidade/hotel', (req, res) => {
    res.json({
        "response": [
            {
                "nome": "Ponto 1",
                "horario": "Horário",
                "endereco": "Endereço",
                "avaliacao": 4.5
            }
        ],
        "status": "OK"
    })
})

app.get('/api/cidade/:estado/:cidade/hotel/:nome', (req, res) => {
    res.json({
        "response": [
            {
                "n": "10",
                "preco": 2.53,
                "capacidade": 0,
                "tipo": "algum tipo"
            }
        ],
        "status": "OK"
    })
})

app.post('/api/cidade/:estado/:cidade/hotel/:nome/:quarto', (req, res) => {
    
})

app.get('/api/cidade/:estado/:cidade/transporte', (req, res) => {
    res.json({
        "response": [
            {
                "nome": "Ponto 1",
                "horario": "Horário",
                "endereco": "Endereço",
                "avaliacao": 4.5
            }
        ],
        "status": "OK"
    })
})

app.get('/api/cidade/:estado/:cidade/transporte/:nome', (req, res) => {
    res.json({
        "response": [
            {
                "n": "100",
                "data": "11/02/2021",
                "horario": "21hrs",
                "preco": 1.37,
                "passa_por": "cidade 1, cidade 2, cidade 3",
                "tipo": "algum tipo"
            }
        ],
        "status": "OK"
    })
})

app.post('/api/cidade/:estado/:cidade/transporte/:nome/:passagem', (req, res) => {
    
})

app.get('/api/user/', (req, res) => {
    res.json({
        "response": [
            {
                "cpf": "000.000.000-00",
                "nome": "Nome do turista"
            }
        ],
        "status": "OK"
    })
})

app.get('/api/user/:nome', (req, res) => {
    res.json({
        "response": {
            "cpf": "000.000.000-00",
            "nome": "Nome do turista"
        },
        "status": "OK"
    })
})

app.get('/api/pedido/', (req, res) => {
    res.json({
        "response": {
            "cpf": "000.000.000-00",
            "nome": "Nome do turista"
        },
        "status": "OK"
    })
})
 
app.listen(8080)