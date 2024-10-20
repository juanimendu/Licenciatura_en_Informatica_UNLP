{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 7a}
{Realizar un programa que analice las inversiones de las empresas más grandes del país.
Para cada empresa, se lee su código (un número entero), la cantidad de inversiones que tiene y el monto dedicado a cada una de las inversiones.
La lectura finaliza al ingresar la empresa con código 100, que debe procesarse.
El programa deberá informar:
•	Para cada empresa, el monto promedio de sus inversiones.
•	Código de la empresa con mayor monto total invertido.
•	Cantidad de empresas con inversiones de más de $50.000.}

program TP4_E7a;
{$codepage UTF8}
uses crt;
const
  empresa_salida=100;
  monto_corte=50000.0;
  empresas_total=5000;
type
  t_empresa=1..empresas_total;
  t_registro_empresa=record
    empresa: int16;
    inversiones: int16;
    monto_total: real;
  end;
  t_vector_empresas=array[t_empresa] of t_registro_empresa;
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
procedure cargar_vector_empresas(var vector_empresas: t_vector_empresas; var empresas: int16);
var 
  registro_empresa: t_registro_empresa;
begin
  repeat
    leer_empresa(registro_empresa);
    empresas:=empresas+1;
    vector_empresas[empresas]:=registro_empresa;
  until (vector_empresas[empresas].empresa=empresa_salida);
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
procedure procesar_vector_empresas(vector_empresas: t_vector_empresas; empresas: int16; var empresa_max, empresas_corte: int16);
var
  i: t_empresa;
  monto_max: real;
begin
  monto_max:=-9999999;
  for i:= 1 to empresas do
    if (vector_empresas[i].inversiones>0) then
    begin
      calcular_a(vector_empresas[i].empresa,vector_empresas[i].inversiones,vector_empresas[i].monto_total);
      calcular_b(vector_empresas[i].monto_total,vector_empresas[i].empresa,monto_max,empresa_max);
      calcular_c(vector_empresas[i].monto_total,empresas_corte);
    end;
end;
var
  vector_empresas: t_vector_empresas;
  empresas, empresa_max, empresas_corte: int16;
begin
  randomize;
  empresas:=0;
  empresa_max:=0;
  empresas_corte:=0;
  cargar_vector_empresas(vector_empresas,empresas);
  procesar_vector_empresas(vector_empresas,empresas,empresa_max,empresas_corte);
  textcolor(green); write('El código de la empresa con mayor monto total invertido es '); textcolor(red); writeln(empresa_max);
  textcolor(green); write('La cantidad de empresas con inversiones de más de $'); textcolor(yellow); write(monto_corte:0:2); textcolor(green); write(' es '); textcolor(red); write(empresas_corte);
end.