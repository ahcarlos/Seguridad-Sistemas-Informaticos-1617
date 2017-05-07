def fast_expo(base, expo, modulo)
    # b -> exponente
    # m -> modulo
    x = 1
    y = base % modulo
    while expo > 0 && y > 1
        if expo.odd?
            x = (x * y) % modulo
            expo -= 1
        else
            y *= y % modulo
            expo /= 2
        end
    end
    x
end
 
def gcd_euclides(a, b)
   while b != 0
       t = b
       b = a % b
       a = t
   end
   a
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
        t, newt = newt, t - quotient * newt
        r, newr = newr, r - quotient * newr
    end
    return false if r > 1
    if t < 0 
        t += n
    end
    t
end

# Lehman primality test
# Output: prime:0, composite:1
# l: veces a iterar, n: numero a probar
# source: http://studentnet.cs.manchester.ac.uk/resources/library/3rd-year-projects/2016/tong.ding.pdf
# steps:
# 1. Pick a random integer a, 1 <= a < n.
# 2. Let c be a**(n−1)/2 mod n.
# 3. If c is neither 1 nor n−1, then return n as composite, otherwise store c into an array.
# 4. Loop for l times, keep trying different random values of a.
# 5. If any element in array is not equal to 1, return n as composite. Otherwise, n is prime.
def lehmann_test(n, l)
    b = []
    for it in 1..l
        a = Random.rand(1..n-1)
        c = a**((n-1)/2) % n
        if c != 1 && c != n - 1
            return 1
        else
            b.insert(it, c)
        end
    end
    
    if b.all? { |num| num == 1 } == true
        return 1
    end
    return 0
end

def require_data
    prime_p = 0 # privado
    prime_q = 0 # privado
    d = 0
    phi = 0
    loop do 
        puts "Introduce el número p, tiene que ser primo"
        prime_p = gets.to_i
    break if lehmann_test(prime_p, 100) == 1
    end
    
    loop do 
        puts "Introduce el número q, tiene que ser primo"
        prime_q = gets.to_i
    break if lehmann_test(prime_q, 100) == 1
    end
    
    phi = (prime_p - 1) * (prime_q - 1)
    n = prime_p * prime_q # publica
    
    loop do
        puts "Introduce el valor de d, tal que sea comprimo con Φ(n)= #{phi}"
        d = gets.to_i
        break if gcd_euclides(d, phi) == 1
    end
    
    
    fs_object = FiatShamir.new(prime_p, prime_q, s, iter)
    # return fs_object
end
    