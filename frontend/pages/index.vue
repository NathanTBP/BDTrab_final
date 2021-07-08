<template>
  <div>
    <section class="hero is-fullheight is-warning" v-bind:style="heroStyle">
      <div class="hero-head has-text-white-ter">
        <Navbar />
      </div>
      <div class="hero-body">
        <div class="container has-text-centered">
          <p class="title has-text-primary-light is-capitalized has-text-weight-bold is-size-1">
            Viagens para o mundo todo
          </p>
          <p class="subtitle has-text-grey-darker is-size-4">
            Organize viagens em grupos e conheça os melhores pontos gastrônomicos locais!
          </p>
        </div>
      </div>
      <div class="hero-foot">
      </div>
    </section>
    <section class="section">
      <div class="content is-uppercase has-text-weight-semibold">
        Viagens para lugares impressionantes
      </div>
      <div class="columns is-centered is-variable is-6 is-dektop has-text-centered">
        <div class="column is-one-quarter">
          <Card title="País" subtitle="Cidade" description="Descrição" image="https://bulma.io/images/placeholders/1280x960.png" :to="{ name: 'index'}" />
        </div>
        <div class="column is-one-quarter">
          <Card title="País" subtitle="Cidade" description="Descrição" image="https://bulma.io/images/placeholders/1280x960.png" :to="{ name: 'index'}" />
        </div>
        <div class="column is-one-quarter">
          <Card title="País" subtitle="Cidade" description="Descrição" image="https://bulma.io/images/placeholders/1280x960.png" :to="{ name: 'index'}" />
        </div>
      </div>
    </section>
    <Footer />
  </div>
</template>

<script>
export default {
  name: 'HomePage',
  data() {
    return {
      layout: 'home',
      heroStyle: {
        "background": "#eb01a5",
        "background-image": "linear-gradient(to bottom, rgba(245, 246, 252, 0.52), rgba(255, 221, 87, 0.73)), url(bg.jpg)",
        "background-size": "cover"
      }
    }
  }
}
</script>
