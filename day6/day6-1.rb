file = File.open('input')
answers = file.read.split("\n\n")
file.close

p answers.map(&:split).map(&:join).map(&:chars).map(&:uniq).map(&:size).sum
