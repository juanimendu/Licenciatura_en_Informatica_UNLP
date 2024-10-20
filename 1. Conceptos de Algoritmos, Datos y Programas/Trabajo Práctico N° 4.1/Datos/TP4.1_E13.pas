{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 13}
{El Grupo Intergubernamental de Expertos sobre el Cambio Climático de la ONU (IPCC) realiza todos los años mediciones de temperatura en 100 puntos diferentes del planeta y, para cada uno de estos lugares, obtiene un promedio anual.
Este relevamiento se viene realizando desde hace 50 años y, con todos los datos recolectados, el IPCC se encuentra en condiciones de realizar análisis estadísticos.
Realizar un programa que lea y almacene los datos correspondientes a las mediciones de los últimos 50 años (la información se ingresa ordenada por año).
Una vez finalizada la carga de la información, obtener:
•	El año con mayor temperatura promedio a nivel mundial.
•	El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años.}

program TP4_E13;
{$codepage UTF8}
uses crt;
const
  puntos_total=100;
  anio_ini=1974; anio_fin=2023;
type
  t_punto=1..puntos_total;
  t_anio=anio_ini..anio_fin;
  t_vector_puntos=array[t_punto] of real;
  t_vector_anios=array[t_anio] of t_vector_puntos;
procedure inicializar_vector_anios(var vector_anios: t_vector_anios);
var
  i: t_anio;
  j: t_punto;
begin
  for i:= anio_ini to anio_fin do
    for j:= 1 to puntos_total do
      vector_anios[i][j]:=0;
end;
procedure cargar_vector_anios(var vector_anios: t_vector_anios);
var
  i: t_anio;
  j: t_punto;
begin
  for i:= anio_ini to anio_fin do
    for j:= 1 to puntos_total do
      vector_anios[i][j]:=-50+random(1001)/10;
end;
procedure actualizar_maximo1(promedio_anio: real; anio: int16; var promedio_max: real; var anio_max1: int16);
begin
  if (promedio_anio>promedio_max) then
  begin
    promedio_max:=promedio_anio;
    anio_max1:=anio;
  end;
end;
procedure actualizar_maximo2(temperatura: real; anio: int16; var temperatura_max: real; var anio_max2: int16);
begin
  if (temperatura>temperatura_max) then
  begin
    temperatura_max:=temperatura;
    anio_max2:=anio;
  end;
end;
procedure procesar_vector_anios(vector_anios: t_vector_anios; var anio_max1, anio_max2: int16);
var
  i: t_anio;
  j: t_punto;
  temperatura_anio, promedio_anio, promedio_max, temperatura_max: real;
begin
  promedio_max:=-9999999;
  temperatura_max:=-9999999;
  for i:= anio_ini to anio_fin do
  begin
    temperatura_anio:=0;
    for j:= 1 to puntos_total do
    begin
      temperatura_anio:=temperatura_anio+vector_anios[i][j];
      actualizar_maximo2(vector_anios[i][j],i,temperatura_max,anio_max2);
    end;
    promedio_anio:=temperatura_anio/puntos_total;
    actualizar_maximo1(promedio_anio,i,promedio_max,anio_max1);
  end;
end;
var
  vector_anios: t_vector_anios;
  anio_max1, anio_max2: int16;
begin
  randomize;
  anio_max1:=0; anio_max2:=0;
  inicializar_vector_anios(vector_anios);
  cargar_vector_anios(vector_anios);
  procesar_vector_anios(vector_anios,anio_max1,anio_max2);
  textcolor(green); write('El año con mayor temperatura promedio a nivel mundial es '); textcolor(red); writeln(anio_max1);
  textcolor(green); write('El año con la mayor temperatura detectada en algún punto del planeta en los últimos 50 años es '); textcolor(red); write(anio_max2);
end.