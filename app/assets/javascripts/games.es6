// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('.play-tile').click(function(){
    $(this).toggleClass('selected');
    var column = $(this).data('column');
    var row = $(this).data('row');
    console.log(`col: ${column}, row:${row}`);
  });

  $('#submit_game').click(function(){
    var selected = []
    $('.selected').each(function(key, value){
      var row = $(value).data('row');
      var column = $(value).data('column');
      selected.push({row: row, column: column});
    });
    console.log(selected);

    $.ajax({
      type: "POST",
      url:  location.href+'/check_answer.json',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({"selected": selected}),
      success: function(data) {
        console.log(data);
        $('.game-status').text(data['message'])
      }
    });
  });

});

