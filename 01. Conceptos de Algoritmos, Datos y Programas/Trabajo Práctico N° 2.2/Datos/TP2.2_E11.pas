{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 11}
{Realizar un programa modularizado que lea una secuencia de caracteres y verifique si cumple con el patrón A%B*, donde:
•	A es una secuencia de caracteres en la que no existe el carácter ‘$’.
•	B es una secuencia con la misma cantidad de caracteres que aparecen en A y en la que aparece, a lo sumo, 3 veces el carácter ‘@’.
•	Los caracteres % y * seguro existen.
Nota: En caso de no cumplir, informar que parte del patrón no se cumplió.}

program TP2_E11;
{$codepage UTF8}
uses crt;
const
  arrobas_corte=3;
function leer_secuencia(secuencia: string): string;
begin
  textcolor(green); write('Introducir secuencia de caracteres: ');
  textcolor(yellow); readln(secuencia);
  leer_secuencia:=secuencia;
end;
procedure parseo_string(var cumple_A, cumple_B, cumple_AB: boolean);
var
  i, j, arrobas: int8;
  secuencia: string;
begin
  secuencia:='';
  secuencia:=leer_secuencia(secuencia);
  i:=1; arrobas:=0;
  while (secuencia[i]<>'%') do
  begin
    cumple_A:=cumple_A and (secuencia[i]<>'$');
    cumple_AB:=cumple_AB and (secuencia[i]<>'$');
    i:=i+1;
  end;
  j:=i+1;
  while (secuencia[j]<>'*') do
  begin
    if (secuencia[j]='@') then
      arrobas:=arrobas+1;
    cumple_B:=cumple_B and (arrobas<=arrobas_corte);
    cumple_AB:=cumple_AB and (arrobas<=arrobas_corte);
    j:=j+1;
  end;
  cumple_B:=cumple_B and (j/2=i);
  cumple_AB:=cumple_AB and (j/2=i);
end;
var
  cumple_A, cumple_B, cumple_AB: boolean;
begin
  cumple_A:=true; cumple_B:=true; cumple_AB:=true;
  parseo_string(cumple_A,cumple_B,cumple_AB);
  if (cumple_AB=true) then
  begin
    textcolor(yellow); write('La secuencia cumple con el patrón A%B*');
  end
  else if ((cumple_A=false) and (cumple_B=true)) then
  begin
    textcolor(yellow); write('La secuencia no cumple con la parte A del patrón A%B*');
  end
  else if ((cumple_A=true) and (cumple_B=false)) then
  begin
    textcolor(yellow); write('La secuencia no cumple con la parte B del patrón A%B*');
  end
  else
  begin
    textcolor(yellow); write('La secuencia no cumple con las partes A y B del patrón A%B*');
  end;
end.