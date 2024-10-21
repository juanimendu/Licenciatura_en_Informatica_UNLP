{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 3}
{Implementar un programa que contenga:
(a) Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de Informática y los almacene en una estructura de datos.
La información que se lee es legajo, código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0.
La estructura generada debe ser eficiente para la búsqueda por número de legajo y, para cada alumno, deben guardarse los finales que rindió en una lista.
(b) Un módulo que reciba la estructura generada en (a) y retorne la cantidad de alumnos con legajo impar.
(c) Un módulo que reciba la estructura generada en (a) e informe, para cada alumno, su legajo y su cantidad de finales aprobados (nota mayor o igual a 4).
(d) Un módulo que reciba la estructura generada en (a) y un valor real. Este módulo debe retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program TP3_E3;
{$codepage UTF8}
uses crt;
const
  nota_ini=1; nota_fin=10;
  legajo_salida=0;
  nota_corte=4;
type
  t_nota=nota_ini..nota_fin;
  t_registro_final1=record
    legajo: int16;
    materia: string;
    fecha: int8;
    nota: t_nota;
  end;
  t_registro_final2=record
    materia: string;
    fecha: int8;
    nota: t_nota;
  end;
  t_lista_finales=^t_nodo_finales;
  t_nodo_finales=record
    ele: t_registro_final2;
    sig: t_lista_finales;
  end;
  t_registro_alumno1=record
    legajo: int16;
    finales: t_lista_finales;
  end;
  t_abb_alumnos1=^t_nodo_abb_alumnos1;
  t_nodo_abb_alumnos1=record
    ele: t_registro_alumno1;
    hi: t_abb_alumnos1;
    hd: t_abb_alumnos1;
  end;
  t_registro_alumno2=record
    legajo: int16;
    promedio: real;
  end;
  t_abb_alumnos2=^t_nodo_abb_alumnos2;
  t_nodo_abb_alumnos2=record
    ele: t_registro_alumno2;
    hi: t_abb_alumnos2;
    hd: t_abb_alumnos2;
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
procedure leer_final(var registro_final1: t_registro_final1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_final1.legajo:=legajo_salida
  else
    registro_final1.legajo:=1+random(high(int16));
  if (registro_final1.legajo<>legajo_salida) then
  begin
    registro_final1.materia:=random_string(5+random(6));
    registro_final1.fecha:=1+random(high(int8));
    registro_final1.nota:=nota_ini+random(nota_fin);
  end;
end;
procedure cargar_registro_final2(var registro_final2: t_registro_final2; registro_final1: t_registro_final1);
begin
  registro_final2.materia:=registro_final1.materia;
  registro_final2.fecha:=registro_final1.fecha;
  registro_final2.nota:=registro_final1.nota;
end;
procedure agregar_adelante_lista_finales(var lista_finales: t_lista_finales; registro_final1: t_registro_final1);
var
  nuevo: t_lista_finales;
begin
  new(nuevo);
  cargar_registro_final2(nuevo^.ele,registro_final1);
  nuevo^.sig:=lista_finales;
  lista_finales:=nuevo;
end;
procedure cargar_registro_alumno1(var registro_alumno1: t_registro_alumno1; registro_final1: t_registro_final1);
begin
  registro_alumno1.legajo:=registro_final1.legajo;
  registro_alumno1.finales:=nil;
  agregar_adelante_lista_finales(registro_alumno1.finales,registro_final1);
end;
procedure agregar_abb_alumnos1(var abb_alumnos1: t_abb_alumnos1; registro_final1: t_registro_final1);
begin
  if (abb_alumnos1=nil) then
  begin
    new(abb_alumnos1);
    cargar_registro_alumno1(abb_alumnos1^.ele,registro_final1);
    abb_alumnos1^.hi:=nil;
    abb_alumnos1^.hd:=nil;
  end
  else
    if (registro_final1.legajo=abb_alumnos1^.ele.legajo) then
      agregar_adelante_lista_finales(abb_alumnos1^.ele.finales,registro_final1)
    else if (registro_final1.legajo<abb_alumnos1^.ele.legajo) then
      agregar_abb_alumnos1(abb_alumnos1^.hi,registro_final1)
    else
      agregar_abb_alumnos1(abb_alumnos1^.hd,registro_final1);
end;
procedure cargar_abb_alumnos1(var abb_alumnos1: t_abb_alumnos1);
var
  registro_final1: t_registro_final1;
begin
  leer_final(registro_final1);
  while (registro_final1.legajo<>legajo_salida) do
  begin
    agregar_abb_alumnos1(abb_alumnos1,registro_final1);
    leer_final(registro_final1);
  end;
end;
procedure imprimir_registro_final2(registro_final2: t_registro_final2; legajo, final: int16);
begin
  textcolor(green); write('La materia del final '); textcolor(yellow); write(final); textcolor(green); write(' del legajo '); textcolor(yellow); write(legajo); textcolor(green); write(' es '); textcolor(red); writeln(registro_final2.materia);
  textcolor(green); write('La fecha del final '); textcolor(yellow); write(final); textcolor(green); write(' del legajo '); textcolor(yellow); write(legajo); textcolor(green); write(' es '); textcolor(red); writeln(registro_final2.fecha);
  textcolor(green); write('La nota del final '); textcolor(yellow); write(final); textcolor(green); write(' del legajo '); textcolor(yellow); write(legajo); textcolor(green); write(' es '); textcolor(red); writeln(registro_final2.nota);
end;
procedure imprimir_lista_finales(lista_finales: t_lista_finales; legajo: int16);
var
  i: int16;
begin
  i:=0;
  while (lista_finales<>nil) do
  begin
    i:=i+1;
    imprimir_registro_final2(lista_finales^.ele,legajo,i);
    lista_finales:=lista_finales^.sig;
  end;
end;
procedure imprimir_registro_alumno1(registro_alumno1: t_registro_alumno1);
begin
  textcolor(green); write('El legajo del alumno es '); textcolor(red); writeln(registro_alumno1.legajo);
  imprimir_lista_finales(registro_alumno1.finales,registro_alumno1.legajo);
  writeln();
end;
procedure imprimir_abb_alumnos1(abb_alumnos1: t_abb_alumnos1);
begin
  if (abb_alumnos1<>nil) then
  begin
    imprimir_abb_alumnos1(abb_alumnos1^.hi);
    imprimir_registro_alumno1(abb_alumnos1^.ele);
    imprimir_abb_alumnos1(abb_alumnos1^.hd);
  end;
end;
procedure contar_legajos_impar(abb_alumnos1: t_abb_alumnos1; var legajos_impar: int16);
begin
  if (abb_alumnos1<>nil) then
  begin
    contar_legajos_impar(abb_alumnos1^.hi,legajos_impar);
    if (abb_alumnos1^.ele.legajo mod 2<>0) then
      legajos_impar:=legajos_impar+1;
    contar_legajos_impar(abb_alumnos1^.hd,legajos_impar);
  end;
end;
function contar_finales_aprobados(lista_finales: t_lista_finales): int16;
var
  finales: int16;
begin
  finales:=0;
  while (lista_finales<>nil) do
  begin
    if (lista_finales^.ele.nota>=nota_corte) then
      finales:=finales+1;
    lista_finales:=lista_finales^.sig;
  end;
  contar_finales_aprobados:=finales;
end;
procedure informar_abb_alumnos1(abb_alumnos1: t_abb_alumnos1);
begin
  if (abb_alumnos1<>nil) then
  begin
    informar_abb_alumnos1(abb_alumnos1^.hi);
    textcolor(green); write('El legajo del alumno es '); textcolor(red); writeln(abb_alumnos1^.ele.legajo);
    textcolor(green); write('La cantidad de finales aprobados (nota mayor o igual a '); textcolor(yellow); write(nota_corte); textcolor(green); write(') del alumno es '); textcolor(red); writeln(contar_finales_aprobados(abb_alumnos1^.ele.finales));
    writeln();
    informar_abb_alumnos1(abb_alumnos1^.hd);
  end;
end;
function calcular_promedio(lista_finales: t_lista_finales): real;
var
  notas_total, notas: int16;
begin
  notas_total:=0; notas:=0;
  while (lista_finales<>nil) do
  begin
    notas_total:=notas_total+lista_finales^.ele.nota;
    notas:=notas+1;
    lista_finales:=lista_finales^.sig;
  end;
  if (notas>0) then
    calcular_promedio:=notas_total/notas
  else
    calcular_promedio:=notas_total;
end;
procedure cargar_registro_alumno2(var registro_alumno2: t_registro_alumno2; legajo: int16; promedio_alumno: real);
begin
  registro_alumno2.legajo:=legajo;
  registro_alumno2.promedio:=promedio_alumno;
end;
procedure agregar_abb_alumnos2(var abb_alumnos2: t_abb_alumnos2; legajo: int16; promedio_alumno: real);
begin
  if (abb_alumnos2=nil) then
  begin
    new(abb_alumnos2);
    cargar_registro_alumno2(abb_alumnos2^.ele,legajo,promedio_alumno);
    abb_alumnos2^.hi:=nil;
    abb_alumnos2^.hd:=nil;
  end
  else
    if (legajo<=abb_alumnos2^.ele.legajo) then
      agregar_abb_alumnos2(abb_alumnos2^.hi,legajo,promedio_alumno)
    else
      agregar_abb_alumnos2(abb_alumnos2^.hd,legajo,promedio_alumno);
end;
procedure cargar_abb_alumnos2(var abb_alumnos2: t_abb_alumnos2; abb_alumnos1: t_abb_alumnos1; promedio: real);
var
  promedio_alumno: real;
begin
  if (abb_alumnos1<>nil) then
  begin
    cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hi,promedio);
    promedio_alumno:=calcular_promedio(abb_alumnos1^.ele.finales);
    if (promedio_alumno>promedio) then
      agregar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.ele.legajo,promedio_alumno);
    cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hd,promedio);
  end;
