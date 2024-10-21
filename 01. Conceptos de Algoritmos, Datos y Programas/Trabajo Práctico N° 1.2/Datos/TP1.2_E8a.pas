{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 8a}
{Un local de ropa desea analizar las ventas realizadas en el último mes. Para ello, se lee, por cada día del mes, los montos de las ventas realizadas.
La lectura de montos para cada día finaliza cuando se lee el monto 0. Se asume un mes de 31 días.
Informar la cantidad de ventas por cada día y el monto total acumulado en ventas de todo el mes.}

program TP1_E8a;
{$codepage UTF8}
uses crt;
const
  monto_salida=0;
  dias_total=31;
var
  i: int8;
  ventas_dia: int16;
  monto, monto_total: real;
begin
  randomize;
  monto_total:=0;
  for i:= 1 to dias_total do
  begin
    ventas_dia:=0;
    monto:=monto_salida+random(101);
    while (monto<>monto_salida) do
    begin
      ventas_dia:=ventas_dia+1;
      monto_total:=monto_total+monto;
      monto:=monto_salida+random(101);
    end;
    textcolor(green); write('La cantidad de ventas del día ',i,' del mes fue '); textcolor(red); writeln(ventas_dia);
  end;
  textcolor(green); write('El monto total acumulado en ventas de todo el mes fue $'); textcolor(red); write(monto_total:0:2);
end.