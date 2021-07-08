<template>
  <section class="section">
    <div v-for="i in Math.ceil(response.length / 3)" :key="i" class="columns is-centered is-variable is-6 is-dektop has-text-centered">
      <div v-if="response[(i - 1) * 3]" class="column is-one-quarter">
        <Card :title="'N° ' + response[(i - 1) * 3].n" subtitleIcon="currency-usd" :subtitle="response[(i - 1) * 3].preco" :description="'Capacidade: ' + response[(i - 1) * 3].capacidade + ' / Tipo: ' + response[(i - 1) * 3].tipo" image="https://i0.wp.com/www.transamerica.com.br/blog/wp-content/uploads/2018/07/Esplanada-1.jpg?resize=870%2C576&ssl=1" :to="{ name: 'index'}" />
      </div>
      <div v-if="response[(i - 1) * 3 + 1]" class="column is-one-quarter">
        <Card :title="'N° ' + response[(i - 1) * 3 + 1].n" subtitleIcon="currency-usd" :subtitle="response[(i - 1) * 3 + 1].preco" :description="'Capacidade: ' + response[(i - 1) * 3 + 1 + 1].capacidade + ' / Tipo: ' + response[(i - 1) * 3 + 1].tipo" image="https://i0.wp.com/www.transamerica.com.br/blog/wp-content/uploads/2018/07/Esplanada-1.jpg?resize=870%2C576&ssl=1" :to="{ name: 'index'}" />
      </div>
      <div v-if="response[(i - 1) * 3 + 2]" class="column is-one-quarter">
        <Card :title="'N° ' + response[(i - 1) * 3 + 2].n" subtitleIcon="currency-usd" :subtitle="response[(i - 1) * 3 + 2].preco" :description="'Capacidade: ' + response[(i - 1) * 3 + 2 + 2].capacidade + ' / Tipo: ' + response[(i - 1) * 3 + 2].tipo" image="https://i0.wp.com/www.transamerica.com.br/blog/wp-content/uploads/2018/07/Esplanada-1.jpg?resize=870%2C576&ssl=1" :to="{ name: 'index'}" />
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
    const response = await this.$axios.get(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}/hotel/${this.$route.params.slug}`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>