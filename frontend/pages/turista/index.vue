<template>
  <section class="section">
    <div v-for="i in Math.ceil(response.length / 3)" :key="i" class="columns is-centered is-variable is-6 is-dektop has-text-centered">
      <div v-if="response[(i - 1) * 3]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3].cpf" :subtitle="response[(i - 1) * 3].nome" description="" image="https://bulma.io/images/placeholders/1280x960.png" :to="{ name: 'index'}" />
      </div>
      <div v-if="response[(i - 1) * 3 + 1]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3 + 1].cpf" :subtitle="response[(i - 1) * 3 + 1].nome" description="" image="https://bulma.io/images/placeholders/1280x960.png" :to="{ name: 'index'}" />
      </div>
      <div v-if="response[(i - 1) * 3 + 2]" class="column is-one-quarter">
        <Card :title="response[(i - 1) * 3 + 2].cpf" :subtitle="response[(i - 1) * 3 + 2].nome" description="" image="https://bulma.io/images/placeholders/1280x960.png" :to="{ name: 'index'}" />
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
    const response = await this.$axios.get('/api/user/')

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>