// document ready
$(function(){
  // attach event to All Beers in nav - may remove this
  allBeersBtn();
  // attach event to apply filter button
  // applyFilterBtn();
  filterChange();
  // make the call to GET /beers
  getBeers();
  alert("the stuff from beers.js was loaded")
  // should i conditionalize when stuff loads on the beers#show page?
  nextBeerBtn();
})

function nextBeerBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked the next button");
    // make GET request to /beers/:id for next beer
    let nextId = parseInt($(".js-next").attr("data-id")) + 1;
    $.get("/beers/" + nextId, function (data){
      let beer = data;
      displayNextBeer(beer);
    });
  });
}

function displayNextBeer(beer){
  // update the page to show next beer's data
  $(".beerName").text(beer.name);
  $(".beerABV").text(beer.abv);
  $(".beerDescription").text(beer.description);
  $(".breweryName").text(beer.brewery.name);
  $("a.breweryName").attr("href", "/breweries/" + beer.brewery.id);
  $(".categoryName").text(beer.category.name);
  $("a.categoryName").attr("href", "/categories/" + beer.category.id);
  // update URL
  $(".js-next").attr("data-id", beer.id);
}

function allBeersBtn() {
  // when you click on the button it invokes getBeers()
  $('#beers').on("click", function(e){
    alert("you clicked on all beers")
    // e.preventDefault(); - removing this made the page load after the click
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
    alert("you changed a filter on /beers");
    e.preventDefault();
    let url = $("form").attr("action");
    let brewery = $("#brewery option:selected").val();
    let category = $("#category option:selected").val();
    let formData = {category: category, brewery: brewery}
    getBeers(url, formData);
  })
}

function getBeers(url, filters) {
  // update this alert to show what page it was called from
  alert("getBeers was called from...")
  $.ajax({
    url: url,
    data: filters
  }).success(function(beerData){
    // make the apply filter button active again
    displayBeers(beerData);
  });
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
