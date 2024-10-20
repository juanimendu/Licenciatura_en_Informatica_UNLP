{TRABAJO PRÁCTICO N° 1.3}
{EJERCICIO 1}
{Realizar un programa que analice las inversiones de las empresas más grandes del país.
Para cada empresa, se lee su código (un número entero), la cantidad de inversiones que tiene y el monto dedicado a cada una de las inversiones.
La lectura finaliza al ingresar la empresa con código 100, que debe procesarse.
El programa deberá informar:
•	Para cada empresa, el monto promedio de sus inversiones.
•	Código de la empresa con mayor monto total invertido.
•	Cantidad de empresas con inversiones de más de $50.000.}

program TP1_E1;
{$codepage UTF8}
uses crt;
const
  empresa_salida=100;
  monto_corte=50000.0;
var
  i: int8;
  j, empresa, inversiones, empresa_max, empresas_corte: int16;
  monto, monto_total, monto_max: real;
begin
  randomize;
  monto_max:=-9999999; empresa_max:=0;
  empresas_corte:=0;
  repeat
    i:=random(100);
    if (i=0) then
      empresa:=empresa_salida
    else
      empresa:=1+random(high(int16));
    inversiones:=1+random(1000);
    monto_total:=0;
    for j:= 1 to inversiones do
    begin
      monto:=1+random(1000);
      monto_total:=monto_total+monto;
    end;
    textcolor(green); write('El monto promedio de las inversiones de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(monto_total/inversiones:0:2);
    if (monto_total>monto_max) then
    begin
      monto_max:=monto_total;
      empresa_max:=empresa;
    end;
    if (monto_total>monto_corte) then
      empresas_corte:=empresas_corte+1;
  until (empresa=empresa_salida);
  textcolor(green); write('El código de la empresa con mayor monto total invertido es '); textcolor(red); writeln(empresa_max);
  textcolor(green); write('La cantidad de empresas con inversiones de más de $'); textcolor(yellow); write(monto_corte:0:2); textcolor(green); write(' es '); textcolor(red); write(empresas_corte);
end.