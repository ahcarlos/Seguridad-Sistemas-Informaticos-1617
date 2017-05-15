
loop do
  puts
  puts '-----Menú con las prácticas de Seguridad en Sistemas Informáticos-----'
  puts 'Las prácticas incluyen las modificaciones'
  puts 'Opciones soportadas:'
  puts '[0].Salir'
  puts '[1].Vernam'
  puts '[2].Vigenere'
  puts '[3].RC4'
  puts '[4].A5/1'
  puts '[5].Algoritmo Rijndael'
  puts '[6].Algoritmo Diffie-Hellman'
  puts '[7].Algoritmo Fiat-Shamir'
  puts '[8].RSA'
  puts 'Introduzca una opción'
  n = gets.to_i

  case n
  when 1
    system('clear') || system('cls')
    load './prct/p1.rb'
  when 2
      system('clear') || system('cls')
    load './prct/p2.rb'
    
  when 3
    system('clear') || system('cls')
    load './prct/p3.rb'
  when 4
    system('clear') || system('cls')
    load './prct/p4.rb'
  when 5
    system('clear') || system('cls')
    load './prct/p5.rb'
  when 6
    system('clear') || system('cls')
    load './prct/p6.rb'
  when 7
    system('clear') || system('cls')
    load'./prct/p7.rb'
  when 8
    system('clear') || system('cls')
    load './prct/p8.rb'
  else
    puts 'Terminando ejecución.'
  end
  break if n.zero?
end
