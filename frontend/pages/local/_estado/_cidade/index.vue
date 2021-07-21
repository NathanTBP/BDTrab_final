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
        <NuxtLink :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/pontogastronomico/` }" class="button is-info">Visualizar Pontos Gastronômico</NuxtLink>
        <NuxtLink :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/hotel/` }" class="button is-warning">Visualizar hoteis</NuxtLink>
        <NuxtLink :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/` }" class="button is-success">Visualizar companhias de transporte</NuxtLink>
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