end;
procedure imprimir_registro_alumno2(registro_alumno2: t_registro_alumno2);
begin
  textcolor(green); write('El legajo del alumno es '); textcolor(red); writeln(registro_alumno2.legajo);
  textcolor(green); write('El promedio del alumno es '); textcolor(red); writeln(registro_alumno2.promedio:0:2);
  writeln();
end;
procedure imprimir_abb_alumnos2(abb_alumnos2: t_abb_alumnos2);
begin
  if (abb_alumnos2<>nil) then
  begin
    imprimir_abb_alumnos2(abb_alumnos2^.hi);
    imprimir_registro_alumno2(abb_alumnos2^.ele);
    imprimir_abb_alumnos2(abb_alumnos2^.hd);
  end;
end;
var
  abb_alumnos1: t_abb_alumnos1;
  abb_alumnos2: t_abb_alumnos2;
  legajos_impar: int16;
  promedio: real;
begin
  randomize;
  abb_alumnos1:=nil;
  legajos_impar:=0;
  abb_alumnos2:=nil;
  writeln(); textcolor(red); write('INCISO (a):'); writeln();
  cargar_abb_alumnos1(abb_alumnos1);
  if (abb_alumnos1<>nil) then
  begin
    imprimir_abb_alumnos1(abb_alumnos1);
    writeln(); textcolor(red); write('INCISO (b):'); writeln();
    contar_legajos_impar(abb_alumnos1,legajos_impar);
    textcolor(green); write('La cantidad de alumnos con legajos impar es '); textcolor(red); writeln(legajos_impar);
    writeln(); textcolor(red); write('INCISO (c):'); writeln();
    informar_abb_alumnos1(abb_alumnos1);
    writeln(); textcolor(red); write('INCISO (d):'); writeln();
    promedio:=1+random(91)/10;
    cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1,promedio);
    if (abb_alumnos2<>nil) then
      imprimir_abb_alumnos2(abb_alumnos2);
  end;
end.