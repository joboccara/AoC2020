class Symbol
  def with(*args)
    ->(object){ object.send(self, *args) }
  end
end

def passport_data(passport)
  passport.map{ |entry| /(?<label>\w\w\w):(?<data>.+)/.match(entry) }
end

file = File.open('input')
passports = file.read
            .split("\n\n")
            .map(&:sub.with("\n"," "))
            .map(&:split.with(" "))
            .map(&method(:passport_data))

file.close

required_labels = [ 'byr' , 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid' ]

def label_index(passport, label)
  passport.index {|element| element['label'] == label}
end

def read_label(passport, label)
  passport[label_index(passport, label)]['data']
end

def is_within?(value, low, high)
  return low <= value && value <= high
end

def valid_height?(hgt)
  height = /^(?<value>\d+)(?<unit>(cm|in))$/.match(hgt)
  height &&
    ((height[:unit] == "cm" && is_within?(height[:value].to_i, 150, 193)) || (height[:unit] == "in" && is_within?(height[:value].to_i, 59, 76)))
end

is_valid =
{
  'byr' => ->(byr){ byr.length == 4 && is_within?(byr.to_i, 1920, 2002) },
  'iyr' => ->(iyr){ iyr.length == 4 && is_within?(iyr.to_i, 2010, 2020) },
  'eyr' => ->(eyr){ eyr.length == 4 && is_within?(eyr.to_i, 2020, 2030) },
  'hgt' => method(:valid_height?),
  'hcl' => ->(hcl){ /^#([a-f]|[0-9]){6}$/.match?(hcl) },
  'ecl' => ->(ecl){ ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].any? ecl },
  'pid' => ->(pid){ /^\d{9}$/.match?(pid) }
}

define_method(:is_valid?) do |label, data|
  is_valid[label].(data)
end

p (passports.count { |passport| required_labels.all? { |label| label_index(passport, label) && is_valid?(label, read_label(passport, label)) } })

