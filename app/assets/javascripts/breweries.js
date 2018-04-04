// document ready
$(function(){
  // make call to api when filter changes
  filterChange();
  // make the call to GET /beers
  // need to make sure that the getBeers() gets the right id on the page load
  getBreweries();
})

function filterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#categoryFilter').on("change", function(e){
    alert("you changed a filter");
    e.preventDefault();
    // need to capture the brewery too so that you have the id to pass to the controller
    let category = $("#category option:selected").val();
    let formData = {category: category}
    debugger
    console.log(formData)
  })
}

function getBreweries() {
  debugger
  $.get("/breweries", function(data){
    console.log(data);
    let breweryData = data;
    $('tbody').empty()
    breweryData.forEach(function(beer){
      let breweryName = beer.brewery.name;
      let breweryLocation = beer.brewery.location;
      // let beerName = beer.name;
      // let beerAbv = beer.abv;
      // let beerId = beer.id;
      // probably want to use a template here
      // this successfully adds all of the beers with the proper links
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
      })
    }
  })
}

// function getBeers(filters) {
//   $.ajax({
//     url: "/breweries",
//     data: filters
//   }).done(function(data){
//     // make the apply filter button active again
//     displayBeers(data);
//     // this isn't working again
//     // $('#applyFilter').prop('disabled', false);
//   });
// }
//
// function displayBeers(beerData) {
//   // clear out the beer list before you add new stuff to DOM so that filters work properly
//   $('tbody').empty()
//   // when the list is empty it should show you "no results"
//   if (beerData.length === 0) {
//     $('tbody').append("<tr><td><em>No results</em></td><td></td><td></td><td></td></tr>");
//   } else {
//     beerData.forEach(function(beer){
//       let breweryName = beer.brewery.name;
//       let breweryId = beer.brewery.location;
//       // let beerName = beer.name;
//       // let beerAbv = beer.abv;
//       // let beerId = beer.id;
//       // probably want to use a template here
//       // this successfully adds all of the beers with the proper links
//       $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}%</td></tr>`);
//     })
//   }
// }
