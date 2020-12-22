file = File.open('input')
adapters = file.read.split.map(&:to_i).sort
file.close

adapters.prepend(0)
adapters.append(adapters.max + 3)

def number_arrangements(adapters, index, cache)
  if cache.has_key? index then return cache[index] end

  if index == adapters.size-1
    cache[index] = 1
    return 1
  end

  result = 0
  if index+1 < adapters.size && adapters[index+1] - adapters[index] <= 3
    result += number_arrangements(adapters, index+1, cache)
  end

  if index+2 < adapters.size && adapters[index+2] - adapters[index] <= 3
    result += number_arrangements(adapters, index+2, cache)
  end

  if index+3 < adapters.size && adapters[index+3] - adapters[index] <= 3
    result += number_arrangements(adapters, index+3, cache)
  end

  cache[index] = result
  return result
end

p number_arrangements(adapters, 0, {})
