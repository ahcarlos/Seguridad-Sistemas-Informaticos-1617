class Integer
  # Se modifica la clase entero para añadir la exponenciación rápida
  # @param b [Integer] base
  # @param m [Integer] módulo a aplicar
  # @return [Integer] resultado de la exponenciación rápida
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

# Algoritmo de euclides para comprobar que dos números son coprimos
# @param a [Integer] primer número
# @param b [Integer] segundo número
# @return [Integer] si devuelve 1 son coprimos, en otro caso, no son coprimos
def gcd_euclides(a, b)
  while b != 0
    t = b
    b = a % b
    a = t
  end
  a
end

# Test de primalidad de Lehmann
# Pasos:
# 1. Pick a random integer a, 1 <= a < n.
# 2. Let c be a**(n−1)/2 mod n.
# 3. If c is neither 1 nor n−1, then return n as composite, otherwise store c into an array.
# 4. Loop for l times, keep trying different random values of a.
# 5. If any element in array is not equal to 1, return n as composite. Otherwise, n is prime.
# @note fuente: http://studentnet.cs.manchester.ac.uk/resources/library/3rd-year-projects/2016/tong.ding.pdf
# @param n [Integer] el número que queremos probar si es primo o compuesto
# @param l [Integer] el número de veces que se hace la comprobación, ya que es probabilístico
# @return [Integer] 0 si es número primo, 1 si es número compuesto
def lehmann_test(n, l)
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

def require_data
  prime_p = 0 # privado
  prime_q = 0 # privado
  d = 0
  phi = 0
  loop do
    puts 'Introduce el número p, tiene que ser primo'
    prime_p = gets.to_i
    break if lehmann_test(prime_p, 100).zero?
  end

  loop do
    puts 'Introduce el número q, tiene que ser primo'
    prime_q = gets.to_i
    break if lehmann_test(prime_q, 100).zero?
  end

  phi = (prime_p - 1) * (prime_q - 1)
  n = prime_p * prime_q # publica

  loop do
    puts "Introduce el valor de d, tal que sea comprimo con Φ(n)= #{phi}"
    d = gets.to_i
    break if gcd_euclides(d, phi) == 1
  end
  p
  puts 'Introduce el mensaje:'
  msg = gets.chomp
  rsa_object = RSA.new(prime_p, prime_q, d, phi, msg)
  # return fs_object
end

