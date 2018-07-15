<template lang="html">
  <v-card class="mb-3">
    <v-toolbar card dark dense class="teal accent-4">
      <v-toolbar-title>Opponents</v-toolbar-title>
    </v-toolbar>
    <v-data-table v-if="opponentsData"
                  id="career-table"
                  :headers="headers"
                  :items="opponentsData"
                  :pagination.sync="pagination"
                  class="elevation-10"
                  dark>
      <template slot="items" scope="props">
        <td>{{ props.item.name }}</td>
        <td class="text-xs-right">{{ props.item.total_w }}</td>
        <td class="text-xs-right">{{ props.item.total_l }}</td>
        <td class="text-xs-right">{{ props.item.reg_w }}</td>
        <td class="text-xs-right">{{ props.item.reg_l }}</td>
        <td class="text-xs-right">{{ props.item.pl_w }}</td>
        <td class="text-xs-right">{{ props.item.pl_l }}</td>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
export default {
  props: ['opponentsData'],
  data () {
    return {
      pagination: { descending: true, rowsPerPage: 5 },
      headers: [
        { text: 'OPPONENT', align: 'left', value: 'opponent', sortable: false },
        { text: 'TOTAL W', value: 'total_w'},
        { text: 'TOTAL L', value: 'total_l'},
        { text: 'REG W', value: 'reg_w' },
        { text: 'REG L', value: 'reg_l' },
        { text: 'PL W', value: 'pl_w' },
        { text: 'PL L', value: 'pl_l' }
      ]
    }
  }
}
</script>

<style scoped>
</style>
