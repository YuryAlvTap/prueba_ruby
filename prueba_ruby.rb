# PRUEBA PROGRAMACION RUBY
CONST_ARCHIVO = 'Promedios_Alumnos.txt'
CONST_ARCHIVO1 = 'Alumnos.csv'
CONST_NOTA_DEFECTO = 5.0
def vuelve_menu
   puts"Quiere volver al menu? S/N"
   v = gets.chomp.to_s
   if v.upcase.include? 'S'
      system('clear') 
      menu
   end
end

def menu
  begin
   # Lee Archivo de Alumnos y Notas
   file = File.open(CONST_ARCHIVO1, 'r')
   data = file.readlines.map{ |w| w.chomp } #borra los saltos.
   file.close

   puts 'Eliga una opción'
   puts '1 - Generar archivo con promedio de notas de los alumnos.'
   puts '2 - Ver la Cantidad total de inasistencias por alumno.'
   puts '3 - Ver Nombres y promedios de alumnos aprobados.'
   puts '4 - Salir'
   opcion = gets.chomp.to_i

   case opcion
   when 1
       system('clear')      
       promedio_alumnos(data,CONST_ARCHIVO)
       vuelve_menu
   when 2
       system('clear')      
       alumnos_inasistencias(data)
       vuelve_menu 
   when 3
       system('clear')
       aprobado(CONST_NOTA_DEFECTO,CONST_ARCHIVO)
       vuelve_menu 
   when 4
       system('clear')   
   else
       puts "No existe la opcion ingresada"
       vuelve_menu
   end
  end    
end

def aprobado(nota_defecto, archivo_promedio)

 if File.exist?(archivo_promedio)
 puts "El promedio para poder aprobar debe ser mayor a #{CONST_NOTA_DEFECTO}"
 # Lee Archivo de Alumnos y Notas
 file = File.open(archivo_promedio, 'r')
 data = file.readlines.map{ |w| w.chomp } #borra los saltos.
 file.close

 a = data.map{ |ele| ele.split(' ')}
  a.each do |fila|
    alumno = fila[5] # Nombre Alumno
    cuenta = fila[10]# Promedio Alumno    
    if cuenta.to_f >= nota_defecto
     puts "Alumno aprobado: #{alumno} con promedio: #{cuenta}"  
    else
     puts "Alumno No aprobado: #{alumno} con promedio: #{cuenta}"  
    end
  end
 else
   puts "El archivo con promedios de los alumnos no existe"    
   puts "Escoga opción: 1 para crearlo"     
 end
end

def promedio_alumnos(data, archivo_promedio)
# Consulta existencia de archivo promedio notas
if File.exist?(archivo_promedio)
  # Borra Archivo de Alumnos y Notas
  remove_file(archivo_promedio)   
end

a = data.map{ |ele| ele.split(', ')}

  a.each do |fila|
    alumno = fila[0]
    sum = 0
    promedio = 0
    fila.each do |col|
     if col.to_i > 0
     sum += col.to_f
     cuenta = fila.count - 1
     promedio = sum/cuenta
     end 
    end
    # Llama metodo para crear archivo
    crea_archivo_promedio("El nombre del alumno es: #{alumno} y su promedio es: #{promedio}",archivo_promedio)
  end
    puts"Se ha creado el archivo: Promedios_Alumnos.txt"
end

def remove_file(file)
  File.delete(file)
end

def crea_archivo_promedio(elemento,archivo_promedio)
 # creacion de archivo com promedio de alumnos
 file = File.open(archivo_promedio,'a')
 file.puts elemento
 file.close 
end

def alumnos_inasistencias(data)

puts"Reporte de inasistencias de los alumnos Desafio Latam."

a = data.map{ |ele| ele.split(', ')}
  a.each do |fila|
    alumno = fila[0]
    ina = 0
    fila.each do |col|
     if col.to_s == "A"
        ina += 1 
     end 
    end
    # Muestra por pantalla las inasistencias
    case ina
    when 0
     puts ("El alumno: #{alumno}, no tiene inasistencias.")
    when 1
     puts ("El alumno: #{alumno}, tiene: #{ina} inasistencia.")   
    else
     puts ("El alumno: #{alumno}, tiene: #{ina} inasistencias.")
    end
  end
end

begin
    # Inicio del programa
    menu
end 
