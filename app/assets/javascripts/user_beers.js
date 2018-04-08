// document ready
$(function(){
  if (window.location.pathname.endsWith("/user_beers")) {
    // load the users list of beers
    // attach filter listeners
    getUserBeers(window.location.pathname, "");
    // filterChange();
    console.log("the stuff for userbeers#index was loaded");
  // } else {
  //   // show page
  //   // prev and next button listeners
  //   // retrieve data for show page
  //   prevBeerBtn();
  //   nextBeerBtn();
  //   getBeer(window.location.pathname);
  //   console.log("the stuff for userbeers#show was loaded");
  console.log("the stuff from userbeers.js was loaded")
  // should i conditionalize when stuff loads on the beers#show page?
  };
})

//
// function getUserBeer(url) {
//   $.get(url, function(data){
//     let beer = data;
//     displayBeer(beer);
//   })
// }
//
// function displayBeer(beer){
//   // update the page to show next beer's data
//   $("#beerHeader").attr("data-id", beer.id);
//   $("#beerName").text(beer.name);
//   $("#beerABV").text(`${beer.abv}%`);
//   $("#beerDescription").text(beer.description);
//   $("#breweryName").text(beer.brewery.name);
//   $("a#breweryName").attr("href", "/breweries/" + beer.brewery.id);
//   $("#categoryName").text(beer.category.name);
//   $("a#categoryName").attr("href", "/categories/" + beer.category.id);
// }

function getUserBeers(url, filters) {
  // update this alert to show what page it was called from
  console.log(`getUserBeers() was called`)
  $.ajax({
    url: url,
    data: filters
  }).success(function(userBeerData){
    console.log("this data is from getUserBeers()");
    console.log(userBeerData);
    displayUserBeers(userBeerData);
  })
}

function displayUserBeers(userBeerData) {
  // clear out the beer list before you add new stuff to DOM so that filters work properly
  $('tbody').empty();
  // when the list is empty it should show you "no results"
  if (userBeerData.length === 0) {
    $('tbody').append("<tr><td><em>No results</em></td><td></td><td></td><td></td></tr>");
  } else {
    userBeerData.forEach(function(beer){
      console.log("this is data about an individual beer");
      console.log(beer);
      // let breweryName = beer.brewery.name;
      // let breweryId = beer.brewery.id;
      // let beerName = beer.name;
      // let beerAbv = beer.abv;
      // let beerId = beer.id;
      // // probably want to use a template here
      // // this successfully adds all of the beers with the proper links
      // $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}%</td></tr>`);
    })
  }
}
