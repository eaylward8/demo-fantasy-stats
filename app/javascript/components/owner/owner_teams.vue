<template lang="html">
  <v-card class="mb-3">
    <v-toolbar card dark dense class="teal accent-4">
      <v-toolbar-title>Teams</v-toolbar-title>
    </v-toolbar>
    <v-data-table v-if="teamsData"
                  id="teams-table"
                  :headers="headers"
                  :items="teamsData"
                  :pagination.sync="pagination"
                  class="elevation-10"
                  dark>
      <template slot="items" scope="props">
        <td>{{ props.item.name }}</td>
        <td class="text-xs-right">{{ props.item.year }}</td>
        <td class="text-xs-right">{{ props.item.final_rank }}</td>
        <td class="text-xs-right">{{ props.item.wins }}</td>
        <td class="text-xs-right">{{ props.item.losses }}</td>
        <td class="text-xs-right">{{ props.item.points_for }}</td>
        <td class="text-xs-right">{{ props.item.points_against }}</td>
        <td class="text-xs-right" v-if="props.item.made_playoffs">Y</td>
        <td class="text-xs-right" v-else>N</td>
        <td class="text-xs-right">{{ props.item.moves }}</td>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
export default {
  props: ['teamsData'],
  data () {
    return {
      pagination: { descending: true, rowsPerPage: 5 },
      headers: [
        { text: 'NAME   ', align: 'left', value: 'name', sortable: false },
        { text: 'YEAR', value: 'year' },
        { text: 'FINAL RANK', value: 'final_rank' },
        { text: 'W', value: 'wins'},
        { text: 'L', value: 'losses' },
        { text: 'PF', value: 'points_for' },
        { text: 'PA', value: 'points_against' },
        { text: 'PLAYOFFS?', value: 'made_playoffs' },
        { text: 'MOVES', value: 'moves' }
      ]
    }
  }
}
</script>

<style scoped>
</style>
