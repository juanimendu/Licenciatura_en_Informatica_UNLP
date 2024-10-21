{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 17a}
{Realizar un programa que analice las inversiones de las empresas más grandes del país.
Para cada empresa, se lee su código (un número entero), la cantidad de inversiones que tiene y el monto dedicado a cada una de las inversiones.
La lectura finaliza al ingresar la empresa con código 100, que debe procesarse.
El programa deberá informar:
•	Para cada empresa, el monto promedio de sus inversiones.
•	Código de la empresa con mayor monto total invertido.
•	Cantidad de empresas con inversiones de más de $50.000.}

program TP6_E17a;
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
  t_lista_empresas=^t_nodo_empresas;
  t_nodo_empresas=record
    ele: t_registro_empresa;
    sig: t_lista_empresas;
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
procedure agregar_adelante_lista_empresas(var lista_empresas: t_lista_empresas; registro_empresa: t_registro_empresa);
var
  nuevo: t_lista_empresas;
begin
  new(nuevo);
  nuevo^.ele:=registro_empresa;
  nuevo^.sig:=lista_empresas;
  lista_empresas:=nuevo;
end;
procedure cargar_lista_empresas(var lista_empresas: t_lista_empresas);
var 
  registro_empresa: t_registro_empresa;
begin
  repeat
    leer_empresa(registro_empresa);
    agregar_adelante_lista_empresas(lista_empresas,registro_empresa);
  until (lista_empresas^.ele.empresa=empresa_salida);
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
procedure procesar_lista_empresas(lista_empresas: t_lista_empresas; var empresa_max, empresas_corte: int16);
var
  monto_max: real;
begin
  monto_max:=-9999999;
  while (lista_empresas<>nil) do
  begin
    if (lista_empresas^.ele.inversiones>0) then
    begin
      calcular_a(lista_empresas^.ele.empresa,lista_empresas^.ele.inversiones,lista_empresas^.ele.monto_total);
      calcular_b(lista_empresas^.ele.monto_total,lista_empresas^.ele.empresa,monto_max,empresa_max);
      calcular_c(lista_empresas^.ele.monto_total,empresas_corte);
    end;
    lista_empresas:=lista_empresas^.sig;
  end;
end;
var
  lista_empresas: t_lista_empresas;
  empresa_max, empresas_corte: int16;
begin
  randomize;
  lista_empresas:=nil;
  empresa_max:=0;
  empresas_corte:=0;
  cargar_lista_empresas(lista_empresas);
  procesar_lista_empresas(lista_empresas,empresa_max,empresas_corte);
  textcolor(green); write('El código de la empresa con mayor monto total invertido es '); textcolor(red); writeln(empresa_max);
  textcolor(green); write('La cantidad de empresas con inversiones de más de $'); textcolor(yellow); write(monto_corte:0:2); textcolor(green); write(' es '); textcolor(red); write(empresas_corte);
end.