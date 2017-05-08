class Integer
  def fast_expo(b, m)
    # b -> exponente
    # m -> modulo
    x = 1
    y = self % m
    while b > 0 && y > 1
      if b.odd?
        x = (x * y) % m
        b -= 1
      else
        y *= y % m
        b /= 2
      end
    end
    x
  end
end

def fast_expo(base, exponente, modulo)
  # b -> exponente
  # m -> modulo
  x = 1
  y = base % modulo
  while exponente > 0 && y > 1
    if exponente.odd?
      x = (x * y) % modulo
      exponente -= 1
    else
      y *= y % modulo
      exponente /= 2
    end
  end
  x
end

# para calcular "e", que es el inverso de d modulo Φ(n)
# https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Computing_multiplicative_inverses_in_modular_structures
def modular_inverse(a, n)
  t = 0
  r = n
  newt = 1
  newr = a

  while newr != 0
    quotient = r / newr
    p quotient
    t, newt = newt, t - quotient * newt
    r, newr = newr, r - quotient * newr
  end
  return false if r > 1
  t += n if t < 0
  t
end

# i = modular_inverse(1619, 2520)
# p i

# Output: prime:0, composite:1
# l: veces a iterar, n: numero a probar
# source: http://studentnet.cs.manchester.ac.uk/resources/library/3rd-year-projects/2016/tong.ding.pdf
# steps:
# 1. Pick a random integer a, 1 <= a < n.
# 2. Let c be a
# n−1/2 mod n.
# 3. If c is neither 1 nor n−1, then return n as composite, otherwise store c into an array.
# 4. Loop for l times, keep trying different random values of a.
# 5. If any element in array is not equal to 1, return n as composite. Otherwise, n is prime.
def lehmann(n, l)
  b = []
  for it in 1..l
    a = Random.rand(1..n - 1)
    c = a**((n - 1) / 2) % n
    if c != 1 && c != n - 1
      return 1
    else
      b.insert(it, c)
    end
  end

  return 1 if b.all? { |num| num == 1 } == true
  0
end

def gcd_euclides(a, b)
  while b != 0
    t = b
    b = a % b
    a = t
  end
  a
end

LETTER_TO_INDEX = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7,

                    'I' => 8, 'J' => 9, 'K' => 10, 'L' => 11, 'M' => 12, 'N' => 13, 'O' => 14, 'P' => 15, 'Q' => 16, 'R' => 17, 'S' => 18,

                    'T' => 19, 'U' => 20, 'V' => 21, 'W' => 22, 'X' => 23, 'Y' => 24, 'Z' => 25 }.freeze

def finder(hash, str)
  hash[str] || hash.key(str)
end

# msg = "MANDADINEROS"
# arr = []
# msg.each_char do |char|
#     index_of_letter = finder(LETTER_TO_INDEX, char)
#     arr.push(index_of_letter)
# end
#  p arr
#
#  base = LETTER_TO_INDEX.length
#  tam = 2
#  vec = arr.each_slice(tam).to_a
#
#  nuevo = []
#
#  # 0*26^3+1*26^2+2*26+3=731
#  vec.each { |item|
#      valor = 0
#      t = 0
#      for it in 0...item.length
#          #valor = item[it] * (base**(item.length-1)-it)
#          p "#{item[it]} * #{base}} elevado a #{(item.length-1)-it}"
#          iter = (item.length-1)-it
#          ex = base ** iter
#          mul = item[it]
#          v = mul * ex
#          t += v
#          #p t
#          puts
#      end
#      nuevo.push(t)
#
#  }
#  p nuevo
#

def set_block_size
  base = 26
  j = 0
  n = 2947
  j += 1 while base**j < n
  j - 1
end
res = set_block_size
p res
