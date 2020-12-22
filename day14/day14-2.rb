class Symbol
  def with(*args)
    ->(object){ object.send(self, *args) }
  end
end

file = File.open('input')
file_contents = file.read.split("\n")
file.close

def apply_mask(mask, address)
  binary_address = address.to_s(2)
  (36 - binary_address.size).times{ binary_address.prepend('0') }
  binary_address.chars.zip(mask.chars).map { |a,m| m == '0' ? a : m }.join
end

def real_addresses_impl(masked_address, index, head, results)
  if index == masked_address.size
    results.append(head)
    return
  end

  if masked_address[index] != 'X'
    real_addresses_impl(masked_address, index + 1, head + masked_address[index], results)
  else
    real_addresses_impl(masked_address, index + 1, head + '0', results)
    real_addresses_impl(masked_address, index + 1, head + '1', results)
  end
end

def real_addresses(masked_address)
  results = []
  real_addresses_impl(masked_address, 0, '', results)
  results.map(&:to_i.with(2))
end

def apply_instructions(instructions, memory)
  mask = /mask = (?<mask>.*)/.match(instructions[0])[:mask]
  instructions = instructions.drop(1).map{ |instruction| /mem\[(?<address>\d+)\] = (?<value>\d+)/.match(instruction) }

  mask1 = mask.chars.map{|b| b == '1' ? b : '0' }.join.to_i(2)
  mask0 = mask.chars.map{|b| b == '0' ? b : '1' }.join.to_i(2)

  instructions.each do |instruction|
    masked_address = apply_mask(mask, instruction[:address].to_i)
    real_addresses(masked_address).each do |address|
      memory[address] = instruction[:value].to_i
    end
  end
end

memory = {}

file_contents
  .each_index
  .select{ |index| file_contents[index].include? 'mask' }
  .append(file_contents.size)
  .each_cons(2) do |index_and_next_index|
    index = index_and_next_index[0]
    next_index = index_and_next_index[1]
    instruction_set = file_contents.slice(index, next_index-index)
    apply_instructions(instruction_set, memory)
end

p memory.values.sum
