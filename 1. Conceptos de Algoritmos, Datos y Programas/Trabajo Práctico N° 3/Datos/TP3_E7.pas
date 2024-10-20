{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 7}
{Realizar un programa que lea información de centros de investigación de Universidades Nacionales.
De cada centro, se lee su nombre abreviado (ej., LIDI, LIFIA, LINTI), la universidad a la que pertenece, la cantidad de investigadores y la cantidad de becarios que poseen.
La información se lee de forma consecutiva por universidad y la lectura finaliza al leer un centro con 0 investigadores, que no debe procesarse.
Informar:
•	Cantidad total de centros para cada universidad.
•	Universidad con mayor cantidad de investigadores en sus centros.
•	Los dos centros con menor cantidad de becarios.}

program TP3_E7;
{$codepage UTF8}
uses crt;
const
  investigadores_salida=0;
type
  t_registro_centro=record
    centro: string;
    universidad: string;
    investigadores: int16;
    becarios: int16;
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
procedure leer_centro(var registro_centro: t_registro_centro; universidad: string);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_centro.investigadores:=investigadores_salida
  else
    registro_centro.investigadores:=1+random(100);
  if (registro_centro.investigadores<>investigadores_salida) then
  begin
    registro_centro.centro:='Centro '+random_string(5+random(6));
    i:=random(2);
    if (i=0) then
      registro_centro.universidad:=universidad
    else
      registro_centro.universidad:='Universidad '+random_string(5+random(6));
    registro_centro.becarios:=1+random(100);
  end;
end;
procedure actualizar_minimos(becarios: int16; centro: string; var becarios_min1, becarios_min2: int16; var centro_min1, centro_min2: string);
begin
  if (becarios<becarios_min1) then
  begin
    becarios_min2:=becarios_min1;
    centro_min2:=centro_min1;
    becarios_min1:=becarios;
    centro_min1:=centro;
  end
  else
    if (becarios<becarios_min2) then
    begin
      becarios_min2:=becarios;
      centro_min2:=centro;
    end;
end;
procedure actualizar_maximo(investigadores_universidad: int16; universidad: string; var investigadores_max: int16; var universidad_max: string);
begin
  if (investigadores_universidad>investigadores_max) then
  begin
    investigadores_max:=investigadores_universidad;
    universidad_max:=universidad;
  end;
end;
procedure leer_centros(var universidad_max, centro_min1, centro_min2: string);
var
  registro_centro: t_registro_centro;
  centros_universidad, investigadores_universidad, investigadores_max, becarios_min1, becarios_min2: int16;
  universidad: string;
begin
  investigadores_max:=low(int16);
  becarios_min1:=high(int16); becarios_min2:=high(int16);
  universidad:='Universidad XXX';
  leer_centro(registro_centro,universidad);
  while (registro_centro.investigadores<>investigadores_salida) do
  begin
    universidad:=registro_centro.universidad;
    centros_universidad:=0;
    investigadores_universidad:=0;
    while ((registro_centro.investigadores<>investigadores_salida) and (registro_centro.universidad=universidad)) do
    begin
      centros_universidad:=centros_universidad+1;
      investigadores_universidad:=investigadores_universidad+registro_centro.investigadores;
      actualizar_minimos(registro_centro.becarios,registro_centro.centro,becarios_min1,becarios_min2,centro_min1,centro_min2);
      leer_centro(registro_centro,universidad);
    end;
    textcolor(green); write('La cantidad total de centros de la universidad '); textcolor(yellow); write(universidad); textcolor(green); write(' es '); textcolor(red); writeln(centros_universidad);
    actualizar_maximo(investigadores_universidad,universidad,investigadores_max,universidad_max);
  end;
end;
var
  universidad_max, centro_min1, centro_min2: string;
begin
  randomize;
  universidad_max:='';
  centro_min1:=''; centro_min2:='';
  leer_centros(universidad_max,centro_min1,centro_min2);
  textcolor(green); write('La universidad con mayor cantidad de investigadores en sus centros es '); textcolor(red); writeln(universidad_max);
  textcolor(green); write('Los dos centros con menor cantidad de becarios son '); textcolor(red); write(centro_min1); textcolor(green); write(' y '); textcolor(red); write(centro_min2);
end.