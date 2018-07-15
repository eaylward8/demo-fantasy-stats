<template lang="html">
  <v-card class="mb-3">
    <v-tabs dark v-model="active">
      <v-toolbar card dark dense class="teal accent-4">
        <v-toolbar-title id="records-title">Records</v-toolbar-title>
        <v-tabs-bar class="teal accent-4">
          <v-tabs-item v-for="tab in tabs" :key="tab" :href="'#' + tab" ripple>
            {{ tab.toUpperCase() }}
          </v-tabs-item>
          <v-tabs-slider class="yellow"></v-tabs-slider>
        </v-tabs-bar>
      </v-toolbar>
      <v-tabs-items>
        <v-tabs-content v-for="tab in tabs" :key="tab" :id="tab">
          <game-records-table v-if="tab === 'game'" :gameRecords="gameRecords"></game-records-table>
          <season-records-table v-if="tab === 'season'" :seasonRecords="seasonRecords"></season-records-table>
        </v-tabs-content>
      </v-tabs-items>
    </v-tabs>
  </v-card>
</template>

<script>
import GameRecordsTable from './game_records_table.vue'
import SeasonRecordsTable from './season_records_table.vue'

export default {
  props: ['gameRecords', 'seasonRecords'],
  components: {
    GameRecordsTable,
    SeasonRecordsTable
  },
  data () {
    return {
      tabs: ['game', 'season'],
      active: null
    }
  }
}
</script>

<style scoped>
#records-title {
  width: 130px;
  min-width: 100px;
}
</style>
