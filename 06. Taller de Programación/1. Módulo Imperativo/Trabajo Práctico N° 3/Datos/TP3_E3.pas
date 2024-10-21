{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 3}
{Implementar un programa que contenga:
(a) Un módulo que lea información de alumnos de Taller de Programación y los almacene en una estructura de datos.
De cada alumno, se lee legajo, DNI, año de ingreso y los códigos y notas de los finales rendidos.
La estructura generada debe ser eficiente para la búsqueda por número de legajo.
La lectura de los alumnos finaliza con legajo 0 y, para cada alumno, el ingreso de las materias finaliza con el código de materia -1.
(b) Un módulo que reciba la estructura generada en (a) y retorne los DNI y año de ingreso de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
(c) Un módulo que reciba la estructura generada en (a) y retorne el legajo más grande.
(d) Un módulo que reciba la estructura generada en (a) y retorne el DNI más grande.
(e) Un módulo que reciba la estructura generada en (a) y retorne la cantidad de alumnos con legajo impar.
(f) Un módulo que reciba la estructura generada en (a) y retorne el legajo y el promedio del alumno con mayor promedio.
(g) Un módulo que reciba la estructura generada en (a) y un valor entero. Este módulo debe retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program TP3_E3;
{$codepage UTF8}
uses crt;
const
  nota_ini=1; nota_fin=10;
  legajo_salida=0; codigo_salida=-1;
type
  t_nota=nota_ini..nota_fin;
  t_registro_final=record
    codigo: int8;
    nota: t_nota;
  end;
  t_lista_finales=^t_nodo_finales;
  t_nodo_finales=record
    ele: t_registro_final;
    sig: t_lista_finales;
  end;
  t_registro_alumno1=record
    legajo: int16;
    dni: int32;
    anio_ingreso: int16;
    finales: t_lista_finales;
  end;
  t_abb_alumnos1=^t_nodo_abb_alumnos1;
  t_nodo_abb_alumnos1=record
    ele: t_registro_alumno1;
    hi: t_abb_alumnos1;
    hd: t_abb_alumnos1;
  end;
  t_registro_alumno2=record
    dni: int32;
    anio_ingreso: int16;
  end;
  t_abb_alumnos2=^t_nodo_abb_alumnos2;
  t_nodo_abb_alumnos2=record
    ele: t_registro_alumno2;
    hi: t_abb_alumnos2;
    hd: t_abb_alumnos2;
  end;
  t_registro_alumno3=record
    legajo: int16;
    promedio: real;
  end;
  t_abb_alumnos3=^t_nodo_abb_alumnos3;
  t_nodo_abb_alumnos3=record
    ele: t_registro_alumno3;
    hi: t_abb_alumnos3;
    hd: t_abb_alumnos3;
  end;
procedure leer_final(var registro_final: t_registro_final);
var
  i: int8;
begin
  i:=random(10);
  if (i=0) then
    registro_final.codigo:=codigo_salida
  else
    registro_final.codigo:=1+random(high(int8));
  if (registro_final.codigo<>codigo_salida) then
    registro_final.nota:=nota_ini+random(nota_fin);
end;
procedure agregar_adelante_lista_finales(var lista_finales: t_lista_finales; registro_final: t_registro_final);
var
  nuevo: t_lista_finales;
begin
  new(nuevo);
  nuevo^.ele:=registro_final;
  nuevo^.sig:=lista_finales;
  lista_finales:=nuevo;
end;
procedure leer_finales(var lista_finales: t_lista_finales);
var
  registro_final: t_registro_final;
begin
  leer_final(registro_final);
  while (registro_final.codigo<>codigo_salida) do
  begin
    agregar_adelante_lista_finales(lista_finales,registro_final);
    leer_final(registro_final);
  end;
end;
procedure leer_alumno(var registro_alumno1: t_registro_alumno1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_alumno1.legajo:=legajo_salida
  else
    registro_alumno1.legajo:=1+random(high(int16));
  if (registro_alumno1.legajo<>legajo_salida) then
  begin
    registro_alumno1.dni:=10000000+random(40000001);
    registro_alumno1.anio_ingreso:=2000+random(25);
    registro_alumno1.finales:=nil;
    leer_finales(registro_alumno1.finales);
  end;
end;
procedure agregar_abb_alumnos1(var abb_alumnos1: t_abb_alumnos1; registro_alumno1: t_registro_alumno1);
begin
  if (abb_alumnos1=nil) then
  begin
    new(abb_alumnos1);
    abb_alumnos1^.ele:=registro_alumno1;
    abb_alumnos1^.hi:=nil;
    abb_alumnos1^.hd:=nil;
  end
  else
    if (registro_alumno1.legajo<=abb_alumnos1^.ele.legajo) then
      agregar_abb_alumnos1(abb_alumnos1^.hi,registro_alumno1)
    else
      agregar_abb_alumnos1(abb_alumnos1^.hd,registro_alumno1);
end;
procedure cargar_abb_alumnos1(var abb_alumnos1: t_abb_alumnos1);
var
  registro_alumno1: t_registro_alumno1;
begin
  leer_alumno(registro_alumno1);
  while (registro_alumno1.legajo<>legajo_salida) do
  begin
    agregar_abb_alumnos1(abb_alumnos1,registro_alumno1);
    leer_alumno(registro_alumno1);
  end;
end;
procedure imprimir_registro_final(registro_final: t_registro_final; legajo, final: int16);
begin
  textcolor(green); write('El código del final '); textcolor(yellow); write(final); textcolor(green); write(' del legajo '); textcolor(yellow); write(legajo); textcolor(green); write(' es '); textcolor(red); writeln(registro_final.codigo);
  textcolor(green); write('La nota del final '); textcolor(yellow); write(final); textcolor(green); write(' del legajo '); textcolor(yellow); write(legajo); textcolor(green); write(' es '); textcolor(red); writeln(registro_final.nota);
end;
procedure imprimir_lista_finales(lista_finales: t_lista_finales; legajo: int16);
var
  i: int16;
begin
  i:=0;
  while (lista_finales<>nil) do
  begin
    i:=i+1;
    imprimir_registro_final(lista_finales^.ele,legajo,i);
    lista_finales:=lista_finales^.sig;
  end;
end;
procedure imprimir_registro_alumno1(registro_alumno1: t_registro_alumno1);
begin
  textcolor(green); write('El legajo del alumno es '); textcolor(red); writeln(registro_alumno1.legajo);
  textcolor(green); write('El DNI del alumno es '); textcolor(red); writeln(registro_alumno1.dni);
  textcolor(green); write('El año de ingreso del alumno es '); textcolor(red); writeln(registro_alumno1.anio_ingreso);
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
procedure cargar_registro_alumno2(var registro_alumno2: t_registro_alumno2; registro_alumno1: t_registro_alumno1);
begin
  registro_alumno2.dni:=registro_alumno1.dni;
  registro_alumno2.anio_ingreso:=registro_alumno1.anio_ingreso;
end;
procedure agregar_abb_alumnos2(var abb_alumnos2: t_abb_alumnos2; registro_alumno1: t_registro_alumno1);
begin
  if (abb_alumnos2=nil) then
  begin
    new(abb_alumnos2);
    cargar_registro_alumno2(abb_alumnos2^.ele,registro_alumno1);
    abb_alumnos2^.hi:=nil;
    abb_alumnos2^.hd:=nil;
  end
  else
    if (registro_alumno1.dni<=abb_alumnos2^.ele.dni) then
      agregar_abb_alumnos2(abb_alumnos2^.hi,registro_alumno1)
    else
      agregar_abb_alumnos2(abb_alumnos2^.hd,registro_alumno1);
end;
procedure cargar_abb_alumnos2(var abb_alumnos2: t_abb_alumnos2; abb_alumnos1: t_abb_alumnos1; legajo: int16);
begin
  if (abb_alumnos1<>nil) then
  begin
    if (abb_alumnos1^.ele.legajo<legajo) then
    begin
      cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hi,legajo);
      agregar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.ele);
      cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hd,legajo);
    end
    else
      cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hi,legajo);
  end;
