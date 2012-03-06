# -*- coding: utf-8 -*-

######################################################### FIZZBUZZ
limit = 30

# en très naïf
def fb1(x)
  if x % 5 == 0 && x % 3 == 0
    'FizzBuzz'
  elsif x % 3 == 0
    'Fizz'
  elsif x % 5 == 0
    'Buzz'
  else
    x
  end
end

1.upto(limit) {|i| puts fb1(i) }

# approche 2 : concaténation de chaîne
def fb2(x)
  s = "#{'Fizz' if x % 3 == 0}#{'Buzz' if x % 5 == 0}"
  return s == '' ? x : s
end

1.upto(limit) {|i| puts fb2(i) }

# la même en one-liner
def fb3(x)
  (x%5!=0 && x%3!=0) ? x : "#{'Fizz' if x % 3 == 0}#{'Buzz' if x % 5 == 0}"
end

1.upto(limit) {|i| puts fb3(i) }




######################################################### NOMBRES PREMIERS

# naïf
def is_prime(i)
  2.upto(Math.sqrt(i).to_i) {|j|
    return false if i % j == 0
  }
  true
end


def aff_prime(x=1, y=42)
  x.upto(y) {|k|
    next unless is_prime(k)
    puts "#{k} is prime"
  }
end

aff_prime

# la définition de votre prof de maths, indenté
def premiers_de_x_a_y(x,y)
  (x..y).select do |i|
    not (2..(Math.sqrt(i).to_i)).any? do |j|
      i % j == 0
    end
  end
end

# la même en one-liner
def premiers_de_x_a_y(x,y)
  (x..y).select {|i| !(2..(Math.sqrt(i).to_i)).any? {|j| i % j == 0 } }
end
