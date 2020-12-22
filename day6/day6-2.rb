class Symbol
  def with(*args)
    ->(object){ object.send(self, *args) }
  end
end

file = File.open('input')
answers = file.read.split("\n\n")
file.close

p answers.map(&:split).map{|string_array| string_array.map(&:chars) }.map(&:reduce.with(:&)).map(&:size).sum
