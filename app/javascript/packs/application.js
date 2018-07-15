/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'
import VueRouter from 'vue-router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import Vuetify from 'vuetify'
import('../../../node_modules/vuetify/dist/vuetify.min.css')

import App from './app.vue'
import Home from '../components/home/home.vue'
import SeasonRecords from '../components/record_book/season_records.vue'
import GameRecords from '../components/record_book/game_records.vue'
import OtherRecords from '../components/record_book/other_records.vue'
import Owner from '../components/owner/owner.vue'

Vue.use(VueRouter)
Vue.use(VueAxios, axios)
Vue.use(Vuetify)

const routes = [
  { path: '/', name: 'home', component: Home },
  { path: '/season_records', name: 'seasonRecords', component: SeasonRecords },
  { path: '/game_records', name: 'gameRecords', component: GameRecords },
  { path: '/other_records', name: 'otherRecords', component: OtherRecords },
  { path: '/owners/:id', name: 'owners', component: Owner, props: true },
]

const router = new VueRouter({ routes })

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('app')
  var props = JSON.parse(element.getAttribute('data'))

  new Vue({
    router,
    render: h => h(App, { props })
  }).$mount('#app');
})
