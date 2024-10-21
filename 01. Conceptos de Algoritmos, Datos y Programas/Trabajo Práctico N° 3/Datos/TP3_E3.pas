{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 3}
{El Ministerio de Educación desea realizar un relevamiento de las 2400 escuelas primarias de la provincia de Bs. As.,
con el objetivo de evaluar si se cumple la proporción de alumnos por docente calculada por la UNESCO para el año 2015 (1 docente cada 23.435 alumnos).
Para ello, se cuenta con información de: CUE (código único de establecimiento), nombre del establecimiento, cantidad de docentes, cantidad de alumnos, localidad.
Se pide implementar un programa que procese la información y determine:
•	Cantidad de escuelas de La Plata con una relación de alumnos por docente superior a la sugerida por UNESCO.
•	CUE y nombre de las dos escuelas con mejor relación entre docentes y alumnos.
El programa debe utilizar:
•	Un módulo para la lectura de la información de la escuela.
•	Un módulo para determinar la relación docente-alumno (esa relación se obtiene del cociente entre la cantidad de alumnos y la cantidad de docentes).}

program TP3_E3;
{$codepage UTF8}
uses crt;
const
  escuelas_total=2400;
  localidad_corte='La Plata'; ratio_corte=23.435;
type
  t_registro_escuela=record
    escuela: int16;
    nombre: string;
    docentes: int16;
    alumnos: int16;
    localidad: string;
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
procedure leer_escuela(var registro_escuela: t_registro_escuela);
var
  i: int8;
begin
  registro_escuela.escuela:=1+random(high(int16));
  registro_escuela.nombre:='Escuela '+random_string(5+random(6));
  registro_escuela.docentes:=1+random(100);
  registro_escuela.alumnos:=1+random(1000);
  i:=random(100);
  if (i=0) then
    registro_escuela.localidad:=localidad_corte
  else
    registro_escuela.localidad:='Localidad '+random_string(5+random(6));
end;
function ratio_alumnos_docente(registro_escuela: t_registro_escuela): real;
begin
    ratio_alumnos_docente:=registro_escuela.alumnos/registro_escuela.docentes;
end;
procedure actualizar_minimos(ratio: real; registro_escuela: t_registro_escuela; var ratio_min1, ratio_min2: real; var escuela_min1, escuela_min2: int16; var nombre_min1, nombre_min2: string);
begin
  if (ratio<ratio_min1) then
  begin
    ratio_min2:=ratio_min1;
    escuela_min2:=escuela_min1;
    nombre_min2:=nombre_min1;
    nombre_min1:=registro_escuela.nombre;
    escuela_min1:=registro_escuela.escuela;
  end
  else
    if (ratio<ratio_min2) then
    begin
      ratio_min2:=ratio;
      escuela_min2:=registro_escuela.escuela;
      nombre_min2:=registro_escuela.nombre;
  end;
end;
procedure leer_escuelas(var escuelas_corte, escuela_min1, escuela_min2: int16; var nombre_min1, nombre_min2: string);
var
  registro_escuela: t_registro_escuela;
  i: int16;
  ratio, ratio_min1, ratio_min2: real;
begin
  ratio:=0;
  ratio_min1:=9999999; ratio_min2:=9999999;
  for i:= 1 to escuelas_total do
  begin
    leer_escuela(registro_escuela);
    ratio:=ratio_alumnos_docente(registro_escuela);
    actualizar_minimos(ratio,registro_escuela,ratio_min1,ratio_min2,escuela_min1,escuela_min2,nombre_min1,nombre_min2);
    if ((registro_escuela.localidad=localidad_corte) and (ratio>ratio_corte)) then
      escuelas_corte:=escuelas_corte+1;
  end;
end;
var
  escuelas_corte, escuela_min1, escuela_min2: int16;
  nombre_min1, nombre_min2: string;
begin
  randomize;
  escuelas_corte:=0;
  escuela_min1:=0; escuela_min2:=0; nombre_min1:=''; nombre_min2:='';
  leer_escuelas(escuelas_corte,escuela_min1,escuela_min2,nombre_min1,nombre_min2);
  textcolor(green); write('La cantidad de escuelas de '); textcolor(yellow); write(localidad_corte); textcolor(green); write(' con una relación de alumnos por docente superior a la sugerida por UNESCO ('); textcolor(yellow); write(ratio_corte:0:2); textcolor(green); write(') es '); textcolor(red); writeln(escuelas_corte);
  textcolor(green); write('Los CUEs de las dos escuelas con mejor relación entre docentes y alumnos son '); textcolor(red); write(escuela_min1); textcolor(green); write(' y '); textcolor(red); writeln(escuela_min2);
  textcolor(green); write('Los nombres de las dos escuelas con mejor relación entre docentes y alumnos son '); textcolor(red); write(nombre_min1); textcolor(green); write(' y '); textcolor(red); write(nombre_min2);
end.