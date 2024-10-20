{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 14}
{La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a alumnos de la UNLP.
Para ello, esta oficina cuenta con un registro detallado de todos los viajes realizados por una muestra de 1300 alumnos durante el mes de marzo.
De cada viaje, se conoce el código de alumno (entre 1 y 1300), día del mes, Facultad a la que pertenece y medio de transporte (1. colectivo urbano; 2. colectivo interurbano; 3. tren universitario; 4. tren Roca; 5. bicicleta).
Tener en cuenta que un alumno puede utilizar más de un medio de transporte en un mismo día. Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una estructura de datos apropiada.
La lectura finaliza al ingresarse el código de alumno -1, que no debe procesarse.
Una vez finalizada la lectura, informar:
•	La cantidad de alumnos que realizan más de 6 viajes por día.
•	La cantidad de alumnos que gastan en transporte más de $80 por día.
•	Los dos medios de transporte más utilizados.
•	La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.}

program TP6_E14;
{$codepage UTF8}
uses crt;
const
  alumnos_total=1300;
  dia_ini=1; dia_fin=31;
  transporte_ini=1; transporte_fin=5;
  alumno_salida=-1;
  viajes_corte=6;
  gasto_corte=80;
  transporte_corte=5;
type
  t_alumno=1..alumnos_total;
  t_dia=dia_ini..dia_fin;
  t_transporte=transporte_ini..transporte_fin;
  t_registro_viaje=record
    alumno: int16;
    dia: t_dia;
    facultad: string;
    transporte: t_transporte;
  end;
  t_vector_precios=array[t_transporte] of real;
  t_vector_transportes=array[t_transporte] of int16;
  t_lista_viajes=^t_nodo_viajes;
  t_nodo_viajes=record
    ele: t_registro_viaje;
    sig: t_lista_viajes;
  end;
  t_vector_alumnos=array[t_alumno] of t_lista_viajes;
procedure cargar_vector_precios(var vector_precios: t_vector_precios);
var
  i: t_transporte;
begin
  for i:= transporte_ini to transporte_fin do
    vector_precios[i]:=10+random(90);
end;
procedure inicializar_vector_alumnos(var vector_alumnos: t_vector_alumnos);
var
  i: t_alumno;
begin
  for i:= 1 to alumnos_total do
    vector_alumnos[i]:=nil;
end;
function random_string(length: int8): string;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leer_viaje(var registro_viaje: t_registro_viaje);
begin
  registro_viaje.alumno:=alumno_salida+random(100);
  if (registro_viaje.alumno<>alumno_salida) then
  begin
    registro_viaje.dia:=dia_ini+random(dia_fin);
    registro_viaje.facultad:=random_string(1+random(10));
    registro_viaje.transporte:=transporte_ini+random(transporte_fin);
  end;
end;
procedure agregar_ordenado_lista_viajes(var lista_viajes: t_lista_viajes; registro_viaje: t_registro_viaje);
var
  anterior, actual, nuevo: t_lista_viajes;
begin
  new(nuevo);
  nuevo^.ele:=registro_viaje;
  anterior:=lista_viajes; actual:=lista_viajes;
  while ((actual<>nil) and (actual^.ele.dia<nuevo^.ele.dia)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_viajes) then
    lista_viajes:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_lista_viajes(var lista_viajes: t_lista_viajes; alumno: t_alumno);
var
  registro_viaje: t_registro_viaje;
begin
  leer_viaje(registro_viaje);
  while (registro_viaje.alumno<>alumno_salida) do
  begin
    registro_viaje.alumno:=alumno;
    agregar_ordenado_lista_viajes(lista_viajes,registro_viaje);
    leer_viaje(registro_viaje);
  end;
end;
procedure cargar_vector_alumnos(var vector_alumnos: t_vector_alumnos);
var
  i: t_alumno;
begin
  for i:= 1 to alumnos_total do
    cargar_lista_viajes(vector_alumnos[i],i);
end;
procedure inicializar_vector_transportes(var vector_transportes: t_vector_transportes);
var
  i: t_transporte;
begin
  for i:= transporte_ini to transporte_fin do
    vector_transportes[i]:=0;
end;
function cumple_criterio(vector_transportes2: t_vector_transportes): boolean;
var
  transporte: t_transporte;
  cumple: boolean;
begin
  transporte:=transporte_ini;
  cumple:=false;
  while ((transporte<transporte_fin) and (cumple<>true)) do
  begin
    if (vector_transportes2[transporte]>0) then
      cumple:=true;
    transporte:=transporte+1;
  end;
  cumple_criterio:=cumple;
