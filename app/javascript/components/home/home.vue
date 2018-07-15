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
      heading: '812 Fantasy Football Stats',
      subheading: 'Historical data since keeper league formation in 2012.',
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
