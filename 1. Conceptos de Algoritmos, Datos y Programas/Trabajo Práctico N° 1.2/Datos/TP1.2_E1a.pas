{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 1a}
{Realizar un programa que lea 10 números enteros e informe la suma total de los números leídos.}

program TP1_E1a;
{$codepage UTF8}
uses crt;
const
  num_total=10;
var
  i: int8;
  num: int16;
  suma: int32;
begin
  randomize;
  suma:=0;
  for i:= 1 to num_total do
  begin
    num:=random(10);
    suma:=suma+num;
  end;
  textcolor(green); write('La suma total de los números leídos es '); textcolor(red); write(suma);
end.