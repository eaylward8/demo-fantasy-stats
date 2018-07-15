<template>
  <v-card class="mt-2 mb-3">
    <h3 class="amber--text text-xs-center mb-0 py-3 px-1">
      <strong>{{heading}}</strong>
    </h3>
    <v-card-text v-if="subheading" class="pt-0 text-xs-center">
      <span class="subheading">{{subheading}}</span>
    </v-card-text>
    <v-layout row justify-center v-if="selectItems">
      <v-flex xs6 sm3 xl2>
        <v-select v-bind:items="selectItems"
                  v-model="select"
                  @input="fetchData($event)"
                  label="Select"
                  return-object
                  dark>
        </v-select>
      </v-flex>
    </v-layout>
  </v-card>
</template>

<script>
export default {
  props: ['heading', 'subheading', 'selectItems'],
  data() {
    return {
      defaultRecord: { text: 'Points - Most', value: 'points_most' },
      select: { text: 'Points - Most', value: 'points_most' }
    }
  },
  created() {
    this.fetchData(this.defaultRecord)
  },
  methods: {
    fetchData(recordType) {
      this.axios.get(`api/game_records/${recordType.value}`)
                .then((response) => {
                  this.$emit('recordSelected', { records: response.data, recordType: recordType.text })
                }).catch((error) => {
                  console.log(error)
                })
    }
  }
}
</script>

<style lang="css">
.input-group--focused label,
.input-group--focused i,
.list__tile--active {
  color: #00BFA5 !important;
}

.input-group--focused .input-group__details:after {
  background-color: #00BFA5 !important;
}
</style>
