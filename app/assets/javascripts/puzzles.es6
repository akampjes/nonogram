// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
var current_color = null;

function puzzle_submission() {
  var submit_button = document.getElementById('submit_board');

  submit_button.addEventListener('click', (event) => {
    var boxes = []
    var selecteds = document.getElementsByClassName('selected');

    Array.prototype.forEach.call(selecteds, function(element, i){
      var row = element.dataset.row;
      var column = element.dataset.column;
      var color = element.dataset.color;
      boxes.push({row: row, column: column, color: color});
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

function board_interaction() {
  var play_cells = document.getElementsByClassName('play-cell');

  Array.prototype.forEach.call(play_cells, function(item, i){
    item.addEventListener('click', (event) => {
      var element = event.target;
      element.classList.toggle('selected');

      if(!element.dataset.color){
        element.style.backgroundColor = `hsl(${current_color}, 90%, 50%)`;
        element.setAttribute('data-color', current_color);
      }else{
        element.style.backgroundColor = '';
        element.setAttribute('data-color', '');
      }
      console.log(element);
    });
  });

  Array.prototype.forEach.call(play_cells, function(item, i){
    item.addEventListener('mouseover', (event) => {
      //can i use let here?
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

function color_picker() {
  var color_pickers = document.getElementsByClassName('color-picker');

  Array.prototype.forEach.call(color_pickers, function(item, i){
    item.addEventListener('click', (event) => {
      var element = event.target;
      current_color = element.dataset.color;

      // Remove outlining for current color pickers
      var current_selected_color_picker = document.getElementsByClassName('selected-color-picker');
      Array.prototype.forEach.call(current_selected_color_picker, function(element, i){
        element.classList.remove('selected-color-picker');
      });

      element.classList.add('selected-color-picker');
      console.log("current_color" + current_color);
    });
  });

  // Initialize current_color
  var element = color_pickers[0];
  current_color = element.dataset.color;
  element.classList.add('selected-color-picker');
  console.log("initial current_color" + current_color);
}

function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

ready(() => {
  var submit_button = document.getElementById('submit_board');

  if(!submit_button){
    return;
  }

  color_picker();
  board_interaction();
  puzzle_submission();
});

ready();
