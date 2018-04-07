// document ready
$(function(){
  if(window.location.pathname === "/breweries") {
    getBreweries();
  } else {
    getBeers(window.location.pathname);
    categoryFilterChange();
  }
  console.log("the stuff from breweries.js was loaded")
})

function categoryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#category').on("change", function(e){
    alert("you changed a category filter on /breweries");
    e.preventDefault();
    let url = $("form").attr("action");
    let category = $("#category option:selected").val();
    let formData = {category: category}
    getBeers(url, formData);
  })
}

function getBreweries() {
  $.get("/breweries", function(data){
    let breweryData = data;
    $('tbody').empty();
    breweryData.forEach(function(brewery){
      let breweryName = brewery.name;
      let breweryLocation = brewery.location;
      let breweryId = brewery.id;
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
    })
  })
}
