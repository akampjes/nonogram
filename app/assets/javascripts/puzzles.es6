// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

ready(() => {
  var play_tiles = document.getElementsByClassName('play-tile');

  Array.prototype.forEach.call(play_tiles, function(item, i){
    item.addEventListener('click', (event) => {
      var element = event.target;
      element.classList.toggle('selected');
      var column = element.dataset.column;
      var row = element.dataset.row;
    });
  });

  var submit_button = document.getElementById('submit_board');

  // Only want to run this if we have a submit_button on the page :(
  if(submit_button){
    submit_button.addEventListener('click', (event) => {
      var boxes = []
      var selecteds = document.getElementsByClassName('selected');

      Array.prototype.forEach.call(selecteds, function(item, i){
        item.addEventListener('click', (event) => {
          var element = event.target;
          var row = element.dataset.row;
          var column = element.dataset.column;
          boxes.push({row, column});
        });
      });

      $.ajax({
        type: "POST",
        url:  location.href+'/check_solution.json',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify({boxes}),
        success: (response) => {
          console.log(response);
          var element = document.getElementsByClassName('board-status')[0]
          console.log(response);
          element.textContent = response['message'];
        }
      });
    });
  }
});

ready();

  /*
   * :sadface:, can't use fetch because 
     window.fetch(location.href + '/check_solution.json' , {
     method: 'post',
     body: JSON.stringify({boxes})
     }).then((response) => {
     response = response.json();
     console.log(response);
     $('.board-status').text(data['message'])
     }).catch((err) => {
     });
     */

