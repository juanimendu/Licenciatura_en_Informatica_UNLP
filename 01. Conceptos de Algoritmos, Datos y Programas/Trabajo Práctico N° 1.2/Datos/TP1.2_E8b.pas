{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 8b}
{Modificar el ejercicio anterior para que, además, informe el día en el que se realizó la mayor cantidad de ventas.}

program TP1_E8b;
{$codepage UTF8}
uses crt;
const
  monto_salida=0;
  dias_total=31;
var
  i, dia_max: int8;
  ventas_dia, ventas_max: int16;
  monto, monto_total: real;
begin
  randomize;
  monto_total:=0;
  ventas_max:=low(int8); dia_max:=0;
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
    if (ventas_dia>ventas_max) then
    begin
      ventas_max:=ventas_dia;
      dia_max:=i;
    end;
  end;
  textcolor(green); write('El monto total acumulado en ventas de todo el mes fue $'); textcolor(red); writeln(monto_total:0:2);
  textcolor(green); write('El día en el que se realizó la mayor cantidad de ventas fue el '); textcolor(red); write(dia_max); textcolor(green); write(' del mes');
end.