$(document).ready(function(){
  console.log('testing that the js is working');
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

var checkForMatch = function(searchArray,optionText) {
  return searchArray.some(function(searchTerm){
    return searchTerm === optionText;
  });
};

var linkSearchToSelectInput = function(searchBox){
  $('#' + searchBox).on('input', function(){
    var searchArray = $(this).val().split(/[,;]/);
    $('select option').each(function(index){
      var option = $(this);
      if (checkForMatch(searchArray,option.text())) {
        option.prop('selected',true);
      } else {
        option.prop('selected',false)
      };
    });
  });
};