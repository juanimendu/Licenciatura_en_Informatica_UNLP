{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 10}
{Un centro de investigación de la UNLP está organizando la información de las 320 especies de plantas con las que trabajan.
Para cada especie, se ingresa su nombre científico, tiempo promedio de vida (en meses), tipo de planta (por ej., árbol, conífera, arbusto, helecho, musgo, etc.), clima (templado, continental, subtropical, desértico, etc.) y países en el mundo donde se las encuentra.
La información de las plantas se ingresa ordenada por tipo de planta y, para cada planta, la lectura de países donde se las encuentra finaliza al ingresar el país “zzz”.
Al finalizar la lectura, informar:
•	El tipo de planta con menor cantidad de plantas.
•	El tiempo promedio de vida de las plantas de cada tipo.
•	El nombre científico de las dos plantas más longevas.
•	Los nombres de las plantas nativas de Argentina que se encuentran en regiones con clima subtropical.
•	El nombre de la planta que se encuentra en más países.}

program TP3_E10;
{$codepage UTF8}
uses crt;
const
  plantas_total=320;
  pais_salida='zzz';
  pais_corte='Argentina'; clima_corte='subtropical';
type
  t_registro_planta=record
    nombre: string;
    vida: int16;
    tipo: string;
    clima: string;
    pais: string;
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
procedure leer_planta(var registro_planta: t_registro_planta; planta, tipo: string; var tipo_pos: int8);
var
  vector_tipos: array[1..5] of string=('arbol', 'conifera', 'arbusto', 'helecho', 'musgo');
  vector_climas: array[1..4] of string=('templado', 'continental', 'subtropical', 'desertico');
  i: int8;
begin
  i:=random(10);
  if (i=0) then
  begin
    registro_planta.nombre:='Especie '+random_string(5+random(6));
    registro_planta.pais:=pais_salida;
  end
  else
  begin
    registro_planta.nombre:=planta;
    if (i<=5) then
      registro_planta.pais:=pais_corte
    else
      registro_planta.pais:=random_string(5+random(6));
  end;
  i:=random(20);
  if (i=0) then
  begin
    registro_planta.nombre:='Especie '+random_string(5+random(6));
    tipo_pos:=tipo_pos+1;
    if (tipo_pos<=5) then
      registro_planta.tipo:=vector_tipos[tipo_pos]
    else
      registro_planta.tipo:='Tipo '+random_string(5+random(6));
  end
  else
    if (tipo_pos<=5) then
      registro_planta.tipo:=vector_tipos[tipo_pos]
    else
      registro_planta.tipo:=tipo;
  registro_planta.vida:=1+random(100);
  registro_planta.clima:=vector_climas[1+random(4)];
end;
procedure actualizar_minimo(plantas_tipo: int16; tipo: string; var plantas_min: int16; var tipo_min: string);
begin
  if (plantas_tipo<plantas_min) then
  begin
    plantas_min:=plantas_tipo;
    tipo_min:=tipo;
  end;
end;
function calcular_tiempo_promedio(vida_tipo, plantas_tipo_paises: int16): real;
begin
  calcular_tiempo_promedio:=vida_tipo/plantas_tipo_paises;
end;
procedure actualizar_maximos(vida: int16; planta: string; var vida_max1, vida_max2: int16; var planta_max1, planta_max2: string);
begin
  if (vida>vida_max1) then
  begin
    vida_max2:=vida_max1;
    planta_max2:=planta_max1;
    vida_max1:=vida;
    planta_max1:=planta;
  end
  else
    if (vida>vida_max2) then
    begin
      vida_max2:=vida;
      planta_max2:=planta;
    end;
end;
procedure actualizar_maximo(paises_planta: int16; planta: string; var paises_max3: int16; var planta_max3: string);
begin
  if (paises_planta>paises_max3) then
  begin
    paises_max3:=paises_planta;
    planta_max3:=planta;
  end;
end;
procedure leer_plantas(var tipo_min, planta_max1, planta_max2, planta_max3: string);
var
  registro_planta: t_registro_planta;
  tipo_pos: int8;
  plantas, plantas_tipo, plantas_min, vida_tipo, plantas_tipo_paises, vida_max1, vida_max2, paises_planta, paises_max3: int16;
  tipo, planta: string;
begin
  plantas:=0;
  plantas_min:=high(int16);
  vida_max1:=low(int16); vida_max2:=low(int16);
  paises_max3:=low(int16);
  planta:='Especie XXX'; tipo:=''; tipo_pos:=1;
  leer_planta(registro_planta,planta,tipo,tipo_pos);
  while (plantas<plantas_total) do
  begin
    tipo:=registro_planta.tipo;
    plantas_tipo:=0;
    vida_tipo:=0; plantas_tipo_paises:=0;
    while ((plantas<plantas_total) and (registro_planta.tipo=tipo)) do
    begin
      planta:=registro_planta.nombre;
      plantas_tipo:=plantas_tipo+1;
      paises_planta:=0;
      while ((registro_planta.tipo=tipo) and (registro_planta.pais<>pais_salida)) do
      begin
        vida_tipo:=vida_tipo+registro_planta.vida;
        plantas_tipo_paises:=plantas_tipo_paises+1;
        actualizar_maximos(registro_planta.vida,registro_planta.nombre,vida_max1,vida_max2,planta_max1,planta_max2);
        if ((registro_planta.pais=pais_corte) and (registro_planta.clima=clima_corte)) then
        begin
          textcolor(green); write('El nombre de la planta nativa de '); textcolor(yellow); write(pais_corte); textcolor(green); write(' que se encuentran en una región con clima '); textcolor(yellow); write(clima_corte); textcolor(green); write(' es '); textcolor(red); writeln(planta);
        end;
        paises_planta:=paises_planta+1;
        leer_planta(registro_planta,planta,tipo,tipo_pos);
      end;
      if (registro_planta.tipo=tipo) then
        registro_planta.pais:=random_string(5+random(6));
      actualizar_maximo(paises_planta,planta,paises_max3,planta_max3);
      plantas:=plantas+1;
    end;
    actualizar_minimo(plantas_tipo,tipo,plantas_min,tipo_min);
    textcolor(green); write('El tiempo promedio de vida (en meses) de las plantas de tipo '); textcolor(red); write(tipo); textcolor(green); write(' es '); textcolor(red); writeln(calcular_tiempo_promedio(vida_tipo,plantas_tipo_paises):0:2);
  end;
end;
var
  tipo_min, planta_max1, planta_max2, planta_max3: string;
begin
  randomize;
  tipo_min:='';
  planta_max1:=''; planta_max2:='';
  planta_max3:='';
  leer_plantas(tipo_min,planta_max1,planta_max2,planta_max3);
  textcolor(green); write('El tipo de planta con menor cantidad de plantas es '); textcolor(red); writeln(tipo_min);
  textcolor(green); write('Los nombres científicos de las dos plantas más longevas son '); textcolor(red); write(planta_max1); textcolor(green); write(' y '); textcolor(red); writeln(planta_max2);
  textcolor(green); write('El nombre de la planta que se encuentra en más países es '); textcolor(red); write(planta_max3);
end.