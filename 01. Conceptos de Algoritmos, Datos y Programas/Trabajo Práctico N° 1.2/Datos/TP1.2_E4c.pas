{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 4c}
{Modificar el ejercicio anterior para que, en vez de leer 1000 números, la lectura finalice al leer el número 0, el cual no debe procesarse.}

program TP1_E4c;
{$codepage UTF8}
uses crt;
const
  num_salida=0;
var
  num, min1, min2: int16;
begin
  randomize;
  min1:=high(int16); min2:=high(int16);
  num:=num_salida+random(high(int16));
  while (num<>num_salida) do
  begin
    if (num<min1) then
    begin
      min2:=min1;
      min1:=num;
    end
    else
      if (num<min2) then
        min2:=num;
    num:=num_salida+random(high(int16));
  end;
  textcolor(green); write('Los dos números mínimos leídos son '); textcolor(red); write(min1); textcolor(green); write(' y '); textcolor(red); write(min2);
end.