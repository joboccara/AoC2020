file = File.open('input')
file_contents = file.read.split("\n\n")
file.close

ranges_predicates =
  file_contents[0]
  .split("\n")
  .map{ |range| /(?<type>.*): (?<low1>\d+)-(?<high1>\d+) or (?<low2>\d+)-(?<high2>\d+)/.match(range) }
  .map{ |matchdata| ->(value){ matchdata[:low1].to_i <= value && value <= matchdata[:high1].to_i || matchdata[:low2].to_i <= value && value <= matchdata[:high2].to_i } }

my_ticket =
  file_contents[1]
  .split("\n")
  .drop(1)
  .map{ |ticket| ticket.split(',').map(&:to_i) }
  .flatten

nearby_tickets =
  file_contents[2]
  .split("\n")
  .drop(1)
  .map{ |ticket| ticket.split(',').map(&:to_i) }

def valid_value(value, ranges_predicates)
  ranges_predicates.any?{ |range_predicate| range_predicate.call(value) }
end

nearby_valid_tickets = nearby_tickets
  .select{ |ticket| ticket.all?{ |value| valid_value(value, ranges_predicates) } }

possibilities = nearby_valid_tickets
  .transpose
  .map do |field_values|
    ranges_predicates.each_index.select do |index|
      field_values.all?{|field_value| ranges_predicates[index].call(field_value)}
    end
  end

def contains_more_than_1(possibility)
  possibility.size > 1
end

def contains_1(possibility)
  possibility.size == 1
end

while possibilities.find{|possibility| possibility.size > 1}
  possibilities.select{|possibility| possibility.size > 1}
    .map{|possibility| possibilities.select{|possibility1| possibility1.size == 1}.each{|possibility1| possibility.delete_if{|value| value == possibility1[0]}}}
end

possibilities.flatten!

p my_ticket.values_at(*possibilities.each_index.select{|index| possibilities[index] < 6}).reduce(:*)
