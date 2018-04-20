// document ready
$(function(){
  if(window.location.pathname === "/categories") {
    getCategories();
    console.log("the stuff for categories#index was loaded");
  } else if (window.location.pathname.startsWith("/categories/")) {
    getCategory(window.location.pathname);
    prevCategoryBtn();
    nextCategoryBtn();
    breweryFilterChange();
    console.log("the stuff for categories#show was loaded");
  }
  console.log("the stuff from categories.js was loaded")
})

function prevCategoryBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked on previous category");
    let prevId = parseInt($("#categoryHeader").attr("data-id"))-1;
    let url = `/categories/${prevId}`;
    getCategory(url);
  });
}

function nextCategoryBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked on next category");
    let nextId = parseInt($("#categoryHeader").attr("data-id"))+1;
    let url = `/categories/${nextId}`;
    getCategory(url);
  });
}

function breweryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#brewery').on("change", function(e){
    alert("you changed a brewery filter on /categories");
    e.preventDefault();
    let category = $("#categoryHeader").attr("data-id");
    let brewery = $("#brewery option:selected").val();
    let formData = {category: category, brewery: brewery}
    getBeers(formData);
  })
}

function Category(attributes) {
  this.id = attributes.id;
  this.name = attributes.name;
  this.beerCount = attributes.beer_count;
  this.description = attributes.description;
}

Category.prototype.displayCategory = function() {
  console.log(this);
  $("#categoryName").text(this.name);
  $("#categoryLocation").text(this.location);
  $("#categoryDescription").text(this.description);
  // update data-id
  $("#categoryHeader").attr("data-id", this.id);
}

Category.prototype.categoryListDisplay = function() {
  console.log(this)
  $('tbody').append(`<tr><td id="categoryName"><a href="/categories/${this.id}">${this.name}</a></td><td id="categoryCount">${this.beerCount}</td></tr>`);
}

function getCategory(url) {
  $.get(url, function(data){
    console.log(data)
    let category = new Category(data);
    category.displayCategory();
    let filters = {category: category.id};
    getBeers(filters);
  })
}

function getCategories() {
  $.get("/categories", function(data){
    let categoryData = data;
    $('tbody').empty();
    categoryData.forEach(function(response){
      let category = new Category(response)
      category.categoryListDisplay();
    })
  })
}
