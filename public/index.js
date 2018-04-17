/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      products: []
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
  methods: {},
  computed: {}
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
// var productTemplate = document.querySelector("#product-card");
// var productContainer = document.querySelector(".row");

// axios.get("http://localhost:3000/products").then(function(response) {
//   var products = response.data;
//   console.log(products);

//   products.forEach(function(product) {
//     var productClone = productTemplate.content.cloneNode(true);

//     productClone.querySelector(".card-title").innerText = product.name;
//     productClone.querySelector(".card-img-top").src = product.images[0];
//     productContainer.appendChild(productClone);
//   });
// });
