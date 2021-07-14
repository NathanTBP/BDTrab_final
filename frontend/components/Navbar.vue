<template>
  <b-navbar type="is-warning">
    <template #brand>
          <b-navbar-item tag="router-link" :to="{ name: 'index' }" transparent="true">
              UMA LOGO AQUI
          </b-navbar-item>
      </template>
      <template #start>
          <b-navbar-item v-for="(item, key) in items" :key="key" tag="NuxtLink" :to="item.to">
            <b-icon :icon="item.icon" />
            <span>
              {{ item.title }}
            </span>
          </b-navbar-item>
      </template>
      <template #end>
          <b-navbar-item tag="NuxtLink" :to="{ path: '/pedido/' }">
            <b-icon icon="cart" />
            <span>
              Pedido
            </span>
          </b-navbar-item>
      </template>
  </b-navbar>
</template>

<script>
export default {
  data() {
    return {
      items: [
        {
          title: "Página Inicial",
          icon: "home",
          to: { name: 'index' }
        },
        {
          title: "Viajar",
          icon: "map-marker",
          to: { path: '/pais/' }
        }
      ]
    }
  }
}
</script>
