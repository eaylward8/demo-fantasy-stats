<template>
  <v-card class="mt-2 mb-3 outline-card">
    <v-container fluid grid-list-md>
      <v-layout row wrap>
        <v-flex xs12 sm12 md5>
          <v-card-title class="pr-0 pb-0 mt-2">
            <h4 class="mb-0 mr-4">{{ owner }}</h4>
            <div v-if="trophies" class="d-flex">
              <v-avatar size="24px" class="mx-1 yellow darken-3">
                <span class="white--text">{{ trophies.first }}</span>
              </v-avatar>
              <v-avatar size="24px" class="mx-1 grey">
                <span class="white--text">{{ trophies.second }}</span>
              </v-avatar>
              <v-avatar size="24px" class="mx-1 deep-orange darken-4">
                <span class="white--text">{{ trophies.third }}</span>
              </v-avatar>
            </div>
          </v-card-title>
        </v-flex>
        <!-- TODO: display via loop -->
        <v-flex xs4 md2 class="mt-2">
          <div>
            <div class="text-xs-center">SEASONS</div>
            <div><h4 class="text-xs-center amber--text">{{ seasons }}</h4></div>
          </div>
        </v-flex>
        <v-flex xs4 md2 class="mt-2">
          <div>
            <div class="text-xs-center">BEST FINISH</div>
            <div><h4 class="text-xs-center amber--text">{{ bestFinish }}</h4></div>
          </div>
        </v-flex>
        <v-flex xs4 md2 class="mt-2">
          <div>
            <div class="text-xs-center">WORST FINISH</div>
            <div><h4 class="text-xs-center amber--text">{{ worstFinish }}</h4></div>
          </div>
        </v-flex>
      </v-layout>
    </v-container>
  </v-card>
</template>

<script>
export default {
  props: ['owner', 'trophies', 'seasons', 'avgPts', 'bestFinish', 'worstFinish']
}
</script>

<style scoped>
</style>
