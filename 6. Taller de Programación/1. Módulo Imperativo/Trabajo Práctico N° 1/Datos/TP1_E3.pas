{TRABAJO PRÁCTICO N° 1}
{EJERCICIO 3}
{Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022.
De cada película, se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
(a) Leer los datos de películas, los almacene por orden de llegada y agrupados por código de género y retorne en una estructura de datos adecuada.
La lectura finaliza cuando se lee el código de la película -1.
(b) Generar y retornar, en un vector, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas, a partir de la estructura generada en (a).
(c) Ordenar los elementos del vector generado en (b) por puntaje, utilizando alguno de los dos métodos vistos en la teoría.
(d) Mostrar el código de película con mayor puntaje y el código de película con menor puntaje, del vector obtenido en el inciso (c).}

program TP1_E3;
{$codepage UTF8}
uses crt;
const
  genero_ini=1; genero_fin=8;
  codigo_salida=-1;
type
  t_genero=genero_ini..genero_fin;
  t_registro_pelicula1=record
    codigo: int16;
    genero: t_genero;
    puntaje: real;
  end;
  t_registro_pelicula2=record
    codigo: int16;
    puntaje: real;
  end;
  t_lista_peliculas=^t_nodo_peliculas;
  t_nodo_peliculas=record
    ele: t_registro_pelicula2;
    sig: t_lista_peliculas;
  end;
  t_vector_peliculas1=array[t_genero] of t_lista_peliculas;
  t_vector_peliculas2=array[t_genero] of t_registro_pelicula2;
procedure inicializar_vector_peliculas1(var vector_peliculas1: t_vector_peliculas1);
var
  i: t_genero;
begin
  for i:= genero_ini to genero_fin do
    vector_peliculas1[i]:=nil;
end;
procedure leer_pelicula(var registro_pelicula1: t_registro_pelicula1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_pelicula1.codigo:=codigo_salida
  else
    registro_pelicula1.codigo:=1+random(high(int16));
  if (registro_pelicula1.codigo<>codigo_salida) then
  begin
    registro_pelicula1.genero:=genero_ini+random(genero_fin);
    registro_pelicula1.puntaje:=1+random(10);
  end;
end;
procedure cargar_registro_pelicula2(var registro_pelicula2: t_registro_pelicula2; registro_pelicula1: t_registro_pelicula1);
begin
  registro_pelicula2.codigo:=registro_pelicula1.codigo;
  registro_pelicula2.puntaje:=registro_pelicula1.puntaje;
end;
procedure agregar_atras_lista_peliculas(var lista_peliculas: t_lista_peliculas; registro_pelicula1: t_registro_pelicula1);
var
  aux, ult: t_lista_peliculas;
begin
  new(aux);
  cargar_registro_pelicula2(aux^.ele,registro_pelicula1);
  aux^.sig:=nil;
  if (lista_peliculas=nil) then
    lista_peliculas:=aux
  else
  begin
    ult:=lista_peliculas;
    while (ult^.sig<>nil) do
      ult:=ult^.sig;
    ult^.sig:=aux;
  end;
end;
procedure cargar_vector_peliculas1(var vector_peliculas1: t_vector_peliculas1);
var
  registro_pelicula1: t_registro_pelicula1;
begin
  leer_pelicula(registro_pelicula1);
  while (registro_pelicula1.codigo<>codigo_salida) do
  begin
    agregar_atras_lista_peliculas(vector_peliculas1[registro_pelicula1.genero],registro_pelicula1);
    leer_pelicula(registro_pelicula1);
  end;
end;
procedure imprimir_registro_pelicula2(registro_pelicula2: t_registro_pelicula2; genero: t_genero; pelicula: int16);
begin
  textcolor(green); write('El código de película de la película '); textcolor(yellow); write(pelicula); textcolor(green); write(' del género '); textcolor(yellow); write(genero); textcolor(green); write(' es '); textcolor(red); writeln(registro_pelicula2.codigo);
  textcolor(green); write('El puntaje de la película '); textcolor(yellow); write(pelicula); textcolor(green); write(' del género '); textcolor(yellow); write(genero); textcolor(green); write(' es '); textcolor(red); writeln(registro_pelicula2.puntaje:0:2);
end;
procedure imprimir_lista_peliculas(lista_peliculas: t_lista_peliculas; genero: t_genero);
var
  i: int16;
begin
  i:=0;
  while (lista_peliculas<>nil) do
  begin
    i:=i+1;
    imprimir_registro_pelicula2(lista_peliculas^.ele,genero,i);
    lista_peliculas:=lista_peliculas^.sig;
  end;
end;
procedure imprimir_vector_peliculas1(vector_peliculas1: t_vector_peliculas1);
var
  i: t_genero;
begin
  for i:= genero_ini to genero_fin do
  begin
    textcolor(green); write('La información de las películas del género '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_lista_peliculas(vector_peliculas1[i],i);
    writeln();
  end;
end;
procedure cargar_vector_peliculas2(var vector_peliculas2: t_vector_peliculas2; vector_peliculas1: t_vector_peliculas1);
var
  i: t_genero;
  codigo_max: int16;
  puntaje_max: real;
begin
  for i:= genero_ini to genero_fin do
  begin
    puntaje_max:=-9999999; codigo_max:=-1;
    while (vector_peliculas1[i]<>nil) do
    begin
      if (vector_peliculas1[i]^.ele.puntaje>puntaje_max) then
      begin
        puntaje_max:=vector_peliculas1[i]^.ele.puntaje;
        codigo_max:=vector_peliculas1[i]^.ele.codigo;
      end;
      vector_peliculas1[i]:=vector_peliculas1[i]^.sig;
    end;
    vector_peliculas2[i].codigo:=codigo_max;
    vector_peliculas2[i].puntaje:=puntaje_max;
  end;
end;
procedure imprimir_vector_peliculas2(vector_peliculas2: t_vector_peliculas2);
var
  i: t_genero;
begin
  for i:= genero_ini to genero_fin do
  begin
    imprimir_registro_pelicula2(vector_peliculas2[i],i,1);
    writeln();
  end;
end;
procedure ordenar_vector_peliculas2(var vector_peliculas2: t_vector_peliculas2);
var
  item: t_registro_pelicula2;
  i, j, k: t_genero;
begin
  for i:= genero_ini to (genero_fin-1) do
  begin
    k:=i;
    for j:= (i+1) to genero_fin do
      if (vector_peliculas2[j].puntaje<vector_peliculas2[k].puntaje) then
        k:=j;
    item:=vector_peliculas2[k];
    vector_peliculas2[k]:=vector_peliculas2[i];
    vector_peliculas2[i]:=item;
  end;
end;
var
  vector_peliculas1: t_vector_peliculas1;
  vector_peliculas2: t_vector_peliculas2;
begin
  randomize;
  inicializar_vector_peliculas1(vector_peliculas1);
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_peliculas1(vector_peliculas1);
  imprimir_vector_peliculas1(vector_peliculas1);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  cargar_vector_peliculas2(vector_peliculas2,vector_peliculas1);
  imprimir_vector_peliculas2(vector_peliculas2);
  writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
  ordenar_vector_peliculas2(vector_peliculas2);
  imprimir_vector_peliculas2(vector_peliculas2);
  writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
  textcolor(green); write('El código de película con mayor y menor puntaje son '); textcolor(red); write(vector_peliculas2[genero_fin].codigo); textcolor(green); write(' y '); textcolor(red); write(vector_peliculas2[genero_ini].codigo); textcolor(green); write(', respectivamente');
end.