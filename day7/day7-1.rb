require 'set'

file = File.open('input')
rules = file.read.split("\n")
file.close

containers2containedAL = {}
rules
  .map{|rule| /^(?<container>.*) bags contain(?<contained>.*)\.$/.match(rule)}
  .each do |matchdata|
  if matchdata[:contained] == " no other bags"
      containers2containedAL[matchdata[:container]] = []
    else
      containers2containedAL[matchdata[:container]] = 
        matchdata[:contained].split(',').map{|contained| / \d+ (?<color>.*) bag/.match(contained)[:color]}
    end
  end

def revert_ajdacency_list(adjacency_list)
  reverted_ajdacency_list = {}
  adjacency_list.each do |source, destinations|
    destinations.each do |destination|
      if reverted_ajdacency_list.key? destination
        reverted_ajdacency_list[destination].add(source)
      else
        reverted_ajdacency_list[destination] = Set[source]
      end
    end
  end
  reverted_ajdacency_list
end

def count_accessible(adjacency_list, node, visited)
  visited.add(node)
  accessible = 1
  if adjacency_list.key? node
    adjacency_list[node].each do |destination|
      if !visited.include? destination
        accessible += count_accessible(adjacency_list, destination, visited)
      end
    end
  end
  return accessible
end

p (count_accessible(revert_ajdacency_list(containers2containedAL), 'shiny gold', Set.new) - 1)