end;
procedure imprimir_registro_alumno2(registro_alumno2: t_registro_alumno2);
begin
  textcolor(green); write('El DNI del alumno es '); textcolor(red); writeln(registro_alumno2.dni);
  textcolor(green); write('El año de ingreso del alumno es '); textcolor(red); writeln(registro_alumno2.anio_ingreso);
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
function buscar_mayor_legajo(abb_alumnos1: t_abb_alumnos1): int16;
begin
  if (abb_alumnos1^.hd=nil) then
    buscar_mayor_legajo:=abb_alumnos1^.ele.legajo
  else
    buscar_mayor_legajo:=buscar_mayor_legajo(abb_alumnos1^.hd);
end;
procedure buscar_mayor_dni(abb_alumnos1: t_abb_alumnos1; var dni_max: int32);
begin
  if (abb_alumnos1<>nil) then
  begin
    buscar_mayor_dni(abb_alumnos1^.hi,dni_max);
    if (abb_alumnos1^.ele.dni>dni_max) then
      dni_max:=abb_alumnos1^.ele.dni;
    buscar_mayor_dni(abb_alumnos1^.hd,dni_max);
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
procedure buscar_legajo_mayor_promedio(abb_alumnos1: t_abb_alumnos1; var promedio_max: real; var legajo_max: int16);
var
  promedio: real;
