  def KSA(key, action, s, message)
    key_length = key.length
    #---------KSA-----------
    k = Array.new
    for i in (0..255) #repitiendo los valores de la clave en el array k 255 veces
      k[i] = key[i % key_length]
    end
    puts 'El vector de semilla de clave es: '
    p k

    f = 0
    for i in (0..255)
      f = (f +  s[i] + k[i]) % 256
       s[i],  s[f] =  s[f],  s[i]
    end
    puts
    puts 'El vector de estado después de los intercambios es: '
    p s
    #-------FINAL KSA----------
    #llamada al método PRGA
    spritz_prga(action, s, message)
    #PRGA(action, s, message)
  end


  def spritz_prga(action, s, message)
    message_length = message.length
    key_stream = Array.new
    cifrado = Array.new
    i = 0
    j = 0
    k = 0
    w = 5
    z = 0
    size = 0

    #while (size < message_length) do
      i = i + w
      puts "s[i] #{s[i]}"
      #j = (k + s[(j + s[i])%256])
      j = ( k + s.at((j + s.at(i) % 256)))
      p "j #{j}"


      k = (i + k + s[j]) % 256
      s[i],  s[j] =  s[j],  s[i]
=begin
      prim = s[(z + k)%256]

      puts "Primero: #{prim}"
      seg = s[(i + prim) %256]

      puts "Segundo: #{seg}"
      acc = prim + seg
      puts "Acc: #{acc}"
      ter = s[(j + acc)%256]
      ter = s.at(j + acc) % 256
      puts "TER: #{ter}"
      z = ter % 256
=end
      #z = (s[j + s[i + s[z + k]]]) % 256
      prim = s.at(z + k) % 256
      p "prim #{prim}"
      seg = s.at(i + prim) % 256
      p"seg #{seg}"
      acc = prim + seg
      p "acc #{acc}"
      ter = s.at((j + acc) % 256)
      p "ter #{ter}"
      z = ter
      p " es !!!z #{z}"

      #z = (s.at(j + s.at(i + s.at(z + k)))) % 256


      key_stream[size] =  s.at(z)

      cifrado[size] = key_stream[size] ^ message[size]
      #size += 1
    #end
    puts "El key_stream es: #{key_stream}"
    if action == false
      puts "El valor de z es: #{z}"
      puts "El texto cifrado es: #{cifrado}"
    else
      puts "El valor de z es: #{z}"
      puts "El texto original es: #{cifrado}"
    end

  end



  def PRGA(action, s, message)
    message_length = message.length
    #----------PRGA----------
    key_stream = Array.new
    cifrado = Array.new
    original = Array.new
    i = 0
    j = 0
    k = 0

    while (k < message_length) do
      i = (i + 1) % 256
      j = (j +  s[i]) % 256
       s[i],  s[j] =  s[j],  s[i]
      t = ( s[i] + s[j]) % 256
      key_stream[k] =  s[t]

      cifrado[k] = key_stream[k] ^ message[k].to_i #XOR entre la secuencia cifrante y el mensaje
      original[k] = key_stream[k] ^ cifrado[k] #Obtenemos el mensaje original haciendo un XOR entre la secuencia cifrante y el texto cifrado

      k += 1
    end
    #-------FINAL PRGA-------
    puts
    if action == false
      puts "El texto cifrado es: #{cifrado}"
    else
      puts "El texto original es: #{cifrado}"
    end
  end


  #vector s, vector estado
  s = (0..255).to_a

puts 'Elija [1].Cifrar o [2].Descifrar'
choice = gets.chomp

if choice == '1'
  accion = false
  puts 'Introduzca el mensaje'
  msg = gets.chomp
  message = msg.split(' ').map(&:to_i)
  puts
  puts 'Introduzca la semilla de clave'
  clave = gets.chomp
  key = clave.split(' ').map(&:to_i)
  puts
  KSA(key, accion, s, message)
elsif choice == '2'
  accion = true
  puts 'Introduzca el mensaje cifrado'
  msg = gets.chomp
  message = msg.split(' ').map(&:to_i)
  puts
  puts 'Introduzca la semilla de clave'
  clave = gets.chomp
  key = clave.split(' ').map(&:to_i)
  puts
  KSA(key, accion, s, message)
else
  puts "Opción no soportada."
end
