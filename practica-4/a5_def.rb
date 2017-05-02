lfsr1 = Array.new(19, 0)
lfsr2 = Array.new(22, 0)
lfsr3 = Array.new(23, 0)

key_stream = []
output = []

# Constantes clocking bit
C1 = 8
C2 = 10
C3 = 10

semilla1 = '1000101100010001001'
semilla2 = '0101100100011110011010'
semilla3 = '11110000111101100111101'

# Mensaje cifrado o descifrado
mensaje = '111111'
message = mensaje.split('').map(&:to_i)

lfsr1 = semilla1.split('').map(&:to_i)
lfsr2 = semilla2.split('').map(&:to_i)
lfsr3 = semilla3.split('').map(&:to_i)

def majority(lfsr1, lfsr2, lfsr3)
    majority_bit = ((lfsr1.at(C1) * lfsr2.at(C2)) ^ (lfsr1.at(C1) * lfsr3.at(C3)) ^ (lfsr2.at(C2) * lfsr3.at(C3)))
    # p "mayoria es #{major}"

    p lfsr1.at(C1)
    p lfsr2.at(C2)
    p lfsr3.at(C3)

    # se devuelve major
    majority_bit
end


# ====================================
# ======= MODIFICACIÓN ===============

h = 0
while h < 10

    desplaza = majority(lfsr1, lfsr2, lfsr3)

    if lfsr1.at(C1) == desplaza
        xor_reg1 = lfsr1.at(18) ^ lfsr1.at(17) ^ lfsr1.at(16) ^ lfsr1.at(13)
        lfsr1.unshift(xor_reg1)
        lfsr1.delete_at(19)
    end

    if lfsr2.at(C2) == desplaza
        xor_reg2 = lfsr2.at(21) ^ lfsr2.at(20)
        lfsr2.unshift(xor_reg2)
        lfsr2.delete_at(22)
    end

    if lfsr3.at(C3) == desplaza
        xor_value3 = lfsr3.at(22) ^ lfsr3.at(21) ^ lfsr3.at(20) ^ lfsr3.at(7)
        lfsr3.unshift(xor_value3)
        lfsr3.delete_at(23)
    end

    h += 1
end

# ======================
# == FIN MODIFICACIÓN ==

i = 0
while i < 6

    z = lfsr1.at(18) ^ lfsr2.at(21) ^ lfsr3.at(22)
    puts
    puts "EL BIT Z ES: #{z}"
    key_stream.push(z)

    desplaza = majority(lfsr1, lfsr2, lfsr3)

    if lfsr1.at(C1) == desplaza
        xor_reg1 = lfsr1.at(18) ^ lfsr1.at(17) ^ lfsr1.at(16) ^ lfsr1.at(13)
        lfsr1.unshift(xor_reg1)
        lfsr1.delete_at(19)
        puts "reg 1: #{lfsr1}"
    end

    if lfsr2.at(C2) == desplaza
        xor_reg2 = lfsr2.at(21) ^ lfsr2.at(20)
        lfsr2.unshift(xor_reg2)
        lfsr2.delete_at(22)
        puts "reg 2: #{lfsr2}"
    end

    if lfsr3.at(C3) == desplaza
        xor_value3 = lfsr3.at(22) ^ lfsr3.at(21) ^ lfsr3.at(20) ^ lfsr3.at(7)
        lfsr3.unshift(xor_value3)
        lfsr3.delete_at(23)
        puts "reg 3: #{lfsr3}"
    end

    i += 1
end

# puts
puts
puts "La secuencia cifrante es: #{key_stream}"

j = 0
while j < key_stream.length
    output[j] = key_stream.at(j) ^ message.at(j)
    j += 1
end

puts "Mensaje cifrado #{output}"
