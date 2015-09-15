// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function puzzle_submission() {
  var submit_button = document.getElementById('submit_board');

  // Only want to run this if we have a submit_button on the page :(
  if(submit_button){
    submit_button.addEventListener('click', (event) => {
      var boxes = []
      var selecteds = document.getElementsByClassName('selected');

      Array.prototype.forEach.call(selecteds, function(element, i){
        var row = element.dataset.row;
        var column = element.dataset.column;
        boxes.push({row: row, column: column});
        console.log(boxes);
      });

      console.log(boxes);

      $.ajax({
        type: "POST",
        url:  location.href+'/check_solution.json',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify({boxes: boxes}),
        success: (response) => {
          console.log(response);
          var element = document.getElementsByClassName('board-status')[0]
          console.log(response);
          element.textContent = response['message'];
        }
      });
    });
  }
}

function board_interaction() {
  var play_cells = document.getElementsByClassName('play-cell');

  Array.prototype.forEach.call(play_cells, function(item, i){
    item.addEventListener('click', (event) => {
      var element = event.target;
      element.classList.toggle('selected');
    });
  });

  Array.prototype.forEach.call(play_cells, function(item, i){
    item.addEventListener('mouseover', (event) => {
      var element = event.target;
      var column = element.dataset.column;
      var row = element.dataset.row;
      var cells = document.querySelectorAll(`.clue-cell[data-column='${column}'], .clue-cell[data-row='${row}']`);
      Array.prototype.forEach.call(cells, function(item, i){
        item.classList.add('highlight');
      });
    });
  });

  Array.prototype.forEach.call(play_cells, function(item, i){
    item.addEventListener('mouseout', (event) => {
      var element = event.target;
      var column = element.dataset.column;
      var row = element.dataset.row;
      var cells = document.querySelectorAll(`.clue-cell[data-column='${column}'], .clue-cell[data-row='${row}']`);
      Array.prototype.forEach.call(cells, function(item, i){
        item.classList.remove('highlight');
      });
    });
  });
}

function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

ready(() => {
  board_interaction()
    puzzle_submission();
});

ready();
