<template>
  <div id="owner">
    <div class="loading" v-if="loading">
      <v-progress-linear class="my-0"
                         :indeterminate="true"
                         height="5"
                         color-front="amber"
                         color-back="grey darken-4">
      </v-progress-linear>
    </div>
    <div :class="{ 'half-opacity': loading }">
      <owner-title :owner="owner"
                   :trophies="trophies"
                   :seasons="seasons"
                   :avgPts="avgPts"
                   :bestFinish="bestFinish"
                   :worstFinish="worstFinish">
      </owner-title>
      <owner-career :careerData="careerData"></owner-career>
      <owner-records :gameRecords="gameRecords" :seasonRecords="seasonRecords"></owner-records>
      <owner-teams :teamsData="teamsData"></owner-teams>
      <owner-opponents :opponentsData="opponentsData"></owner-opponents>
    </div>
  </div>
</template>

<script>
import OwnerTitle     from './owner_title.vue'
import OwnerCareer    from './owner_career.vue'
import OwnerRecords   from './owner_records.vue'
import OwnerTeams     from './owner_teams.vue'
import OwnerOpponents from './owner_opponents.vue'

export default {
  props: ['id'],
  components: {
    OwnerTitle,
    OwnerCareer,
    OwnerRecords,
    OwnerTeams,
    OwnerOpponents
  },
  data() {
    return {
      loading: false,
      error: null,
      owner: null,
      trophies: null,
      seasons: null,
      avgPts: null,
      bestFinish: null,
      worstFinish: null,
      careerData: [],
      gameRecords: null,
      seasonRecords: null,
      teamsData: null,
      opponentsData: null
    }
  },
  created() {
    this.fetchData(this.id)
  },
  beforeRouteUpdate(to, from, next) {
    this.fetchData(to.params.id)
    next()
  },
  methods: {
    fetchData(id) {
      // this.error = this.post = null
      this.loading = true
      this.axios.get(`/api/owners/${id}`)
                .then((response) => {
                  this.loading = false
                  this.setData(response.data)
                }).catch((error) => {
                  console.log(error)
                })
    },
    setData(data) {
      this.owner         = data.title.name
      this.trophies      = data.title.trophies
      this.seasons       = data.title.seasons
      this.bestFinish    = data.title.best_finish
      this.worstFinish   = data.title.worst_finish
      this.careerData    = data.career
      this.gameRecords   = data.records.game
      this.seasonRecords = data.records.season
      this.teamsData     = data.teams
      this.opponentsData = data.opponents
    }
  }
}
</script>

<style scoped>
.outline-card {
  /*border-bottom: 3px solid #00BFA5;*/
}
.half-opacity {
  opacity: 0.5;
}
</style>
