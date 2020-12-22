file = File.open("input")
entries = file.read.split("\n")
file.close

inputPattern = /(?<first>\d+)-(?<second>\d+) (?<char>\w): (?<password>\w+)/

p (entries.count do |entry|
  elements = inputPattern.match(entry)
  firstMatch = elements[:password][elements[:first].to_i-1] == elements[:char]
  secondMatch = elements[:password][elements[:second].to_i-1] == elements[:char]
  firstMatch ^ secondMatch
end)
