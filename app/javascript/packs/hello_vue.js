/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> and
// <%= stylesheet_pack_tag 'hello_vue' %> to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import Hello from './hello.vue'

document.addEventListener('DOMContentLoaded', () => {
  // Get the properties BEFORE the app is instantiated
  const element = document.getElementById('hello-vue')
  const props = JSON.parse(element.getAttribute('data'))

  // Render component with props
  new Vue({
    render: h => h(Hello, { props })
  }).$mount('#hello-vue');
})
