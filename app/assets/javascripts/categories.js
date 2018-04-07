// document ready
$(function(){
  if(window.location.pathname === "/categories") {
    getCategories();
    console.log("the stuff for categories#index was loaded");
  } else if (window.location.pathname.startsWith("/categories/")) {
    getBeers(window.location.pathname);
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
    $.get("/categories/" + prevId, function(data){
      debugger
      console.log(data);
      let url = `/categories/${prevId}`;
      $("#categoryName").text(data[0].category.name);
      $("#categoryDescription").text(data[0].category.description);
      // update data-id
      $("#categoryHeader").attr("data-id", prevId)
      getBeers(url);
    })
  });
}

function nextCategoryBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked on next category");
    let nextId = parseInt($("#categoryHeader").attr("data-id"))+1;
    $.get("/categories/" + nextId, function(data){
      debugger
      console.log(data);
      // the data that's being returned includes everything - want to constrain so that it's just about breweries
      let url = `/categories/${nextId}`;
      $("#categoryName").text(data[0].category.name);
      $("#categoryDescription").text(data[0].category.description);
      // update data-id
      $("#categoryHeader").attr("data-id", nextId)
      getBeers(url);
    })
  });
}

function breweryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#brewery').on("change", function(e){
    alert("you changed a brewery filter on /categories");
    e.preventDefault();
    let url = `/categories/${$("#categoryHeader").attr("data-id")}`;
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
