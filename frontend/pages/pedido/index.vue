<template>
  <section class="section">
    <div class="box">
      <div class="content">
        <h1 class="title is-3 is-spaced">Informações sobre o seu pedido</h1>
        <h2 class="subtitle is-5">N° do pedido: #111111111</h2>
      </div>
    </div>
    <b-tabs expanded="true" type="is-toggle">
        <b-tab-item label="Pontos Gastrônomicos" icon="room-service">
          <div class="box">
            <h1 class="title is-4 is-spaced">Nome</h1>
            <span>Informações</span>
          </div>
          <div class="box">
            <h1 class="title is-4 is-spaced">Nome</h1>
            <span>Informações</span>
          </div>
        </b-tab-item>
        <b-tab-item label="Quartos" icon="bed">
          <div class="box">
            <h1 class="title is-4 is-spaced">N° do quarto / Preço</h1>
            <span>Informações</span>
          </div>
          <div class="box">
            <h1 class="title is-4 is-spaced">N° do quarto / Preço</h1>
            <span>Informações</span>
          </div>
        </b-tab-item>
        <b-tab-item label="Passagens" icon="airplane">
          <div class="box">
            <h1 class="title is-4 is-spaced">N° do assento / Preço</h1>
            <span>Informações</span>
          </div>
          <div class="box">
            <h1 class="title is-4 is-spaced">N° do assento / Preço</h1>
            <span>Informações</span>
          </div>
        </b-tab-item>
      </b-tabs>
    <div class="box">
      <div class="buttons">
        <button class="button is-link">Finalizar pedido</button>
        <button class="button is-danger">Deletar pedido</button>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  layout(context) {
    return "pages"
  }
}
</script>