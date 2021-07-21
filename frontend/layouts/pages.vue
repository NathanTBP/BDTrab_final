<template>
  <div>
    <Navbar />

    <section class="main-content columns">
      <aside class="column is-2 section">
        <p class="menu-label is-hidden-touch">
          Navegação
        </p>
        <ul class="menu-list">
          <li
            v-for="(item, key) of items"
            :key="key"
          >
            <NuxtLink
              :to="item.to"
              exact-active-class="is-active"
            >
              <b-icon :icon="item.icon" /> {{ item.title }}
            </NuxtLink>
          </li>
        </ul>
      </aside>

      <div class="container column is-10">
        <Nuxt />
      </div>
    </section>

    <Footer />
  </div>
</template>

<script>
export default {
  data () {
    return {
      navbar: {
        items: [
          {
            title: "Home",
            to: { name: 'index' }
          }
        ]
      },
      items: [
        {
          title: 'Home',
          icon: 'home',
          to: { name: 'index' }
        },
        {
          title: 'Países',
          icon: 'map-search-outline',
          to: { path: '/pais/' }
        },
        {
          title: 'Turistas',
          icon: 'account-multiple',
          to: { path: '/turista/' }
        }
      ]
    }
  }
}
</script>