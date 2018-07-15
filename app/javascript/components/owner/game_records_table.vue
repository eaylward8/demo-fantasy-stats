<template lang="html">
  <v-data-table v-if="gameRecords"
                id="game-records-table"
                :headers="game_headers"
                :items="gameRecords"
                class="elevation-10"
                hide-actions
                dark>
    <template slot="items" scope="props">
      <td>{{ props.item.description }}</td>
      <td class="text-xs-right">{{ props.item.stat }}</td>
      <td class="text-xs-right">{{ props.item.week }}</td>
      <td class="text-xs-right">{{ props.item.year }}</td>
      <td class="text-xs-right">{{ props.item.opponent }}</td>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: ['gameRecords'],
  data () {
    return {
      game_headers: [
        { text: 'DESCRIPTION', value: 'game', align: 'left', sortable: false },
        { text: 'STAT', value: 'stat', sortable: false },
        { text: 'WEEK', value: 'week', sortable: false },
        { text: 'YEAR', value: 'year', sortable: false },
        { text: 'OPPONENT', value: 'year', sortable: false }
      ]
    }
  }
}
</script>

<style scoped>
</style>
