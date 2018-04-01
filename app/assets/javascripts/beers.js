$(function(){
  allBeersBtn();
})

function allBeersBtn() {
  $('#beers').on("click", function(e){
    e.preventDefault();
    getBeers();
  })
}

function getBeers() {
  $.get("/beers", function(data){
    alert("you click on all beers")
  })
}
