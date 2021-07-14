<template>
  <section class="section">
    <div class="box">
      <div class="content">
        <h1 class="title is-3 is-spaced">{{ response.cpf }}</h1>
        <h2 class="subtitle is-5">{{ response.nome }}</h2>
      </div>
      <div class="buttons">
        <button class="button is-link" @click="adicionar">Adicionar turista no pedido</button>
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
    const response = await this.$axios.get(`/api/user/${encodeURIComponent(this.$route.params.slug)}`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      this.$buefy.toast.open(`Um erro aconteceu: ${response.data.message}`)
    }
  },
  methods: {
    async adicionar() {
      const response = await this.$axios.post(`/api/pedido/1/111.222.333-42/adicionar/turista/${encodeURIComponent(this.$route.params.slug)}`)

      if (response.data.status === "OK") {
        this.$router.push("/pedido/")
      } else {
        this.$buefy.toast.open(`Um erro aconteceu: ${response.data.message}`)
      }
    }
  }
}
</script>