class Array
  def top
    last
  end
end

file = File.open('input')
expressions = file.read.split("\n")
file.close

def is_digit(c)
  return '0'.ord <= c.ord && c.ord <= '9'.ord
end

class Token
  attr_accessor :type
  attr_accessor :value
  def initialize(type, value)
    @type = type
    @value = value
  end
end

def lex(expression)
  expression.chars.reduce ([]) do |tokens, c|
    if is_digit(c)
      tokens.append(Token.new('number', c.to_i))
    elsif c == '+'
      tokens.append(Token.new('operator', '+'))
    elsif c == '*'
      tokens.append(Token.new('operator', '*'))
    elsif c == '('
      tokens.append(Token.new('open bracket', '('))
    elsif c == ')'
      tokens.append(Token.new('close bracket', ')'))
    end
    tokens
  end
end

class Node
  attr_accessor :value
  attr_accessor :children
  def initialize(value)
    @value = value
    @children = []
  end

  def add_child(child)
    @children.append(child)
  end
end

def pop_operator(outputs_stack, operators_stack)
  operator = operators_stack.pop
  right = outputs_stack.pop
  left = outputs_stack.pop
  operation = Node.new(operator)
  operation.add_child(left)
  operation.add_child(right)
  outputs_stack.push(operation)
end

def precedence(op1, op2)
  if op1 == op2 then return 0 end
  if [op1,op2] == ['*','+'] then return 1 end
  -1
end

def parse(tokens)
  outputs_stack = []
  operators_stack = []

  tokens.each do |token|
    case token.type
    when 'number'
      outputs_stack.push(Node.new(token.value))
    when 'operator'
      if outputs_stack.size >= 2 && !operators_stack.empty? && operators_stack.top != '(' && precedence(operators_stack.top, token.value) != 1
        pop_operator(outputs_stack, operators_stack)
      end
      operators_stack.push(token.value)
    when 'open bracket'
      operators_stack.push(token.value)
    when 'close bracket'
      until operators_stack.top == '('
        pop_operator(outputs_stack, operators_stack)
      end
      operators_stack.pop
    end
  end
  until operators_stack.empty?
    pop_operator(outputs_stack, operators_stack)
  end
  outputs_stack.first
end

def print_tree(tree)
  print tree.value
  if !tree.children.empty?
    print '{'
    tree.children.each {|child| print_tree(child) }
    print '}'
  end
end

def compute_tree(tree)
  case tree.value
  when '+'
    compute_tree(tree.children[0]) + compute_tree(tree.children[1])
  when '*'
    compute_tree(tree.children[0]) * compute_tree(tree.children[1])
  else
    tree.value
  end
end

p expressions.map{|expression| compute_tree(parse(lex(expression)))}.sum

