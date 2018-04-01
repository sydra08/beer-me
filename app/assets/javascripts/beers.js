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
    alert("you click on all beers")
    // make sure that there is data being returned
    displayBeers(data);
  });
}

function displayBeers(beerData) {
  beerData.forEach(function(beer){
    let breweryName = beer.brewery.name;
    let beerName = beer.name;
    let beerAbv = beer.abv;

    console.log(`<tr><td id="breweryName">${breweryName}</td><td id="beerName">${beerName}</td><td id="abv">${beerAbv}</td></tr>`);
  })
}

function beerFormat(){
  var row = `<tr><td id="breweryName"></td><td id="beerName"></td><td id="abv"></td></tr>`
};
