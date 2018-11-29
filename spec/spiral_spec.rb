require 'spec_helper'

describe 'spiral.rb' do
  describe 'spiral' do
    let(:array) { TwoDimArr::Spiral }
    let(:arr1) { [1] }
    let(:arr2) { [[1, 2], [3, 4]] }
    let(:arr3) { [[1,  2,  3],
                  [4, 's', 6],
                  [7,  8,  9]] }
    let(:arr4) { [[1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9]] }
    let(:result4) { [5, 4, 1, 2, 3, 6, 9, 8, 7] }
    let(:arr5) { [[1, 2, 3,  4,  5],
                  [3, 4, 5,  5,  5],
                  [5, 3, 2,  5,  5],
                  [1, 2, 3,  4,  6],
                  [2, 3, 10, 10, 1]] }
    let(:result5) { [2, 3, 4, 5, 5, 5, 4, 3, 2, 1, 5, 3, 1, 2, 3, 4, 5, 5, 5, 6, 1, 10, 10, 3, 2] }
    let(:result6) { [5, 2, 3, 6, 9, 8, 7, 4, 1] }


    it 'is not two dimensional array' do
      expect { array.call(arr1) }
        .to raise_error(TwoDimArr::NonArraysOfArraysError)
              .with_message('Not two dimensional array')
    end

    it 'is not odd array' do
      expect { array.call(arr2) }
        .to raise_error(TwoDimArr::ArraySizeError)
              .with_message('Wrong array size')
    end

    it 'is have values other than 1..10' do
      expect { array.call(arr3) }
        .to raise_error(TwoDimArr::ArrayValueError)
              .with_message('Wrong values in array (Each value should be Integer in 0..10 range)')
    end

    it 'is have wrong name of direction' do
      expect { array.call(arr4, [:up, :right, :down, :levt]) }
        .to raise_error(TwoDimArr::WrongDirectionSequence)
              .with_message('wrong direction sequence')
    end

    it 'is have wrong direction sequence' do
      expect { array.call(arr4, [:up, :down, :down, :left]) }
        .to raise_error(TwoDimArr::WrongDirectionSequence)
              .with_message('wrong direction sequence')
    end

    it 'is an Enumerator' do
      expect(array.call(arr4, [:up, :right, :down, :left])).to be_an(Enumerator)
    end

    it 'is have correct result with 3x3 array' do
      expect(array.call(arr4).to_a).to eq(result4)
    end

    it 'is have correct result with 5x5 array' do
      expect(array.call(arr5).to_a)
        .to eq(result5)
    end

    it 'is have correct result with 3x3 array with [:up, :right, :down, :left]' do
      expect(array.call(arr4, [:up, :right, :down, :left]).to_a).to eq(result6)
    end
  end
end

