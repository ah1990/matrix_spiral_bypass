require 'spec_helper'

describe 'matrix_creator.rb' do
  describe 'generate matrix' do
    context 'not valid' do
      it 'is raise exception' do
        expect { MatrixCreator.call(4) }
          .to raise_error(MatrixCreator::MatrixSizeError)
                .with_message('Not valid matrix')
      end
    end

    context 'valid' do
      it 'is create matrix and convert to array of arrays' do
        expect(MatrixCreator.call(11).class).to eq(Array)
      end
    end
  end
end