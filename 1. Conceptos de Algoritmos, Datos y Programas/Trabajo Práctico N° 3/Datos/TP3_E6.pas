{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 6}
{Una empresa importadora de microprocesadores desea implementar un sistema de software para analizar la información de los productos que mantiene, actualmente, en stock.
Para ello, se conoce la siguiente información de los microprocesadores:
marca (Intel, AMD, NVidia, etc.), línea (Xeon, Core i7, Opteron, Atom, Centrino, etc.),
cantidad de cores o núcleos de procesamiento (1, 2, 4, 8), velocidad del reloj (medida en Ghz) y
tamaño en nanómetros (nm) de los transistores (14, 22, 32, 45, etc.).
La información de los microprocesadores se lee de forma consecutiva por marca de procesador y
la lectura finaliza al ingresar un procesador con 0 cores (que no debe procesarse).
Se pide implementar un programa que lea información de los microprocesadores de la empresa importadora e informe:
•	Marca y línea de todos los procesadores de más de 2 cores con transistores de, a lo sumo, 22 nm.
•	Las dos marcas con mayor cantidad de procesadores con transistores de 14 nm.
•	Cantidad de procesadores multicore (de más de un core) de Intel o AMD, cuyos relojes alcancen velocidades de, al menos, 2 Ghz.}

program TP3_E6;
{$codepage UTF8}
uses crt;
const
  cores_salida=0;
  cores_corte=2;
  transistores_corte1=22;
  transistores_corte2=14;
  marca_corte1='Intel'; marca_corte2='AMD'; velocidad_corte=2.0;
type
  t_registro_procesador=record
    cores: int16;
    marca: string;
    linea: string;
    velocidad: real;
    transistores: int16;
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
procedure leer_procesador(var registro_procesador: t_registro_procesador; marca: string; var marca_pos: int8);
var
  vector_cores: array[1..4] of int8=(1, 2, 4, 8);
  vector_marcas: array[1..3] of string=('Intel', 'AMD', 'Nvidia');
  vector_lineas: array[1..5] of string=('Xeon', 'Core i7', 'Opteron', 'Atom', 'Centrino');
  vector_nms: array[1..4] of int8=(14, 22, 32, 45);
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_procesador.cores:=cores_salida
  else
    registro_procesador.cores:=vector_cores[1+random(4)];
  if (registro_procesador.cores<>cores_salida) then
  begin
    i:=random(10);
    if (i=0) then
    begin
      marca_pos:=marca_pos+1;
      if (marca_pos<=3) then
        registro_procesador.marca:=vector_marcas[marca_pos]
      else
        registro_procesador.marca:=random_string(5+random(6));
    end
    else
      if (marca_pos<=3) then
        registro_procesador.marca:=vector_marcas[marca_pos]
      else
        registro_procesador.marca:=marca;
    registro_procesador.linea:=vector_lineas[1+random(5)];
    registro_procesador.velocidad:=1+random(40)/10;
    registro_procesador.transistores:=vector_nms[1+random(4)];
  end;
end;
procedure actualizar_maximos(transistores_marca: int16; marca: string; var transistores_max1, transistores_max2: int16; var marca_max1, marca_max2: string);
begin
  if (transistores_marca>transistores_max1) then
  begin
    transistores_max2:=transistores_max1;
    marca_max2:=marca_max1;
    transistores_max1:=transistores_marca;
    marca_max1:=marca;
  end
  else
    if (transistores_marca>transistores_max2) then
    begin
      transistores_max2:=transistores_marca;
      marca_max2:=marca;
    end;
end;
procedure leer_procesadores(var procesadores_corte: int16; var marca_max1, marca_max2: string);
var
  registro_procesador: t_registro_procesador;
  marca_pos: int8;
  transistores_marca, transistores_max1, transistores_max2: int16;
  marca: string;
begin
  transistores_max1:=low(int16); transistores_max2:=low(int16);
  marca:=''; marca_pos:=1;
  leer_procesador(registro_procesador,marca,marca_pos);
  while (registro_procesador.cores<>cores_salida) do
  begin
    marca:=registro_procesador.marca;
    transistores_marca:=0;
    while ((registro_procesador.cores<>cores_salida) and (registro_procesador.marca=marca)) do
    begin
      if ((registro_procesador.cores>cores_corte) and (registro_procesador.transistores<=transistores_corte1)) then
      begin
        textcolor(green); write('La marca y la línea de este procesador con más de '); textcolor(yellow); write(cores_corte); textcolor(green); write(' cores con transistores de, a lo sumo, '); textcolor(yellow); write(transistores_corte1); textcolor(green); write(' nm. son '); textcolor(red); write(registro_procesador.marca); textcolor(green); write(' y '); textcolor(red); write(registro_procesador.linea); textcolor(green); writeln(', respectivamente');
      end;
      if (registro_procesador.transistores=transistores_corte2) then
        transistores_marca:=transistores_marca+1;
      if ((registro_procesador.cores>=cores_corte) and ((registro_procesador.marca=marca_corte1) or (registro_procesador.marca=marca_corte2)) and (registro_procesador.velocidad>=velocidad_corte)) then
        procesadores_corte:=procesadores_corte+1;
      leer_procesador(registro_procesador,marca,marca_pos);
    end;
    actualizar_maximos(transistores_marca,marca,transistores_max1,transistores_max2,marca_max1,marca_max2);
  end;
end;
var
  procesadores_corte: int16;
  marca_max1, marca_max2: string;
begin
  randomize;
  marca_max1:=''; marca_max2:='';
  procesadores_corte:=0;
  leer_procesadores(procesadores_corte,marca_max1,marca_max2);
  textcolor(green); write('Las dos marcas con mayor cantidad de procesadores con transistores de '); textcolor(yellow); write(transistores_corte2); textcolor(green); write(' nm. son '); textcolor(red); write(marca_max1); textcolor(green); write(' y '); textcolor(red); writeln(marca_max2);
  textcolor(green); write('La cantidad de procesadores multicore (de más de un core) de '); textcolor(yellow); write(marca_corte1); textcolor(green); write(' o '); textcolor(yellow); write(marca_corte2); textcolor(green); write(' cuyos relojes alcancen velocidades de, al menos, '); textcolor(yellow); write(velocidad_corte:0:2); textcolor(green); write(' Ghz es '); textcolor(red); write(procesadores_corte);
end.