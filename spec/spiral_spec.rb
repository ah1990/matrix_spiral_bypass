require 'spec_helper'

describe 'spiral.rb' do
  describe 'spiral' do
    let(:clazz) { TwoDimArr::Spiral }

    context 'when not two dimensional array' do
      arr1 = [1]
      it 'is raise exception' do
        expect { clazz.new(arr1) }
          .to raise_error(TwoDimArr::NonArraysOfArraysError)
                .with_message('Not two dimensional array')
      end
    end

    context 'when not odd array' do
      arr2 = [[1, 2], [3, 4]]
      it 'is raise exception' do
        expect { clazz.new(arr2) }
          .to raise_error(TwoDimArr::ArraySizeError)
                .with_message('Wrong array size')
      end
    end

    context 'when is have values other than 1..10' do
      arr3 = [[1,  2,  3],
              [4, 's', 6],
              [7,  8,  9]]
      it 'is raise exception' do
        expect { clazz.new(arr3) }
          .to raise_error(TwoDimArr::ArrayValueError)
                .with_message('Wrong values in array (Each value should be Integer in 0..10 range)')
      end
    end

    context 'when have wrong name of direction' do
      arr = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
      direction = [:up, :right, :down, :levt]
      it 'is raise exception' do
        expect { clazz.new(arr, direction) }
          .to raise_error(TwoDimArr::WrongDirectionSequence)
                .with_message('wrong direction sequence')
      end
    end

    context 'when have wrong direction sequence' do
      arr4 = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
      it 'is raise exception' do
        expect { clazz.new(arr4, [:up, :down, :down, :left]) }
          .to raise_error(TwoDimArr::WrongDirectionSequence)
                .with_message('wrong direction sequence')
      end
    end

    context 'with valid arguments' do
      arr = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
      it 'is a lazy enumerator' do
        inst = clazz.new(arr, [:up, :right, :down, :left])
        expect(inst.call).to be_an(Enumerator::Lazy)
      end

      it 'is have correct result' do
        result = [5, 4, 1, 2, 3, 6, 9, 8, 7]
        inst = clazz.new(arr)
        expect(inst.call.to_a).to eq(result)
      end
    end

    context 'with valid 3x3 matrix' do
      arr = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
      it 'is have correct result on each enumerator step' do
        result = [5, 4, 1, 2, 3, 6, 9, 8, 7]
        inst = clazz.new(arr)
        enumerator = inst.call
        expected_res = result.to_enum
        result.size.times do
          expect(enumerator.next).to eq(expected_res.next)
        end
      end
    end

    context 'with valid 5x5 matrix' do
      arr = [[1, 2, 3,  4,  5],
              [3, 4, 5,  5,  5],
              [5, 3, 2,  5,  5],
              [1, 2, 3,  4,  6],
              [2, 3, 10, 10, 1]]
      it 'is have correct result array' do
        result = [2, 3, 4, 5, 5, 5, 4, 3, 2, 1, 5, 3, 1, 2, 3, 4, 5, 5, 5, 6, 1, 10, 10, 3, 2]
        inst = clazz.new(arr)
        expect(inst.call.to_a).to eq(result)
      end
    end

    context 'with valid matrix and direction' do
      arr = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
      direction = [:up, :right, :down, :left]
      it 'is equal current result' do
        result = [5, 2, 3, 6, 9, 8, 7, 4, 1]
        inst = clazz.new(arr, direction)
        expect(inst.call.to_a).to eq(result)
      end
    end
  end
end

