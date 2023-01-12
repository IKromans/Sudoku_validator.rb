class Validator
    def initialize(puzzle_string)
      @puzzle_string = puzzle_string
    end
  
    def self.validate(puzzle_string)
      new(puzzle_string).validate
    end
  
    def validate
        field = create_game_numbers_array(@puzzle_string)
        is_valid = true
        rows = Array.new(9) { [] }
        cols = Array.new(9) { [] }
        squares = Array.new(9) { [] }
    
        field.each_with_index do |row, i|
          row.each_with_index do |col, j|
            next if col == 0
            val = rows[i].include?(col)
            cval = cols[j].include?(col)
            bval = squares[i/3*3 + j/3].include?(col)
            if val || cval || bval
              is_valid = false
              break
            end
            rows[i] << col
            cols[j] << col
            squares[i/3*3 + j/3] << col
          end
          break unless is_valid
        end
    
        if is_valid
          field.flatten.include?(0) ? 'Sudoku is valid but incomplete.' : 'Sudoku is valid.'
        else
          'Sudoku is invalid.'
        end
      end
    
      private
    
      def create_game_numbers_array(sudoku_game_string)
        sudoku_game_string.gsub(/\D/, '').chars.map(&:to_i).each_slice(9).to_a
      end
    end