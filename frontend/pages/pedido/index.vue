<template>
  <section class="section">
    <div class="box">
      <div class="content">
        <h1 class="title is-3 is-spaced">Informações sobre o seu pedido</h1>
        <h2 class="subtitle is-5">N° do pedido: #1 - CPF Criador: 111.222.333-42</h2>
      </div>
    </div>
    <b-tabs expanded="true" type="is-toggle">
        <b-tab-item label="Pontos Gastrônomicos" icon="room-service">
          <div class="box" v-for="item in response.pontos" :key="item.nome">
            <h1 class="title is-4 is-spaced">{{ item.nome }}</h1>
            <p>
              <strong>Endereço:</strong>
              <span>{{ item.endereco }}</span>
            </p>
          </div>
        </b-tab-item>
        <b-tab-item label="Quartos" icon="bed">
          <div class="box" v-for="item in response.quartos" :key="item.n">
            <h1 class="title is-4 is-spaced">N° {{ item.n }} / $ {{ item.preco }}</h1>
            <p>
              <strong>Endereço do hotel:</strong>
              <span>{{ item.endereco }}</span>
            </p>
            <p>
              <strong>Tipo de quarto:</strong>
              <span>{{ item.tipo }}</span>
            </p>
            <p>
              <strong>Capacidade do quarto:</strong>
              <span>{{ item.capacidade }}</span>
            </p>
          </div>
        </b-tab-item>
        <b-tab-item label="Passagens" icon="airplane">
          <div class="box" v-for="item in response.passagens" :key="item.n">
            <h1 class="title is-4 is-spaced">N° {{ item.n }} / $ {{ item.preco }}</h1>
            <p>
              <strong>Horário:</strong>
              <span>{{ item.horario }}</span>
            </p>
            <p>
              <strong>Tipo:</strong>
              <span>{{ item.tipo }}</span>
            </p>
            <p>
              <strong>Data:</strong>
              <span>{{ item.data }}</span>
            </p>
            <p>
              <strong>Tipo:</strong>
              <span>{{ item.tipo }}</span>
            </p>
            <p>
              <strong>Passa por:</strong>
              <span>{{ item.passa_por }}</span>
            </p>
          </div>
        </b-tab-item>
        <b-tab-item label="Turistas" icon="account-group" v-for="item in response.turistas" :key="item.cpf">
          <div class="box">
            <h1 class="title is-4 is-spaced">{{ item.nome }}</h1>
          </div>
        </b-tab-item>
      </b-tabs>
    <div class="box">
      <div class="buttons">
        <button class="button is-link">Finalizar pedido</button>
        <button class="button is-danger">Deletar pedido</button>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      response: {
        pedido: {},
        turistas: [],
        quartos: [],
        pontos: [],
        passagens: []
      }
    }
  },
  layout(context) {
    return "pages"
  },
  async created() {
    const response = await this.$axios.get('/api/pedido/1/111.222.333-42/')

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>