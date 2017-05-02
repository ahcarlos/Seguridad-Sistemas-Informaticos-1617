=begin
# esto sería en el caso de texto
k = Array.new
for i in (0..255) #repitiendo los valores de la clave en el array k 255 veces
  k[i] = key.getbyte(i % key_length)
end

f = 0
for i in (0..255)
  f = (f + s[i] + k[i]) % 256
  s[i], s[f] = s[f], s[i]
end

p s


i = 4
j = key.getbyte(i % key_length) % 256
 p j

   0.upto(255) do |i|
      s2 << key_arr[i % key.bytesize]
   end
=end
