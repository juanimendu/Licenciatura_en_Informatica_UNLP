{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 6}
{La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales lanzadas al espacio en la última década.
De cada sonda, se conoce su nombre, duración estimada de la misión (cantidad de meses que permanecerá activa), el costo de construcción, el costo de mantenimiento mensual y el rango del espectro electromagnético sobre el que realizará estudios.
Dicho rango se divide en 7 categorías: 1. radio; 2. microondas; 3. infrarrojo; 4. luz visible; 5. ultravioleta; 6. rayos X; 7. rayos gamma.
Realizar un programa que lea y almacene la información de todas las sondas espaciales.
La lectura finaliza al ingresar la sonda llamada “GAIA”, que debe procesarse.
Una vez finalizada la lectura, informar:
•	El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
•	La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
•	La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
•	El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las sondas.
Nota: Para resolver los incisos, la lista debe recorrerse la menor cantidad de veces posible.}

program TP6_E6;
{$codepage UTF8}
uses crt;
const
  rango_ini=1; rango_fin=7;
  nombre_salida='GAIA';
type
  t_rango=rango_ini..rango_fin;
  t_registro_sonda=record
    nombre: string;
    duracion: int8;
    costo_construccion: real;
    costo_mantenimiento: real;
    rango: t_rango;
  end;
  t_lista_sondas=^t_nodo_sondas;
  t_nodo_sondas=record
    ele: t_registro_sonda;
    sig: t_lista_sondas;
  end;
  t_vector_rangos=array[t_rango] of int16;
procedure inicializar_vector_rangos(var vector_rangos: t_vector_rangos);
var
  i: t_rango;
begin
  for i:= rango_ini to rango_fin do
    vector_rangos[i]:=0;
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
procedure leer_sonda(var registro_sonda: t_registro_sonda);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_sonda.nombre:=nombre_salida
  else
    registro_sonda.nombre:=random_string(5+random(6));
  registro_sonda.duracion:=1+random(high(int8));
  registro_sonda.costo_construccion:=1+random(10000);
  registro_sonda.costo_mantenimiento:=1+random(100);
  registro_sonda.rango:=rango_ini+random(rango_fin);
end;
procedure agregar_adelante_lista_sondas(var lista_sondas: t_lista_sondas; registro_sonda: t_registro_sonda);
var
  nuevo: t_lista_sondas;
begin
  new(nuevo);
  nuevo^.ele:=registro_sonda;
  nuevo^.sig:=lista_sondas;
  lista_sondas:=nuevo;
end;
procedure cargar_lista_sondas(var lista_sondas: t_lista_sondas; var duracion_prom, costo_prom: real);
var
  registro_sonda: t_registro_sonda;
  sondas_total: int16;
  duracion_total, costo_total: real;
begin
  duracion_total:=0; sondas_total:=0;
  costo_total:=0;
  repeat
    leer_sonda(registro_sonda);
    agregar_adelante_lista_sondas(lista_sondas,registro_sonda);
    duracion_total:=duracion_total+lista_sondas^.ele.duracion;
    sondas_total:=sondas_total+1;
    costo_total:=costo_total+lista_sondas^.ele.costo_construccion;
  until (registro_sonda.nombre=nombre_salida);
  duracion_prom:=duracion_total/sondas_total;
  costo_prom:=costo_total/sondas_total;
end;
procedure actualizar_maximo(costo: real; nombre: string; var costo_max: real; var nombre_max: string);
begin
  if (costo>costo_max) then
  begin
    costo_max:=costo;
    nombre_max:=nombre;
  end;
end;
procedure procesar_lista_sondas(lista_sondas: t_lista_sondas; duracion_prom, costo_prom: real; var nombre_max: string; var vector_rangos: t_vector_rangos; var sondas_prom: int16);
var
  costo_sonda, costo_max: real;
begin
  costo_max:=-9999999;
  while (lista_sondas<>nil) do
  begin
    costo_sonda:=lista_sondas^.ele.costo_construccion+lista_sondas^.ele.costo_mantenimiento*lista_sondas^.ele.duracion;
    actualizar_maximo(costo_sonda,lista_sondas^.ele.nombre,costo_max,nombre_max);
    vector_rangos[lista_sondas^.ele.rango]:=vector_rangos[lista_sondas^.ele.rango]+1;
    if (lista_sondas^.ele.duracion>duracion_prom) then
      sondas_prom:=sondas_prom+1;
    if (lista_sondas^.ele.costo_construccion>costo_prom) then
    begin
      textcolor(green); write('El nombre de esta sonda cuyo costo de construcción supera el costo promedio entre todas las sondas es '); textcolor(red); writeln(lista_sondas^.ele.nombre);
    end;
    lista_sondas:=lista_sondas^.sig;
  end;
end;
procedure imprimir_vector_rangos(vector_rangos: t_vector_rangos);
var
  i: t_rango;
begin
  for i:= rango_ini to rango_fin do
  begin
    textcolor(green); write('La cantidad de sondas que realizarán estudios en el rango ',i,' del espectro electromagnético es '); textcolor(red); writeln(vector_rangos[i]);
  end;
end;
var
  vector_rangos: t_vector_rangos;
  lista_sondas: t_lista_sondas;
  sondas_prom: int16;
  duracion_prom, costo_prom: real;
  nombre_max: string;
begin
  randomize;
  lista_sondas:=nil;
  nombre_max:='';
  inicializar_vector_rangos(vector_rangos);
  duracion_prom:=0; sondas_prom:=0;
  costo_prom:=0;
  cargar_lista_sondas(lista_sondas,duracion_prom,costo_prom);
  procesar_lista_sondas(lista_sondas,duracion_prom,costo_prom,nombre_max,vector_rangos,sondas_prom);
  textcolor(green); write('El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento es '); textcolor(red); writeln(nombre_max);
  imprimir_vector_rangos(vector_rangos);
  textcolor(green); write('La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas es '); textcolor(red); write(sondas_prom);
end.