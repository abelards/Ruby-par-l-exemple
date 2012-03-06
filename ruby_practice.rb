# -*- coding: utf-8 -*-
# 0) Avantage numéro un : la communauté !
#    Bouillon de culture pour les best practices : Agile, testing...
#    Beaucoup de bibliothèques et frameworks, dont Rails est le plus célèbre


# 1) oui, c'est un langage de script
str = "bonjour"
num = 7

# 2) syntaxe agréable qui se fait oublier.
#    Tout ce que le langage peut deviner est optionnel (points virgules, parenthèses...)

"#{str}, #{num} langages ce soir"
# => "bonjour, 7 langages ce soir"

# 3) sucre syntaxique, operateurs, post-conditions...
if num > 1 # if et end classiques
  num += 3 # opérateur +=
end
num

# ||= est l'opérateur qui assigne une valeur si la variable est vide
a ||= 4
a
a ||= 8
a

# si le code tient en une ligne on peut utiliser les post-conditions
# ça ressemble à un langage plus naturel, proche de l'anglais
# si vous ne savez pas coder en Ruby, vous saurez vite lire du Ruby !
puts "TIM" if num != 3
puts "TOW" if not num == 3
puts "TDI" unless num == 1

puts "I #{num == 3 ? 'love' : 'hate' } ternary operator"
# => "I love ternary operator"


# 4) tout est objet
str.capitalize # les chaînes et entiers ont des méthodes
"Ho ! " * 3 # et des opérateurs surchargés

num.times do # la syntaxe de bloc (scope / fonction anonyme / ...) est en accolades ou do/end
end
  puts "Ho !"
end


# 5) structures simples et efficaces

classics = ["Java", "C"] # tableau
classics << "Lisp" # ajout
classics += ["C++", "C#"] # addition de tableaux
classics.sort.join(", ")
# => "C, C#, C++, Java, Lisp"

scripts = ['ruby', 'python', 'perl', 'sh']
funcs = "Caml F# Haskell".split # un tableau à partir d'une string

hash = {"a" => 1, "b" => 2} # hash : tableau associatif

lang = { # clés de tout type / valeurs également
  :script => scripts,
  :c => classics,
  'JVM' => ['Scala', 'Clojure', '...'],
  ['fonctionnels'] => funcs
}

lang[:script]
lang[:js] = 'js'
lang[:scripts] << 'js'
lang[:classic] << 'js'
lang


# 6) API efficace, saveur fonctionnelle
# je veux tous mes langages : toutes les valeurs
lang.values
# ça me donne un tableau de tableaux, je veux un tableau
lang.values.flatten

# je veux enlever les doublons, trier par ordre alphabétique et les afficher séparés par des virgules
lang.values.flatten.uniq.sort.join(', ')
# => "..., C, C#, C++, Caml, Clojure, F#, Haskell, Java, Lisp,
#     Scala, js, perl, python, ruby, sh"

# je veux ne ressortir que les éléments contenant la lettre C
classics.select{|x| x.include? "C" }
# => ["C", "C++", "C#"]



# 7) programmation fonctionnelle avec des blocks
1.upto(4) {|i| puts "#{i}e#{i == 1 ? 'r' : 'me' }" }
# 1er
# 2eme
# 3eme
# 4eme

pows = "1 2 4 8 16 32 64".split.map{|x| x.to_i}

# inject c'est envoyer une valeur pour faire un fold
# la fonction est appliquée à tous les éléments en reprenant le résultat de l'appel d'avant en argument
pows.inject(0) {|x, sum| sum + x }
# => 127


# zip permet d'itérer sur plusieurs énumérables en même temps :
# elle créé un tableau de paires [élément i du tableau 1, élément i du tableau 2]
a1 = ['Pierre', 'Paul', 'Jacques']
a2 = [27, 32, 45]
a1.zip(a2) {|x,y| puts "#{x} a #{y} ans" }
# Pierre a 27 ans
# Paul a 32 ans
# Jacques a 45 ans


# 8) definition de fonction
def is_prime(i)
  2.upto(Math.sqrt(i).to_i) {|j|
    return false if i % j == 0
  }
  true
end

# 9) parametres optionnels
def aff_prime(x=1, y=42)
  x.upto(y) {|k|
    next unless is_prime(k)
    puts "#{k} is prime"
  }
end

# et hop, la même en une seule fonction
def premiers_de_x_a_y(x,y)
  (x..y).select {|i|
    !(2..(Math.sqrt(i).to_i)).any? {|j|
      i % j == 0
    }
  }
end

# et hop, la même en une seule ligne
def primes(x,y)
  (x..y).select {|i| !(2..(Math.sqrt(i).to_i)).any? {|j| i % j == 0 } }
end


aff_prime
aff_prime(127, 150)
primes

# 10) classes et accesseurs
class Point
  attr_accessor :x
  attr_accessor :y
end

p = Point.new
p.x = 3
p.y = -1
p.x
p.y
p

# 11) constructeur spécifique : surcharger "initialize"
class Carre
  attr_accessor :w

  def initialize(point, w=2)
    @point = point
    @w = w
  end

# 12) la philosophie Ruby encourage les getters et setters simples
  def x
    @point.x
  end

  def y
    @point.y
  end

  def x=(x)
    @point.x = x
  end

  def y(y)
    @point.y = y
  end


end

c = Carre.new(p)
c

# 13) l'heritage est simple
class Rectangle < Carre
  attr_accessor :h
end

# mais les modules peuvent simuler un excellent heritage multiple
String.ancestors



# 14) parametres
class Point
  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(*args)
    if args.first.respond_to?(:x)
      @x += args.first.x; @y += args.first.y
    elsif args.size > 1
      @x += x; @y += y
    end
  end
end

p.move(p)
p

r = Rectangle.new(Point.new(-2, 4))
r.h = 5
r

# 15) 'réouverture' de classes : on peut aussi modifier des instances
class Rectangle
  def area
    @w.to_i * @h.to_i
  end

end

# 16) normes, conventions et duck-typing
class Carre
  def area
    @w.to_i ** 2
  end

  def to_s
    "Carre : position (#{x}, #{y}), cote #{@w} "
  end
end

class Rectangle
  def to_s
    "Rectangle : position (#{@x}, #{@y})," +
    "largeur #{@w}, hauteur #{@h} "
  end

end

"#{c}#{r}"


# 17) integration Java sans probleme avec JRuby


# ruby 1.9

# new block syntax
# blk = ->(key, value) {puts key, value}
# {username: "roidrage", fullname: "Mathias Meyer"}.each &blk

# we can take splat args, but just one: hey, it's not magic
# blk = ->(first, *middle, last) {puts last}
# blk.(1, 2, 3)

