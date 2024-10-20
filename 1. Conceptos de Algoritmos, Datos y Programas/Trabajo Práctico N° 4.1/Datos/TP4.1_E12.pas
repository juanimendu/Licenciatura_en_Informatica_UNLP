{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 12}
{En astrofísica, una galaxia se identifica por su nombre, su tipo (1. elíptica; 2. espiral; 3. lenticular; 4. irregular), su masa (medida en kg) y la distancia en pársecs (pc) medida desde la Tierra.
La Unión Astronómica Internacional cuenta con datos correspondientes a las 53 galaxias que componen el Grupo Local.
Realizar un programa que lea y almacene estos datos y, una vez finalizada la carga, informe:
•	La cantidad de galaxias de cada tipo.
•	La masa total acumulada de las 3 galaxias principales (la Vía Láctea, Andrómeda y Triángulo) y el porcentaje que esto representa respecto a la masa de todas las galaxias.
•	La cantidad de galaxias no irregulares que se encuentran a menos de 1000 pc.
•	El nombre de las dos galaxias con mayor masa y el de las dos galaxias con menor masa.}

program TP4_E12;
{$codepage UTF8}
uses crt;
const
  galaxias_total=53;
  tipo_ini=1; tipo_fin=4;
  galaxia_corte1='la Via Lactea'; galaxia_corte2='Andromeda'; galaxia_corte3='Triangulo';
  tipo_corte=4; distancia_corte=1000.0;
type
  t_galaxia=1..galaxias_total;
  t_tipo=tipo_ini..tipo_fin;
  t_registro_galaxia=record
    nombre: string;
    tipo: t_tipo;
    masa: real;
    distancia: real;
  end;
  t_vector_galaxias=array[t_galaxia] of t_registro_galaxia;
  t_vector_tipos=array[t_tipo] of int16;
procedure inicializar_vector_tipos(var vector_tipos: t_vector_tipos);
var
  i: t_tipo;
begin
  for i:= tipo_ini to tipo_fin do
    vector_tipos[i]:=0;
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
procedure leer_galaxia(var registro_galaxia: t_registro_galaxia);
var
  i: int8;
begin
  i:=random(4);
  if (i=0) then
    registro_galaxia.nombre:=galaxia_corte1
  else if (i=1) then
    registro_galaxia.nombre:=galaxia_corte2
  else if (i=2) then
    registro_galaxia.nombre:=galaxia_corte3
  else
    registro_galaxia.nombre:='Galaxia '+random_string(5+random(6));
  registro_galaxia.tipo:=tipo_ini+random(tipo_fin);
  registro_galaxia.masa:=11+random(99991)/10;
  registro_galaxia.masa:=11+random(99991)/10;
end;
procedure cargar_vector_galaxias(var vector_galaxias: t_vector_galaxias);
var
  registro_galaxia: t_registro_galaxia;
  i: t_galaxia;
begin
  for i:= 1 to galaxias_total do
  begin
    leer_galaxia(registro_galaxia);
    vector_galaxias[i]:=registro_galaxia;
  end;
end;
procedure actualizar_maximos(masa: real; nombre: string; var masa_max1, masa_max2: real; var nombre_max1, nombre_max2: string);
begin
  if (masa>masa_max1) then
  begin
    masa_max2:=masa_max1;
    nombre_max2:=nombre_max1;
    masa_max1:=masa;
    nombre_max1:=nombre;
  end
  else
    if (masa>masa_max2) then
    begin
      masa_max2:=masa;
      nombre_max2:=nombre;
    end;
end;
procedure actualizar_minimos(masa: real; nombre: string; var masa_min1, masa_min2: real; var nombre_min1, nombre_min2: string);
begin
  if (masa<masa_min1) then
  begin
    masa_min2:=masa_min1;
    nombre_min2:=nombre_min1;
    masa_min1:=masa;
    nombre_min1:=nombre;
  end
  else
    if (masa<masa_min2) then
    begin
      masa_min2:=masa;
      nombre_min2:=nombre;
    end;
