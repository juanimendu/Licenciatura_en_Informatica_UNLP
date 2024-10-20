{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 2b}
{Modificar el programa anterior para que, además de informar el mayor número leído, se informe el número de orden, dentro de la secuencia, en el que fue leído.
Por ejemplo, si se lee la misma secuencia 3 5 6 2 3 10 98 8 -12 9, deberá informar: “El mayor número leído fue el 98, en la posición 7”.}

program TP1_E2b;
{$codepage UTF8}
uses crt;
const
  num_total=10;
var
  i, pos: int8;
  num, max: int16;
begin
  randomize;
  max:=low(int16);
  for i:= 1 to num_total do
  begin
    num:=random(100);
    if (num>max) then
    begin
      max:=num;
      pos:=i;
    end;
  end;
  textcolor(green); write('El mayor número leído fue el '); textcolor(red); write(max); textcolor(green); write(', en la posición '); textcolor(red); write(pos);
end.