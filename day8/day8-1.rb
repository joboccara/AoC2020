file = File.open('input')
instructions = file.read.split("\n")
file.close

def execute(instructions, index, accumulator, executed)
  if index == instructions.size 
    p 'one after last'
    return accumulator
  end

  if executed.include?(index) then return accumulator end
  executed.append(index)

  instruction = /(?<code>\w{3}) (?<value>.*)$/.match(instructions[index])
  case instruction[:code]
  when 'acc'
    accumulator += instruction[:value].to_i
    execute(instructions, index + 1, accumulator, executed)
  when 'jmp'
    execute(instructions, index + instruction[:value].to_i, accumulator, executed)
  when 'nop'
    execute(instructions, index + 1, accumulator, executed)
  end
end

jmp_nop_indexes = [1 ,4 ,133 ,232 ,233 ,10 ,14 ,122 ,123 ,361 ,328 ,329 ,330 ,490 ,491 ,436 ,437 ,439 ,317 ,319 ,95 ,96 ,274 ,416 ,420 ,107 ,210 ,161 ,70 ,72 ,74 ,580 ,441 ,442 ,166 ,167 ,310 ,312 ,313 ,637 ,215 ,549 ,7 ,628 ,629 ,630 ,433 ,151 ,153 ,336 ,155 ,201 ,249 ,306 ,601 ,603 ,517 ,584 ,587 ,281 ,99 ,562 ,400 ,376 ,502 ,446 ,449 ,477 ,530 ,542 ,283 ,614 ,615 ,527 ,142 ,145 ,146 ,554 ,557 ,469 ,470 ,140 ,537 ,264 ,325 ,326 ,23 ,35 ,38 ,39 ,457 ,607 ,608 ,609 ,610 ,256 ,575 ,462 ,567 ,427 ,428 ,385 ,193]

# jmp_nop_indexes = [0,2,4,7]

def string_swap!(string, sub1, sub2)
  if string.include? sub1
    string.sub!(sub1, sub2)
  else
    string.sub!(sub2, sub1)
  end
end

=begin
jmp_nop_indexes.each_with_index do |index|
  string_swap!(instructions[index], 'jmp', 'nop')
  p index 
  execute(instructions, 0, 0, [])
  string_swap!(instructions[index], 'jmp', 'nop')
end
=end

p execute(instructions, 0, 0, [])
