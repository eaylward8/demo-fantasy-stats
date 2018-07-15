import Vue from 'vue'
import OwnersList from '../owners_list.vue'

document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById("owners-list")
  const props = JSON.parse(element.getAttribute('data'))
  console.log(props)
  if (element != null && props != null) {
    var ownersList = new Vue({
      el: '#owners-list',
      render: h => h(OwnersList, { props })
    })
  }

  console.log(ownersList)
})
