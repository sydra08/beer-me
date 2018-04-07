// document ready
$(function(){
  if(window.location.pathname === "/breweries") {
    // why isn't this firing when you go to /breweries ?
    getBreweries();
    console.log("the stuff for breweries#index was loaded");
  } else if (window.location.pathname.startsWith("/breweries/")) {
    getBeers(window.location.pathname);
    prevBreweryBtn();
    nextBreweryBtn();
    categoryFilterChange();
    console.log("the stuff for breweries#show was loaded");
  }
  console.log("the stuff from breweries.js was loaded")
})

function prevBreweryBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked on previous brewery");
    let prevId = parseInt($("header.align-center").attr("data-id"))-1;
    $.get("/breweries/" + prevId, function(data){
      console.log(data);
      let url = `/breweries/${prevId}`;
      $("#breweryName").text(data[0].brewery.name);
      $("#breweryLocation").text(data[0].brewery.location);
      $("#breweryDescription").text(data[0].brewery.description);
      // update data-id
      $("header.align-center").attr("data-id", prevId)
      getBeers(url);
    })
  });
}

function nextBreweryBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked on next brewery");
    let nextId = parseInt($("header.align-center").attr("data-id"))+1;
    $.get("/breweries/" + nextId, function(data){
      console.log(data);
      // the data that's being returned includes everything - want to constrain so that it's just about breweries
    })
  });
}


function categoryFilterChange() {
  // this works and you don't have to worry about the apply filter button
  $('#category').on("change", function(e){
    alert("you changed a category filter on /breweries");
    e.preventDefault();
    let url = $("form").attr("action");
    let category = $("#category option:selected").val();
    let formData = {category: category}
    getBeers(url, formData);
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
