file = File.open('input')
bus_lines_data = file.read.split[1].split(',')
file.close

bus_lines= bus_lines_data
  .each_with_index
  .select{ |bus_line, index| bus_line != 'x' }
  .map{ |bus_line, index| [bus_line.to_i, index] }
 # .sort{ |entry1, entry2| entry2[0] <=> entry1[0] }

p bus_lines

def match(index1, index2, multiplicand, bus_lines)
  is_match = (bus_lines[index1][0] * multiplicand - bus_lines[index1][1] + bus_lines[index2][1]) % bus_lines[index2][0] == 0
  if is_match && index2 > 3 then p index2; p multiplicand end
  is_match
end

current = 9

p ((1..1000).select do |multiplicand|
  (bus_lines[0][0] * (19 + 37 * (365 + 541 * (6 + 23 * (13 + 13 * (14 + 17 * (6 + 29 * (486 + 983 * (8 + 19 * multiplicand)))))))) - bus_lines[0][1]) % bus_lines[current][0] == (-bus_lines[current][1]) % bus_lines[current][0]
end)

=begin
multiplicand = 112367646392
while true do
  multiplicand = multiplicand + 1
  if match(0, 1, multiplicand, bus_lines) && match(0, 2, multiplicand, bus_lines) && match(0, 3, multiplicand, bus_lines) && match(0, 4, multiplicand, bus_lines) && match(0, 5, multiplicand, bus_lines) && match(0, 6, multiplicand, bus_lines) && match(0, 7, multiplicand, bus_lines) && match(0, 8, multiplicand, bus_lines)
    p (multiplicand * bus_lines[0][0] - bus_lines[0][1])
    bloublou
  end
end
=end

=begin
(107702804644..).each do |multiplicand|
  if match(0, 1, multiplicand, bus_lines) && match(0, 2, multiplicand, bus_lines) && match(0, 3, multiplicand, bus_lines) && match(0, 4, multiplicand, bus_lines) && match(0, 5, multiplicand, bus_lines) && match(0, 6, multiplicand, bus_lines) && match(0, 7, multiplicand, bus_lines) && match(0, 8, multiplicand, bus_lines)
    p (multiplicand * bus_lines[0][0] - bus_lines[0][1])
    bloublou
  end
end
=end

=begin
p ((20000000000..100000000000).select do |multiplicand|
  (bus_lines[0][0] * multiplicand - bus_lines[0][1]) % bus_lines[1][0] == (-bus_lines[1][1]) % bus_lines[1][0]
end 
  .select do |multiplicand|
  bus_lines.last(bus_lines.size-2).all? { |bus_line, index| (bus_lines[0][0] * multiplicand - bus_lines[0][1]) % bus_line == (-index) % bus_line }
end.map {|multiplicand| bus_lines[0][0] * multiplicand }).first - bus_lines[0][1]
=end

=begin
accumulated_mulitplicand = 1

bus_lines.each_with_index do |bus_line, index|
  if index > 0 && bus_line != 'x'
    mult = (1..).find do |multiplicand|
      (bus_lines[0].to_i * multiplicand * accumulated_mulitplicand) % bus_line.to_i == (-index) % bus_line.to_i
    end
    p mult
    accumulated_mulitplicand *= mult
  end
end

p accumulated_mulitplicand
=end
