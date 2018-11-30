# frozen_string_literal: true
require 'Matrix'

class MatrixCreator
  class MatrixSizeError < StandardError; end

  def self.call(n)
    raise MatrixSizeError, 'Not valid matrix' if n.even?
    Matrix.build(n) { rand(0..10) }.to_a
  end

end