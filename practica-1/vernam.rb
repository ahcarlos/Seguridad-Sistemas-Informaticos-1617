# encoding: ISO-8859-1
# coding: ISO-8859-1
# -*- coding: ISO-8859-1 -*-

module Vernam
  def Vernam.CodificarDecodificar(key, msg, action)
      key_bin = key.unpack("B*")[0]
      msg_bin = msg

      if action == true
        puts
        p "El mensaje cifrado en binario es: #{msg_bin}"
        p "La longitud del mensaje cifrado en binario es: #{msg_bin.length}"
      else
        puts
        p "El mensaje original en binario: #{msg_bin}"
        p "La longitud del mensaje original en binario es: #{msg_bin.length}"
      end

      msg_cif_bin =  (key_bin.to_i(2) ^ msg_bin.to_i(2)).to_s(2).rjust(key_bin.length, "0")
      #MODIFICACION 2: HACER UN SEGUNDO XOR CON LA CLAVE
      #xor2 = (msg_cif_bin.to_i(2) ^ key_bin.to_i(2)).to_s(2).rjust(key_bin.length, "0")
      msg_cif_text = [msg_cif_bin].pack("B*")

      if action == true
        puts
        p "Salida:"
        p "Mensaje original en binario: #{msg_bin}"
        p "Mensaje original: #{msg_cif_text}"
      else
        puts
        p "Salida:"
        p "Mensaje cifrado en binario: #{msg_cif_bin}"
        p "Mensaje cifrado: #{msg_cif_text}"
        puts
        puts
        puts
        p "KEY BIN: #{key_bin}"
        p "MSG_BIN: #{msg_bin}"
        p "MSG_FIN: #{msg_cif_bin}"
      end
  end
end

 # cada letra equivale a 8 bits, 3x8= 24 es el tamaño del resultado
 # el rjust es para que se añadan los ceros de la izquierda de la cadena

puts "Elija [1].Cifrar o [2].Descifrar"
choice = gets.chomp

if choice == "1"
  accion = false
  puts "Introduzca el mensaje"
  msg_org = gets.chomp
  msg_bin = msg_org.unpack("B*")[0]
  longitud_clave = msg_bin.length

  puts "----------Sugerencia de clave aleatoria ----------"
  3.times do
    puts (1..longitud_clave).map { [0, 1].sample }.join
  end
  puts "---------------------------------------------------"
  puts

  puts "Introduzca la clave"
  clave = gets.chomp




  Vernam.CodificarDecodificar(clave, msg_bin, accion)
elsif choice == "2"
  accion = true
  puts "Introduzca el mensaje cifrado"
  msg_org = gets.chomp

  msg_bin = (msg_org.unpack("B*")[0])
  longitud_clave = msg_bin.length
  puts "----------Sugerencia de clave aleatoria----------"
  3.times do
    puts (1..longitud_clave).map { [0, 1].sample }.join
  end
  puts "--------------------------------------------------"
  puts
  puts "Introduzca la clave"
  clave = gets.chomp


  Vernam.CodificarDecodificar(clave, msg_bin, accion)
elsif
  p "Opción no soportada."
end
