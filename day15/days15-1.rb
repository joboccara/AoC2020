file = File.open('input')
numbers = file.read.split(',').map(&:to_i)
file.close

(30000000-numbers.size).times do
  previous_index = numbers.reverse.drop(1).find_index(numbers.last)
  if previous_index
    numbers.append(1 + previous_index)
  else
    numbers.append(0)
  end
end

p numbers.last
