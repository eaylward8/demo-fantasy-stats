<template>
  <div id='owners-list-template'>
    <h1>Owners</h1>
    <h2>{{test}}</h2>
    <ol>
      <li v-for="owner in owners">{{ owner }}</li>
    </ol>
  </div>
</template>

<script>
export default {
  props: ['owners'],
  data: function () {
    return {
      test: 'test data'
    }
  }
}
</script>

<style scoped>
  
</style>
