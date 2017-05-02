def clock_1(register1)
    puts
    p register1
    p register1.at(18)
    p register1.at(17)
    p register1.at(16)
    p register1.at(13)


    xor_reg1 = register1.at(18) ^ register1.at(17) ^ register1.at(16) ^ register1.at(13)
    p "RESULTADO #{xor_reg1}"
    register1.unshift(xor_reg1)
    register1.delete_at(19)
    p register1
end

def clock_2(register2)
    xor_reg2 = register2.at(21) ^ register2.at(20)
    register2.unshift(xor_reg2)
    register2.delete_at(22)
    puts "ENTRE!!!!"
end

def clock_3(register3)
    xor_reg3 = register3.at(22) ^ register3.at(21) ^ register3.at(20) ^ register3.at(7)
    register3.unshift(xor_reg3)
    register3.delete_at(23)
    puts "entre!!!!!"
end

#funcion mayoria
def majority(lfsr1, lfsr2, lfsr3)
    major = [lfsr1.at(C1), lfsr2.at(C2), lfsr3.at(C3)].join('')
    #p major
    #return ((R1[8] * R2[10]) ^ (R1[8] * R3[10]) ^ (R2[10] * R3[10]));
    if(major == '000' || major == '111') #se desplazan los tres registros
        r1 = 111
        #p "devuelvo r1 #{r1}"
        return r1
    elsif (major == '001' || major == '110') #se desplazan los registros 1 y 2
        r2 = 110
        #p "devuelvo r2 #{r2}"
        return r2
    elsif (major == '011' || major == '100') # se desplazan los registros 2 y 3
        r3 = 100
        #r3 = 011
        #p "devuelvo r3 #{r3}"
        return r3
    elsif (major == '101' || major == '010') # se desplazan los registros 1 y 3
        r4 = 101
        #p "devuelvo r4 #{r4}"
        return r4
    end

end

#iniciando los registros a 0
lfsr1 = Array.new(19, 0)
lfsr2 = Array.new(22, 0)
lfsr3 = Array.new(23, 0)
#Constantes clocking bit
C1 = 8
C2 = 10
C3 = 10

#semilla ="1001000100011010001010110011110001001101010111100110111100001111"
semilla = "0100111000101111010011010111110000011110101110001000101100111010"
key_session = semilla.split('').map(&:to_i) #la semilla convertida en array, el map es para pasar cada elemento a entero
#p key_session
counter = "1110101011001111001011"
frame_counter = counter.split('').map(&:to_i)


#STEP 2
i = 0
while (i < 64) do
  #.at() devuelve el valor de la posicion especificada
  #delete_at() elimina el elemento de la posicion especificada
  #.unshift(valor) añade al principio del array el valor y mueve los que ya estan
  valor1 = lfsr1.at(18) ^ lfsr1.at(17) ^ lfsr1.at(16) ^ lfsr1.at(13)
  meter_en_lfsr1 = key_session.at(i) ^ valor1
  lfsr1.unshift(meter_en_lfsr1)
  lfsr1.delete_at(19)

  valor2 = lfsr2.at(21) ^ lfsr2.at(20)
  meter_en_lfsr2 = key_session.at(i) ^ valor2
  lfsr2.unshift(meter_en_lfsr2)
  lfsr2.delete_at(22)

  valor3 = lfsr3.at(22) ^ lfsr3.at(21) ^ lfsr3.at(20) ^ lfsr3.at(7)
  meter_en_lfsr3 = key_session.at(i) ^ valor3
  lfsr3.unshift(meter_en_lfsr3)
  lfsr3.delete_at(23)

  i += 1
end
#p lfsr1
#p lfsr2
#p lfsr3
#END STEP 2

#STEP 3
j = 0
while (j < 22) do
  xor_value1 = lfsr1.at(18) ^ lfsr1.at(17) ^ lfsr1.at(16) ^ lfsr1.at(13)
  result1 = frame_counter.at(j) ^ xor_value1
  lfsr1.unshift(result1)
  lfsr1.delete_at(19)

  xor_value2 = lfsr2.at(21) ^ lfsr2.at(20)
  result2 = frame_counter.at(j) ^ xor_value2
  lfsr2.unshift(result2)
  lfsr2.delete_at(22)

  xor_value3 = lfsr3.at(22) ^ lfsr3.at(21) ^ lfsr3.at(20) ^ lfsr3.at(7)
  result3 = frame_counter.at(j) ^ xor_value3
  lfsr3.unshift(result3)
  lfsr3.delete_at(23)
  j += 1
end
#END STEP 3

#STEP 4
#desplazar registro que se le pasa por parametro
h = 0
while ( h < 20)
    desplaza = majority(lfsr1, lfsr2, lfsr3)
    puts
    if (desplaza == 111)
        clock_1(lfsr1)
        clock_2(lfsr2)
        clock_3(lfsr3)
        p "entro 111"

    elsif (desplaza == 110)
        clock_1(lfsr1)
        clock_2(lfsr2)
        p "entro 110"

    elsif (desplaza == 100)
        clock_2(lfsr2)
        clock_3(lfsr3)
        p "entro 100"

    elsif (desplaza == 101)
        clock_1(lfsr1)
        clock_3(lfsr3)
        p "entro 101"
    end
    p h
    h += 1
end
puts "R1: #{lfsr1}"
=begin

p lfsr1.length

puts "R2: #{lfsr2}"
p lfsr2.length

puts "R3: #{lfsr3}"
p lfsr3.length
=end

=begin
puts "operacion frame counter #{lfsr1}"
p lfsr1.length

puts "operacion frame counter #{lfsr2}"
p lfsr2.length

puts "operacion frame counter #{lfsr3}"
p lfsr3.length
=end
