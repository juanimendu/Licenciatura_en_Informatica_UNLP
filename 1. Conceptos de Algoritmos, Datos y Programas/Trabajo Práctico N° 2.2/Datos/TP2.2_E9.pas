{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 9}
{Realizar un programa modularizado que lea información de alumnos de una facultad. Para cada alumno, se lee: número de inscripción, apellido y nombre.
La lectura finaliza cuando se ingresa el alumno con número de inscripción 1200, que debe procesarse.
Se pide calcular e informar:
•	Apellido de los dos alumnos con número de inscripción más chico.
•	Nombre de los dos alumnos con número de inscripción más grande.
•	Porcentaje de alumnos con número de inscripción par.}

program TP2_E9;
{$codepage UTF8}
uses crt;
const
  numero_salida=1200;
function random_string(length: int8): string;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_alumno(var numero: int16; var apellido, nombre: string);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    numero:=numero_salida
  else
    numero:=1+random(random(high(int16)));
  apellido:=random_string(5+random(6));
  nombre:=random_string(5+random(6));
end;
procedure actualizar_minimos(numero: int16; apellido: string; var numero_min1, numero_min2: int16; var apellido_min1, apellido_min2: string);
begin
  if (numero<numero_min1) then
  begin
    numero_min2:=numero_min1;
    apellido_min2:=apellido_min1;
    numero_min1:=numero;
    apellido_min1:=apellido;
  end
  else
    if (numero<numero_min2) then
    begin
      numero_min2:=numero;
      apellido_min2:=apellido;
    end;
end;
procedure actualizar_maximos(numero: int16; nombre: string; var numero_max1, numero_max2: int16; var nombre_max1, nombre_max2: string);
begin
  if (numero>numero_max1) then
  begin
    numero_max2:=numero_max1;
    nombre_max2:=nombre_max1;
    numero_max1:=numero;
    nombre_max1:=nombre;
  end
  else
    if (numero>numero_max2) then
    begin
      numero_max2:=numero;
      nombre_max2:=nombre;
    end;
end;
procedure leer_alumnos(var apellido_min1, apellido_min2, nombre_max1, nombre_max2: string; var porcentaje_par: real);
var
  alumnos_par, alumnos_total: int16;
  numero, numero_min1, numero_min2, numero_max1, numero_max2: int16;
  apellido, nombre: string;
begin
  alumnos_par:=0; alumnos_total:=0;
  numero_min1:=high(int16); numero_min2:=high(int16);
  numero_max1:=low(int16); numero_max2:=low(int16);
  repeat
    leer_alumno(numero,apellido,nombre);
    actualizar_minimos(numero,apellido,numero_min1,numero_min2,apellido_min1,apellido_min2);
    actualizar_maximos(numero,nombre,numero_max1,numero_max2,nombre_max1,nombre_max2);
    alumnos_total:=alumnos_total+1;
    if (numero mod 2=0) then
      alumnos_par:=alumnos_par+1;
  until (numero=numero_salida);
  porcentaje_par:=alumnos_par/alumnos_total*100;
end;
var
  porcentaje_par: real;
  apellido_min1, apellido_min2, nombre_max1, nombre_max2: string;
begin
  randomize;
  apellido_min1:=''; apellido_min2:='';
  nombre_max1:=''; nombre_max2:='';
  porcentaje_par:=0;
  leer_alumnos(apellido_min1,apellido_min2,nombre_max1,nombre_max2,porcentaje_par);
  textcolor(green); write('Los apellidos de los dos alumnos con número de inscripción más chico son '); textcolor(red); write(apellido_min1); textcolor(green); write(' y '); textcolor(red); writeln(apellido_min2);
  textcolor(green); write('Los nombres de los dos alumnos con número de inscripción más grande son '); textcolor(red); write(nombre_max1); textcolor(green); write(' y '); textcolor(red); writeln(nombre_max2);
  textcolor(green); write('El porcentaje de alumnos con número de inscripción par es '); textcolor(red); write(porcentaje_par:0:2); textcolor(green); write('%');
end.