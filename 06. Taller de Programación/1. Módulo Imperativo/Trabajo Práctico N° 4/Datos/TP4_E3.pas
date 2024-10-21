{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 3}
{Una facultad nos ha encargado procesar la información de sus alumnos de la carrera XXX. Esta carrera tiene 30 materias. Implementar un programa con:
(a) Un módulo que lea la información de los finales rendidos por los alumnos y los almacene en dos estructuras de datos.
  (i) Una estructura que, para cada alumno, se almacenen sólo código y nota de las materias aprobadas (4 a 10).
  De cada final rendido, se lee el código del alumno, el código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con nota -1.
  La estructura debe ser eficiente para buscar por código de alumno.
  (ii) Otra estructura que almacene para cada materia, su código y todos los finales rendidos en esa materia (código de alumno y nota).
(b) Un módulo que reciba la estructura generada en (i) y un código de alumno y retorne los códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.
(c) Un módulo que reciba la estructura generada en (i), dos códigos de alumnos y un valor entero y retorne la cantidad de alumnos con cantidad de finales aprobados igual al valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los dos códigos de alumnos ingresados.}

program TP4_E3;
{$codepage UTF8}
uses crt;
const
  materias_total=30;
  nota_corte=4;
  nota_ini=1; nota_fin=10;
  nota_salida=-1;
type
  t_materia=1..materias_total;
  t_nota=nota_salida..nota_fin;
  t_registro_final1=record
    codigo_alumno: int8;
    codigo_materia: t_materia;
    nota: t_nota;
  end;
  t_vector_notas=array[t_materia] of t_nota;
  t_registro_alumno1=record
    codigo_alumno: int8;
    notas: t_vector_notas;
  end;
  t_abb_alumnos1=^t_nodo_abb_alumnos1;
  t_nodo_abb_alumnos1=record
    ele: t_registro_alumno1;
    hi: t_abb_alumnos1;
    hd: t_abb_alumnos1;
  end;
  t_registro_final2=record
    codigo_alumno: int8;
    nota: t_nota;
  end;
  t_lista_finales=^t_nodo_finales;
  t_nodo_finales=record
    ele: t_registro_final2;
    sig: t_lista_finales;
  end;
  t_vector_finales=array[t_materia] of t_lista_finales;
  t_registro_alumno2=record
    codigo_alumno: int8;
    promedio: real;
  end;
  t_abb_alumnos2=^t_nodo_abb_alumnos2;
  t_nodo_abb_alumnos2=record
    ele: t_registro_alumno2;
    hi: t_abb_alumnos2;
    hd: t_abb_alumnos2;
  end;
procedure inicializar_vector_finales(var vector_finales: t_vector_finales);
var
  i: t_materia;
begin
  for i:= 1 to materias_total do
    vector_finales[i]:=nil;
