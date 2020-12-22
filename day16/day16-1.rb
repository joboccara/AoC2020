file = File.open('input')
file_contents = file.read.split("\n\n")
file.close

ranges_predicates =
  file_contents[0]
  .split("\n")
  .map{ |range| /(?<type>.*): (?<low1>\d+)-(?<high1>\d+) or (?<low2>\d+)-(?<high2>\d+)/.match(range) }
  .map{ |matchdata| ->(value){ matchdata[:low1].to_i <= value && value <= matchdata[:high1].to_i || matchdata[:low2].to_i <= value && value <= matchdata[:high2].to_i } }

nearby_tickets =
  file_contents[2]
  .split("\n")
  .drop(1)
  .map{ |ticket| ticket.split(',').map(&:to_i) }

p nearby_tickets
  .flatten
  .select{ |ticket| ranges_predicates.none?{ |range_predicate| range_predicate.call(ticket) } }
  .sum
