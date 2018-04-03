// document ready
$(function(){
  // attach event to All Beers in nav - may remove this
  allBeersBtn();
  // attach event to apply filter button
  // applyFilterBtn();
  filterChange();
  // make the call to GET /beers
  getBeers();
})

function allBeersBtn() {
  // when you click on the button it invokes getBeers()
  $('#beers').on("click", function(e){
    alert("you clicked on all beers")
    e.preventDefault();
    // should I reset the filter buttons here just in case you click here after applying a filter?
    getBeers();
  })
}

function applyFilterBtn() {
  // submitting a form now so handle it that way
  $('#beerFilter').on("submit", function(e){
    alert("you clicked on apply filter")
    // without this the filters don't work properly
    e.preventDefault();
    // use option:selected to get the value (aka ID) for the selected filters to send with the request
    let brewery = $("#brewery option:selected").val();
    let category = $("#category option:selected").val();
    let formData = {category: category, brewery: brewery}
    // need to capture the data from the form here
    // need to make sure to pass through the filter param
    // console.log(formData)
    getBeers(formData);
  });
  // category filters are still broken for some reason but brewery filters are fine
  // should the filters go back to default or should they
}

function filterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#beerFilter').on("change", function(e){
    alert("you changed a filter");
    e.preventDefault();
    let brewery = $("#brewery option:selected").val();
    let category = $("#category option:selected").val();
    let formData = {category: category, brewery: brewery}
    getBeers(formData);
  })
}

function getBeers(filters) {
  // make GET request for beer data
  // $.get("/beers", function(data){
  //   // make sure that the button works properly
  //   // this now shows up whenever a page loads...think I might need to constrain different pages to specific controllers?
  //   // or is this because the button it's linked to is in the nav and therefore will get loaded everytime a page is?
  //   // if that's the case then maybe the button shouldn't go the API call - just the page
  //   alert("making GET request to /beers")
  //   // invoke displayBeers() to show the returned data
  //   displayBeers(data);
  // });
  // use $.ajax() to send the request so that you can send data in the GET request
  $.ajax({
    url: "/beers",
    data: filters
  }).done(function(data){
    // make the apply filter button active again
    displayBeers(data);
    // this isn't working again
    // $('#applyFilter').prop('disabled', false);
  });
}

function displayBeers(beerData) {
  // clear out the beer list before you add new stuff to DOM so that filters work properly
  $('tbody').empty()
  // when the list is empty it should show you "no results"
  if (beerData.length === 0) {
    $('tbody').append("<tr><td><em>No results</em></td><td></td><td></td><td></td></tr>");
  } else {
    beerData.forEach(function(beer){
      let breweryName = beer.brewery.name;
      let breweryId = beer.brewery.id;
      let beerName = beer.name;
      let beerAbv = beer.abv;
      let beerId = beer.id;
      // probably want to use a template here
      // this successfully adds all of the beers with the proper links
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}%</td></tr>`);
    })
  }
}

function beerFormat(){
  // use later on when I do templates
  var row = `<tr><td id="breweryName"></td><td id="beerName"></td><td id="abv"></td></tr>`
};
