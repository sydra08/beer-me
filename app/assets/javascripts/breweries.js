// document ready
$(function(){
  if(window.location.pathname === "/breweries") {
    // why isn't this firing when you go to /breweries ?
    getBreweries();
    // addBreweryBtn();
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

// function addBreweryBtn() {
//   $("#addBrewery").on("click", function(e){
//     e.preventDefault();
//     alert("you clicked add brewery");
//     $.get("/breweries/new", function(data){
//       console.log(data);
//       // debugger
//       $("div#addBreweryForm").append(data)
//     })
//     newBreweryBtn();
//   })
// }

function newBreweryBtn() {
  $("form#new_brewery").submit(function(e){
    e.preventDefault();
    alert("you clicked add new brewery");
    let formData = $(this).serialize();
    console.log(formData);
    addBrewery(formData);
  });
}

function addBrewery(newBreweryData) {
  let posting = $.post("/breweries", newBreweryData)
  posting.done(function(newBrewery){
    console.log(newBrewery)
    let breweryName = newBrewery.name;
    let breweryLocation = newBrewery.location;
    let breweryId = newBrewery.id;
    $("form#new_brewery")[0].reset();
    $("input[type='submit']").attr("disabled", false);
    // $("input[type='submit']").prop("disabled", false);
    $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
  });
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
      console.log(brewery)
      let breweryName = brewery.name;
      let breweryLocation = brewery.location;
      let breweryId = brewery.id;
      // var breweryDescription = brewery.description
      // if (brewery.description === null) {
      //   breweryDescription = "";
      // }
      $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td></tr>`);
      // $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${breweryId}">${breweryName}</a></td><td id="breweryLocation">${breweryLocation}</td><td id="breweryDescription">${breweryDescription}</td></tr>`);
    })
  })
}
