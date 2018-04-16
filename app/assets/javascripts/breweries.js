// document ready
$(function(){
  if(window.location.pathname === "/breweries") {
    // why isn't this firing when you go to /breweries ?
    getBreweries();
    newBreweryBtn();
    console.log("the stuff for breweries#index was loaded");
  } else if (window.location.pathname.startsWith("/breweries/")) {
    // when the page first loads use the url otherwise use the #breweryHeader
    getBrewery(window.location.pathname);
    prevBreweryBtn();
    nextBreweryBtn();
    categoryFilterChange();
    console.log("the stuff for breweries#show was loaded");
  }
  console.log("the stuff from breweries.js was loaded")
})

function getBrewery(url){
  $.get(url, function(data){
    console.log(data)
    let brewery = data;
    let filters = {brewery: brewery.id};
    $("#breweryName").text(brewery.name);
    $("#breweryLocation").text(brewery.location);
    $("#breweryDescription").text(brewery.description);
    // update data-id
    $("#breweryHeader").attr("data-id", brewery.id);
    getBeers(filters);
  })
}

function newBreweryBtn() {
  $("form#new_brewery").submit(function(e){
    e.preventDefault();
    alert("you clicked add new brewery");
    let formData = $(this).serialize();
    console.log(formData);
    let posting = $.post("/breweries", formData)
    posting.done(function(newBrewery){
      console.log(newBrewery)
      let breweryName = newBrewery.name;
      let breweryLocation = newBrewery.location;
      let breweryId = newBrewery.id;
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
    })
  })
}

function prevBreweryBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked on previous brewery");
    let prevId = parseInt($("#breweryHeader").attr("data-id"))-1;
    let url = `/breweries/${prevId}`;
    getBrewery(url);
  });
}

function nextBreweryBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked on next brewery");
    let nextId = parseInt($("#breweryHeader").attr("data-id"))+1;
    let url = `/breweries/${nextId}`;
    getBrewery(url);
  });
}

function categoryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#category').on("change", function(e){
    alert("you changed a category filter on /breweries");
    e.preventDefault();
    let category = $("#category option:selected").val();
    let brewery = $("#breweryHeader").attr("data-id");
    let formData = {category: category, brewery: brewery};
    getBeers(formData);
  })
}

function getBreweries() {
  $.get("/breweries", function(data){
    let breweryData = data;
    $('tbody').empty();
    breweryData.forEach(function(brewery){
      let breweryName = brewery.name;
      let breweryLocation = brewery.location;
      let breweryId = brewery.id;
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
    })
  })
}