end;
procedure procesar_vector_galaxias(vector_galaxias: t_vector_galaxias; var vector_tipos: t_vector_tipos; var masa_principales, porcentaje_principales: real; var galaxias_corte: int8; var nombre_max1, nombre_max2, nombre_min1, nombre_min2: string);
var
  i: t_galaxia;
  masa_total, masa_max1, masa_max2, masa_min1, masa_min2: real;
begin
  masa_total:=0;
  masa_max1:=-9999999; masa_max2:=-9999999;
  masa_min1:=9999999; masa_min2:=9999999;
  for i:= 1 to galaxias_total do
  begin
    vector_tipos[vector_galaxias[i].tipo]:=vector_tipos[vector_galaxias[i].tipo]+1;
    masa_total:=masa_total+vector_galaxias[i].masa;
    if ((vector_galaxias[i].nombre=galaxia_corte1) or (vector_galaxias[i].nombre=galaxia_corte2) or (vector_galaxias[i].nombre=galaxia_corte3)) then
      masa_principales:=masa_principales+vector_galaxias[i].masa;
    if ((vector_galaxias[i].tipo<>tipo_corte) and (vector_galaxias[i].distancia<distancia_corte)) then
      galaxias_corte:=galaxias_corte+1;
    actualizar_maximos(vector_galaxias[i].masa,vector_galaxias[i].nombre,masa_max1,masa_max2,nombre_max1,nombre_max2);
    actualizar_minimos(vector_galaxias[i].masa,vector_galaxias[i].nombre,masa_min1,masa_min2,nombre_min1,nombre_min2);
  end;
  porcentaje_principales:=masa_principales/masa_total*100;
end;
var
  vector_tipos_string: array[t_tipo] of string=('eliptica', 'espiral', 'lenticular', 'irregular');
  vector_galaxias: t_vector_galaxias;
  vector_tipos: t_vector_tipos;
  galaxias_corte: int8;
  masa_principales, porcentaje_principales: real;
  nombre_max1, nombre_max2, nombre_min1, nombre_min2: string;
begin
  randomize;
  inicializar_vector_tipos(vector_tipos);
  masa_principales:=0; porcentaje_principales:=0;
  galaxias_corte:=0;
  nombre_max1:=''; nombre_max2:='';
  nombre_min1:=''; nombre_min2:='';
  cargar_vector_galaxias(vector_galaxias);
  procesar_vector_galaxias(vector_galaxias,vector_tipos,masa_principales,porcentaje_principales,galaxias_corte,nombre_max1,nombre_max2,nombre_min1,nombre_min2);
  textcolor(green); write('La cantidad de galaxias de cada tipo (1. elíptica; 2. espiral; 3. lenticular; 4. irregular) es '); textcolor(red); write(vector_tipos[1],', ',vector_tipos[2],', ',vector_tipos[3],', ',vector_tipos[4]); textcolor(green); writeln(', respectivamente');
  textcolor(green); write('La masa total acumulada de las 3 galaxias principales ('); textcolor(yellow); write(galaxia_corte1,', ',galaxia_corte2,', ',galaxia_corte3); textcolor(green); write(') y el porcentaje que esto representa respecto a la masa de todas las galaxias son '); textcolor(red); write(masa_principales:0:2); textcolor(green); write(' y '); textcolor(red); write(porcentaje_principales:0:2); textcolor(green); writeln('%, respectivamente');
  textcolor(green); write('La cantidad de galaxias no '); textcolor(yellow); write(vector_tipos_string[tipo_corte]); textcolor(green); write(' que se encuentran a menos de '); textcolor(yellow); write(distancia_corte:0:2); textcolor(green); write(' pc es '); textcolor(red); writeln(galaxias_corte);
  textcolor(green); write('Los nombres de las dos galaxias con mayor masa son '); textcolor(red); write(nombre_max1); textcolor(green); write(' y '); textcolor(red); writeln(nombre_max2);
  textcolor(green); write('Los nombres de las dos galaxias con menor masa son '); textcolor(red); write(nombre_min1); textcolor(green); write(' y '); textcolor(red); write(nombre_min2);
end.