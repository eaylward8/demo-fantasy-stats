<template>
  <v-card class="mb-3">
    <v-toolbar card dark dense class="teal accent-4">
      <v-toolbar-title>Career</v-toolbar-title>
    </v-toolbar>
      <v-data-table id="career-table" :headers="headers" :items="careerData" class="elevation-10" hide-actions dark>
        <template slot="items" scope="props">
          <td class="">{{ props.item.name }}</td>
          <td class="text-xs-right">{{ props.item.wins }}</td>
          <td class="text-xs-right">{{ props.item.losses }}</td>
          <td class="text-xs-right">{{ props.item.pct }}</td>
          <td class="text-xs-right">{{ props.item.avg_pts }}</td>
          <td class="text-xs-right">{{ props.item.margin }}</td>
        </template>
      </v-data-table>
  </v-card>
</template>

<script>
  export default {
    props: ['careerData'],
    data () {
      return {
        headers: [
          { value: 'type', sortable: false },
          { text: 'WINS', value: 'wins', sortable: false },
          { text: 'LOSSES', value: 'losses', sortable: false },
          { text: 'PCT', value: 'pct', sortable: false },
          { text: 'AVG PTS', value: 'avgPts', sortable: false },
          { text: 'AVG W/L MARGIN', value: 'margin', sortable: false }
        ]
      }
    }
  }
</script>

<style scoped>
#career-table {
  /*border: 1px solid grey;*/
}
</style>
