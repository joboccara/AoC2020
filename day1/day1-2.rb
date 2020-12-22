file = File.open("input")
values = file.read.split.map(&:to_i).sort
file.close

for v1 in values
  for v2 in values
    for v3 in values
      sum = v1 + v2 + v3 
      if sum == 2020
        p v1 * v2 * v3
      elsf sum > 2020
        break
      end
    end
  end
end
