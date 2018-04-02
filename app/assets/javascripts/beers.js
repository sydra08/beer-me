// document ready
$(function(){
  allBeersBtn();
  applyFilterBtn();
  getBeers();
})

function allBeersBtn() {
  // when you click on the button it invokes getBeers()
  $('#beers').on("click", function(e){
    alert("you clicked on all beers")
    e.preventDefault();
    getBeers();
  })
}

function applyFilterBtn() {
  // submitting a form now so handle it that way
  $('#beerFilter').on("submit", function(e){
    alert("you clicked on apply filter")
    e.preventDefault();
    let brewery = $("#brewery option:selected").val();
    let category = $("#cateogry option:selected").val();
    let formData = {category: category, brewery: brewery}
    // need to capture the data from the form here
    // need to make sure to pass through the filter param
    console.log(formData)
    // getBeers();
  })
}

function getBeers() {
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
  // use option:selected to get the value (aka ID) for the selected filters to send with the request
  $.ajax({
    url: "/beers",
    data: {category: $("#cateogry option:selected").val(), brewery: $("#brewery option:selected").val()}
  }).done(function(data){
    displayBeers(data);
  });
}

function displayBeers(beerData) {
  beerData.forEach(function(beer){
    let breweryName = beer.brewery.name;
    let breweryId = beer.brewery.id;
    let beerName = beer.name;
    let beerAbv = beer.abv;
    let beerId = beer.id;
    // probably want to use a template here
    // this successfully adds all of the beers with the proper links
    $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}</td></tr>`);
  })
}

function beerFormat(){
  // use later on when I do templates
  var row = `<tr><td id="breweryName"></td><td id="beerName"></td><td id="abv"></td></tr>`
};
