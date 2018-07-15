<v-card>
  <v-toolbar card dark class="teal accent-4">
    <!-- <v-toolbar-items class="ml-5"> -->
    <v-btn-toggle v-model="activeBtn" class="teal accent-4 btn--flat">
      <v-btn flat large @click="shitonosc">Career</v-btn>
      <v-btn flat large>Teams</v-btn>
      <v-btn flat large>Opponents</v-btn>
    </v-btn-toggle>
    <!-- </v-toolbar-items> -->
  </v-toolbar>
  <v-container fluid grid-list-lg v-for="(value, key) in stats">
    <div class="subheading">{{ key }}</div>
    <v-layout row wrap>
      <v-flex xs3 v-for="(value, key) in value" class="text-xs-center">
        <div class="subheading">{{ key }}</div>
        <h4 class="teal--text text--accent-4">{{ value }}</h4>
      </v-flex>
    </v-layout>
    <v-divider></v-divider>
  </v-container>
</v-card>
