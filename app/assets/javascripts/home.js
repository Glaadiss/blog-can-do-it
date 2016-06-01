$.fn.scrollTo = function( target ){
  $('html, body').animate({
      scrollTop: $(''+target+'').offset().top
  }, 1000);
} 

$(document).ready(function(){
  $('#toSecond').on('click',function(){
      $('body').scrollTo('#two');
  })
  $('#toFirst').on('click',function(){
      $('body').scrollTo('#one');
  })
  $('#toThird').on('click',function(){
      $('body').scrollTo('#three');
  })
  $('#toSecond2').on('click',function(){
      $('body').scrollTo('#two');
  })
})




