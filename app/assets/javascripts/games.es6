// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $('.play_tile').click(function(){
        $(this).toggleClass('selected');
        var column = $(this).data('column');
        var row = $(this).data('row');
        console.log(`col: ${column}, row:${row}`);

        // format data that i need
        });
    });