end;
procedure leer_final(var registro_final1: t_registro_final1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_final1.nota:=nota_salida
  else
    registro_final1.nota:=nota_ini+random(nota_fin);
  if (registro_final1.nota<>nota_salida) then
  begin
    registro_final1.codigo_alumno:=1+random(high(int8));
    registro_final1.codigo_materia:=1+random(materias_total);
  end;
end;
procedure inicializar_vector_notas(var vector_notas: t_vector_notas);
var
  i: t_materia;
begin
  for i:= 1 to materias_total do
    vector_notas[i]:=0;
end;
procedure cargar_registro_alumno1(var registro_alumno1: t_registro_alumno1; registro_final1: t_registro_final1);
begin
  registro_alumno1.codigo_alumno:=registro_final1.codigo_alumno;
  inicializar_vector_notas(registro_alumno1.notas);
  if (registro_final1.nota>=nota_corte) then
    registro_alumno1.notas[registro_final1.codigo_materia]:=registro_final1.nota;
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
    if (registro_final1.codigo_alumno=abb_alumnos1^.ele.codigo_alumno) then
    begin
      if (registro_final1.nota>=nota_corte) then
        abb_alumnos1^.ele.notas[registro_final1.codigo_materia]:=registro_final1.nota;
    end
    else if (registro_final1.codigo_alumno<abb_alumnos1^.ele.codigo_alumno) then
      agregar_abb_alumnos1(abb_alumnos1^.hi,registro_final1)
    else
      agregar_abb_alumnos1(abb_alumnos1^.hd,registro_final1);
end;
procedure cargar_registro_final2(var registro_final2: t_registro_final2; registro_final1: t_registro_final1);
begin
  registro_final2.codigo_alumno:=registro_final1.codigo_alumno;
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
procedure cargar_vector_finales(var vector_finales: t_vector_finales; registro_final1: t_registro_final1);
begin
  agregar_adelante_lista_finales(vector_finales[registro_final1.codigo_materia],registro_final1);
end;
procedure cargar_estructuras(var abb_alumnos1: t_abb_alumnos1; var vector_finales: t_vector_finales);
var
  registro_final1: t_registro_final1;
begin
  leer_final(registro_final1);
  while (registro_final1.nota<>nota_salida) do
  begin
    agregar_abb_alumnos1(abb_alumnos1,registro_final1);
    cargar_vector_finales(vector_finales,registro_final1);
    leer_final(registro_final1);
  end;
end;
procedure imprimir_vector_notas(vector_notas: t_vector_notas; codigo_alumno: int8);
var
  i: t_materia;
begin
  for i:= 1 to materias_total do
  begin
    if (vector_notas[i]>0) then
    begin
      textcolor(green); write('La nota de la materia '); textcolor(yellow); write(i); textcolor(green); write(' del código de alumno '); textcolor(yellow); write(codigo_alumno); textcolor(green); write(' es '); textcolor(red); writeln(vector_notas[i]);
    end;
  end;
end;
procedure imprimir_registro_alumno1(registro_alumno1: t_registro_alumno1);
begin
  textcolor(green); write('El código de alumno del alumno es '); textcolor(red); writeln(registro_alumno1.codigo_alumno);
  imprimir_vector_notas(registro_alumno1.notas,registro_alumno1.codigo_alumno);
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
procedure imprimir_registro_final2(registro_final2: t_registro_final2; materia: t_materia; final: int16);
begin
  textcolor(green); write('El código de alumno del final '); textcolor(yellow); write(final); textcolor(green); write(' de la materia '); textcolor(yellow); write(materia); textcolor(green); write(' es '); textcolor(red); writeln(registro_final2.codigo_alumno);
  textcolor(green); write('La nota del final '); textcolor(yellow); write(final); textcolor(green); write(' de la materia '); textcolor(yellow); write(materia); textcolor(green); write(' es '); textcolor(red); writeln(registro_final2.nota);
end;
procedure imprimir_lista_finales(lista_finales: t_lista_finales; materia: t_materia);
var
  i: int16;
begin
  i:=0;
  while (lista_finales<>nil) do
  begin
    i:=i+1;
    imprimir_registro_final2(lista_finales^.ele,materia,i);
    lista_finales:=lista_finales^.sig;
  end;
end;
procedure imprimir_vector_finales(vector_finales: t_vector_finales);
var
  i: t_materia;
begin
  for i:= 1 to materias_total do
  begin
    textcolor(green); write('Los finales rendidos de la materia '); textcolor(yellow); write(i); textcolor(green); writeln(' son:');
    imprimir_lista_finales(vector_finales[i],i);
    writeln();
  end;
end;
function calcular_promedio(vector_notas: t_vector_notas): real;
var
  i: t_materia;
  notas_total, notas: int16;
begin
  notas_total:=0; notas:=0;
  for i:= 1 to materias_total do
    if (vector_notas[i]>=nota_corte) then
    begin
      notas_total:=notas_total+vector_notas[i];
      notas:=notas+1;
    end;
  if (notas>0) then
    calcular_promedio:=notas_total/notas
  else
    calcular_promedio:=notas_total;
end;
procedure cargar_registro_alumno2(var registro_alumno2: t_registro_alumno2; registro_alumno1: t_registro_alumno1);
begin
  registro_alumno2.codigo_alumno:=registro_alumno1.codigo_alumno;
  registro_alumno2.promedio:=calcular_promedio(registro_alumno1.notas);
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
    if (registro_alumno1.codigo_alumno<=abb_alumnos2^.ele.codigo_alumno) then
      agregar_abb_alumnos2(abb_alumnos2^.hi,registro_alumno1)
    else
      agregar_abb_alumnos2(abb_alumnos2^.hd,registro_alumno1);
end;
procedure cargar_abb_alumnos2(var abb_alumnos2: t_abb_alumnos2; abb_alumnos1: t_abb_alumnos1; codigo: int8);
begin
  if (abb_alumnos1<>nil) then
  begin
    if (abb_alumnos1^.ele.codigo_alumno>codigo) then
    begin
      cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hi,codigo);
      agregar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.ele);
      cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hd,codigo);
    end
    else
      cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1^.hd,codigo);;
  end;
