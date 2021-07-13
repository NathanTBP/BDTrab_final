<template>
  <section class="section">
    <div v-for="i in Math.ceil(response.length / 3)" :key="i" class="columns is-centered is-variable is-6 is-dektop has-text-centered">
      <div v-if="response[(i - 1) * 3]" class="column is-one-quarter">
        <Card :title="'N° ' + response[(i - 1) * 3].n + ' - ' + response[(i - 1) * 3].horario" subtitleIcon="currency-usd" :subtitle="response[(i - 1) * 3].preco" :description="'Tipo: ' + response[(i - 1) * 3].tipo + ' / Passa por: ' + response[(i - 1) * 3].passa_por + '. Data: ' + response[(i - 1) * 3].data" image="https://mediastorage.cnnbrasil.com.br/IMAGES/00/00/01/13045_ED4975BA0518D4EA.jpg" :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/${encodeURIComponent($route.params.slug)}/adicionar/${encodeURIComponent(response[(i - 1) * 3].id)}` }" />
      </div>
      <div v-if="response[(i - 1) * 3 + 1]" class="column is-one-quarter">
        <Card :title="'N° ' + response[(i - 1) * 3 + 1].n + ' - ' + response[(i - 1) * 3 + 1].horario" subtitleIcon="currency-usd" :subtitle="response[(i - 1) * 3 + 1].preco" :description="'Tipo: ' + response[(i - 1) * 3 + 1 + 1].tipo + ' / Passa por: ' + response[(i - 1) * 3 + 1].passa_por + '. Data: ' + response[(i - 1) * 3 + 1].data" image="https://mediastorage.cnnbrasil.com.br/IMAGES/00/00/01/13045_ED4975BA0518D4EA.jpg" :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/${encodeURIComponent($route.params.slug)}/adicionar/${encodeURIComponent(response[(i - 1) * 3 + 1].id)}` }" />
      </div>
      <div v-if="response[(i - 1) * 3 + 2]" class="column is-one-quarter">
        <Card :title="'N° ' + response[(i - 1) * 3 + 2].n + ' - ' + response[(i - 1) * 3 + 2].horario" subtitleIcon="currency-usd" :subtitle="response[(i - 1) * 3 + 2].preco" :description="'Tipo: ' + response[(i - 1) * 3 + 2].tipo + ' / Passa por: ' + response[(i - 1) * 3 + 2].passa_por + '. Data: ' + response[(i - 1) * 3 + 2].data" image="https://mediastorage.cnnbrasil.com.br/IMAGES/00/00/01/13045_ED4975BA0518D4EA.jpg" :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/transporte/${encodeURIComponent($route.params.slug)}/adicionar/${encodeURIComponent(response[(i - 1) * 3 + 2].id)}` }" />
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
    const response = await this.$axios.get(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}/transporte/${encodeURIComponent(this.$route.params.slug)}`)

    console.log(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}/transporte/${encodeURIComponent(this.$route.params.slug)}`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>