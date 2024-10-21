{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 10}
{Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón A$B#, donde:
•	A es una secuencia de sólo letras vocales.
•	B es una secuencia de sólo caracteres alfabéticos sin letras vocales.
•	Los caracteres $ y # seguro existen.
Nota: En caso de no cumplir, informar qué parte del patrón no se cumplió.}

program TP2_E10;
{$codepage UTF8}
uses crt;
function leer_secuencia(secuencia: string): string;
begin
  textcolor(green); write('Introducir secuencia de caracteres: ');
  textcolor(yellow); readln(secuencia);
  leer_secuencia:=secuencia;
end;
function es_vocal(c: char): boolean;
begin
  es_vocal:=(c='A') or (c='E') or (c='I') or (c='O') or (c='U') or (c='a') or (c='e') or (c='i') or (c='o') or (c='u');
end;
procedure parseo_string(var cumple_A, cumple_B, cumple_AB: boolean);
var
  i, j: int8;
  secuencia: string;
begin
  secuencia:='';
  secuencia:=leer_secuencia(secuencia);
  i:=1;
  while (secuencia[i]<>'$') do
  begin
    cumple_A:=cumple_A and (es_vocal(secuencia[i])=true);
    cumple_AB:=cumple_AB and (es_vocal(secuencia[i])=true);
    i:=i+1;
  end;
  j:=i+1;
  while (secuencia[j]<>'#') do
  begin
    cumple_B:=cumple_B and (es_vocal(secuencia[j])=false);
    cumple_AB:=cumple_AB and (es_vocal(secuencia[j])=false);
    j:=j+1;
  end;
end;
var
  cumple_A, cumple_B, cumple_AB: boolean;
begin
  cumple_A:=true; cumple_B:=true; cumple_AB:=true;
  parseo_string(cumple_A,cumple_B,cumple_AB);
  if (cumple_AB=true) then
  begin
    textcolor(yellow); write('La secuencia cumple con el patrón A$B#');
  end
  else if ((cumple_A=false) and (cumple_B=true)) then
  begin
    textcolor(yellow); write('La secuencia no cumple con la parte A del patrón A$B#');
  end
  else if ((cumple_A=true) and (cumple_B=false)) then
  begin
    textcolor(yellow); write('La secuencia no cumple con la parte B del patrón A$B#');
  end
  else
  begin
    textcolor(yellow); write('La secuencia no cumple con las partes A y B del patrón A$B#');
  end;
end.