end;
procedure imprimir_registro_alumno2(registro_alumno2: t_registro_alumno2);
begin
  textcolor(green); write('El código de alumno del alumno es '); textcolor(red); writeln(registro_alumno2.codigo_alumno);
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
procedure verificar_codigos(var codigo1, codigo2: int8);
var
  aux: int8;
begin
  if (codigo1>codigo2) then
  begin
    aux:=codigo1;
    codigo1:=codigo2;
    codigo2:=aux;
  end;
end;
function contar_notas(vector_notas: t_vector_notas; finales: t_materia): int8;
var
  i: t_materia;
  notas: int8;
begin
  notas:=0;
  for i:= 1 to materias_total do
    if (vector_notas[i]>=nota_corte) then
      notas:=notas+1;
  if (notas=finales) then
    contar_notas:=1
  else
    contar_notas:=0;
end;
function contar_alumnos(abb_alumnos1: t_abb_alumnos1; codigo1, codigo2: int16; finales: t_materia): int16;
begin
  if (abb_alumnos1=nil) then
    contar_alumnos:=0
  else
    if (codigo1>=abb_alumnos1^.ele.codigo_alumno) then
      contar_alumnos:=contar_alumnos(abb_alumnos1^.hd,codigo1,codigo2,finales)
    else if (codigo2<=abb_alumnos1^.ele.codigo_alumno) then
      contar_alumnos:=contar_alumnos(abb_alumnos1^.hi,codigo1,codigo2,finales)
    else
      contar_alumnos:=contar_alumnos(abb_alumnos1^.hi,codigo1,codigo2,finales)+contar_alumnos(abb_alumnos1^.hd,codigo1,codigo2,finales)+contar_notas(abb_alumnos1^.ele.notas,finales);
end;
var
  vector_finales: t_vector_finales;
  abb_alumnos1: t_abb_alumnos1;
  abb_alumnos2: t_abb_alumnos2;
  finales: t_materia;
  codigo, codigo1, codigo2: int8;
begin
  randomize;
  abb_alumnos1:=nil; inicializar_vector_finales(vector_finales);
  abb_alumnos2:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_estructuras(abb_alumnos1,vector_finales);
  if (abb_alumnos1<>nil) then
  begin
    writeln(); textcolor(red); writeln('ABB_ALUMNOS1:'); writeln();
    imprimir_abb_alumnos1(abb_alumnos1);
    writeln(); textcolor(red); writeln('VECTOR_FINALES:'); writeln();
    imprimir_vector_finales(vector_finales);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    codigo:=1+random(high(int8));
    cargar_abb_alumnos2(abb_alumnos2,abb_alumnos1,codigo);
    if (abb_alumnos2<>nil) then
      imprimir_abb_alumnos2(abb_alumnos2);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    codigo1:=1+random(high(int8)); codigo2:=1+random(high(int8)); finales:=2;
    verificar_codigos(codigo1,codigo2);
    textcolor(green); write('La cantidad de alumnos en el abb cuyo código de alumno se encuentra entre '); textcolor(yellow); write(codigo1); textcolor(green); write(' y '); textcolor(yellow); write(codigo2); textcolor(green); write(' y tienen '); textcolor(yellow); write(finales); textcolor(green); write(' finales aprobados es '); textcolor(red); write(contar_alumnos(abb_alumnos1,codigo1,codigo2,finales));
  end;
end.