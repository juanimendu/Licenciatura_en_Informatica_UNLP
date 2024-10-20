{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 6}
{(a) Realizar un módulo que lea de teclado números enteros hasta que llegue un valor negativo. Al finalizar la lectura, el módulo debe imprimir en pantalla cuál fue el número par más alto.
(b) Implementar un programa que invoque al módulo del inciso (a).}

program TP2_E6;
{$codepage UTF8}
uses crt;
const
  num_salida=-1;
var 
  num, num_max: int16;
procedure num_par_mayor;
begin
  num_max:=low(int16);
  num:=num_salida+random(102);
  while (num<>num_salida) do
  begin
    if ((num mod 2=0) and (num>num_max)) then
      num_max:=num;
    num:=num_salida+random(102);
  end;
  textcolor(green); write('El número par más alto fue '); textcolor(red); write(num_max);
end;
begin
  randomize;
  num_par_mayor;
end.