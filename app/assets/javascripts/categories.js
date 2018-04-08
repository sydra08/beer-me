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

function getCategory(url) {
  $.get(url, function(data){
    console.log(data)
    let category = data;
    let filters = {category: category.id};
    $("#categoryName").text(category.name);
    $("#categoryLocation").text(category.location);
    $("#categoryDescription").text(category.description);
    // update data-id
    $("#categoryHeader").attr("data-id", category.id);
    getBeers(filters);
  })
}

function getCategories() {
  $.get("/categories", function(data){
    let categoryData = data;
    $('tbody').empty();
    categoryData.forEach(function(category){
      let categoryName = category.name;
      let categoryCount = category.beer_count;
      let categoryId = category.id;
      $('tbody').append(`<tr><td id="categoryName"><a href="/categories/${categoryId}">${categoryName}</a></td><td id="categoryCount">${categoryCount}</td></tr>`);
    })
  })
}
