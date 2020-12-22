file = File.open('input')
lines = file.read.split("\n")
file.close

def nbTrees(lines, right, down)
  length = lines[0].length
  currentColumn = 0

  lines.each_slice(down).map(&:first).count do |line|
    isTree = line[currentColumn] == '#'
    currentColumn += right
    currentColumn %= length
    isTree
  end
end

n1 = nbTrees(lines, 1, 1) 
n2 = nbTrees(lines, 3, 1) 
n3 = nbTrees(lines, 5, 1) 
n4 = nbTrees(lines, 7, 1) 
n5 = nbTrees(lines, 1, 2) 

p n1 * n2 * n3 * n4 * n5
