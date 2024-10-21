{TRABAJO PRÁCTICO N° 4.2}
{EJERCICIO 3}
{Una empresa de transporte de caudales desea optimizar el servicio que brinda a sus clientes.
Para ello, cuenta con información sobre todos los viajes realizados durante el mes de marzo.
De cada viaje, se cuenta con la siguiente información: día del mes (de 1 a 31), monto de dinero transportado y distancia recorrida por el camión (medida en kilómetros).
(a) Realizar un programa que lea y almacene la información de los viajes (a lo sumo, 200). La lectura finaliza cuando se ingresa una distancia recorrida igual a 0 km, que no debe procesarse.
(b) Realizar un módulo que reciba el vector generado en (a) e informe:
•	El monto promedio transportado de los viajes realizados.
•	La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero.
•	La cantidad de viajes realizados cada día del mes.
(c) Realizar un módulo que reciba el vector generado en (a) y elimine todos los viajes cuya distancia recorrida sea igual a 100 km.
Nota: Para realizar el inciso (b), el vector debe recorrerse una única vez.}

program TP4_E3;
{$codepage UTF8}
uses crt;
const
  dia_ini=1; dia_fin=31;
  viajes_total=200;
  distancia_salida=0;
  distancia_corte=100;
type
  t_viaje=1..viajes_total;
  t_dia=dia_ini..dia_fin;
  t_registro_viaje=record
    dia: t_dia;
    monto: real;
    distancia: real;
  end;
  t_vector_viajes=array[t_viaje] of t_registro_viaje;
  t_vector_dias=array[t_dia] of int16;
procedure inicializar_vector_dias(var vector_dias: t_vector_dias);
var
  i: t_dia;
begin
  for i:= dia_ini to dia_fin do
    vector_dias[i]:=0;
end;
procedure leer_viaje(var registro_viaje: t_registro_viaje);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_viaje.distancia:=distancia_salida
  else if (i<=50) then
    registro_viaje.distancia:=distancia_corte
  else
    registro_viaje.distancia:=1+random(1000);
  if (registro_viaje.distancia<>distancia_salida) then
  begin
    registro_viaje.dia:=dia_ini+random(dia_fin);
    registro_viaje.monto:=1+random(100);
  end;
end;
procedure cargar_vector_viajes(var vector_viajes: t_vector_viajes; var viajes: int16);
var
  registro_viaje: t_registro_viaje;
begin
  leer_viaje(registro_viaje);
  while ((registro_viaje.distancia<>distancia_salida) and (viajes<viajes_total)) do
  begin
    viajes:=viajes+1;
    vector_viajes[viajes]:=registro_viaje;
    leer_viaje(registro_viaje);
  end;
end;
procedure actualizar_minimo(monto: real; dia: t_dia; distancia: real; var monto_min: real; var dia_min: int8; var distancia_min: real);
begin
  if (monto<monto_min) then
  begin
    monto_min:=monto;
    dia_min:=dia;
    distancia_min:=distancia;
  end;
end;
procedure calcular_informar_vector_viajes(vector_viajes: t_vector_viajes; viajes: int16);
var
  vector_dias: t_vector_dias;
  i: t_viaje;
  j: t_dia;
  dia_min: int8;
  monto_total, monto_prom, monto_min, distancia_min: real;
begin
  monto_total:=0; monto_prom:=0;
  monto_min:=9999999; distancia_min:=0; dia_min:=0; 
  inicializar_vector_dias(vector_dias);
  for i:= 1 to viajes do
  begin
    monto_total:=monto_total+vector_viajes[i].monto;
    actualizar_minimo(vector_viajes[i].monto,vector_viajes[i].dia,vector_viajes[i].distancia,monto_min,dia_min,distancia_min);
    vector_dias[vector_viajes[i].dia]:=vector_dias[vector_viajes[i].dia]+1;
  end;
  monto_prom:=monto_total/viajes;
  textcolor(green); write('El monto promedio de los viajes realizados es $'); textcolor(red); writeln(monto_prom:0:2);
  textcolor(green); write('La distancia recorrida y el día del mes en que se realizó el viaje que transportó menos dinero son '); textcolor(red); write(distancia_min:0:2); textcolor(green); write(' y '); textcolor(red); write(dia_min); textcolor(green); writeln(', respectivamente');
  for j:= dia_ini to dia_fin do
  begin
    textcolor(green); write('La cantidad de viajes realizados el día ',j,' del mes de marzo es '); textcolor(red); writeln(vector_dias[j]);
  end;
end;
procedure buscar_desordenado_vector_viajes(vector_viajes: t_vector_viajes; viajes: int16; var pos: int16);
begin
  while ((pos<=viajes) and (vector_viajes[pos].distancia<>distancia_corte)) do
    pos:=pos+1;
  if (pos>viajes) then
    pos:=-1;
end;
procedure eliminar_vector_viajes(var vector_viajes: t_vector_viajes; var viajes: int16; pos: int16);
var
  i: t_viaje;
begin
  if ((pos>=1) and (pos<=viajes)) then
  begin
    for i:= pos to (viajes-1) do
      vector_viajes[i]:=vector_viajes[i+1];
    viajes:=viajes-1;
  end;
end;
procedure buscar_eliminar_vector_viajes(var vector_viajes: t_vector_viajes; var viajes: int16);
var
  pos: int16;
begin
  pos:=0;
  buscar_desordenado_vector_viajes(vector_viajes,viajes,pos);
  while ((pos>=1) and (pos<=viajes)) do
  begin
    eliminar_vector_viajes(vector_viajes,viajes,pos);
    buscar_desordenado_vector_viajes(vector_viajes,viajes,pos);
  end;
end;
procedure imprimir_vector_viajes(vector_viajes: t_vector_viajes; viajes: int16);
var
  i: int16;
begin
  for i:= 1 to viajes do
  begin
    textcolor(green); write('Elemento ',i,' del vector (elemento distancia): '); textcolor(red); writeln(vector_viajes[i].distancia:0:2);
  end;
end;
var
  vector_viajes: t_vector_viajes;
  viajes: int16;
begin
  randomize;
  viajes:=0;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_viajes(vector_viajes,viajes);
  if (viajes>0) then
  begin
    imprimir_vector_viajes(vector_viajes,viajes);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    calcular_informar_vector_viajes(vector_viajes,viajes);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    buscar_eliminar_vector_viajes(vector_viajes,viajes);
    imprimir_vector_viajes(vector_viajes,viajes);
  end;
end.