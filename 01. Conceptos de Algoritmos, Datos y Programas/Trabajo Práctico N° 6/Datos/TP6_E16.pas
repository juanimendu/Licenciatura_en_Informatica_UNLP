{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 16}
{La empresa distribuidora de una app móvil para corredores ha organizado una competencia mundial, en la que corredores de todos los países participantes salen a correr en el mismo momento en distintos puntos del planeta.
La app registra, para cada corredor, el nombre y apellido, la distancia recorrida (en kilómetros), el tiempo (en minutos) durante el que corrió, el país y la ciudad desde donde partió y la ciudad donde finalizó su recorrido.
Realizar un programa que permita leer y almacenar toda la información registrada durante la competencia. La lectura finaliza al ingresar la distancia -1.
Una vez que se han almacenado todos los datos, informar:
•	La cantidad total de corredores, la distancia total recorrida y el tiempo total de carrera de todos los corredores.
•	El nombre de la ciudad que convocó la mayor cantidad de corredores y la cantidad total de kilómetros recorridos por los corredores de esa ciudad.
•	La distancia promedio recorrida por corredores de Brasil.
•	La cantidad de corredores que partieron de una ciudad y finalizaron en otra ciudad.
•	El paso (cantidad de minutos por km) promedio de los corredores de la ciudad de Boston.}

program TP6_E16;
{$codepage UTF8}
uses crt;
const
  distancia_salida=-1.0;
  pais_corte='Brasil';
  ciudad_corte='Boston';
type
  t_registro_corredor=record
    nombre: string;
    apellido: string;
    distancia: real;
    tiempo: real;
    pais: string;
    ciudad_ini: string;
    ciudad_fin: string;
  end;
  t_lista_corredores=^t_nodo_corredores;
  t_nodo_corredores=record
    ele: t_registro_corredor;
    sig: t_lista_corredores;
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
procedure leer_corredor(var registro_corredor: t_registro_corredor);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_corredor.distancia:=distancia_salida
  else
    registro_corredor.distancia:=1+random(91)/10;
  if (registro_corredor.distancia<>distancia_salida) then
  begin
    registro_corredor.nombre:=random_string(1+random(10));
    registro_corredor.apellido:=random_string(5+random(6));
    registro_corredor.tiempo:=1+random(360);
    i:=random(10);
    if (i=0) then
      registro_corredor.pais:=pais_corte
    else
      registro_corredor.pais:=random_string(5+random(6));
    i:=random(10);
    if (i=0) then
      registro_corredor.ciudad_ini:=ciudad_corte
    else
      registro_corredor.ciudad_ini:=random_string(5+random(6));
    i:=random(10);
    if (i=0) then
      registro_corredor.ciudad_fin:=random_string(5+random(6))
    else
      registro_corredor.ciudad_fin:=registro_corredor.ciudad_ini;
  end;
end;
procedure agregar_ordenado_lista_corredores(var lista_corredores: t_lista_corredores; registro_corredor: t_registro_corredor);
var
  anterior, actual, nuevo: t_lista_corredores;
begin
  new(nuevo);
  nuevo^.ele:=registro_corredor;
  anterior:=lista_corredores; actual:=lista_corredores;
  while ((actual<>nil) and (actual^.ele.ciudad_ini<nuevo^.ele.ciudad_ini)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_corredores) then
    lista_corredores:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_lista_corredores(var lista_corredores: t_lista_corredores);
var
  registro_corredor: t_registro_corredor;
begin
  leer_corredor(registro_corredor);
  while (registro_corredor.distancia<>distancia_salida) do
  begin
    agregar_ordenado_lista_corredores(lista_corredores,registro_corredor);
    leer_corredor(registro_corredor);
  end;
end;
procedure actualizar_maximos(corredores_ciudad: int16; ciudad: string; distancia_ciudad: real; var corredores_max: int16; var ciudad_max: string; var distancia_max: real);
begin
  if (corredores_ciudad>corredores_max) then
  begin
    corredores_max:=corredores_ciudad;
    ciudad_max:=ciudad;
    distancia_max:=distancia_ciudad;
  end;
end;
procedure procesar_lista_corredores(lista_corredores: t_lista_corredores; var corredores_total, corredores_distinta_ciudad: int16; var distancia_total, tiempo_total, distancia_max, distancia_prom_corte, tiempo_prom_corte: real; var ciudad_max: string);
var
  corredores_ciudad, corredores_max, corredores_corte_pais: int16;
  distancia_ciudad, distancia_corte_pais, distancia_corte_ciudad, tiempo_corte_ciudad: real;
  ciudad: string;
