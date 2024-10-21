{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 5}
{Modificar el ejercicio anterior para que, luego de leer el número X, se lean, a lo sumo, 10 números reales.
La lectura deberá finalizar al ingresar un valor que sea el doble de X o al leer el décimo número, en cuyo caso deberá informarse:
“No se ha ingresado el doble de X”.}

program TP1_E5;
{$codepage UTF8}
uses crt;
const
  num_total=10;
  multiplo=2;
var
  i: int8;
  num1, num2: real;
begin
  randomize;
  i:=1;
  num1:=random(1000)/10;
  num2:=multiplo*num1+random(num_total);
  while ((i<num_total) and (num2<>(num1*multiplo))) do
  begin
    i:=i+1;
    num2:=multiplo*num1+random(num_total);
  end;
  if (i<num_total) then
  begin
    textcolor(green); write('El número introducido ('); textcolor(red); write(num2:0:2); textcolor(green); write(') es igual al inicial ('); textcolor(red); write(num1:0:2); textcolor(green); write(') multiplicado por '); textcolor(yellow); write(multiplo);
  end
  else
  begin
    textcolor(green); write('No se ha ingresado el doble de '); textcolor(red); write(num1:0:2);
  end;
end.