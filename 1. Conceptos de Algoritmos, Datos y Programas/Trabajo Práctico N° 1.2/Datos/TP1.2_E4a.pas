{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 4a}
{Realizar un programa que lea 1000 números enteros desde teclado. Informar en pantalla cuáles son los dos números mínimos leídos.}

program TP1_E4a;
{$codepage UTF8}
uses crt;
const
  num_total=1000;
var
  i, num, min1, min2: int16;
begin
  randomize;
  min1:=high(int16); min2:=high(int16);
  for i:= 1 to num_total do
  begin
    num:=random(high(int16));
    if (num<min1) then
    begin
      min2:=min1;
      min1:=num;
    end
    else
      if (num<min2) then
        min2:=num;
  end;
  textcolor(green); write('Los dos números mínimos leídos son '); textcolor(red); write(min1); textcolor(green); write(' y '); textcolor(red); write(min2);
end.