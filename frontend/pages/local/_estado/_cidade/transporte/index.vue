<template>
  <section class="section">
    <div v-for="i in Math.ceil(response.length / 3)" :key="i" class="columns is-centered is-variable is-6 is-dektop has-text-centered">
      <div v-if="response[(i - 1) * 3]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3].nome" subtitleIcon="star" :subtitle="response[(i - 1) * 3].avaliacao + ' / 5'" :description="response[(i - 1) * 3].horario + ' / ' + response[(i - 1) * 3].endereco" image="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGxhbmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80" :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/${encodeURIComponent(response[(i - 1) * 3].cnpj)}` }" />
      </div>
      <div v-if="response[(i - 1) * 3 + 1]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3 + 1].nome" subtitleIcon="star" :subtitle="response[(i - 1) * 3 + 1].avaliacao + ' / 5'" :description="response[(i - 1) * 3 + 1 + 1].horario + ' / ' + response[(i - 1) * 3 + 1].endereco" image="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGxhbmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80" :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/${encodeURIComponent(response[(i - 1) * 3 + 1].cnpj)}` }" />
      </div>
      <div v-if="response[(i - 1) * 3 + 2]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3 + 2].nome" subtitleIcon="star" :subtitle="response[(i - 1) * 3 + 2].avaliacao + ' / 5'" :description="response[(i - 1) * 3 + 2 + 2].horario + ' / ' + response[(i - 1) * 3 + 2].endereco" image="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGxhbmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80" :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/${encodeURIComponent(response[(i - 1) * 3 + 2].cnpj)}` }" />
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      response: []
    }
  },
  layout(context) {
    return "pages"
  },
  async created() {
    const response = await this.$axios.get(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}/transporte/`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>