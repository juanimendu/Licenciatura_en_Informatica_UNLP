{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 15}
{La cátedra de CADP está organizando la cursada para el año 2019. Para ello, dispone de una lista con todos los alumnos que cursaron EPA.
De cada alumno, se conoce su DNI, apellido, nombre y la nota obtenida.
Escribir un programa que procese la información de alumnos disponible y los distribuya en turnos utilizando los siguientes criterios:
•	Los alumnos que obtuvieron, al menos, 8 en EPA deberán ir a los turnos 1 o 4.
•	Los alumnos que obtuvieron entre 5 y 8 deberán ir a los turnos 2, 3 o 5.
•	Los alumnos que no alcanzaron la nota 5 no se les asignará turno en CADP.
Al finalizar, el programa debe imprimir en pantalla la lista de alumnos para cada turno.
Nota: La distribución de alumnos debe ser lo más equitativa posible.}

program TP6_E15;
{$codepage UTF8}
uses crt;
const
  dni_salida=0;
  nota_ini=1; nota_fin=10;
  turno_ini=1; turno_fin=5;
  nota_corte1=8; nota_corte2=5;
type
  t_nota=nota_ini..nota_fin;
  t_turno=turno_ini..turno_fin;
  t_registro_alumno=record
    dni: int16;
    apellido: string;
    nota: t_nota;
  end;
  t_lista_alumnos=^t_nodo_alumnos;
  t_nodo_alumnos=record
    ele: t_registro_alumno;
    sig: t_lista_alumnos;
  end;
  t_vector_alumnos=array[t_turno] of t_lista_alumnos;
procedure inicializar_vector_alumnos(var vector_alumnos: t_vector_alumnos);
var
  i: t_turno;
begin
  for i:= turno_ini to turno_fin do
    vector_alumnos[i]:=nil;
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
procedure leer_alumno(var registro_alumno: t_registro_alumno);
begin
  registro_alumno.dni:=1+random(high(int16));
  if (registro_alumno.dni<>dni_salida) then
  begin
    registro_alumno.apellido:=random_string(1+random(10));
    registro_alumno.nota:=nota_ini+random(nota_fin);
  end;
end;
procedure agregar_adelante_lista_alumnos(var lista_alumnos: t_lista_alumnos; registro_alumno: t_registro_alumno);
var
  nuevo: t_lista_alumnos;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno;
  nuevo^.sig:=lista_alumnos;
  lista_alumnos:=nuevo;
end;
procedure cargar_lista_alumnos(var lista_alumnos: t_lista_alumnos);
var
  registro_alumno: t_registro_alumno;
begin
  leer_alumno(registro_alumno);
  while (registro_alumno.dni<>dni_salida) do
  begin
    agregar_adelante_lista_alumnos(lista_alumnos,registro_alumno);
    leer_alumno(registro_alumno);
  end;
end;
function randomH(): int8;
var
  vectorH: array[1..2] of int8;
begin
  vectorH[1]:=1;
  vectorH[2]:=4;
  randomH:=vectorH[1+random(2)];
end;
function randomM(): int8;
var
  vectorM: array[1..3] of int8;
begin
  vectorM[1]:=2;
  vectorM[2]:=3;
  vectorM[3]:=5;
  randomM:=vectorM[1+random(3)];
end;
procedure procesar_lista_alumnos(lista_alumnos: t_lista_alumnos; var vector_alumnos: t_vector_alumnos);
begin
  while (lista_alumnos<>nil) do
  begin
    if (lista_alumnos^.ele.nota>=nota_corte1) then
      agregar_adelante_lista_alumnos(vector_alumnos[randomH()],lista_alumnos^.ele)
    else
      if (lista_alumnos^.ele.nota>=nota_corte2) then
        agregar_adelante_lista_alumnos(vector_alumnos[randomM()],lista_alumnos^.ele);
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
procedure imprimir_vector_alumnos(vector_alumnos: t_vector_alumnos);
var
  i: t_turno;
begin
  for i:= turno_ini to turno_fin do
    while (vector_alumnos[i]<>nil) do
    begin
      textcolor(green); write('TURNO ',i,': '); textcolor(green); write('DNI - '); textcolor(red); write(vector_alumnos[i]^.ele.dni); textcolor(green); write('; APELLIDO - '); textcolor(red); write(vector_alumnos[i]^.ele.apellido); textcolor(green); write('; NOTA - '); textcolor(red); writeln(vector_alumnos[i]^.ele.nota);
      vector_alumnos[i]:=vector_alumnos[i]^.sig;
    end;
end;
var
  vector_alumnos: t_vector_alumnos;
  lista_alumnos: t_lista_alumnos;
begin
  randomize;
  lista_alumnos:=nil;
  inicializar_vector_alumnos(vector_alumnos);
  cargar_lista_alumnos(lista_alumnos);
  if (lista_alumnos<>nil) then
  begin
    procesar_lista_alumnos(lista_alumnos,vector_alumnos);
    imprimir_vector_alumnos(vector_alumnos);
  end;
end.