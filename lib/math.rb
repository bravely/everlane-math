class MathProblem
  def initialize(problem)
    if problem.is_a? String
      @problem = problem.split(' ')
    else
      fail ImproperFormatError, "#{problem} is not a String."
    end
  end

  def solve
    while @problem.length != 1
      current_problem_length = @problem.length

      if division_slice = @problem.index('/')
        solution = division(division_slice)
        clean_up(division_slice, solution)
      end

      if multiplication_slice = @problem.index('*')
        solution = multiplication(multiplication_slice)
        clean_up(multiplication_slice, solution)
      end

      if addition_slice = @problem.index('+')
        solution = addition(addition_slice)
        clean_up(addition_slice, solution)
      end

      if subtraction_slice = @problem.index('-')
        solution = subtraction(subtraction_slice)
        clean_up(subtraction_slice, solution)
      end

      if @problem.length == current_problem_length
        fail ImproperFormatError, "Problem is not properly formatted: #{@problem}"
      end
    end

    @problem[0]
  end

  private

  def division(division_index)
    parse_number(@problem[(division_index - 1)]) / parse_number(@problem[(division_index + 1)])
  end

  def multiplication(multiplication_index)
    parse_number(@problem[(multiplication_index - 1)]) * parse_number(@problem[(multiplication_index + 1)])
  end

  def addition(addition_index)
    parse_number(@problem[(addition_index - 1)]) + parse_number(@problem[(addition_index + 1)])
  end

  def subtraction(subtraction_index)
    parse_number(@problem[(subtraction_index - 1)]) - parse_number(@problem[(subtraction_index + 1)])
  end

  def parse_number(slice)
    if slice.class == Float
      return slice
    else
      if slice.match(/^\-?\d+$/)
        slice.to_f
      else
        fail ImproperFormatError, "#{slice} is improperly formatted."
      end
    end
  end

  def clean_up(slice, replacement)
    @problem.insert((slice + 2), replacement)
    @problem.delete_at(slice + 1)
    @problem.delete_at(slice)
    @problem.delete_at(slice - 1)
  end
end

class ImproperFormatError < StandardError
end