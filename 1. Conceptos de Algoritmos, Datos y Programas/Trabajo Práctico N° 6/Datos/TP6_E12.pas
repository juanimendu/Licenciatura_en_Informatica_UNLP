{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 12}
{Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de todos los dispositivos que poseen sus juegos instalados.
De cada dispositivo, se conoce la versión de Android instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee (medida en GB).
La información disponible se encuentra ordenada por versión de Android.
Realizar un programa que procese la información disponible de todos los dispositivos e informe:
•	La cantidad de dispositivos para cada versión de Android.
•	La cantidad de dispositivos con más de 3 GB de memoria y pantallas de, a lo sumo, 5 pulgadas.
•	El tamaño promedio de las pantallas de todos los dispositivos.}

program TP6_E12;
{$codepage UTF8}
uses crt;
const
  version_salida=-1;
  ram_corte=3; tamanio_corte=5;
type
  t_registro_celular=record
    version: int8;
    tamanio: real;
    ram: real;
  end;
  t_lista_celulares=^t_nodo_celulares;
  t_nodo_celulares=record
    ele: t_registro_celular;
    sig: t_lista_celulares;
  end;
procedure leer_celular(var registro_celular: t_registro_celular; version: int8);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
    registro_celular.version:=version_salida
  else if (i<=50) then
    registro_celular.version:=version
  else
    registro_celular.version:=1+random(high(int8));
  if (registro_celular.version<>version_salida) then
  begin
    registro_celular.tamanio:=1+random(91)/10;
    registro_celular.ram:=1+random(64);
  end;
end;
procedure agregar_ordenado_lista_celulares(var lista_celulares: t_lista_celulares; registro_celular: t_registro_celular);
var
  anterior, actual, nuevo: t_lista_celulares;
begin
  new(nuevo);
  nuevo^.ele:=registro_celular;
  anterior:=lista_celulares; actual:=lista_celulares;
  while ((actual<>nil) and (actual^.ele.version<nuevo^.ele.version)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_celulares) then
    lista_celulares:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_lista_celulares(var lista_celulares: t_lista_celulares);
var
  registro_celular: t_registro_celular;
begin
  leer_celular(registro_celular,1+random(high(int8)));
  while (registro_celular.version<>version_salida) do
  begin
    agregar_ordenado_lista_celulares(lista_celulares,registro_celular);
    leer_celular(registro_celular,registro_celular.version);
  end;
end;
function cumple_criterios(registro_celular: t_registro_celular): boolean;
begin
  cumple_criterios:=((registro_celular.ram>ram_corte) and (registro_celular.tamanio<=tamanio_corte));
end;
procedure procesar_lista_celulares(lista_celulares: t_lista_celulares; var celulares_corte: int16; var tamanio_prom: real);
var
  version: int8;
  celulares_version, celulares_total: int16;
  tamanio_total: real;
begin
  celulares_total:=0; tamanio_total:=0;
  while (lista_celulares<>nil) do
  begin
    version:=lista_celulares^.ele.version;
    celulares_version:=0;
    while ((lista_celulares<>nil) and (lista_celulares^.ele.version=version)) do
    begin
      celulares_version:=celulares_version+1;
      if (cumple_criterios(lista_celulares^.ele)=true) then
        celulares_corte:=celulares_corte+1;
      celulares_total:=celulares_total+1;
      tamanio_total:=tamanio_total+lista_celulares^.ele.tamanio;
      lista_celulares:=lista_celulares^.sig;
    end;
    textcolor(green); write('La cantidad de dispositivos para la versión de Android '); textcolor(yellow); write(version); textcolor(green); write(' es '); textcolor(red); writeln(celulares_version);
  end;
  tamanio_prom:=tamanio_total/celulares_total;
end;
var
  lista_celulares: t_lista_celulares;
  celulares_corte: int16;
  tamanio_prom: real;
begin
  randomize;
  lista_celulares:=nil;
  celulares_corte:=0;
  tamanio_prom:=0;
  cargar_lista_celulares(lista_celulares);
  if (lista_celulares<>nil) then
  begin
    procesar_lista_celulares(lista_celulares,celulares_corte,tamanio_prom);
    textcolor(green); write('La cantidad de dispositivos con más de '); textcolor(yellow); write(ram_corte); textcolor(green); write(' GB de memoria y pantallas de, a lo sumo, '); textcolor(yellow); write(tamanio_corte); textcolor(green); write(' pulgadas es '); textcolor(red); writeln(celulares_corte);
    textcolor(green); write('El tamaño promedio de las pantallas de todos los dispositivos es '); textcolor(red); write(tamanio_prom:0:2);
  end;
end.