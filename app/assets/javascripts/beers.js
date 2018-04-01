$(function(){
  allBeersBtn();
  applyFilterBtn();
  getBeers();
})

function allBeersBtn() {
  // when you click on the button it invokes getBeers()
  $('#beers').on("click", function(e){
    e.preventDefault();
    getBeers();
  })
}

function applyFilterBtn() {
  // submitting a form now so handle it that way
  $('#beerFilter').on("submit", function(e){
    e.preventDefault();
    // need to make sure to pass through the filter param
    getBeers();
  })
}

function getBeers() {
  // make GET request for beer data
  $.get("/beers", function(data){
    // make sure that the button works properly
    alert("you clicked on all beers")
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
    // need to add the beer data to the DOM now
    // so need to figure out how to add all of the beers instead of just the last one
    $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}</td></tr>`);
    // console.log(`<tr><td id="breweryName">${breweryName}</td><td id="beerName">${beerName}</td><td id="abv">${beerAbv}</td></tr>`);
  })
}

function beerFormat(){
  var row = `<tr><td id="breweryName"></td><td id="beerName"></td><td id="abv"></td></tr>`
};