# @author Carlos de Armas Hernández
class RSA
  # Clase que implementa el cifrado y descifrado RSA
  # @!attribute p
  #   @return [Integer] Número primo p
  # @!attribute q
  #   @return [Integer] Número primo q
  # @!attribute d
  #   @return [Integer] Entero primo con phi
  # @!attribute phi
  #   @return [Integer] (p - 1) * (q - 1)
  # @!attribute e
  #   @return [Integer] Inverso de d módulo phi(n)
  # @!attribute n
  #   @return [Integer] (p * q)
  # @!attribute message
  #   @return [String] El mensaje sin espacios en blanco
  # @!attribute numeric_encrypt
  #   @return [Array] Cifrado numérico
  # @!attribute final_encrypt
  #   @return [Array] Cifrado final, c_i = m_i**e mod n
  # @!attribute block_size
  #   @return [Integer] Tamaño del bloque
  # @!attribute decrypted
  #   @return [Array] Vector con el texto descifrado
  # @!attribute arr
  #   @return [Array] Vector donde se almacenan los índices de las letras del mensaje

  attr_accessor :p, :q, :d, :phi, :n, :e, :message, :numeric_encrypt, :final_encrypt, :decrypted, :block_size

  def initialize(prime_p, q, d, msg)
    @p = prime_p # inf privada
    @q = q # inf privada
    @d = d # inf privada
    @phi = (@p - 1) * (@q - 1) # inf privada
    @n = @p * @q # inf publica
    @e = modular_inverse(@d, @phi) # inf publica
    @message = msg.delete(' ') # al mensaje le quitamos los espacios en blanco
    @numeric_encrypt = [] # aquí va el cifrado numérico
    @final_encrypt = [] # cifrado final
    @decrypted = []
    @arr = [] # array de indices
    @LETTER_TO_INDEX = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7,

                         'I' => 8, 'J' => 9, 'K' => 10, 'L' => 11, 'M' => 12, 'N' => 13, 'O' => 14, 'P' => 15, 'Q' => 16, 'R' => 17, 'S' => 18,

                         'T' => 19, 'U' => 20, 'V' => 21, 'W' => 22, 'X' => 23, 'Y' => 24, 'Z' => 25 }.freeze
    @block_size = set_block_size
  end

  #   to_s de la clase, permite ver información por pantalla
  def to_s
    puts 'Información privada'
    puts "p = #{@p}, q = #{@q}, d = #{@d}, Φ(n) = #{@phi}"
    puts
    puts 'Información pública'
    puts "n = #{@n}, e = #{@e}"
    puts
    puts "Tamaño del bloque = #{@block_size}"
    puts
  end

  # Busca en el hash por clave o por valor de manera que se devuelve la letra o el índice
  # @param str [Integer|String] letra o índice por el que se desea buscar
  # @return [Integer|String] la letra o el índice resultante
  def finder(str)
    @LETTER_TO_INDEX[str] || @LETTER_TO_INDEX.key(str)
  end

  # Establece el tamaño del bloque
  # @return [Integer] el tamaño del bloque que se va a usar
  def set_block_size
    base = @LETTER_TO_INDEX.length
    j = 0
    j += 1 while base**j < @n
    j - 1
  end

  # Para calcular "e", que es el inverso de d modulo phi(n)
  # @note fuente: https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Computing_multiplicative_inverses_in_modular_structures
  # @param a [Integer] el numero d
  # @param n [Integer] phi de n
  # @return [Integer] el inverso
  def modular_inverse(a, n)
    t = 0
    r = n
    newt = 1
    newr = a

    while newr != 0
      quotient = r / newr
      t, newt = newt, t - quotient * newt
      r, newr = newr, r - quotient * newr
    end
    return false if r > 1
    t += n if t < 0
    t
  end

  # Realiza la codificación numérica
  # @note modifica el atributo numeric_encrypt
  def numeric_cypher
    @message.each_char do |char|
      index_of_letter = finder(char)
      @arr.push(index_of_letter)
    end
    puts "Vector de índices de las letras del mensaje #{@arr.inspect}"
    base = @LETTER_TO_INDEX.length # tamaño del alfabeto (es la base de la codificacion numerica)
    vec = @arr.each_slice(@block_size).to_a # PARTIMOS EL VECTOR SEGUN EL TAMAÑO DEL BLOQUE
    vec.each do |item|
      t = 0
      for it in 0...item.length
        # tuve que separarlo mucho para que los resultados fueran correctos
        # p "#{item[it]} * #{base}} elevado a #{(item.length-1)-it}"
        iter = (item.length - 1) - it
        ex = base**iter
        mul = item[it]
        v = mul * ex
        t += v
      end
      @numeric_encrypt.push(t)
    end
    puts
    puts "Resultado de la codificación numérica: #{@numeric_encrypt}"
    puts
  end

  # Realiza el cifrado final
  # @note modifica el atributo final_encrypt
  def encrypt
    @numeric_encrypt.each do |item|
      cipher = item.fast_expo(@e, @n)
      @final_encrypt.push(cipher)
    end

    puts "El cifrado final es: #{@final_encrypt}"
    puts
  end

  def decto26(int)
    tam = @block_size
    b = []
    i = 0
    while i < tam
      r = int % 26
      int /= 26
      b[tam - i - 1] = @decrypted[r]
      i += 1
    end
    puts b.to_s
  end

  # Realiza el descifrado
  # @note modifica el atributo decrypted
  def decrypt
    @final_encrypt.each do |element|
      m_i = element.fast_expo(@d, @n)
      @decrypted.push(m_i)
    end

    puts "El mensaje descifrado en índices es: #{@decrypted}"
  end
end

puts '------ Ejemplo 1 ------'
msg_test = 'MANDA DINEROS'
prueba = RSA.new(421, 7, 1619, msg_test)
prueba.to_s
prueba.numeric_cypher
prueba.encrypt
prueba.decrypt
puts
puts '------ Ejemplo 2 ------'
msg_test2 = 'AMIGO MIO'
prueba2 = RSA.new(2347, 347, 5, msg_test2)
prueba2.to_s
prueba2.numeric_cypher
prueba2.encrypt
prueba2.decrypt
puts
