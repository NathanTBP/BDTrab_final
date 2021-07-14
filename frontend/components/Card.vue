<template>
  <div class="card">
    <div class="card-image" v-if="image">
      <figure class="image is-4by3">
        <img :src="image" />
      </figure>
    </div>
    <div class="card-content">
      <p class="title is-4">
        {{ title }}
      </p>
      <p class="subtitle is-6">
        <span v-if="subtitleIcon">
          <b-icon :icon="subtitleIcon" size="is-small" />
        </span>
        <span>
          {{ subtitle }}
        </span>
      </p>
      <p>
        {{ description }} 
      </p>
    </div>
    <div class="card-footer" v-if="to">
      <NuxtLink class="card-footer-item" :to="to">
        Ir para página
      </NuxtLink>
    </div>
    <div class="card-footer" v-else-if="buttonOn">
      <a class="card-footer-item" @click="clicked">Adicionar</a>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true
    },
    subtitle: {
      type: String,
      required: true
    },
    subtitleIcon: {
      type: String,
      required: false
    },
    description: {
      type: String,
      required : true
    },
    image: {
      type: String,
      required: false
    },
    to: {
      type: Object,
      required: false
    },
    buttonOn: {
      type: Boolean,
      required: false
    }
  },
  methods: {
    clicked() {
      this.$emit("clicked");
    }
  }
}
</script>
