{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 11}
{Una compañía de vuelos internacionales está analizando la información de todos los vuelos realizados por sus aviones durante todo el año 2019.
De cada vuelo, se conoce el código de avión, país de salida, país de llegada, cantidad de kilómetros recorridos y porcentaje de ocupación del avión.
La información se ingresa ordenada por código de avión y, para cada avión, por país de salida. La lectura finaliza al ingresar el código 44.
Informar:
•	Los dos aviones que más kilómetros recorrieron y los dos aviones que menos kilómetros recorrieron.
•	El avión que salió desde más países diferentes.
•	La cantidad de vuelos de más de 5.000 km que no alcanzaron el 60% de ocupación del avión.
•	La cantidad de vuelos de menos de 10.000 km que llegaron a Australia o a Nueva Zelanda.}

program TP3_E11;
{$codepage UTF8}
uses crt;
const
  avion_salida=44;
  kms_corte1=5000.0; ocupacion_corte=60.0;
  kms_corte2=10000.0; pais_corte1='Australia'; pais_corte2='Nueva Zelanda';
type
  t_registro_vuelo=record
    avion: int16;
    pais_salida: string;
    pais_llegada: string;
    kms: real;
    ocupacion: real;
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
procedure leer_vuelo(var registro_vuelo: t_registro_vuelo; avion: int16; pais_salida: string);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_vuelo.avion:=avion_salida
  else if (i<=50) then
    registro_vuelo.avion:=avion
  else
    registro_vuelo.avion:=1+random(high(int16));
  if (registro_vuelo.avion<>avion_salida) then
  begin
    i:=random(2);
    if (i=0) then
      registro_vuelo.pais_salida:=pais_salida
    else
      registro_vuelo.pais_salida:=random_string(5+random(6));
    i:=1+random(3);
    if (i=1) then
      registro_vuelo.pais_llegada:=pais_corte1
    else if (i=2) then
      registro_vuelo.pais_llegada:=pais_corte2
    else
      registro_vuelo.pais_llegada:=random_string(random(10));
    registro_vuelo.kms:=100+random(9901);
    registro_vuelo.ocupacion:=1+random(991)/10;
  end;
end;
procedure actualizar_maximos(kms_avion: real; avion: int16; var kms_max1, kms_max2: real; var avion_max1, avion_max2: int16);
begin
  if (kms_avion>kms_max1) then
  begin
    kms_max2:=kms_max1;
    avion_max2:=avion_max1;
    kms_max1:=kms_avion;
    avion_max1:=avion;
  end
  else
    if (kms_avion>kms_max2) then
    begin
      kms_max2:=kms_avion;
      avion_max2:=avion;
    end;
end;
procedure actualizar_minimos(var kms_avion: real; avion: int16; var kms_min1, kms_min2: real; var avion_min1, avion_min2: int16);
begin
  if (kms_avion<kms_min1) then
  begin
    kms_min2:=kms_min1;
    avion_min2:=avion_min1;
    kms_min1:=kms_avion;
    avion_min1:=avion;
  end
  else
    if (kms_avion<kms_min2) then
    begin
      kms_min2:=kms_avion;
      avion_min2:=avion;
    end;
end;
procedure actualizar_maximo(paises_avion, avion: int16; var paises_max3, avion_max3: int16);
begin
  if (paises_avion>paises_max3) then
  begin
    paises_max3:=paises_avion;
    avion_max3:=avion;
  end;
end;
procedure leer_vuelos(var avion_max1, avion_max2, avion_min1, avion_min2, avion_max3, vuelos_corte1, vuelos_corte2: int16);
var
  registro_vuelo: t_registro_vuelo;
  avion, paises_avion, paises_max3: int16;
  kms_avion, kms_max1, kms_max2, kms_min1, kms_min2: real;
  pais: string;
begin
  kms_max1:=-9999999; kms_max2:=-9999999;
  kms_min1:=9999999; kms_min2:=9999999;
  paises_max3:=low(int16);
  avion:=1; pais:='XXX';
  leer_vuelo(registro_vuelo,avion,pais);
  while (registro_vuelo.avion<>avion_salida) do
  begin
    avion:=registro_vuelo.avion;
    kms_avion:=0;
    paises_avion:=0;
    while ((registro_vuelo.avion<>avion_salida) and (registro_vuelo.avion=avion)) do
    begin
      pais:=registro_vuelo.pais_salida;
      paises_avion:=paises_avion+1;
      while ((registro_vuelo.avion<>avion_salida) and (registro_vuelo.avion=avion) and (registro_vuelo.pais_salida=pais)) do
      begin
        kms_avion:=kms_avion+registro_vuelo.kms;
        if ((registro_vuelo.kms>kms_corte1) and (registro_vuelo.ocupacion<ocupacion_corte)) then
          vuelos_corte1:=vuelos_corte1+1;
        if ((registro_vuelo.kms<kms_corte2) and ((registro_vuelo.pais_llegada=pais_corte1) or (registro_vuelo.pais_llegada=pais_corte2))) then
          vuelos_corte2:=vuelos_corte2+1;
        leer_vuelo(registro_vuelo,avion,pais);
      end;
    end;
    actualizar_maximos(kms_avion,avion,kms_max1,kms_max2,avion_max1,avion_max2);
    actualizar_minimos(kms_avion,avion,kms_min1,kms_min2,avion_min1,avion_min2);
    actualizar_maximo(paises_avion,avion,paises_max3,avion_max3);
  end;
end;
var
  avion_max1, avion_max2, avion_min1, avion_min2, avion_max3, vuelos_corte1, vuelos_corte2: int16;
begin
  randomize;
  avion_max1:=0; avion_max2:=0; avion_min1:=0; avion_min2:=0;
  avion_max3:=0;
  vuelos_corte1:=0;
  vuelos_corte2:=0;
  leer_vuelos(avion_max1,avion_max2,avion_min1,avion_min2,avion_max3,vuelos_corte1,vuelos_corte2);
  textcolor(green); write('Los dos aviones que más kilómetros recorrieron son '); textcolor(red); write(avion_max1); textcolor(green); write(' y '); textcolor(red); writeln(avion_max2);
  textcolor(green); write('Los dos aviones que menos kilómetros recorrieron son '); textcolor(red); write(avion_min1); textcolor(green); write(' y '); textcolor(red); writeln(avion_min2);
  textcolor(green); write('El avión que salió de más países diferentes es '); textcolor(red); writeln(avion_max3);
  textcolor(green); write('La cantidad de vuelos de más de '); textcolor(yellow); write(kms_corte1:0:2); textcolor(green); write(' kms que no alcanzaron el '); textcolor(yellow); write(ocupacion_corte:0:2); textcolor(green); write('% de ocupación del avión es '); textcolor(red); writeln(vuelos_corte1);
  textcolor(green); write('La cantidad de vuelos de menos de '); textcolor(yellow); write(kms_corte2:0:2); textcolor(green); write(' kms que llegaron a '); textcolor(yellow); write(pais_corte1); textcolor(green); write(' o a '); textcolor(yellow); write(pais_corte2); textcolor(green); write(' es '); textcolor(red); write(vuelos_corte2);
end.