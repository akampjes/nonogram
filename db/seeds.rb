# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puzzle = Puzzle.create!(board_size: 15, max_colors: 2)

winky = %{.....wwwww.....
...wwpppppww...
..wppwwwwwppw..
.wpwwwwwwwwwpw.
.wpwwwpwpwwwpw.
wpwwwppwppwwwpw
wpwwppwwwppwwpw
wpwwwwwwwwwwwpw
wpwwpwwwwwpwwpw
wpwwppwwwppwwpw
.wpwwpppppwwpw.
.wpwwwpppwwwpw.
..wppwwwwwppw..
...wwpppppww...
.....wwwww.....}


boxes = []
winky.each_line.with_index do |line,row|
  line.each_char.with_index do |char,column|
    if char == 'w'
      boxes << {row: row, column: column, color: '#ffffff'}
    elsif char == 'p'
      boxes << {row: row, column: column, color: '#fa0e6a'}
    end
  end
end

board = Board.new(size: 15).from_boxes(boxes)
GenerateLegendsOnPuzzle.new(puzzle: puzzle, board: board).call
