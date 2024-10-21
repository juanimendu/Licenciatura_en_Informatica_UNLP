{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 12a}
{Realizar un programa que analice las inversiones de las empresas más grandes del país.
Para cada empresa, se lee su código (un número entero), la cantidad de inversiones que tiene y el monto dedicado a cada una de las inversiones.
La lectura finaliza al ingresar la empresa con código 100, que debe procesarse.
El programa deberá informar:
•	Para cada empresa, el monto promedio de sus inversiones.
•	Código de la empresa con mayor monto total invertido.
•	Cantidad de empresas con inversiones de más de $50.000.}

program TP3_E12a;
{$codepage UTF8}
uses crt;
const
  empresa_salida=100;
  monto_corte=50000.0;
type
  t_registro_empresa=record
    empresa: int16;
    inversiones: int16;
    monto_total: real;
  end;
procedure leer_inversiones(empresa, inversiones: int16; var monto_total: real);
var
  i: int16;
  monto: real;
begin
  monto_total:=0;
  for i:= 1 to inversiones do
  begin
    monto:=1+random(1000);
    monto_total:=monto_total+monto;
  end;
end;
procedure leer_empresa(var registro_empresa: t_registro_empresa);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_empresa.empresa:=empresa_salida
  else
    registro_empresa.empresa:=1+random(high(int16));
  registro_empresa.inversiones:=1+random(1000);
  leer_inversiones(registro_empresa.empresa,registro_empresa.inversiones,registro_empresa.monto_total);
end;
procedure calcular_a(empresa, inversiones: int16; monto_total: real);
begin
  textcolor(green); write('El monto promedio de las inversiones de la empresa '); textcolor(yellow); write(empresa); textcolor(green); write(' es '); textcolor(red); writeln(monto_total/inversiones:0:2);
end;
procedure calcular_b(monto_total: real; empresa: int16; var monto_max: real; var empresa_max: int16);
begin
  if (monto_total>monto_max) then
  begin
    monto_max:=monto_total;
    empresa_max:=empresa;
  end;
end;
procedure calcular_c(monto_total: real; var empresas_corte: int16);
begin
  if (monto_total>monto_corte) then
    empresas_corte:=empresas_corte+1;
end;
procedure leer_empresas(var empresa_max, empresas_corte: int16);
var 
  registro_empresa: t_registro_empresa;
  monto_max: real;
begin
  monto_max:=-9999999;
  repeat
    leer_empresa(registro_empresa);
    calcular_a(registro_empresa.empresa,registro_empresa.inversiones,registro_empresa.monto_total);
    calcular_b(registro_empresa.monto_total,registro_empresa.empresa,monto_max,empresa_max);
    calcular_c(registro_empresa.monto_total,empresas_corte);
  until (registro_empresa.empresa=empresa_salida);
end;
var
  empresa_max, empresas_corte: int16;
begin
  randomize;
  empresa_max:=0;
  empresas_corte:=0;
  leer_empresas(empresa_max,empresas_corte);
  textcolor(green); write('El código de la empresa con mayor monto total invertido es '); textcolor(red); writeln(empresa_max);
  textcolor(green); write('La cantidad de empresas con inversiones de más de $'); textcolor(yellow); write(monto_corte:0:2); textcolor(green); write(' es '); textcolor(red); write(empresas_corte);
end.