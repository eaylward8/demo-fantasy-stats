<template>
  <div id="hello-vue-template">
    <!-- <p>{{test}} {{message}} {{name}}</p>
    <p>Props: {{this.$props}}</p> -->
    <p>What the fuck</p>
    <ul v-for="owner in ownerArr" v-bind:key="owner.id">
      <li>{{ owner.name }}</li>
    </ul>
    <!-- <other-component></other-component> -->
  </div>
</template>

<script>
  // import child components here
  // import OtherComponent from './OtherComponent.vue'

  export default {
    props: ['message', 'name', 'owners'],
    data () {
      return {
        test: 'Here is a message for u:',
        ownerArr: this.owners
      }
    },
    components: {
      // list child components here
      //OtherComponent
    }
  }
</script>

<style scoped>
p {
  font-size: 3em;
}
</style>
