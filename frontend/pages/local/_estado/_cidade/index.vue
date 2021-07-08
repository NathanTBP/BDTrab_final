<template>
  <section class="section">
    <div class="box">
      <b-image src="https://via.placeholder.com/1200x600" ratio="3by2" />
      <div class="content">
        <h1 class="title is-3 is-spaced">{{ response.nome }}</h1>
        <h2 class="subtitle is-5">{{ response.estado }}</h2>
        <p>
          {{ response.descricao }}
        </p>
      </div>
      <div class="buttons is-centered">
        <button class="button is-link">Adicionar cidade no pedido</button>
        <button class="button is-info">Visualizar Pontos Gastronômico</button>
        <button class="button is-warning">Visualizar hoteis</button>
        <button class="button is-success">Visualizar passagens</button>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      response: {}
    }
  },
  layout(context) {
    return "pages"
  },
  async created() {
    const response = await this.$axios.get(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>