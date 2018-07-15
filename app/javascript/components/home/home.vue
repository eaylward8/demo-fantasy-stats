<template>
  <div id="home">
    <page-header :heading="heading" :subheading="subheading"></page-header>
    <all-time-standings :standings="standings"></all-time-standings>
  </div>
</template>

<script>
import PageHeader       from '../shared/page_header.vue'
import AllTimeStandings from './all_time_standings.vue'

export default {
  components: {
    PageHeader,
    AllTimeStandings
  },
  data() {
    return {
      loading: false,
      heading: 'Demo Fantasy Football Stats',
      subheading: 'Fake names, real data scraped from Yahoo Fantasy league pages',
      standings: null
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      this.axios.get(`/api/standings`)
                .then((response) => {
                  this.loading = false
                  this.setData(response.data)
                }).catch((error) => {
                  console.log(error)
                })
    },
    setData(data) {
      this.standings = data
    }
  }
}
</script>

<style>
</style>
