class Symbol
  def with(*args)
    ->(object){object.send(self,*args)}
  end
end

file = File.open('input')
grid = file.read.split
file.close

iterations = 6
space_size = iterations + grid.size + iterations

space = []
space_size.times { space.append [] }

space.each do |x|
  space_size.times { x.append [] }
  x.each do |y|
    space_size.times { y.append [] }
    y.each do |z|
      space_size.times { z.append '.' }
    end
  end
end

grid.each_with_index do |line, i_line|
  line.chars.each_with_index do |status, i_status|
    space[i_line + iterations][i_status + iterations][iterations][iterations] = status
  end
end

def neighbours(x,y,z,w,space)
  offsets = [-1,0,1].product([-1,0,1]).product([-1,0,1]).product([-1,0,1]).map(&:flatten).reject{|combination| combination == [0,0,0,0]}
  offsets
    .map{|ox,oy,oz,ow| [x+ox,y+oy,z+oz,w+ow]}
    .select{|coords| coords.all?{|coord| 0<=coord && coord<space.size }}
end

iterations.times do
  space = space.each_with_index.map do |line,x|
    p x
    line.each_with_index.map do |col,y|
      col.each_with_index.map do |point,z|
        point.each_with_index.map do |status,w|
          active_neighbours = neighbours(x,y,z,w,space).map{|coords| space.dig(*coords)}.count('#')
          case status
          when '#'
            if [2,3].include? active_neighbours then '#' else '.' end
          when '.'
            if active_neighbours == 3 then '#' else '.' end
          end
        end
      end
    end
  end
end

def display(array)
  array.each{|element| p element}
end

p space.flatten.count('#')



