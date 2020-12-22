class Symbol
  def with(*args)
    ->(object){ object.send(self, *args) }
  end
end

class String
  def map_chars(&func)
    chars.map(&func).join
  end
end

file = File.open('input')
seats = file.read.split
file.close

def row(seat)
  seat.chars.first(7).map{ |fb| fb == 'F' ? '0' : '1' }.join.to_i(2)
end

def col(seat)
  seat.chars.last(3).map{ |rl| rl == 'L' ? '0' : '1' }.join.to_i(2)
end

p seats.map{ |seat| row(seat) * 8 + col(seat) }.sort
