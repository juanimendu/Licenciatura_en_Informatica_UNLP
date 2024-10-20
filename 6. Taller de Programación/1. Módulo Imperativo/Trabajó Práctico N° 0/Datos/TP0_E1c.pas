{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 1c}
{Implementar un programa que procese la información de los alumnos de la Facultad de Informática.
(c) Analizar: ¿Qué cambios requieren los incisos (a) y (b), si no se sabe de antemano la cantidad de materias aprobadas de cada alumno y si, además, se desean registrar los aplazos?
¿Cómo puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}

program TP0_E1c;
{$codepage UTF8}
uses crt;
const
  anio_ini=2000; anio_fin=2023;
  nota_ini=1; nota_fin=10;
  nota_corte=4; nota_salida=0;
  numero_salida=11111;
type
  t_anio=anio_ini..anio_fin;
  t_nota=nota_ini..nota_fin;
  t_lista_notas=^t_nodo_notas;
  t_nodo_notas=record
    ele: t_nota;
    sig: t_lista_notas;
  end;
  t_registro_alumno1=record
    apellido: string;
    numero: int32;
    anio_ingreso: t_anio;
    notas: t_lista_notas;
    examenes_rendidos: int16;
    materias_aprobadas: int8;
  end;
  t_registro_alumno2=record
    numero: int32;
    promedio_con_aplazos: real;
    promedio_sin_aplazos: real;
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
procedure agregar_adelante_lista_notas(var lista_notas: t_lista_notas; nota: t_nota);
var
  nuevo: t_lista_notas;
begin
  new(nuevo);
  nuevo^.ele:=nota;
  nuevo^.sig:=lista_notas;
  lista_notas:=nuevo;
end;
procedure leer_nota(var nota: int8);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    nota:=nota_salida
  else
    nota:=nota_ini+random(nota_fin);
end;
procedure leer_alumno(var registro_alumno1: t_registro_alumno1);
var
  nota: int8;
  materias_aprobadas, i: int8;
  examenes_rendidos: int16;
begin
  registro_alumno1.notas:=nil;
  examenes_rendidos:=0; materias_aprobadas:=0;
  registro_alumno1.apellido:=random_string(5+random(6));
  i:=random(100);
  if (i=0) then
    registro_alumno1.numero:=numero_salida
  else
    registro_alumno1.numero:=1+random(high(int16));
  registro_alumno1.anio_ingreso:=anio_ini+random(anio_fin-anio_ini+1);
  leer_nota(nota);
  while (nota<>nota_salida) do
  begin
    agregar_adelante_lista_notas(registro_alumno1.notas,nota);
    examenes_rendidos:=examenes_rendidos+1;
    if (nota>=nota_corte) then
      materias_aprobadas:=materias_aprobadas+1;
    leer_nota(nota);
  end;
  registro_alumno1.examenes_rendidos:=examenes_rendidos;
  registro_alumno1.materias_aprobadas:=materias_aprobadas;
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
  textcolor(green); write('La cantidad de exámenes rendidos del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno1.examenes_rendidos);
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
  suma_con_aplazos, suma_sin_aplazos: int16;
begin
  suma_con_aplazos:=0; suma_sin_aplazos:=0;
  registro_alumno2.numero:=registro_alumno1.numero;
  if (registro_alumno1.examenes_rendidos<>0) then
  begin
    while (registro_alumno1.notas<>nil) do
    begin
      suma_con_aplazos:=suma_con_aplazos+registro_alumno1.notas^.ele;
      if (registro_alumno1.notas^.ele>=nota_corte) then
        suma_sin_aplazos:=suma_sin_aplazos+registro_alumno1.notas^.ele;
      registro_alumno1.notas:=registro_alumno1.notas^.sig;
    end;
    registro_alumno2.promedio_con_aplazos:=suma_con_aplazos/registro_alumno1.examenes_rendidos;
    if (registro_alumno1.materias_aprobadas<>0) then
      registro_alumno2.promedio_sin_aplazos:=suma_sin_aplazos/registro_alumno1.materias_aprobadas
    else
      registro_alumno2.promedio_sin_aplazos:=suma_sin_aplazos;
  end
  else
  begin
    registro_alumno2.promedio_con_aplazos:=suma_con_aplazos;
    registro_alumno2.promedio_sin_aplazos:=suma_sin_aplazos;
  end;
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
  textcolor(green); write('El promedio CON aplazos del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno2.promedio_con_aplazos:0:2);
  textcolor(green); write('El promedio SIN aplazos del alumno '); textcolor(yellow); write(alumno); textcolor(green); write(' es '); textcolor(red); writeln(registro_alumno2.promedio_sin_aplazos:0:2);
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