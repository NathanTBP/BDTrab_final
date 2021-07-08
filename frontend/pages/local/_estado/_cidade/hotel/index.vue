<template>
  <section class="section">
    <div v-for="i in Math.ceil(response.length / 3)" :key="i" class="columns is-centered is-variable is-6 is-dektop has-text-centered">
      <div v-if="response[(i - 1) * 3]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3].nome" subtitleIcon="star" :subtitle="response[(i - 1) * 3].avaliacao + ' / 5'" :description="response[(i - 1) * 3].horario + ' / ' + response[(i - 1) * 3].endereco" image="https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768" :to="{ name: 'index'}" />
      </div>
      <div v-if="response[(i - 1) * 3 + 1]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3 + 1].nome" subtitleIcon="star" :subtitle="response[(i - 1) * 3 + 1].avaliacao + ' / 5'" :description="response[(i - 1) * 3 + 1 + 1].horario + ' / ' + response[(i - 1) * 3 + 1].endereco" image="https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768" :to="{ name: 'index'}" />
      </div>
      <div v-if="response[(i - 1) * 3 + 2]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3 + 2].nome" subtitleIcon="star" :subtitle="response[(i - 1) * 3 + 2].avaliacao + ' / 5'" :description="response[(i - 1) * 3 + 2 + 2].horario + ' / ' + response[(i - 1) * 3 + 2].endereco" image="https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768" :to="{ name: 'index'}" />
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
    const response = await this.$axios.get(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}/hotel/`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>