begin
  corredores_max:=low(int16);
  corredores_corte_pais:=0; distancia_corte_pais:=0;
  distancia_corte_ciudad:=0; tiempo_corte_ciudad:=0;
  while (lista_corredores<>nil) do
  begin
    ciudad:=lista_corredores^.ele.ciudad_ini;
    corredores_ciudad:=0; distancia_ciudad:=0;
    while ((lista_corredores<>nil) and (lista_corredores^.ele.ciudad_ini=ciudad)) do
    begin
      corredores_total:=corredores_total+1;
      distancia_total:=distancia_total+lista_corredores^.ele.distancia;
      tiempo_total:=distancia_total+lista_corredores^.ele.tiempo;
      corredores_ciudad:=corredores_ciudad+1;
      distancia_ciudad:=distancia_ciudad+lista_corredores^.ele.distancia;
      if (lista_corredores^.ele.pais=pais_corte) then
      begin
        corredores_corte_pais:=corredores_corte_pais+1;
        distancia_corte_pais:=distancia_corte_pais+lista_corredores^.ele.distancia;
      end;
      if (lista_corredores^.ele.ciudad_ini<>lista_corredores^.ele.ciudad_fin) then
        corredores_distinta_ciudad:=corredores_distinta_ciudad+1;
      if (lista_corredores^.ele.ciudad_ini=ciudad_corte) then
      begin
        distancia_corte_ciudad:=distancia_corte_ciudad+lista_corredores^.ele.distancia;
        tiempo_corte_ciudad:=tiempo_corte_ciudad+lista_corredores^.ele.tiempo;
      end;
      lista_corredores:=lista_corredores^.sig;
    end;
    actualizar_maximos(corredores_ciudad,ciudad,distancia_ciudad,corredores_max,ciudad_max,distancia_max);
  end;
  if (corredores_corte_pais>0) then
    distancia_prom_corte:=distancia_corte_pais/corredores_corte_pais;
  if (distancia_corte_ciudad>0) then
    tiempo_prom_corte:=tiempo_corte_ciudad/distancia_corte_ciudad;
end;
var
  lista_corredores: t_lista_corredores;
  corredores_total, corredores_distinta_ciudad: int16;
  distancia_total, tiempo_total, distancia_max, distancia_prom_corte, tiempo_prom_corte: real;
  ciudad_max: string;
begin
  randomize;
  lista_corredores:=nil;
  corredores_total:=0; distancia_total:=0; tiempo_total:=0;
  ciudad_max:=''; distancia_max:=0;
  distancia_prom_corte:=0;
  corredores_distinta_ciudad:=0;
  tiempo_prom_corte:=0;
  cargar_lista_corredores(lista_corredores);
  if (lista_corredores<>nil) then
  begin
    procesar_lista_corredores(lista_corredores,corredores_total,corredores_distinta_ciudad,distancia_total,tiempo_total,distancia_max,distancia_prom_corte,tiempo_prom_corte,ciudad_max);
    textcolor(green); write('La cantidad total de corredores, la distancia total recorrida y el tiempo total de carrera de todos los corredores son '); textcolor(red); write(corredores_total); textcolor(green); write(' corredores, '); textcolor(red); write(distancia_total:0:2); textcolor(green); write(' km y '); textcolor(red); write(tiempo_total:0:2); textcolor(green); writeln(' minutos, respectivamente');
    textcolor(green); write('El nombre de la ciudad que convocó la mayor cantidad de corredores y la cantidad total de kilómetros recorridos por los corredores de esa ciudad es '); textcolor(red); write(ciudad_max); textcolor(green); write(' y '); textcolor(red); write(distancia_max:0:2); textcolor(green); writeln(', respectivamnte');
    textcolor(green); write('La distancia promedio recorrida por corredores de '); textcolor(yellow); write(pais_corte); textcolor(green); write(' es '); textcolor(red); write(distancia_prom_corte:0:2); textcolor(green); writeln(' km');
    textcolor(green); write('La cantidad de corredores que partieron de una ciudad y finalizaron en otra ciudad es '); textcolor(red); writeln(corredores_distinta_ciudad);
    textcolor(green); write('El paso (cantidad de minutos por km) promedio de los corredores de la ciudad de '); textcolor(yellow); write(ciudad_corte); textcolor(green); write(' es '); textcolor(red); write(tiempo_prom_corte:0:2);
  end;
end.