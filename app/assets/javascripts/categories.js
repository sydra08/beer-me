// document ready
$(function(){
  getCategories();
  // if(window.location.pathname === "/categories") {
  //   getCategories();
  // } else {
  //   getBeers(window.location.pathname);
  //   breweryFilterChange();
  // }
  alert("the stuff from categories.js was loaded")
})

function breweryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#category').on("change", function(e){
    alert("you changed a filter");
    e.preventDefault();
    let url = $("form").attr("action");
    let category = $("#category option:selected").val();
    let formData = {category: category}
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
      $('tbody').append(`<tr><td id="categoryName"><a href="/breweries/${categoryId}">${categoryName}</a></td><td id="categoryCount">${categoryCount}</td></tr>`);
    })
  })
}
