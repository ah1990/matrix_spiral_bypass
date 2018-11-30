# Spiral bypass of matrix

### Using

In script folder:
```bash
bundle
```

In ruby console:
```ruby
require './spiral'
result = TwoDimArr::Spiral.call(arr) # arr is valid two dimensional array with values other than 1..10
# Or create matrix by generator
matrix = MatrixCreator.call(5)
# And call with this matrix in 1st argument
instance = TwoDimArr::Spiral.new(matrix, [:left, :up, :right, :down]) # Create new instance of Spiral class
@spiral = instance.call
```
Result should be an Enumerator
```
=> <Enumerator::Lazy: ...> 
```
Call values
```ruby
@spiral.next
```

You can call method with direction sequence in second argument, with format below

By default:
```ruby
[:left, :up, :right, :down]
```

Call methods
```ruby
matrix = MatrixCreator.call(5) # To create matrix
instance = TwoDimArr::Spiral.new(matrix, [:left, :up, :right, :down]) # to create new instance of Spiral class
spiral = instance.call
spiral.class # => Enumerator::Lazy
spiral.next # calculate next value of spiral matrix bypass
```

Possible sequences
```ruby
[:left, :up, :right, :down]
[:left, :down, :right, :up]
[:up, :right, :down, :left]
[:up, :left, :down, :right]
[:right, :up, :left, :down]
[:right, :down, :left, :up]
[:down, :left, :up, :right]
[:down, :right, :up, :left]
```
##### Rspec tests
```bash
bundle exec rspec spec/
```