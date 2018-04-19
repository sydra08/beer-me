// document ready
$(function(){
  if ((/(\/user_beers\/)[0-9]{1,}/).test(window.location.pathname)) {
    prevUserBeerBtn();
    nextUserBeerBtn();
    addNote();
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

function addNote() {
  $("form#notesForm").on("submit", function(e){
    alert("you clicked add note");
    e.preventDefault();
    debugger
    let formData = $(this).serialize();
    console.log(formData)
    // hardcode user Id for now
    let userId = 1;
    let url = `/users/${userId}/user_beers/${$("#userBeerHeader").attr("data-id")}`;
    let posting = $.post(url, formData);
    posting.done(function(data){
      console.log(data);
    });
  });
}

function prevUserBeerBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked the previous button");
    // need to make sure to fix this
    let userId = 1;
    let prevId = parseInt($("#userBeerHeader").attr("data-id")) - 1;
    let url = `/users/${userId}/user_beers/${prevId}`;
    getUserBeer(url);
  });
}

function nextUserBeerBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked the next button");
    // need to make sure to fix this
    let userId = 1;
    let nextId = parseInt($("#userBeerHeader").attr("data-id")) + 1;
    let url = `/users/${userId}/user_beers/${nextId}`;
    getUserBeer(url);
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
  // this doesn't work atm
  $("#breweryName").text("[breweryName]");
  // $("a#breweryName").attr("href", "/breweries/" + userBeer.brewery.id);
  $("#categoryName").text("[categoryName]");
  // $("a#categoryName").attr("href", "/categories/" + userBeer.category.id);
  $("#userBeerHeader").attr("data-id", userBeer.id);
  // need to make this static. otherwise after it runs out of userbeers for a particular user it moves onto the next user
  $("#userBeerHeader").attr("data-user", userBeer.user_id);
  // if there's a note show it, if not show the form
  if (userBeer.notes === "" || userBeer.notes === null) {
    $("#notesForm").show();
    $("#userBeerNotes").hide();
  } else {
    $("#userBeerNotes").show();
    $("#userBeerNotes").text(userBeer.notes);
    $("#notesForm").hide();
  }
}

function loadBeer() {
  var beer = {
    name: "Fat Tire",
    brewery: "New Belgium",
    abv: "4.5%",
    category: "Amber Ale",
  }

  var template = Handlebars.compile(document.getElementById("example-template").innerHTML);
  var result = template(beer);
  document.getElementsByTagName("main")[0].innerHTML += result;
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
