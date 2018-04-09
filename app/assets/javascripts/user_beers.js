// document ready
$(function(){
  if (window.location.pathname.endsWith("/user_beers")) {
    // load the users list of beers
    // attach filter listeners
    getUserBeers(window.location.pathname, "");
    // filterChange();
    console.log("the stuff for userbeers#index was loaded");
  } else {
    // show page
    // prev and next button listeners
    // retrieve data for show page
    // prevBeerBtn();
    // nextBeerBtn();
    getUserBeer(window.location.pathname);
    console.log("the stuff for userbeers#show was loaded");
  };
  console.log("the stuff from userbeers.js was loaded")
  // should i conditionalize when stuff loads on the beers#show page?

})

//
function getUserBeer(url) {
  $.get(url, function(data){
    let userBeer = data;
    let url = `/beers/${userBeer.beer_id}`;
    console.log(userBeer);
    displayUserBeer(userBeer);
    getBeer(url)
  })
}

function displayUserBeer(userBeer){
  // update the page to show next beer's data
  $("#userBeerNotes").text(userBeer.notes)
}

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
    $('tbody').append("<tr><td><em>No results</em></td><td></td><td></td><td></td><td></td></tr>");
  } else {
    userBeerData.forEach(function(userBeer){
      console.log("this is data about an individual user beer");
      console.log(userBeer);
      // let breweryName = beer.brewery.name;
      // let breweryId = beer.brewery.id;
      let beerName = userBeer.beer.name;
      let beerAbv = userBeer.beer.abv;
      let userBeerId = userBeer.id;
      let userId = userBeer.user.id;
      // // probably want to use a template here
      // // this successfully adds all of the beers with the proper links
      $('tbody').append(`<tr><td id="breweryName"><a href="#">[breweryName]</a></td><td id="beerName"><a href="/users/${userId}/user_beers/${userBeerId}">${beerName}</a></td><td id="abv">${beerAbv}%</td><td>[insert trash]</td></tr>`);
    })
  }
}
