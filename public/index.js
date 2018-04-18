/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      products: [],
      titleFilter: "",
      sortAttribute: "description"
    };
  },
  created: function() {
    axios.get("http://localhost:3000/products").then(
      function(response) {
        this.products = response.data;
        console.log(this.products);
      }.bind(this)
    );
  },
  methods: {
    isValidProduct: function(inputProduct) {
      return inputProduct.name.toLowerCase().includes(this.titleFilter); //???
    }
  },
  computed: {
    sortedProducts: function() {
      return this.products.sort(
        function(product1, product2) {
          // return product1.chef.localeCompare(product2.chef);
          var lowerAttribute1 = product1[this.sortAttribute].toLowerCase();
          var lowerAttribute2 = product2[this.sortAttribute].toLowerCase();
          return lowerAttribute1.localeCompare(lowerAttribute2);
        }.bind(this)
      );
    }
  }
};

var router = new VueRouter({
  routes: [{ path: "/", component: HomePage }],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router
});

// Exercise:
// Add buttons that sort your list by various attributes.

// Bonus: Add a "v" icon that shows up on the button corresponding to the currently sorted attribute. (Like the table at the bottom of this page: https://data.cityofchicago.org/Administration-Finance/Current-Employee-Names-Salaries-and-Position-Title/xzkq-xp2w) (
