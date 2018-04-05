// document ready
$(function(){
  // this doesn't even hit debugger when you load the page
  // make call to api when filter changes
  categoryFilterChange();
  // make the call to GET /beers
  // need to make sure that the getBeers() gets the right id on the page load
  getBreweries();
  alert("the stuff from breweries.js was loaded")
})

function categoryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#category').on("change", function(e){
    alert("you changed a filter");
    e.preventDefault();
    // debugger
    // need to capture the brewery too so that you have the id to pass to the controller
    let url = $("form").attr("action")
    let category = $("#category option:selected").val();
    let formData = {category: category}
    getBeers(url, formData);
  })
}

function getBreweries() {
  $.get("/breweries", function(data){
    let breweryData = data;
    $('tbody').empty()
    breweryData.forEach(function(brewery){
      let breweryName = brewery.name;
      let breweryLocation = brewery.location;
      let breweryId = brewery.id
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
    })
  })
}

function getBeers(url, category) {
  alert("getBeers was called from categoryFilterChange")
  $.ajax({
    url: url,
    data: category
  }).done(function(data){
    // make the apply filter button active again
    displayBeers(data);
  });
}
//
function displayBeers(beerData) {
  // clear out the beer list before you add new stuff to DOM so that filters work properly
  $('tbody').empty()
  // when the list is empty it should show you "no results"
  if (beerData.length === 0) {
    $('tbody').append("<tr><td><em>No results</em></td><td></td><td></td></tr>");
  } else {
    beerData.forEach(function(beer){
      // let breweryName = beer.brewery.name;
      // let breweryId = beer.brewery.location;
      let beerName = beer.name;
      let beerAbv = beer.abv;
      let beerId = beer.id;
      // probably want to use a template here
      // this successfully adds all of the beers with the proper links
      $('tbody').append(`<tr><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}%</td></tr>`);
    })
  }
}
