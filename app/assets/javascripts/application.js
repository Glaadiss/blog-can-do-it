// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require ckeditor/init
//= require_tree .





// url strony z will_paginate gdzie będzie pobierał dane
// counter ustawiony na 2
// div z w którym są nasze elementy
// przycisk do ładowania elementów

function myPagination(url,counter, divv, button){ 
        $.ajax({
          url: url,
          dataType: 'html',
          success: function(html) {
            var div = $(html).find(''+divv+' .row');
            div.css('display','none');
            $(div).appendTo(divv).show('slow').after(function() {
              $("html, body").animate({ scrollTop: $(document).height() }, 1000).after(function(){
                $('html,body').stop(true, false).animate({ scrollTop: $(document).height() }, 1000);
              }); 

            });
          }

        })
        return counter + 1;

}


function removeButon(counter, numberOfElements, button){
  if ( (counter-1)*5 >= numberOfElements )
    $(''+button+'').fadeOut();
}