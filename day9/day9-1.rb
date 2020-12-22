class Symbol
  def with(*args)
    ->(object){ object.send(self, *args) }
  end
end

file = File.open('input')
numbers = file.read.split.map(&:to_i)
file.close

slice_size = 25

def different_values(a)
  a[0] != a[1]
end

(0...(numbers.size - slice_size)).each do |i|
  result_number = numbers[i + slice_size]
  slice = numbers.slice(i, i + slice_size-1)
  if !slice.product(slice).filter(&method(:different_values)).map(&:reduce.with(:+)).include? result_number
    p result_number
  end
end
