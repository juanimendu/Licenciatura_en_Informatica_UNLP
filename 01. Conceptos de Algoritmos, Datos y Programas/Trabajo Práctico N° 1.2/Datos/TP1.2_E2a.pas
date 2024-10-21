{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 2a}
{Realizar un programa que lea 10 números e informe cuál fue el mayor número leído.
Por ejemplo, si se lee la secuencia 3 5 6 2 3 10 98 8 -12 9, deberá informar: “El mayor número leído fue el 98”.}

program TP1_E2a;
{$codepage UTF8}
uses crt;
const
  num_total=10;
var
  i: int8;
  num, max: int16;
begin
  randomize;
  max:=low(int16);
  for i:= 1 to num_total do
  begin
    num:=random(100);
    if (num>max) then
      max:=num;
  end;
  textcolor(green); write('El mayor número leído fue el '); textcolor(red); write(max);
end.