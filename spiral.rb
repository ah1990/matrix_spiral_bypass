# frozen_string_literal: true

module TwoDimArr
  class NonArraysOfArraysError < StandardError; end
  class ArraySizeError < StandardError; end
  class ArrayValueError < StandardError; end
  class WrongDirectionName < StandardError; end
  class WrongDirectionSequence < StandardError; end

  class Spiral

    def initialize(arr, directions)
      @arr = arr
      @arr_flatten = arr_flttn
      @arr_size = arr_size
      @directions = directions
    end

    def self.call(arr, directions=[:left, :up, :right, :down])
      inst = new(arr, directions)
      inst.call
    end

    def call
      check_arr
      check_direction
      start_position = find_center_point
      result = go_spiral(start_position)
      p "Result is #{result}"
      result.lazy.select { |e| e }
    end

    private

    attr_reader :arr, :arr_flatten, :arr_size, :directions

    def check_arr
      unless arr.is_a?(Array) && arr.all? { |el| el.is_a?(Array) }
        raise NonArraysOfArraysError, 'Not two dimensional array'
      end
      unless arr_size % 2 > 0 && arr_size ** 2 - arr_flatten.count == 0
        raise ArraySizeError, 'Wrong array size'
      end
      unless check_el_values
        raise ArrayValueError,
              'Wrong values in array (Each value should be Integer in 1..10 range)'
      end
    end

    def arr_size
      arr.size
    end

    def arr_flttn
      arr.flatten
    end

    def check_el_values
      arr_flatten.all? {|el| (el.is_a?(Integer) && el.between?(0,10)) }
    end

    def find_center_point
      c = arr_size/2
      [c, c]
    end

    def check_direction
      unless possible_directions.include?(directions)
        raise WrongDirectionSequence, 'wrong direction sequence'
      end
    end

    def possible_directions
      [[:left, :up, :right, :down],
       [:left, :down, :right, :up],
       [:up, :right, :down, :left],
       [:up, :left, :down, :right],
       [:right, :up, :left, :down],
       [:right, :down, :left, :up],
       [:down, :left, :up, :right],
       [:down, :right, :up, :left]]
    end

    def go_spiral(start_position)
      step_counts = (1..Float::INFINITY).lazy.flat_map { |e| [e, e] }
      spiral = [arr[start_position[0]][start_position[1]]]
      direction = directions.cycle
      while spiral.size < arr_size ** 2

        current_step_count = step_counts.next
        current_direction = direction.next
        current_step_count.times do
          return spiral if spiral.size >= arr_size ** 2

          case current_direction
            when :up then start_position[0] -= 1
            when :down then start_position[0] += 1
            when :left then start_position[1] -= 1
            when :right then start_position[1] += 1
            # Else never happens because check in possible_directions before
            else raise WrongDirectionName, 'wrong name of direction'
          end


          spiral << arr[start_position[0]][start_position[1]]
        end
      end
    end
  end
end
