// document ready
$(function(){
  if(window.location.pathname === "/categories") {
    getCategories();
  } else {
    getBeers(window.location.pathname);
    breweryFilterChange();
  }
  alert("the stuff from categories.js was loaded")
})

function breweryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#brewery').on("change", function(e){
    alert("you changed a brewery filter on /categories");
    e.preventDefault();
    let url = $("form").attr("action");
    let brewery = $("#brewery option:selected").val();
    let formData = {brewery: brewery}
    getBeers(url, formData);
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
