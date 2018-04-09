// document ready
$(function(){
  if ((/(\/users\/)[0-9]{1,}(\/user_beers\/)[0-9]{1,}/).test(window.location.pathname)) {
    prevUserBeerBtn();
    nextUserBeerBtn();
    getUserBeer(window.location.pathname);
    console.log("the stuff for userbeers#show was loaded");
  } else if ((/(\/users\/)[0-9]{1,}(\/user_beers)/).test(window.location.pathname)) {
    // load the users list of beers
    // attach filter listeners
    getUserBeers(window.location.pathname, "");
    // filterChange();
    console.log("the stuff for userbeers#index was loaded");
  };
  console.log("the stuff from userbeers.js was loaded")
})

function prevUserBeerBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked the previous button");
    let userId = $("#userBeerHeader").attr("data-user");
    let prevId = parseInt($("#userBeerHeader").attr("data-id")) - 1;
    let url = `/users/${userId}/user_beers/${prevId}`;
    getUserBeer(url);
  });
}

function nextUserBeerBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked the next button");
    let userId = $("#userBeerHeader").attr("data-user")
    debugger
    if (userId === current_user) {
      let nextId = parseInt($("#userBeerHeader").attr("data-id")) + 1;
      let url = `/users/${userId}/user_beers/${nextId}`;
      getUserBeer(url);
    }
  });
}


function getUserBeer(url) {
  console.log(url)
  $.get(url, function(data) {
    let userBeer = data;
    console.log(userBeer);
    // let url = `/beers/${userBeer.beer_id}`;
    displayUserBeer(userBeer);
    // getBeer(url)
  })
}

function displayUserBeer(userBeer){
  // update the page to show next beer's data
  $("#beerName").text(userBeer.beer.name);
  $("#beerABV").text(`${userBeer.beer.abv}%`);
  $("#beerDescription").text(userBeer.beer.description);
  // $("#breweryName").text(userBeer.brewery.name);
  // $("a#breweryName").attr("href", "/breweries/" + userBeer.brewery.id);
  // $("#categoryName").text(userBeer.category.name);
  // $("a#categoryName").attr("href", "/categories/" + userBeer.category.id);
  $("#userBeerHeader").attr("data-id", userBeer.id);
  // need to make this static. otherwise after it runs out of userbeers for a particular user it moves onto the next user
  $("#userBeerHeader").attr("data-user", userBeer.user_id);
  $("#userBeerNotes").text(userBeer.notes);
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
