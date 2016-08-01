$(document).ready(function(){
  reveal('second');
  reveal('third');
  reveal('fourth');
});

var reveal = function(step){
  $('#to_' + step + '_step').on('click', function(){
    $('#help_' + step + '_step').show();
    $(this).hide()
  })
}