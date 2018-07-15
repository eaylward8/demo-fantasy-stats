<template>
  <v-app dark>
    <v-navigation-drawer class="" persistent v-model="drawer" enable-resize-watcher clipped>
      <v-list dense>
        <v-list-group v-for="item in navItems" v-bind:key="item.title">
          <v-list-tile slot="item" @click="navigateTo(item)" ripple>
            <v-list-tile-action>
              <v-icon class="list-action-icon">{{ item.action }}</v-icon>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title class="subheading">{{ item.title }}</v-list-tile-title>
            </v-list-tile-content>
            <v-list-tile-action v-if="item.subItems.length > 0">
              <v-icon>keyboard_arrow_down</v-icon>
            </v-list-tile-action>
          </v-list-tile>
          <a v-for="subItem in item.subItems" v-bind:key="subItem.id">
            <v-list-tile @click="navigateTo(subItem)" ripple>
              <v-list-tile-content>
                <v-list-tile-title class="subheading">{{ subItem.name || subItem.year }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </a>
        </v-list-group>
      </v-list>
    </v-navigation-drawer>
    <v-toolbar dark fixed>
      <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
      <v-toolbar-title>812 Fantasy Football Stats</v-toolbar-title>
    </v-toolbar>
    <main>
      <v-container fluid>
        <router-view></router-view>
      </v-container>
    </main>
  </v-app>
</template>

<script>
  import Hello from './hello.vue'

  export default {
    // A child component needs to explicitly declare
    // the props it expects to receive using the props option
    // See https://vuejs.org/v2/guide/components.html#Props
    props: ['owners', 'seasons'],
    components: {
      Hello
    },
    data () {
      return {
        drawer: true,
        navItems: [
          {
            action: 'home',
            title: 'Home',
            route: 'home',
            subItems: []
          },
          {
            action: 'star',
            title: 'Record Book',
            subItems: [
              {
                id: 'season',
                name: 'Season',
                route: 'seasonRecords'
              },
              {
                id: 'game',
                name: 'Game',
                route: 'gameRecords'
              },
              {
                id: 'other',
                name: 'Other',
                route: 'otherRecords'
              }
            ]
          },
          {
            action: 'people',
            title: 'Owners',
            subItems: this.owners
          },
          {
            action: 'date_range',
            title: 'Seasons',
            subItems: this.seasons
          }
        ]
      }
    },
    methods: {
      navigateTo (item) {
        if (item.route) {
          this.$router.push({ name: item.route })
        } else if (item.name) {
          this.$router.push({ name: 'owners', params: { id: item.id }})
        } else if (item.year) {
          console.log(item.year)
        }
      },
    }
  }
</script>

<style scoped>
.list--group__header--active .list-action-icon {
  color: #00BFA5 !important;
}
</style>
