require 'set'

file = File.open('input')
rules = file.read.split("\n")
file.close

containers2containedAL = {}
rules
  .map{|rule| /^(?<container>.*) bags contain(?<contained>.*)\.$/.match(rule)}
  .each do |matchdata|
  containers2containedAL[matchdata[:container]] = {}
    if matchdata[:contained] != " no other bags"
      matchdata[:contained].split(',').each do |contained|
        destination = / (?<number>\d+) (?<color>.*) bag/.match(contained)
        containers2containedAL[matchdata[:container]][destination[:color]] = destination[:number].to_i
      end
    end
end

def sum_accessible_bags(adjacency_list, node)
  empty_bag = !(adjacency_list.include? node) || adjacency_list[node].empty?
  if empty_bag then return 1 end

  sum = 1
  adjacency_list[node].each do |color,number|
    sum += number * sum_accessible_bags(adjacency_list, color)
  end
  return sum
end

p sum_accessible_bags(containers2containedAL, 'shiny gold') - 1
