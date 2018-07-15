<template lang="html">
  <div id="game-records">
    <page-header :heading="heading"
                 :selectItems="selectItems"
                 @recordSelected="setRecordData">
    </page-header>
    <v-card class="mb-3">
      <v-tabs dark v-model="activeTab">
        <v-toolbar card dark dense class="teal accent-4">
          <v-toolbar-title class="table-header">{{ recordHeading }}</v-toolbar-title>
          <v-tabs-bar class="teal accent-4">
            <v-tabs-item v-for="tab in tabs" :key="tab" :href="'#' + tab" ripple>
              {{ tab.toUpperCase() }}
            </v-tabs-item>
            <v-tabs-slider class="yellow"></v-tabs-slider>
          </v-tabs-bar>
        </v-toolbar>
        <v-tabs-items>
          <v-tabs-content v-for="tab in tabs" :key="tab" :id="tab">
            <game-records-table v-if="tab === activeTab"
                                :records="setTabData(activeTab)">
            </game-records-table>
          </v-tabs-content>
        </v-tabs-items>
      </v-tabs>
    </v-card>
  </div>
</template>

<script>
import PageHeader from '../shared/page_header.vue'
import GameRecordsTable from './game_records_table.vue'

export default {
  components: {
    PageHeader,
    GameRecordsTable
  },
  data() {
    return {
      heading: 'Game Records',
      selectItems: [
        { text: 'Points - Most', value: 'points_most' },
        { text: 'Points - Least', value: 'points_least' }
      ],
      recordHeading: 'Points - Most',
      tabs: ['all', 'reg season', 'playoffs'],
      records: null,
      activeTab: null
    }
  },
  methods: {
    setRecordData(data) {
      this.recordHeading = data.recordType
      this.records = data.records
    },
    setTabData(active_tab) {
      switch (active_tab) {
        case 'all':
          return this.records.all
        case 'reg season':
          return this.records.reg_season
        case 'playoffs':
          return this.records.playoffs
      }
    }
  }
}
</script>

<style scoped>
.table-header {
  width: 150px;
  min-width: 140px;
}
</style>
