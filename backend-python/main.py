from flask import Flask
import psycopg2
from psycopg2.extras import RealDictCursor
from flask import jsonify

app = Flask(__name__)

@app.route('/api/pais')
def getCountries():
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)

    cur.execute("""
    SELECT
        P.NOME as "nome",
        P.DESC_GAST as "descricao"
    FROM
        PAIS P;
    """)
    countries = [dict(row) for row in cur.fetchall()]

    return jsonify({
        "response": countries,
        "status": "OK"
    })

@app.route('/api/pais/<nome>')
def getCitiesFromCountry(nome):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        C.NOME_CIDADE as "nome",
        C.NOME_ESTADO as "estado",
        C.DESC_GAST as "descricao"
    FROM
        CIDADE C
    WHERE
        C.NOME_PAIS = '{}';
    """.format(nome))
    cities = [dict(row) for row in cur.fetchall()]

    print(cities)

    return jsonify({
        "response": cities,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>')
def getCity(estado, cidade):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
            C.NOME_CIDADE as "nome",
            C.NOME_ESTADO as "estado",
            C.DESC_GAST as "descricao"
        FROM
            CIDADE C
        WHERE
            C.NOME_ESTADO = %s AND C.NOME_CIDADE = %s;
    """, (estado, cidade))
    city = cur.fetchone()

    return jsonify({
        "response": city,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>/pontos/')
def getGastronomicSpotsFromCity(estado, cidade):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        EC.CNPJ as "cnpj",
        EC.NOME as "nome",
        CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
        CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
        EC.AVALIACAO as "avaliacao"
    FROM
        ESTABELECIMENTO_COMERCIAL EC
    WHERE
        EC.NOME_ESTADO = %s AND EC.NOME_CIDADE = %s AND EC.TIPO = 'PONTO';
    """, (estado, cidade))
    places = [dict(row) for row in cur.fetchall()]
    
    return jsonify({
        "response": places,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>/pontos/<path:cnpj>')
def getGastronomicSpot(estado, cidade, cnpj):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        EC.CNPJ as "cnpj",
        EC.NOME as "nome",
        CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
        CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
        EC.AVALIACAO as "avaliacao"
    FROM
        ESTABELECIMENTO_COMERCIAL EC
    WHERE
        EC.NOME_ESTADO = '{}' AND EC.NOME_CIDADE = '{}' AND EC.TIPO = 'PONTO' AND EC.CNPJ = '{}';
    """.format(estado, cidade, cnpj))
    place = [dict(row) for row in cur.fetchall()]
    
    return jsonify({
        "response": place,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>/hotel/')
def getHotelsFromCity(estado, cidade):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        EC.CNPJ as "cnpj",
        EC.NOME as "nome",
        CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
        CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
        EC.AVALIACAO as "avaliacao"
    FROM
        ESTABELECIMENTO_COMERCIAL EC
    WHERE
        EC.NOME_ESTADO = %s AND EC.NOME_CIDADE = %s AND EC.TIPO = 'HOTEL';
    """, (estado, cidade))
    hotels = [dict(row) for row in cur.fetchall()]
    
    return jsonify({
        "response": hotels,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>/hotel/<path:cnpj>')
def getRoomsFromHotel(estado, cidade, cnpj):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        Q.NUMERO_QUARTO as "n",
        Q.PRECO as "preco",
        Q.CAPACIDADE as "capacidade",
        Q.TIPO_QUARTO as "tipo"
    FROM
        QUARTO Q
    WHERE
        Q.CNPJ_HOTEL = '{}';
    """.format(cnpj))
    rooms = [dict(row) for row in cur.fetchall()]

    return jsonify({
        "response": rooms,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>/transporte/')
def getTransportsFromCity(estado, cidade):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
        SELECT
        EC.CNPJ as "cnpj",
        EC.NOME as "nome",
        CONCAT(EC.HORARIO_INICIO, ' - ', EC.HORARIO_FIM) as "horario",
        CONCAT(EC.RUA, ', ', EC.BAIRRO, ', ', EC.NUMERO, ' - ', EC.CEP) as "endereco",
        EC.AVALIACAO as "avaliacao"
    FROM
        ESTABELECIMENTO_COMERCIAL EC
    WHERE
        EC.NOME_ESTADO = %s AND EC.NOME_CIDADE = %s AND EC.TIPO = 'TRANSPORTE';
    """, (estado, cidade))
    transports = [dict(row) for row in cur.fetchall()]
    
    return jsonify({
        "response": transports,
        "status": "OK"
    })

@app.route('/api/cidade/<estado>/<cidade>/transporte/<path:cnpj>')
def getTicketsFromTransport(estado, cidade, cnpj):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
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
        P.CNPJ_TRANS = '{}'
    GROUP BY
        P.IDPASSAGEM;
    """.format(cnpj))
    tickets = [dict(row) for row in cur.fetchall()]

    return jsonify({
        "response": tickets,
        "status": "OK"
    })

@app.route('/api/user/')
def getUsers():
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        T.CPF as "cpf",
        T.NOME_TURISTA as "nome"
    FROM
        TURISTA T;
    """)

    users = [dict(row) for row in cur.fetchall()]

    return jsonify({
        "response": users,
        "status": "OK"
    })

@app.route('/api/user/<cpf>')
def getUser(cpf):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("""
    SELECT
        T.CPF as "cpf",
        T.NOME_TURISTA as "nome"
    FROM
        TURISTA T
    WHERE
        T.CPF = '{}';
    """.format(cpf))
    user = cur.fetchone()

    return jsonify({
        "response": user,
        "status": "OK"  
    })

@app.route('/api/pedido/<id>/<cpf>/')
def getItemsFromTravel(id, cpf):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    cur = conn.cursor(cursor_factory=RealDictCursor)

    cur.execute("""
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
    """)
    travel = cur.fetchone()

    cur.execute("""
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
    """)
    users = [dict(row) for row in cur.fetchall()]

    cur.execute("""
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
    """)
    rooms = [dict(row) for row in cur.fetchall()]

    cur.execute("""
    SELECT
        P.NOME as "nome",
        CONCAT(P.RUA, ', ', P.BAIRRO, ', ', P.NUMERO, ' - ', P.CEP) as "endereco"
    FROM
        PONTOS_VIAGEM V
    JOIN
        ESTABELECIMENTO_COMERCIAL P
    ON
        (V.CNPJ_ADICIONADO = P.CNPJ);
    """)
    places = [dict(row) for row in cur.fetchall()]

    cur.execute("""
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
    """)
    tickets = [dict(row) for row in cur.fetchall()]

    return jsonify({
        "response": {
            "pedido": travel,
            "turistas": users,
            "quartos": rooms,
            "pontos": places,
            "passagens": tickets
        },
        "status": "OK"
    })

@app.route('/api/pedido/<id>/<cpf>/adicionar/turista/<cpftoadd>', methods=['POST'])
def insertUser(id, cpf, cpftoadd):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    try:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("""
        INSERT INTO
            TURISTAS_VIAGEM (IDVIAGEM, CPF_ADICIONADO)
        VALUES
            ('1', '{}');
        """.format(cpftoadd))
        conn.commit()

        return jsonify({
            "status": "OK"
        })
    except:
        return jsonify({
            "status": "ERROR",
            "message": "Um erro aconteceu na sua requisição!"
        })

@app.route('/api/pedido/<id>/<cpf>/adicionar/quarto/<numeroQuarto>/<path:cpnj>', methods=['POST'])
def insertRoom(id, cpf, numeroQuarto, cpnj):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    try:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("""
        INSERT INTO
            QUARTOS_VIAGEM (IDVIAGEM, NUMERO_QUARTO, CNPJ_HOTEL)
        VALUES
            ('1', '{}', '{}');
        """.format(numeroQuarto, cpnj))
        conn.commit()

        return jsonify({
            "status": "OK"
        })
    except:
        return jsonify({
            "status": "ERROR",
            "message": "Um erro aconteceu na sua requisição!"
        })

@app.route('/api/pedido/<id>/<cpf>/adicionar/ponto/<path:cnpj>', methods=['POST'])
def insertGastronomicPoint(id, cpf, cnpj):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    try:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("""
        INSERT INTO
            PONTOS_VIAGEM (IDVIAGEM, CNPJ_ADICIONADO)
        VALUES
            ('1', '{}');
        """.format(cnpj))
        conn.commit()

        return jsonify({
            "status": "OK"
        })
    except:
        return jsonify({
            "status": "ERROR",
            "message": "Um erro aconteceu na sua requisição!"
        })
        

@app.route('/api/pedido/<id>/<cpf>/adicionar/passagem/<idPassagem>', methods=['POST'])
def insertTicket(id, cpf, idPassagem):
    conn = psycopg2.connect("dbname=postgres user=postgres password=Postgres123! port=5432 host=localhost")
    try:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("""
        INSERT INTO
            PASSAGENS_VIAGEM (IDVIAGEM, IDPASSAGEM)
        VALUES
            ('1', %s);
        """, (idPassagem))
        conn.commit()

        return jsonify({
            "status": "OK"
        })
    except:
        return jsonify({
            "status": "ERROR",
            "message": "Um erro aconteceu na sua requisição!"
        })