begin
  if (abb_alumnos1<>nil) then
  begin
    buscar_legajo_mayor_promedio(abb_alumnos1^.hi,promedio_max,legajo_max);
    promedio:=calcular_promedio(abb_alumnos1^.ele.finales);
    if (promedio>promedio_max) then
    begin
      promedio_max:=promedio;
      legajo_max:=abb_alumnos1^.ele.legajo;
    end;
    buscar_legajo_mayor_promedio(abb_alumnos1^.hd,promedio_max,legajo_max);
  end;
end;
procedure cargar_registro_alumno3(var registro_alumno3: t_registro_alumno3; legajo: int16; promedio_alumno: real);
begin
  registro_alumno3.legajo:=legajo;
  registro_alumno3.promedio:=promedio_alumno;
end;
procedure agregar_abb_alumnos3(var abb_alumnos3: t_abb_alumnos3; legajo: int16; promedio_alumno: real);
begin
  if (abb_alumnos3=nil) then
  begin
    new(abb_alumnos3);
    cargar_registro_alumno3(abb_alumnos3^.ele,legajo,promedio_alumno);
    abb_alumnos3^.hi:=nil;
    abb_alumnos3^.hd:=nil;
  end
  else
    if (legajo<=abb_alumnos3^.ele.legajo) then
      agregar_abb_alumnos3(abb_alumnos3^.hi,legajo,promedio_alumno)
    else
      agregar_abb_alumnos3(abb_alumnos3^.hd,legajo,promedio_alumno);
end;
procedure cargar_abb_alumnos3(var abb_alumnos3: t_abb_alumnos3; abb_alumnos1: t_abb_alumnos1; promedio: real);
var
  promedio_alumno: real;
begin
  if (abb_alumnos1<>nil) then
  begin
    cargar_abb_alumnos3(abb_alumnos3,abb_alumnos1^.hi,promedio);
    promedio_alumno:=calcular_promedio(abb_alumnos1^.ele.finales);
    if (promedio_alumno>promedio) then
      agregar_abb_alumnos3(abb_alumnos3,abb_alumnos1^.ele.legajo,promedio_alumno);
    cargar_abb_alumnos3(abb_alumnos3,abb_alumnos1^.hd,promedio);
  end;
end;
procedure imprimir_registro_alumno3(registro_alumno3: t_registro_alumno3);
begin
  textcolor(green); write('El legajo del alumno es '); textcolor(red); writeln(registro_alumno3.legajo);
  textcolor(green); write('El promedio del alumno es '); textcolor(red); writeln(registro_alumno3.promedio:0:2);
  writeln();
end;
procedure imprimir_abb_alumnos3(abb_alumnos3: t_abb_alumnos3);
begin
  if (abb_alumnos3<>nil) then
  begin
    imprimir_abb_alumnos3(abb_alumnos3^.hi);
    imprimir_registro_alumno3(abb_alumnos3^.ele);
    imprimir_abb_alumnos3(abb_alumnos3^.hd);
  end;
end;
var
  abb_alumnos1: t_abb_alumnos1;
  abb_alumnos2: t_abb_alumnos2;
  abb_alumnos3: t_abb_alumnos3;
  legajo, legajos_impar, legajo_max: int16;
  dni_max: int32;
  promedio_max, promedio: real;
begin
  randomize;
  abb_alumnos1:=nil;
  abb_alumnos2:=nil;
  dni_max:=low(int32);
  legajos_impar:=0;
  promedio_max:=-9999999; legajo_max:=0;
  abb_alumnos3:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abb_alumnos1(abb_alumnos1);
  if (abb_alumnos1<>nil) then
  begin
    imprimir_abb_alumnos1(abb_alumnos1);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    legajo:=1+random(high(int16));
    cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1,legajo);
    if (abb_alumnos2<>nil) then
      imprimir_abb_alumnos2(abb_alumnos2);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    textcolor(green); write('El legajo más grande es '); textcolor(red); writeln(buscar_mayor_legajo(abb_alumnos1));
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    buscar_mayor_dni(abb_alumnos1,dni_max);
    textcolor(green); write('El DNI más grande es '); textcolor(red); writeln(dni_max);
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    contar_legajos_impar(abb_alumnos1,legajos_impar);
    textcolor(green); write('La cantidad de alumnos con legajo impar es '); textcolor(red); writeln(legajos_impar);
    writeln(); textcolor(red); writeln('INCISO (f):'); writeln();
    buscar_legajo_mayor_promedio(abb_alumnos1,promedio_max,legajo_max);
    textcolor(green); write('El legajo y el promedio del alumno con mayor promedio son '); textcolor(red); write(legajo_max); textcolor(green); write(' y '); textcolor(red); write(promedio_max:0:2); textcolor(green); writeln(', respectivamente');
    writeln(); textcolor(red); writeln('INCISO (g):'); writeln();
    promedio:=1+random(91)/10;
    cargar_abb_alumnos3(abb_alumnos3,abb_alumnos1,promedio);
    if (abb_alumnos3<>nil) then
      imprimir_abb_alumnos3(abb_alumnos3);
  end;
end.