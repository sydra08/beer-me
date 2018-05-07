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
    console.log("you clicked on previous category");
    const prevId = parseInt($("#categoryHeader").attr("data-id"))-1;
    const url = `/categories/${prevId}.json`;
    getCategory(url);
  });
}

function nextCategoryBtn(){
  $(".js-next").on("click", function(){
    console.log("you clicked on next category");
    const nextId = parseInt($("#categoryHeader").attr("data-id"))+1;
    const url = `/categories/${nextId}.json`;
    getCategory(url);
  });
}

function breweryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#brewery').on("change", function(e){
    console.log("you changed a brewery filter on /categories");
    e.preventDefault();
    const category = $("#categoryHeader").attr("data-id");
    const brewery = $("#brewery option:selected").val();
    const formData = {category: category, brewery: brewery}
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
  // console.log(this);
  $("#categoryName").text(this.name);
  $("#categoryLocation").text(this.location);
  if(this.description === "" || this.description === null) {
    $("#categoryDescription").text("Description not available");
  } else {
    $("#categoryDescription").text(this.description);
  }
  // update data-id
  $("#categoryHeader").attr("data-id", this.id);
  $(".showMessage").hide();
}

Category.prototype.categoryListDisplay = function() {
  // console.log(this)
  $('tbody').append(`<tr><td id="categoryName"><a href="/categories/${this.id}">${this.name}</a></td><td id="categoryCount">${this.beerCount}</td></tr>`);
}

function getCategory(url) {
  $.get(url, function(data){
    // console.log(data)
  })
  .success(function(categoryData){
    console.log("success")
    const category = new Category(categoryData);
    category.displayCategory();
    const filters = {category: category.id};
    getBeers(filters);
  })
  .fail(function(response){
    console.log("fail")
    $(".showMessage").show().delay(5000).fadeOut();
  });
}

function getCategories() {
  $.get("/categories.json", function(data){
    const categoryData = data;
    $('tbody').empty();
    categoryData.forEach(function(response){
      const category = new Category(response)
      category.categoryListDisplay();
    })
  })
}
