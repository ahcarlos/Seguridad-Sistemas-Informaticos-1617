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
        t, newt = newt, t - quotient * newt
        r, newr = newr, r - quotient * newr
    end
    return false if r > 1
    if t < 0 
        t += n
    end
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

def gcd_euclides(a, b)
    while b != 0
        t = b
        b = a % b
        a = t
    end
    a
end

p num = gcd_euclides(6, 35)








