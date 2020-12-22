file = File.open("input")
entries = file.read.split("\n")
file.close

inputPattern = /(?<low>\d+)-(?<high>\d+) (?<char>\w): (?<password>\w+)/

p (entries.count do |entry|
  elements = inputPattern.match(entry)
  nb = elements[:password].chars.tally[elements[:char]].to_i
  elements[:low].to_i <= nb && nb <= elements[:high].to_i
end)
