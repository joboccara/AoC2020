file = File.open('input')
file_contents = file.read.split
minimum_departure = file_contents[0].to_i
bus_lines = file_contents[1].split(',')
file.close

earliest_bus_line, waiting_time =
  bus_lines
  .select{ |bus_line| bus_line != 'x' }
  .map(&:to_i)
  .map{ |bus_line| [bus_line, bus_line - minimum_departure % bus_line] }
  .min{ |entry1, entry2| entry1[1] <=> entry2[1] }
  
p earliest_bus_line * waiting_time
