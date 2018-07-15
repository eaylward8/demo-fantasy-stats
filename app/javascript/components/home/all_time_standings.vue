<template>
  <v-card class="mb-3">
    <v-toolbar card dark dense class="teal accent-4">
      <v-toolbar-title>All-Time Standings</v-toolbar-title>
    </v-toolbar>
      <v-data-table v-if="standings"
                    id="all-time-standings"
                    :headers="headers"
                    :items="standings"
                    :pagination.sync="pagination"
                    class="elevation-10"
                    hide-actions dark>
        <template slot="items" scope="props">
          <td class="">{{ props.item.name }}</td>
          <td class="text-xs-right">{{ props.item.wins }}</td>
          <td class="text-xs-right">{{ props.item.losses }}</td>
          <td class="text-xs-right">{{ props.item.pct }}</td>
          <td class="text-xs-right">{{ props.item.first }}</td>
          <td class="text-xs-right">{{ props.item.second }}</td>
          <td class="text-xs-right">{{ props.item.third }}</td>
          <td class="text-xs-right">{{ props.item.points }}</td>
        </template>
      </v-data-table>
  </v-card>
</template>

<script>
  export default {
    props: ['standings'],
    data () {
      return {
        pagination: { descending: true, sortBy: 'points', rowsPerPage: 30 },
        headers: [
          { text: 'OWNER', value: 'name', sortable: false },
          { text: 'RS WINS', value: 'wins' },
          { text: 'RS LOSSES', value: 'losses' },
          { text: 'PCT', value: 'pct' },
          { text: '1ST', value: 'first' },
          { text: '2ND', value: 'second' },
          { text: '3RD', value: 'third' },
          { text: 'POINTS', value: 'points' }
        ]
      }
    }
  }
</script>

<style scoped>
</style>
