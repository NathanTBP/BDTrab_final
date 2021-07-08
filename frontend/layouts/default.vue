<template>
  <div>
    <Nuxt />
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
          title: 'Inspire',
          icon: 'lightbulb',
          to: { name: 'inspire' }
        }
      ]
    }
  }
}
</script>
