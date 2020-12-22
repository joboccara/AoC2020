file = File.open('input')
instructions = file.read.split
file.close

x_boat = 0
y_boat = 0

x_waypoint = 10
y_waypoint = 1

def rotate(x, y, angle)
  x_result = 0
  y_result = 0
  angle %= 360
    case angle
    when 90
      x_result = -y
      y_result = x
    when 180
      x_result = -x
      y_result = -y
    when 270
      x_result = y
      y_result = -x
    end
    return x_result, y_result
end

instructions.each do |instruction|
  instruction_data = /(?<type>\w)(?<value>\d+)/.match(instruction)
  value = instruction_data[:value].to_i
  case instruction_data[:type]
  when 'N'
    y_waypoint += value
  when 'S'
    y_waypoint -= value
  when 'E'
    x_waypoint += value
  when 'W'
    x_waypoint -= value
  when 'L'
    x_waypoint,y_waypoint = rotate(x_waypoint, y_waypoint, value)
  when 'R'
    x_waypoint,y_waypoint = rotate(x_waypoint, y_waypoint, -value)
  when 'F'
    x_boat += x_waypoint * value
    y_boat += y_waypoint * value
  end
end

p x_boat.abs + y_boat.abs
