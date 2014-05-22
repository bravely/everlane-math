require File.join(File.dirname(__FILE__), '../lib/math.rb')

describe 'math' do
  describe 'division' do
    it 'can complete simple division' do
      MathProblem.new("4 / 2").solve.should be 2.0
    end
  end

  describe 'multiplication' do
    it 'can complete simple multiplication' do
      MathProblem.new("4 * 4").solve.should be 16.0
    end
  end

  describe 'addition' do
    it 'can complete simple addition' do
      MathProblem.new("1 + 1").solve.should be 2.0
    end
  end

  describe 'subtraction' do
    it 'can complete simple subtraction' do
      MathProblem.new("4 - 3").solve.should be 1.0
    end
  end

  describe 'complex examples' do
    it 'can complete the given complex example' do
      MathProblem.new("10 + 2 * 3 / 4").solve.should be 11.5
    end

    it 'can handle negative values' do
      MathProblem.new("-10 - -4 / 2").solve.should be -8.0
    end

    it 'can handle all negative values' do
      MathProblem.new("-10 - -4 / -2").solve.should be -12.0
    end
  end

  describe 'Improperly formatted examples' do
    it 'does not process anything but strings' do
      expect do
        MathProblem.new(['badtest'])
      end.to raise_exception ImproperFormatError
    end

    it 'catches improperly formatted numbers' do
      expect do
        solution = MathProblem.new('4x12 - 4').solve
      end.to raise_exception ImproperFormatError
    end

    it 'catches a cruel hyphen' do
      expect do
        MathProblem.new('45- + 8').solve
      end.to raise_exception ImproperFormatError
    end
  end
end