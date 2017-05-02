class Integer
    def fast_expo(b, m)
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

class DiffieHellman
    attr_accessor :public_value, :key, :count, :secret, :total_objects, :z
    attr_reader :prime, :alpha
    @@count = 0 # contador de instancias de la clase

    def initialize(secret, alpha, prime)
        @secret = secret # xA
        @alpha = alpha # generador
        @prime = prime # numero primo
        @public_value = @alpha.fast_expo(@secret, @prime) # yA
        @key # clave
        @@count += 1
        @total_objects = []
        @total_objects.push(@@count)
        @z
    end

    def generate_key(exchange_value)
        @key = exchange_value.fast_expo(@secret, @prime)
    end

    # --- parte modificacion ---
    def set_z(val)
        @z = val.fast_expo(@secret, @prime)
    end

    def key_gen_z(value)
        @key = value.fast_expo(@secret, @prime)
    end

    # --- fin parte modificacion ---
    def validate_key(other)
        if key == other.key
            puts "Las claves coinciden K1 = #{key}, K2 = #{other.key}"
        else
            puts "Las claves no coinciden K1 = #{key}, K2 = #{other.key}"
        end
    end

    def to_s
        puts "x#{@total_objects[0]} = #{@secret}, y#{@total_objects[0]} = #{@public_value},  K_z#{@total_objects[0]} = #{@key}"
    end
end
# ----- mi prueba -----
# alice = DiffieHellman.new(5, 4, 13)
# bob = DiffieHellman.new(2, 4, 13)

# alice.generate_key(bob.public_value)
# bob.generate_key(alice.public_value)

# alice.to_s
# bob.to_s
# ---- fin mi prueba -----

# ---- prueba modificacion -----
alice = DiffieHellman.new(14, 11, 23)
bob   = DiffieHellman.new(6, 11, 23)
carl  = DiffieHellman.new(3, 11, 23)

alice.set_z(carl.public_value)
bob.set_z(alice.public_value)
carl.set_z(bob.public_value)

alice.key_gen_z(carl.z)
bob.key_gen_z(alice.z)
carl.key_gen_z(bob.z)

alice.to_s
bob.to_s
carl.to_s
# --- fin prueba modificacion ---
