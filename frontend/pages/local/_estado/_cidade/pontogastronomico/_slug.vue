<template>
  <section class="section">
    <div class="box">
      <b-image src="https://www.casamagalhaes.com.br/blog/wp-content/uploads/2018/01/dicas-para-gerir-um-pequeno-restaurante.jpg" ratio="5by3" />
      <div class="content">
        <h1 class="title is-3 is-spaced">{{ response.nome }}</h1>
        <h2 class="subtitle is-5">
          <span>
            <b-icon icon="star" />
          </span>
          <span>
            Avaliação dos clientes: {{ response.avaliacao }} / 5
          </span>
        </h2>
        <p>
          <strong>Endereço:</strong> {{ response.endereco }}
        </p>
        <p>
          <strong>Horário de funcionamento:</strong> {{ response.horario }}
        </p>
      </div>
      <div class="buttons is-centered">
        <NuxtLink :to="{ path: `/local/${$route.params.estado}/${$route.params.cidade}/pontogastronomico/${encodeURIComponent(this.$route.params.slug)}/adicionar/` }" class="button is-link">Adicionar ponto gastrônomico no pedido</NuxtLink>
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
    const response = await this.$axios.get(`/api/cidade/${this.$route.params.estado}/${this.$route.params.cidade}/pontos/${encodeURIComponent(this.$route.params.slug)}`)

    if (response.data.status === "OK") {
      this.response = response.data.response
    } else {
      // Redirect to error page s
    }

    // console.log(response)
  }
}
</script>