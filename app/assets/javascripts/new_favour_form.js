$(document).ready(function(){
  
  reveal('second');
  reveal('third');
  reveal('fourth');
  
  linkSearchToSelectInput('users-benefiting-search');

});

var reveal = function(step){
  $('#to_' + step + '_step').on('click', function(){
    $('#help_' + step + '_step').show();
    $(this).hide();
  });
};

var linkSearchToSelectInput = function(searchBox){
  $('#' + searchBox).on('input', function(){
    var search = $(this).val();
    $('select option').each(function(index){
      var option = $(this);
      if (option.text().match(new RegExp(search))) {
        option.prop('selected',true);
      } else {
        option.prop('selected',false)
      };
    });
  });
};