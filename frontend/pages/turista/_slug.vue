<template>
  <section class="section">
    <div class="box">
      <div class="content">
        <h1 class="title is-3 is-spaced">{{ response.cpf }}</h1>
        <h2 class="subtitle is-5">{{ response.nome }}</h2>
      </div>
      <div class="buttons">
        <button class="button is-link">Adicionar turista no pedido</button>
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
    const response = await this.$axios.get(`/api/user/${this.$route.params.slug}`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>