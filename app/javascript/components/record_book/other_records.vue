<template lang="html">
  <page-header :heading="heading"></page-header>
</template>

<script>
import PageHeader from '../shared/page_header.vue'

export default {
  components: {
    PageHeader
  },
  data() {
    return {
      heading: 'Other Records'
    }
  }
}
</script>

<style lang="css">
</style>
