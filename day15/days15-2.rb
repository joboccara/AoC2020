file = File.open('input')
numbers = file.read.split(',').map(&:to_i)
file.close

def add_to_cache(number, index, cache)
  if cache.has_key? number
    if cache[number].size == 1
      cache[number].append(index)
    else
      cache[number][0] = cache[number][1]
      cache[number][1] = index
    end
  else
    cache[number] = [index]
  end
end

cache = {}
numbers.each_with_index do |number,index|
  add_to_cache(number, index, cache)
end

time = 0

(30000000-numbers.size).times do
  time += 1
  if time % 1000000 == 0 then p time end
  previous_index = cache[numbers.last].reverse[1]
  if previous_index
    new_number = numbers.size - 1 - previous_index
  else
    new_number = 0
  end
  add_to_cache(new_number, numbers.size, cache)
  numbers.append(new_number)
end

p numbers.last
