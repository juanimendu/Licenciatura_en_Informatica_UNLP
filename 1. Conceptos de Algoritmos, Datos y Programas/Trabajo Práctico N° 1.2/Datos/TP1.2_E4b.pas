{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 4b}
{Modificar el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer el número 0, el cual debe procesarse.}

program TP1_E4b;
{$codepage UTF8}
uses crt;
const
  num_salida=0;
var
  num, min1, min2: int16;
begin
  randomize;
  min1:=high(int16); min2:=high(int16);
  repeat
    num:=num_salida+random(high(int16));
    if (num<min1) then
    begin
      min2:=min1;
      min1:=num;
    end
    else
      if (num<min2) then
        min2:=num;
  until (num=num_salida);
  textcolor(green); write('Los dos números mínimos leídos son '); textcolor(red); write(min1); textcolor(green); write(' y '); textcolor(red); write(min2);
end.