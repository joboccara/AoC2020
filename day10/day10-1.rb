file = File.open('input')
adapters = file.read.split.map(&:to_i)
file.close

adapters.prepend(0)
adapters.append(adapters.max + 3)

differences = adapters.sort.each_cons(2).map{|a1,a2| a2 - a1}

p differences.count(1) * differences.count(3)
