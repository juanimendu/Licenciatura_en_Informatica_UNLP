{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 8}
{Realizar un programa que lea tres caracteres e informe si los tres eran letras vocales o si, al menos, uno de ellos no lo era.
Por ejemplo, si se leen los caracteres “a e o”, deberá informar “Los tres caracteres son vocales” y, si se leen los caracteres “z a g”, deberá informar “Al menos un caracter no era vocal”.}

program TP1_E8;
{$codepage UTF8}
uses crt;
const
  vocales_corte=3;
var
  vocales: int8;
  letra1, letra2, letra3: char;
begin
  vocales:=0;
  textcolor(green); write('Introducir letra: ');
  textcolor(yellow); readln(letra1);
  textcolor(green); write('Introducir letra: ');
  textcolor(yellow); readln(letra2);
  textcolor(green); write('Introducir letra: ');
  textcolor(yellow); readln(letra3);
  if ((letra1='a') or (letra1='e') or (letra1='i') or (letra1='o') or (letra1='u')) then
    vocales:=vocales+1;
  if ((letra2='a') or (letra2='e') or (letra2='i') or (letra2='o') or (letra2='u')) then
    vocales:=vocales+1;
  if ((letra3='a') or (letra3='e') or (letra3='i') or (letra3='o') or (letra3='u')) then
    vocales:=vocales+1;
  if (vocales=vocales_corte) then
  begin
    textcolor(red); write('Los tres caracteres son vocales');
  end
  else
  begin
    textcolor(red); write('Al menos un caracter no es vocal');
  end;
end.