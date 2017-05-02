LETTER_TO_INDEX = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4, 'F' => 5, 'G' => 6, 'H' => 7,
                    'I' => 8, 'J' => 9, 'K' => 10, 'L' => 11, 'M' => 12, 'N' => 13, 'O' => 14, 'P' => 15, 'Q' => 16, 'R' => 17, 'S' => 18,
                    'T' => 19, 'U' => 20, 'V' => 21, 'W' => 22, 'X' => 23, 'Y' => 24, 'Z' => 25 }.freeze

# busca en un hash por clave o por valor
def finder(hash, str)
    hash[str] || hash.key(str)
end

def vigenere_cipher(string, keys, action)
    # encrypted_word ->se almacenará el resultado del cifrado o descifrado
    encrypted_word = ''
    string.each_char.with_index do |char, i|
        key1 = keys[i % keys.length]
        key = finder(LETTER_TO_INDEX, key1)
        index_char_msg = finder(LETTER_TO_INDEX, char)

        if action == false # cifrar
            # ex= (x+n)mod(26) -> cifrado
            # el tamaño del alfabeto es 26 (no incluye la ñ)
            # para poder usar cualquier tamaño del alfabeto cambiamos el 26 por el tamaño del alfabeto que se usa
            ex = (index_char_msg + key) % LETTER_TO_INDEX.length
            encrypted_word << finder(LETTER_TO_INDEX, ex)
        else
            # dx= (x-n)mod(26) -> descifrado
            dx = (index_char_msg - key) % LETTER_TO_INDEX.length
            encrypted_word << finder(LETTER_TO_INDEX, dx)
        end
    end
    encrypted_word.upcase
end

# alfabeto con ñ y espacio
# LETTER_TO_INDEX = {"a"=>0,"b"=> 1,"c"=> 2,"d"=> 3,"e"=> 4,"f"=> 5,"g"=> 6,"h"=> 7,
# "i"=> 8,"j"=> 9, "k"=>10, "l"=>11, "m"=>12, "n"=>13, "o"=>14, "ñ"=>15,"p"=>16, "q"=>17, "r"=>18, "s"=>19, "t"=>20, "u"=>21,
# "v"=>22, "w"=>23, "x"=>24, "y"=>25, "z"=>26, " "=>27}

# msg= "este mensaje se autodestruira ññññ"
# msg= "este mensaje se autodestruira"
# msg= "morrgdxvek"
# msg2= msg.delete(' ')
# clave= "lunes"

puts 'Elija [1].Cifrar o [2].Descifrar'
choice = gets.chomp

if choice == '1'
    accion = false
    puts 'Introduzca el mensaje'
    msg = gets.chomp
    msg_org = msg.delete(' ') # quitamos los espacios del mensaje
    puts
    puts 'Introduzca la clave'
    clave = gets.chomp
    puts
    p "El mensaje cifrado es: #{vigenere_cipher(msg_org, clave, accion)}"
    #p vigenere_cipher(msg_org, clave, accion)

elsif choice == '2'
    accion = true
    puts 'Introduzca el mensaje cifrado'
    msg = gets.chomp
    msg_org = msg.delete(' ')
    puts
    puts 'Introduzca la clave'
    clave = gets.chomp
    puts
    p "El mensaje original es: #{vigenere_cipher(msg_org, clave, accion)}"

elsif
  p 'Opción no soportada.'
end
