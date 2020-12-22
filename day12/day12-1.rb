file = File.open('input')
instructions = file.read.split
file.close

x = 0
y = 0
direction = 0

instructions.each do |instruction|
  instruction_data = /(?<type>\w)(?<value>\d+)/.match(instruction)
  value = instruction_data[:value].to_i
  case instruction_data[:type]
  when 'N'
    y += value
  when 'S'
    y -= value
  when 'E'
    x += value
  when 'W'
    x -= value
  when 'L'
    direction += value
    direction %= 360
  when 'R'
    direction -= value
    direction %= 360
  when 'F'
    direction_rad = direction * Math::PI / 180
    x += Math::cos(direction_rad) * value
    y += Math::sin(direction_rad) * value
  end
end

p x.abs + y.abs
