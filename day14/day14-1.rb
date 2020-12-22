file = File.open('input')
file_contents = file.read.split("\n")
file.close


memory = {}

file_contents
  .each_index
  .select{ |index| file_contents[index].include? 'mask' }
  .append(file_contents.size)
  .each_cons(2) do |index_and_next_index|
    index = index_and_next_index[0]
    next_index = index_and_next_index[1]
    instruction_set = file_contents.slice(index, next_index-index)
    mask = /mask = (?<mask>.*)/.match(instruction_set[0])[:mask]
    mask1 = mask.chars.map{|b| b == '1' ? b : '0' }.join.to_i(2)
    mask0 = mask.chars.map{|b| b == '0' ? b : '1' }.join.to_i(2)
    instructions = instruction_set.drop(1).map{ |instruction| /mem\[(?<address>\d+)\] = (?<value>\d+)/.match(instruction) }

    instructions.each do |instruction|
      memory[instruction[:address]] = (instruction[:value].to_i & mask0 | mask1)
    end
end

p memory.values.sum
