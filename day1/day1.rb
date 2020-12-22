file = File.open("input")
values = file.read.split.map(&:to_i).sort
file.close

beginSecondHalf = values.index { |value| value > (2020 / 2) }

for i in 0..(beginSecondHalf - 1)
  for j in beginSecondHalf..(values.length - 1)
    if values[i] + values[j] == 2020
      p values[i] * values[j]
    end
  end
end
