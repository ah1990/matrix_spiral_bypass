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
```
Result should be an Enumerator
```
=> <Enumerator::Lazy: ...> 
```
Call values
```
result.next
```

You can call method with direction sequence in second argument, with format below

By default:
```ruby
[:left, :up, :right, :down]
```

Call method
```ruby
TwoDimArr::Spiral.call(arr, [:left, :up, :right, :down]) 
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