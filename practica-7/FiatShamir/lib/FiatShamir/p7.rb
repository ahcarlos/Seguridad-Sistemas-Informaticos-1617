class FiatShamir
    attr_accessor :p, :q, :s, :it, :n, :v, :x
    def initialize(prime_p, prime_q, s, iterations)
        @p = prime_p # numero secreto primo p
        @q = prime_q # numero primo secreto q
        @s = s # numero secreto
        @it = iterations # numero de iteraciones
        @n = @p * @q # numero publico N (p * q)
        @v = (@s * @s) % @n # identifición pública de A
        @x # numero secreto x tal que 0 < x < N
        @a # testigo
        @y
    end
    
    def run
        for it in 0...@it
            puts
            puts "Iteración #{it+1}"
            loop do 
                puts "A escoge un número secreto x tal que 0 < x < N"
                @x = gets.to_i
            break if (@x > 0 && @x < @n)
            end
            
            @a = (@x * @x) % @n
            puts "Testigo: A envía a B a = #{@a}"
            puts "Reto: B envía a A un bit e, elegido al azar, introdúcelo"
            e = gets.to_i
            
            if e == 0
                @y = @x % @n
                # puts "Respuesta: A envía a B y = x (mod N)" 
            elsif e == 1
                @y = (@x * @s) % @n
                # puts "Respuesta: A envía a B y = xs (mod N)"
            end
            
            if it == @it - 1
                puts "Verificación: B comprueba la información recibida"
                if e == 0
                    puts "Comprobar que y^2 = a (mod N)"
                    puts "N = #{@n}"
                    puts "v = #{@v}"
                    puts "a = #{@a}, comprobar que #{@y}^2, #{@y * @y} ≡ #{@a} mod #{@n} y dar por válida la iteración."
                elsif e == 1
                    puts "Comprobar que y^2 = a*v (mod N)"
                    puts "N = #{@n}"
                    puts "v = #{@v}"
                    puts "a = #{@a}, comprobar que #{@y}^2, #{@y * @y} ≡ #{@a} * #{@v} mod #{@n} y dar por válida la iteración."
                end
            end
            
            
        end
    end
end

# cuando queremos comprobr si el numero es primo (para p, q introducidos por teclado)
# si prime es 2 significa que solo es divisible por 1 y por si mismo
def is_prime(number)
    prime = 0
    for i in 1..number
        if (number % i == 0)
            prime += 1
        end
    end
    return true if prime == 2
    return false
end

#algoritmo de euclides basado en modulo (tambien esta basado en resta)
# lo utilizamos para saber si dos numeros son coprimos, en cuyo caso se devuelve 1 ya que es el unico
# comun dvisor
def gcd_euclides(a, b)
    while b != 0
        t = b
        b = a % b
        a = t
    end
    a
end

def require_data
    prime_p = 0
    prime_q = 0
    s = 0
    loop do 
        puts "Introduce el número p, tiene que ser primo"
        prime_p = gets.to_i
    break if is_prime(prime_p)
    end
    
    loop do 
        puts "Introduce el número q, tiene que ser primo"
        prime_q = gets.to_i
    break if is_prime(prime_q)
    end
    
    n = prime_p * prime_q
    
    loop do
        puts "Introduce el valor de s (0 < s < N), tal que s y N=#{n} son coprimos"
        s = gets.to_i
        break if s <= 0 || s >= n || gcd_euclides(s, n) == 1
    end
    
    puts "Introduce el número de iteraciones"
    iter = gets.to_i
    
    fs_object = FiatShamir.new(prime_p, prime_q, s, iter)
    # return fs_object
end

 ejemplo_1 = FiatShamir.new(7, 5, 3, 2)
 ejemplo_1.run

ejemplo_2 = FiatShamir.new(683, 811, 43215, 1)
ejemplo_2.run

# modificacion, mostrar solo la ultima iteración
ejemplo_clase = FiatShamir.new(977, 983, 43215, 5)
ejemplo_clase.run