{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 6}
{La compañía Canonical Llt. desea obtener estadísticas acerca del uso de Ubuntu Linux en La Plata.
Para ello, debe realizar un programa que lea y almacene información sobre las computadoras con este sistema operativo (a lo sumo, 10000).
De cada computadora se conoce: código de computadora, la versión de Ubuntu que utiliza (18.04, 17.10, 17.04, etc.), la cantidad de paquetes instalados y la cantidad de cuentas de usuario que posee.
La información debe almacenarse ordenada por código de computadora de manera ascendente.
La lectura finaliza al ingresar el código de computadora -1, que no debe procesarse.
Una vez almacenados todos los datos, se pide:
•	Informar la cantidad de computadoras que utilizan las versiones 18.04 o 16.04.
•	Informar el promedio de cuentas de usuario por computadora.
•	Informar la versión de Ubuntu de la computadora con mayor cantidad de paquetes instalados.
•	Eliminar la información de las computadoras con código entre 0 y 500.}

program TP4_E6;
{$codepage UTF8}
uses crt;
const
  computadoras_total=10000;
  computadora_salida=-1;
  version_corte1='18.04'; version_corte2='16.04';
  computadora_corte1=0; computadora_corte2=500;
type
  t_computadora=1..computadoras_total;
  t_registro_computadora=record
    computadora: int16;
    version: string;
    paquetes: int16;
    cuentas: int16;
  end;
  t_vector_computadoras=array[t_computadora] of t_registro_computadora;
procedure leer_computadora(var registro_computadora: t_registro_computadora);
var
  vector_versiones: array[1..4] of string=('18.04', '17.10', '17.04', '16.04');
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_computadora.computadora:=computadora_salida
  else
    registro_computadora.computadora:=1+random(high(int16));
  if (registro_computadora.computadora<>computadora_salida) then
  begin
    registro_computadora.version:=vector_versiones[1+random(4)];
    registro_computadora.paquetes:=1+random(100);
    registro_computadora.cuentas:=1+random(100);
  end;
end;
function buscar_ordenado_vector_computadoras(vector_computadoras: t_vector_computadoras; computadoras, computadora: int16): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=computadoras) and (vector_computadoras[pos].computadora<computadora)) do
    pos:=pos+1;
  buscar_ordenado_vector_computadoras:=pos;
end;
procedure insertar_vector_computadoras(var vector_computadoras: t_vector_computadoras; var computadoras: int16; registro_computadora: t_registro_computadora; pos: int16);
var
  i: t_computadora;
begin
  if ((computadoras<computadoras_total) and ((pos>=1) and (pos<=computadoras))) then
    for i:= computadoras downto pos do
      vector_computadoras[i+1]:=vector_computadoras[i];
  if ((computadoras<computadoras_total) and ((pos>=1) and (pos<=computadoras+1))) then
  begin
    vector_computadoras[pos]:=registro_computadora;
    computadoras:=computadoras+1;
  end;
end;
procedure cargar_vector_computadoras(var vector_computadoras: t_vector_computadoras; var computadoras: int16);
var
  registro_computadora: t_registro_computadora;
  pos: int16;
begin
  pos:=0;
  leer_computadora(registro_computadora);
  while ((registro_computadora.computadora<>computadora_salida) and (computadoras<computadoras_total)) do
  begin
    pos:=buscar_ordenado_vector_computadoras(vector_computadoras,computadoras,registro_computadora.computadora);
    insertar_vector_computadoras(vector_computadoras,computadoras,registro_computadora,pos);
    leer_computadora(registro_computadora);
  end;
end;
procedure actualizar_maximo(paquetes: int16; version: string; var paquetes_max: int16; var version_max: string);
begin
  if (paquetes>paquetes_max) then
  begin
    paquetes_max:=paquetes;
    version_max:=version;
  end;
end;
procedure eliminar_vector_computadoras(var vector_computadoras: t_vector_computadoras; var computadoras: int16; pos: int16);
var
  i: t_computadora;
begin
  if ((pos>=1) and (pos<=computadoras)) then
  begin
    for i:= pos to (computadoras-1) do
      vector_computadoras[i]:=vector_computadoras[i+1];
    computadoras:=computadoras-1;
  end;
end;
procedure procesar_vector_computadoras(var vector_computadoras: t_vector_computadoras; var computadoras, versiones_corte: int16; var cuentas_prom: real; var version_max: string);
var
  pos: int16;
  computadoras_aux, cuentas_total, paquetes_max: int16;
begin
  pos:=1;
  computadoras_aux:=computadoras;
  cuentas_total:=0;
  paquetes_max:=low(int16);
  while ((pos>=1) and (pos<=computadoras)) do
  begin
    if ((vector_computadoras[pos].version=version_corte1) or (vector_computadoras[pos].version=version_corte2)) then
      versiones_corte:=versiones_corte+1;
    cuentas_total:=cuentas_total+vector_computadoras[pos].cuentas;
    actualizar_maximo(vector_computadoras[pos].paquetes,vector_computadoras[pos].version,paquetes_max,version_max);
    if ((vector_computadoras[pos].computadora>computadora_corte1) and (vector_computadoras[pos].computadora<computadora_corte2)) then
    begin
      eliminar_vector_computadoras(vector_computadoras,computadoras,pos);
      pos:=pos-1;
    end;
    pos:=pos+1;
  end;
  cuentas_prom:=cuentas_total/computadoras_aux;
end;
var
  vector_computadoras: t_vector_computadoras;
  computadoras, versiones_corte: int16;
  cuentas_prom: real;
  version_max: string;
begin
  randomize;
  computadoras:=0;
  versiones_corte:=0;
  cuentas_prom:=0;
  version_max:='';
  cargar_vector_computadoras(vector_computadoras,computadoras);
  if (computadoras>0) then
  begin
    procesar_vector_computadoras(vector_computadoras,computadoras,versiones_corte,cuentas_prom,version_max);
    textcolor(green); write('La cantidad de computadoras que utilizan las versiones '); textcolor(yellow); write(version_corte1); textcolor(green); write(' o '); textcolor(yellow); write(version_corte2); textcolor(green); write(' es '); textcolor(red); writeln(versiones_corte);
    textcolor(green); write('El promedio de cuentas de usuario por computadora es '); textcolor(red); writeln(cuentas_prom:0:2);
    textcolor(green); write('La versión de Ubuntu de la computadora con mayor cantidad de paquetes instalados es '); textcolor(red); write(version_max);
  end;
end.