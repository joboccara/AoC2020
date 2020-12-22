class Symbol
  def with(*args)
    ->(object){ object.send(self,*args) }
  end
end

file = File.open('input')
layout = file.read.split
file.close

def next_in_direction(layout, row, seat, down, right)
  if row + down >= layout.size || seat + right >= layout[0].size || row + down < 0 || seat + right < 0
    return nil
  end

  next_close = layout[row + down][seat + right]
  if next_close == '.'
    next_in_direction(layout, row + down, seat + right, down, right)
  else
    next_close
  end
end


def add_seat_if_exists(layout, seats, row, seat, down, right)
  next_seat = next_in_direction(layout, row, seat, down, right)
  if next_seat then seats.append(next_seat) end
end

def surrounding_seats(layout, row, seat)
  seats = []
  add_seat_if_exists(layout, seats, row, seat, 1, 1)
  add_seat_if_exists(layout, seats, row, seat, 1, 0)
  add_seat_if_exists(layout, seats, row, seat, 1, -1)
  add_seat_if_exists(layout, seats, row, seat, 0, 1)
  add_seat_if_exists(layout, seats, row, seat, 0, -1)
  add_seat_if_exists(layout, seats, row, seat, -1, 1)
  add_seat_if_exists(layout, seats, row, seat, -1, 0)
  add_seat_if_exists(layout, seats, row, seat, -1, -1)
  seats
end


def sit(layout)
  new_layout = layout.clone.map(&:clone)
  layout.each_with_index do |row, r|
    row.chars.each_with_index do |seat, s|
      case seat
      when 'L'
        if !surrounding_seats(layout, r, s).include? '#' then new_layout[r][s] = '#' end
      when '#'
        if surrounding_seats(layout, r, s).count('#') >= 5 then new_layout[r][s] = 'L' end
      end
    end
  end
  new_layout
end

def display(array)
  array.map(&method(:p))
end

def stable_layout(layout)
  previous_layout = layout.clone.map(&:clone)
  layout = sit(layout)
  while layout != previous_layout
    previous_layout = layout
    layout = sit(layout)
  end
  layout
end

p stable_layout(layout).map(&:count.with('#')).sum
