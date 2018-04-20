// document ready
$(function(){
  // attach event to All Beers in nav - may remove this
  allBeersBtn();
  if (window.location.pathname === "/beers") {
    getBeers();
    filterChange();
    newBeerBtn();
    console.log("the stuff for beers#index was loaded");
  } else if (window.location.pathname.startsWith("/beers/")) {
    prevBeerBtn();
    nextBeerBtn();
    getBeer(window.location.pathname);
    console.log("the stuff for beers#show was loaded");
  }
  console.log("the stuff from beers.js was loaded")
  // should i conditionalize when stuff loads on the beers#show page?
})


function allBeersBtn() {
  // when you click on the button it invokes getBeers()
  $('#beers').on("click", function(e){
    alert("you clicked on all beers")
    // e.preventDefault(); - removing this made the page load after the click
    // should I reset the filter buttons here just in case you click here after applying a filter?
    getBeers();
  })
}

function newBeerBtn () {
  $("#new_beer").on("submit", function(e){
    e.preventDefault();
    alert("you clicked on submit new beer")
    let formData = $(this).serialize();
    console.log(formData)
    createBeer(formData)
  })
}

function createBeer(beerData) {
  $("form#new_beer")[0].reset()
  // for some reason this isn't working - think it has something to do with the document ready?
  $("input[type=submit]").prop("disabled", false)
  $.post("/beers", beerData).done(function(newBeer){
    console.log(newBeer);
    let breweryName = newBeer.brewery.name;
    let breweryId = newBeer.brewery.id;
    let beerName = newBeer.name;
    let beerAbv = newBeer.abv;
    let beerId = newBeer.id;
    // probably want to use a template here
    $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="beerName"><a href="/beers/${beerId}">${beerName}</a></td><td id="abv">${beerAbv}%</td></tr>`);
    // how do i make sure that the brewery and category lists get appropriately upated when you try to add a second beer?
    // think I need to quietly re-request the full page afterwards...
  })
}

function Beer(attributes) {
  this.id = attributes.id;
  this.name = attributes.name;
  this.abv = attributes.abv;
  this.description = attributes.description;
  this.brewery = attributes.brewery.name;
  this.breweryId = attributes.brewery.id;
  this.category = attributes.category.name;
  this.categoryId = attributes.category.id;
}

Beer.prototype.displayBeer = function() {
  console.log(this);
  $("#beerHeader").attr("data-id", this.id);
  $("#beerName").text(this.name);
  $("#beerABV").text(`${this.abv}%`);
  $("#beerDescription").text(this.description);
  $("#breweryName").text(this.brewery);
  $("a#breweryName").attr("href", "/breweries/" + this.breweryId);
  $("#categoryName").text(this.category);
  $("a#categoryName").attr("href", "/categories/" + this.categoryId);
}

function filterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#beerFilter').on("change", function(e){
    alert("you changed a filter on /beers");
    e.preventDefault();
    let brewery = $("#brewery option:selected").val();
    let category = $("#category option:selected").val();
    let formData = {category: category, brewery: brewery};
    getBeers(formData);
  })
}

function prevBeerBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked the previous button");
    // make GET request to /beers/:id for next beer
    let prevId = parseInt($("#beerHeader").attr("data-id")) - 1;
    let url = `/beers/${prevId}`;
    getBeer(url);
  });
}

function nextBeerBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked the next button");
    // make GET request to /beers/:id for next beer
    let nextId = parseInt($("#beerHeader").attr("data-id")) + 1;
    let url = `/beers/${nextId}`;
    getBeer(url);
  });
}

function getBeer(url) {
  $.get(url, function(data){
    // let beer = data;
    // displayBeer(beer);
    debugger
    let beer = new Beer(data);
    beer.displayBeer();
  })
}

function displayBeer(beer){
  // update the page to show next beer's data
  $("#beerHeader").attr("data-id", beer.id);
  $("#beerName").text(beer.name);
  $("#beerABV").text(`${beer.abv}%`);
  $("#beerDescription").text(beer.description);
  $("#breweryName").text(beer.brewery.name);
  $("a#breweryName").attr("href", "/breweries/" + beer.brewery.id);
  $("#categoryName").text(beer.category.name);
  $("a#categoryName").attr("href", "/categories/" + beer.category.id);
}

function getBeers(filters) {
  // update this alert to show what page it was called from
  console.log(`getBeers was called from...`)
  $.ajax({
    url: "/beers",
    data: filters
  }).success(function(beerData){
    console.log(beerData);
    displayBeers(beerData);
  })
}

function displayBeers(beerData) {
  // clear out the beer list before you add new stuff to DOM so that filters work properly
  $('tbody').empty();
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
