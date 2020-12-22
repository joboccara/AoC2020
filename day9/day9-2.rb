class Symbol
  def with(*args)
    ->(object){ object.send(self, *args) }
  end
end

file = File.open('input')
numbers = file.read.split.map(&:to_i)
file.close

def find_streak(numbers, target)
  (2..).each do |length|
    (0..(numbers.size - length)).each do |start|
      slice = numbers.slice(start, length)
      if slice.max < target && slice.sum == target
        return slice.min + slice.max
      end
    end
  end
end

p find_streak(numbers, 20874512)
