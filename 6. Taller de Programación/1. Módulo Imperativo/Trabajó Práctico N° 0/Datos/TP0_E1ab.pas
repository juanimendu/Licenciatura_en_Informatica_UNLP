{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 1ab}
{Implementar un programa que procese la información de los alumnos de la Facultad de Informática.
(a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de todos los alumnos.
De cada alumno, se lee su apellido, número de alumno, año de ingreso, cantidad de materias aprobadas (a lo sumo, 36) y nota obtenida (sin contar los aplazos) en cada una de las materias aprobadas.
La lectura finaliza cuando se ingresa el número de alumno 11111, el cual debe procesarse.
(b) Implementar un módulo que reciba la estructura generada en el inciso (a) y retorne número de alumno y promedio de cada alumno.}

program TP0_E1ab;
{$codepage UTF8}
uses crt;
const
  anio_ini=2000; anio_fin=2023;
  materias_total=36;
  nota_ini=4; nota_fin=10;
  numero_salida=11111;
type
  t_materia=1..materias_total;
  t_nota=nota_ini..nota_fin;
  t_vector_notas=array[t_materia] of t_nota;
  t_registro_alumno1=record
    apellido: string;
    numero: int16;
    anio_ingreso: int16;
    materias_aprobadas: int8;
    notas: t_vector_notas;
  end;
  t_registro_alumno2=record
    numero: int32;
    promedio: real;
  end;
  t_lista_alumnos1=^t_nodo_alumnos1;
  t_nodo_alumnos1=record
    ele: t_registro_alumno1;
    sig: t_lista_alumnos1;
  end;
  t_lista_alumnos2=^t_nodo_alumnos2;
  t_nodo_alumnos2=record
    ele: t_registro_alumno2;
    sig: t_lista_alumnos2;
  end;
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
procedure leer_alumno(var registro_alumno1: t_registro_alumno1);
var
  i: int8;
begin
  registro_alumno1.apellido:=random_string(5+random(6));
  i:=random(100);
  if (i=0) then
    registro_alumno1.numero:=numero_salida
  else
    registro_alumno1.numero:=1+random(high(int16));
  registro_alumno1.anio_ingreso:=anio_ini+random(anio_fin-anio_ini+1);
  registro_alumno1.materias_aprobadas:=random(materias_total+1);
  for i:= 1 to registro_alumno1.materias_aprobadas do
    registro_alumno1.notas[i]:=nota_ini+random(nota_fin-nota_ini+1);
end;
procedure agregar_adelante_lista_alumnos1(var lista_alumnos1: t_lista_alumnos1; registro_alumno1: t_registro_alumno1);
var
  nuevo: t_lista_alumnos1;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno1;
  nuevo^.sig:=lista_alumnos1;
  lista_alumnos1:=nuevo;
end;
procedure cargar_lista_alumnos1(var lista_alumnos1: t_lista_alumnos1);
var
  registro_alumno1: t_registro_alumno1;
begin
  repeat
    leer_alumno(registro_alumno1);
    agregar_adelante_lista_alumnos1(lista_alumnos1,registro_alumno1);
  until (registro_alumno1.numero=numero_salida);
end;
procedure imprimir_registro_alumno1(registro_alumno1: t_registro_alumno1; alumno: int16);
begin
  textcolor(green); write('El apellido del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno1.apellido);
  textcolor(green); write('El número de alumno del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno1.numero);
  textcolor(green); write('El año de ingreso del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno1.anio_ingreso);
  textcolor(green); write('La cantidad de materias aprobadas del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno1.materias_aprobadas);
end;
procedure imprimir_lista_alumnos1(lista_alumnos1: t_lista_alumnos1);
var
  i: int16;
begin
  i:=0;
  while (lista_alumnos1<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del alumno '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_alumno1(lista_alumnos1^.ele,i);
    writeln();
    lista_alumnos1:=lista_alumnos1^.sig;
  end;
end;
procedure cargar_registro_alumno2(var registro_alumno2: t_registro_alumno2; registro_alumno1: t_registro_alumno1);
var
  i: int8;
  suma: int16;
begin
  suma:=0;
  registro_alumno2.numero:=registro_alumno1.numero;
  if (registro_alumno1.materias_aprobadas<>0) then
  begin
    for i:= 1 to registro_alumno1.materias_aprobadas do
      suma:=suma+registro_alumno1.notas[i];
    registro_alumno2.promedio:=suma/registro_alumno1.materias_aprobadas;
  end
  else
    registro_alumno2.promedio:=suma;
end;
procedure agregar_adelante_lista_alumnos2(var lista_alumnos2: t_lista_alumnos2; registro_alumno2: t_registro_alumno2);
var
  nuevo: t_lista_alumnos2;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno2;
  nuevo^.sig:=lista_alumnos2;
  lista_alumnos2:=nuevo;
end;
procedure cargar_lista_alumnos2(var lista_alumnos2: t_lista_alumnos2; lista_alumnos1: t_lista_alumnos1);
var
  registro_alumno2: t_registro_alumno2;
begin
  while (lista_alumnos1<>nil) do
  begin
    cargar_registro_alumno2(registro_alumno2,lista_alumnos1^.ele);
    agregar_adelante_lista_alumnos2(lista_alumnos2,registro_alumno2);
    lista_alumnos1:=lista_alumnos1^.sig;
  end;
end;
procedure imprimir_registro_alumno2(registro_alumno2: t_registro_alumno2; alumno: int16);
begin
  textcolor(green); write('El número de alumno del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno2.numero);
  textcolor(green); write('El promedio del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno2.promedio:0:2);
end;
procedure imprimir_lista_alumnos2(lista_alumnos2: t_lista_alumnos2);
var
  i: int16;
begin
  i:=0;
  while (lista_alumnos2<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información del alumno '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_alumno2(lista_alumnos2^.ele,i);
    writeln();
    lista_alumnos2:=lista_alumnos2^.sig;
  end;
end;
var
  lista_alumnos1: t_lista_alumnos1;
  lista_alumnos2: t_lista_alumnos2;
begin
  randomize;
  lista_alumnos1:=nil;
  lista_alumnos2:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_lista_alumnos1(lista_alumnos1);
  imprimir_lista_alumnos1(lista_alumnos1);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  cargar_lista_alumnos2(lista_alumnos2,lista_alumnos1);
  imprimir_lista_alumnos2(lista_alumnos2);
end.