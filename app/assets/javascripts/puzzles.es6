// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(() => {
  $('.play-tile').click(function(){
    $(this).toggleClass('selected');
    var column = $(this).data('column');
    var row = $(this).data('row');
  });

  $('#submit_board').click(function(){ // bra, it's es6: () => 
    var boxes = []
    $('.selected').each(function(key, value){
      var row = $(value).data('row');
      var column = $(value).data('column');
      boxes.push({row, column});
    });

    $.ajax({
      type: "POST",
      url:  location.href+'/check_solution.json',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify({boxes}),
      success: function(data) {
        console.log(data);
        $('.board-status').text(data['message'])
      }
    });
  });

});

