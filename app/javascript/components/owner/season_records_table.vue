<template lang="html">
  <v-data-table v-if="seasonRecords"
                id="season-records-table"
                :headers="season_headers"
                :items="seasonRecords"
                class="elevation-10"
                hide-actions
                dark>
    <template slot="items" scope="props">
      <td>{{ props.item.description }}</td>
      <td class="text-xs-right">{{ props.item.stat }}</td>
      <td class="text-xs-right">{{ props.item.year }}</td>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: ['seasonRecords'],
  data () {
    return {
      season_headers: [
        { text: 'DESCRIPTION', value: 'game', align: 'left', sortable: false },
        { text: 'STAT', value: 'stat', sortable: false },
        { text: 'YEAR', value: 'year', sortable: false }
      ]
    }
  }
}
</script>

<style scoped>
</style>
