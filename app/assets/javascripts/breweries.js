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
  posting.success(function(newBrewery){
    console.log("success")
    $("form#new_brewery")[0].reset();
    $("input[type='submit']").attr("disabled", false);
    let brewery = new Brewery(newBrewery)
    brewery.breweryListDisplay();
  });
  posting.fail(function(response){
    console.log("fail was called")
    $("div#error_explanation").show();
    $("div#error_explanation").append("<p><strong>Error: </strong>Brewery already exists</p>")
    // maybe add a function here that says the submit button is disabled until you change something in the form
    // debugger
  })
}

function prevBreweryBtn(){
  $(".js-prev").on("click", function(){
    alert("you clicked on previous brewery");
    let prevId = parseInt($("#breweryHeader").attr("data-id"))-1;
    let url = `/breweries/${prevId}.json`;
    getBrewery(url);
  });
}

function nextBreweryBtn(){
  $(".js-next").on("click", function(){
    alert("you clicked on next brewery");
    let nextId = parseInt($("#breweryHeader").attr("data-id"))+1;
    let url = `/breweries/${nextId}.json`;
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

function Brewery(attributes) {
  this.id = attributes.id;
  this.name = attributes.name;
  this.location = attributes.location
  this.description = attributes.description;
}

Brewery.prototype.displayBrewery = function() {
  console.log(this);
  $("#breweryName").text(this.name);
  $("#breweryLocation").text(this.location);
  if(this.description === "") {
    $("#breweryDescription").text("Description not available");
  } else {
    $("#breweryDescription").text(this.description);
  }
  // update data-id
  $("#breweryHeader").attr("data-id", this.id);
  $(".showMessage").hide();
}

Brewery.prototype.breweryListDisplay = function() {
  console.log(this)
  $("div#error_explanation").hide();
  $('tbody').append(`<tr><td id="breweryName"><a href="/breweries/${this.id}">${this.name}</a></td><td id="breweryLocation">${this.location}</td></tr>`);
}

function getBrewery(url){
  $.get(url, function(data){
    console.log(data)
  })
  .success(function(breweryData){
    let brewery = new Brewery(breweryData);
    let filters = {brewery: brewery.id};
    brewery.displayBrewery();
    getBeers(filters);
  })
  .fail(function(response){
    console.log("fail")
    $(".showMessage").show().delay(5000).fadeOut();
  })
}

function getBreweries() {
  $.get("/breweries.json", function(data){
    let breweryData = data;
    $('tbody').empty();
    breweryData.forEach(function(response){
      console.log(response)
      let brewery = new Brewery(response)
      brewery.breweryListDisplay();
    })
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
