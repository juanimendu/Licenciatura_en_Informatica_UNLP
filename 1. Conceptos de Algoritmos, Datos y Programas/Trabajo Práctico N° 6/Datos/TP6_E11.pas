{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 11}
{La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les entregará el premio Joaquín V. González.
De cada egresado, se conoce su número de alumno, apellido y el promedio obtenido durante toda su carrera.
Implementar un programa que:
•	Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
•	Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los egresados que recibirán el premio.
La información debe imprimirse ordenada según el promedio del egresado (de mayor a menor).}

program TP6_E11;
{$codepage UTF8}
uses crt;
const
  alumno_corte=10;
  alumno_salida=0;
type
  t_registro_alumno=record
    alumno: int16;
    apellido: string;
    promedio: real;
  end;
  t_lista_alumnos=^t_nodo_alumnos;
  t_nodo_alumnos=record
    ele: t_registro_alumno;
    sig: t_lista_alumnos;
  end;
procedure leer_alumno(var registro_alumno: t_registro_alumno);
begin
  textcolor(green); write('Introducir número de alumno del alumno: ');
  textcolor(yellow); readln(registro_alumno.alumno);
  if (registro_alumno.alumno<>alumno_salida) then
  begin
    textcolor(green); write('Introducir apellido del alumno: ');
    textcolor(yellow); readln(registro_alumno.apellido);
    textcolor(green); write('Introducir promedio obtenido durante toda la carrera del alumno: ');
    textcolor(yellow); readln(registro_alumno.promedio);
  end;
end;
procedure agregar_ordenado_lista_alumnos(var lista_alumnos: t_lista_alumnos; registro_alumno: t_registro_alumno);
var
  anterior, actual, nuevo: t_lista_alumnos;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno;
  anterior:=lista_alumnos; actual:=lista_alumnos;
  while ((actual<>nil) and (actual^.ele.promedio>nuevo^.ele.promedio)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_alumnos) then
    lista_alumnos:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_lista_alumnos(var lista_alumnos: t_lista_alumnos);
var
  registro_alumno: t_registro_alumno;
begin
  leer_alumno(registro_alumno);
  while (registro_alumno.alumno<>alumno_salida) do
  begin
    agregar_ordenado_lista_alumnos(lista_alumnos,registro_alumno);
    leer_alumno(registro_alumno);
  end;
end;
procedure procesar_lista_alumnos(lista_alumnos: t_lista_alumnos);
var
  alumno: int16;
begin
  alumno:=0;
  while ((lista_alumnos<>nil) and (alumno<alumno_corte)) do
  begin
    alumno:=alumno+1;
    textcolor(green); write('El apellido y número de alumno del alumno ',alumno,' que recibirá el premio son '); textcolor(red); write(lista_alumnos^.ele.apellido); textcolor(green); write(' y '); textcolor(red); write(lista_alumnos^.ele.alumno); textcolor(green); writeln(', respectivamente');
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
var
  lista_alumnos: t_lista_alumnos;
begin
  lista_alumnos:=nil;
  cargar_lista_alumnos(lista_alumnos);
  if (lista_alumnos<>nil) then
    procesar_lista_alumnos(lista_alumnos);
end.