end;
procedure procesar_vector_transportes1(vector_transportes1: t_vector_transportes; var transporte_max1, transporte_max2: int8);
var
  i: t_transporte;
  viajes_max1, viajes_max2: int16;
begin
  viajes_max1:=low(int16); viajes_max2:=low(int16);
  for i:= transporte_ini to transporte_fin do
  begin
    if (vector_transportes1[i]>viajes_max1) then
    begin
      viajes_max2:=viajes_max1;
      transporte_max2:=transporte_max1;
      viajes_max1:=vector_transportes1[i];
      transporte_max1:=i;
    end
    else
      if (vector_transportes1[i]>viajes_max2) then
      begin
        viajes_max2:=vector_transportes1[i];
        transporte_max2:=i;
      end;
  end;
end;
procedure procesar_vector_alumnos(vector_alumnos: t_vector_alumnos; vector_precios: t_vector_precios; var alumnos_corte_viajes, alumnos_corte_gasto, alumnos_transportes: int16; var transporte_max1, transporte_max2: int8);
var
  vector_transportes1, vector_transportes2: t_vector_transportes;
  i: t_alumno;
  dia: t_dia;
  viajes_dia: int16;
  gasto_dia: real;
  cumple_viajes, cumple_gasto: boolean;
begin
  inicializar_vector_transportes(vector_transportes1);
  for i:= 1 to alumnos_total do
  begin
    cumple_viajes:=true; cumple_gasto:=true;
    inicializar_vector_transportes(vector_transportes2);
    while (vector_alumnos[i]<>nil) do
    begin
      dia:=vector_alumnos[i]^.ele.dia;
      viajes_dia:=0;
      gasto_dia:=0;
      while ((vector_alumnos[i]<>nil) and (vector_alumnos[i]^.ele.dia=dia)) do
      begin
        viajes_dia:=viajes_dia+1;
        gasto_dia:=gasto_dia+vector_precios[vector_alumnos[i]^.ele.transporte];
        vector_transportes1[vector_alumnos[i]^.ele.transporte]:=vector_transportes1[vector_alumnos[i]^.ele.transporte]+1;
        vector_transportes2[vector_alumnos[i]^.ele.transporte]:=vector_transportes2[vector_alumnos[i]^.ele.transporte]+1;
        vector_alumnos[i]:=vector_alumnos[i]^.sig;
      end;
      if ((cumple_viajes<>false) and (viajes_dia<=viajes_corte)) then
        cumple_viajes:=false;
      if ((cumple_gasto<>false) and (gasto_dia<=gasto_corte)) then
        cumple_gasto:=false;
    end;
    if (cumple_viajes=true) then
      alumnos_corte_viajes:=alumnos_corte_viajes+1;
    if (cumple_gasto=true) then
      alumnos_corte_gasto:=alumnos_corte_gasto+1;
    if ((vector_transportes2[transporte_corte]<>0) and (cumple_criterio(vector_transportes2)=true)) then
      alumnos_transportes:=alumnos_transportes+1;
  end;
  procesar_vector_transportes1(vector_transportes1,transporte_max1,transporte_max2);
end;
var
  vector_precios: t_vector_precios;
  vector_alumnos: t_vector_alumnos;
  transporte_max1, transporte_max2: int8;
  alumnos_corte_viajes, alumnos_corte_gasto, alumnos_transportes: int16;
begin
  randomize;
  cargar_vector_precios(vector_precios);
  alumnos_corte_viajes:=0;
  alumnos_corte_gasto:=0;
  transporte_max1:=0; transporte_max2:=0;
  alumnos_transportes:=0;
  inicializar_vector_alumnos(vector_alumnos);
  cargar_vector_alumnos(vector_alumnos);
  procesar_vector_alumnos(vector_alumnos,vector_precios,alumnos_corte_viajes,alumnos_corte_gasto,alumnos_transportes,transporte_max1,transporte_max2);
  textcolor(green); write('La cantidad de alumnos que realizan más de '); textcolor(yellow); write(viajes_corte); textcolor(green); write(' viajes por día es '); textcolor(red); writeln(alumnos_corte_viajes);
  textcolor(green); write('La cantidad de alumnos que gastan en transporte más de $'); textcolor(yellow); write(gasto_corte); textcolor(green); write(' por día es '); textcolor(red); writeln(alumnos_corte_gasto);
  textcolor(green); write('Los dos medios de transporte más utilizados son '); textcolor(red); write(transporte_max1); textcolor(green); write(' y '); textcolor(red); write(transporte_max2); textcolor(green); writeln(', respectivamente');
  textcolor(green); write('La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte es '); textcolor(red); write(alumnos_transportes);
end.