<template lang="html">
  <v-data-table v-if="records"
                id="recordbook-game-records-table"
                :headers="headers"
                :items="records"
                :pagination.sync = "pagination"
                class="elevation-10"
                hide-actions
                dark>
    <template slot="items" scope="props">
      <td>{{ props.item.rank }}</td>
      <td>{{ props.item.owner }}</td>
      <td>{{ props.item.points }}</td>
      <td>{{ props.item.year }}</td>
      <td>{{ props.item.week }}</td>
      <td>{{ props.item.opponent }}</td>
    </template>
  </v-data-table>
</template>

<script>
export default {
  props: ['records'],
  data () {
    return {
      pagination: { descending: false, sortBy: 'rank', rowsPerPage: 25 },
      headers: [
        { text: 'RANK', value: 'rank', align: 'left'},
        { text: 'OWNER', value: 'owner', align: 'left' },
        { text: 'POINTS', value: 'points', align: 'left' },
        { text: 'YEAR', value: 'year', align: 'left' },
        { text: 'WEEK', value: 'week', align: 'left' },
        { text: 'OPPONENT', value: 'opponent', align: 'left' }
      ]
    }
  }
}
</script>

<style lang="css">
</style>
