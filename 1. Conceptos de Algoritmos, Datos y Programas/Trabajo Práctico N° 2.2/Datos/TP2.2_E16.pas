{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 16}
{(a) Realizar un módulo que reciba como parámetro el radio de un círculo y retorne su diámetro y su perímetro.
(b) Utilizando el módulo anterior, realizar un programa que analice información de planetas obtenida del Telescopio Espacial Kepler.
De cada planeta, se lee su nombre, su radio (medido en kilómetros) y la distancia (medida en años luz) a la Tierra.
La lectura finaliza al leer un planeta con radio 0, que no debe procesarse.
Informar:
•	Nombre y distancia de los planetas que poseen un diámetro menor o igual que el de la Tierra (12.700 km) y mayor o igual que el de Marte (6.780 km).
•	Cantidad de planetas con un perímetro superior al del planeta Júpiter (439.264 km).}

program TP2_E16;
{$codepage UTF8}
uses crt;
const
  radio_salida=0.0;
  diametro_corte1=12700.0; diametro_corte2=6780.0;
  perimetro_corte=439264.0;
procedure circulo(radio: real; var diametro, perimetro: real); 
begin
  diametro:=radio*2;
  perimetro:=pi*diametro;
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
procedure leer_planeta(var nombre: string; var radio, distancia: real);
var
  i: int8;
begin
  nombre:=random_string(5+random(6));
  i:=random(100);
  if (i=0) then
    radio:=radio_salida
  else
    radio:=1+random(100000);
  distancia:=1+random(100);
end;
procedure leer_planetas(var planetas_corte: int16);
var
  radio, distancia, diametro, perimetro: real;
  nombre: string;
begin
  diametro:=0; perimetro:=0;
  leer_planeta(nombre,radio,distancia);
  while (radio<>radio_salida) do
  begin
    circulo(radio,diametro,perimetro);
    if ((diametro<=diametro_corte1) and (diametro>=diametro_corte2)) then
    begin
      textcolor(green); write('El planeta '); textcolor(red); write(nombre); textcolor(green); write(' tiene un diámetro menor o igual al de la Tierra ('); textcolor(yellow); write(diametro_corte1:0:2); textcolor(green); write(' km) y mayor o igual que el de Marte ('); textcolor(yellow); write(diametro_corte2:0:2); textcolor(green); write(' km), y queda a '); textcolor(red); write(distancia:0:2); textcolor(green); writeln(' años luz de la Tierra');
    end;
    if (perimetro>perimetro_corte) then
      planetas_corte:=planetas_corte+1;
    leer_planeta(nombre,radio,distancia);
  end;
end;
var
  planetas_corte: int16;
begin
  randomize;
  planetas_corte:=0;
  leer_planetas(planetas_corte);
  textcolor(green); write('La cantidad de planetas con un perímetro superior al del planeta Júpiter ('); textcolor(yellow); write(perimetro_corte:0:2); textcolor(green); write(' km) es '); textcolor(red); write(planetas_corte);
end.