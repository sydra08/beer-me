$(function(){
  allBeersBtn();
})

function allBeersBtn() {
  // when you click on the button it invokes getBeers()
  $('#beers').on("click", function(e){
    e.preventDefault();
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
    let beerName = beer.name;
    let beerAbv = beer.abv;
    // need to add the beer data to the DOM now
    // so need to figure out how to add all of the beers instead of just the last one
    $('tbody').append(`<tr><td id="breweryName">${breweryName}</td><td id="beerName">${beerName}</td><td id="abv">${beerAbv}</td></tr>`);
    // console.log(`<tr><td id="breweryName">${breweryName}</td><td id="beerName">${beerName}</td><td id="abv">${beerAbv}</td></tr>`);
  })
}

function beerFormat(){
  var row = `<tr><td id="breweryName"></td><td id="beerName"></td><td id="abv"></td></tr>`
};
