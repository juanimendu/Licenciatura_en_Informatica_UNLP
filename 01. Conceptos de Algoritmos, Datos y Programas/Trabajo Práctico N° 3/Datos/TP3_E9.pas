{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 9}
{Realizar un programa que lea información de los candidatos ganadores de las últimas elecciones a intendente de la provincia de Buenos Aires.
Para cada candidato, se lee: localidad, apellido del candidato, cantidad de votos obtenidos y cantidad de votantes de la localidad.
La lectura finaliza al leer la localidad “Zárate”, que debe procesarse.
Informar:
•	El intendente que obtuvo la mayor cantidad de votos en la elección.
•	El intendente que obtuvo el mayor porcentaje de votos de la elección.}

program TP3_E9;
{$codepage UTF8}
uses crt;
const
  localidad_salida='Zarate';
type
  t_registro_candidato=record
    localidad: string;
    apellido: string;
    votos: int16;
    votantes: int32;
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
procedure leer_candidato(var registro_candidato: t_registro_candidato);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_candidato.localidad:=localidad_salida
  else
    registro_candidato.localidad:=random_string(5+random(6));
  if (registro_candidato.localidad<>localidad_salida) then
  begin
    registro_candidato.apellido:=random_string(5+random(6));
    registro_candidato.votos:=10000+random(high(int16)-10000);
    registro_candidato.votantes:=100000+random(100001);
  end;
end;
procedure actualizar_maximo_cantidad(votos: int16; intendente: string; var votos_cantidad: int16; var intendente_cantidad: string);
begin
  if (votos>votos_cantidad) then
  begin
    votos_cantidad:=votos;
    intendente_cantidad:=intendente;
  end;
end;
procedure actualizar_maximo_porcentaje(porcentaje: real; intendente: string; var votos_porcentaje: real; var intendente_porcentaje: string);
begin
  if (porcentaje>votos_porcentaje) then
  begin
    votos_porcentaje:=porcentaje;
    intendente_porcentaje:=intendente;
  end;
end;
procedure leer_candidatos(var intendente_cantidad, intendente_porcentaje: string);
var
  registro_candidato: t_registro_candidato;
  votos_cantidad: int16;
  porcentaje, votos_porcentaje: real;
begin
  votos_cantidad:=low(int16);
  votos_porcentaje:=-9999999;
  leer_candidato(registro_candidato);
  while (registro_candidato.localidad<>localidad_salida) do
  begin
    actualizar_maximo_cantidad(registro_candidato.votos,registro_candidato.apellido,votos_cantidad,intendente_cantidad);
    porcentaje:=registro_candidato.votos/registro_candidato.votantes*100;
    actualizar_maximo_porcentaje(porcentaje,registro_candidato.apellido,votos_porcentaje,intendente_porcentaje);
    leer_candidato(registro_candidato);
  end;
end;
var
  intendente_cantidad, intendente_porcentaje: string;
begin
  randomize;
  intendente_cantidad:='';
  intendente_porcentaje:='';
  leer_candidatos(intendente_cantidad,intendente_porcentaje);
  textcolor(green); write('El intendente que obtuvo la mayor cantidad de votos en la elección es '); textcolor(red); writeln(intendente_cantidad);
  textcolor(green); write('El intendente que obtuvo el mayor porcentaje de votos en la elección es '); textcolor(red); write(intendente_porcentaje);
end.