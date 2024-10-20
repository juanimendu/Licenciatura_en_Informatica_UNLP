{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 12}
{(a) Realizar un módulo que calcule el rendimiento económico de una plantación de soja.
El módulo debe recibir la cantidad de hectáreas (ha) sembradas, el tipo de zona de siembra (1: zona muy fértil, 2: zona estándar, 3: zona árida)
y el precio en U$S de la tonelada de soja; y devolver el rendimiento económico esperado de dicha plantación.
Para calcular el rendimiento económico esperado, debe considerar el siguiente rendimiento por tipo de zona:
(b) ARBA desea procesar información obtenida de imágenes satelitales de campos sembrados con soja en la provincia de Buenos Aires.
De cada campo, se lee: localidad, cantidad de hectáreas sembradas y el tipo de zona (1, 2 ó 3).
La lectura finaliza al leer un campo de 900 ha en la localidad ‘Saladillo’, que debe procesarse.
El precio de la soja es de U$S320 por tn. Informar:
•	La cantidad de campos de la localidad Tres de Febrero con rendimiento estimado superior a U$S 10.000.
•	La localidad del campo con mayor rendimiento económico esperado.
•	La localidad del campo con menor rendimiento económico esperado.
•	El rendimiento económico promedio.}

program TP2_E12;
{$codepage UTF8}
uses crt;
const
  zona_ini=1; zona_fin=3;
  ha_salida=900; localidad_salida='Saladillo';
  precio=320.0;
  localidad_corte='Tres de Febrero'; rendimiento_corte=10000.0;
type
  t_zona=zona_ini..zona_fin;
function rendimiento_economico(ha: int16; zona: t_zona): real;
var
  vector_precios: array[t_zona] of real=(6, 2.6, 1.4);
begin
  rendimiento_economico:=ha*vector_precios[zona]*precio;
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
procedure leer_campo(var localidad: string; var ha: int16; var zona: t_zona);
var
  i: int8;
begin
  i:=random(101);
  if (i=0) then
  begin
    localidad:=localidad_salida;
    ha:=ha_salida;
  end
  else
  begin
    if (i<=50) then
      localidad:=localidad_corte
    else
      localidad:=random_string(5+random(6));
    ha:=1+random(100);
  end;
  zona:=zona_ini+random(zona_fin);
end;
procedure actualizar_maximo(rendimiento: real; localidad: string; var rendimiento_max: real; var localidad_max: string);
begin
  if (rendimiento>rendimiento_max) then
  begin
    rendimiento_max:=rendimiento;
    localidad_max:=localidad;
  end;
end;
procedure actualizar_minimo(rendimiento: real; localidad: string; var rendimiento_min: real; var localidad_min: string);
begin
  if (rendimiento<rendimiento_min) then
  begin
    rendimiento_min:=rendimiento;
    localidad_min:=localidad;
  end;
end;
procedure leer_campos(var campos_corte: int16; var rendimiento_prom: real; var localidad_max, localidad_min: string);
var
  zona: t_zona;
  ha, campos_total: int16;
  rendimiento, rendimiento_max, rendimiento_min, rendimiento_total: real;
  localidad: string;
begin
  rendimiento_max:=-9999999;
  rendimiento_min:=9999999;
  rendimiento_total:=0; campos_total:=0;
  repeat
    leer_campo(localidad,ha,zona);
    rendimiento:=rendimiento_economico(ha,zona);
    rendimiento_total:=rendimiento_total+rendimiento;
    campos_total:=campos_total+1;
    if ((localidad=localidad_corte) and (rendimiento>rendimiento_corte)) then
      campos_corte:=campos_corte+1;
    actualizar_maximo(rendimiento,localidad,rendimiento_max,localidad_max);
    actualizar_minimo(rendimiento,localidad,rendimiento_min,localidad_min);
  until ((localidad=localidad_salida) and (ha=ha_salida));
  rendimiento_prom:=rendimiento_total/campos_total;
end;
var
  campos_corte: int16;
  rendimiento_prom: real;
  localidad_max, localidad_min: string;
begin
  randomize;
  campos_corte:=0;
  localidad_max:=''; localidad_min:='';
  rendimiento_prom:=0;
  leer_campos(campos_corte,rendimiento_prom,localidad_max,localidad_min);
  textcolor(green); write('La cantidad de campos de la localidad '); textcolor(yellow); write(localidad_corte); textcolor(green); write(' con rendimiento estimado superior a U$S '); textcolor(yellow); write(rendimiento_corte:0:2); textcolor(green); write(' es '); textcolor(red); writeln(campos_corte);
  textcolor(green); write('La localidad del campo con mayor rendimiento económico esperado es '); textcolor(red); writeln(localidad_max);
  textcolor(green); write('La localidad del campo con menor rendimiento económico esperado es '); textcolor(red); writeln(localidad_min);
  textcolor(green); write('El rendimiento económico promedio es U$D '); textcolor(red); write(rendimiento_prom:0:2);
end.