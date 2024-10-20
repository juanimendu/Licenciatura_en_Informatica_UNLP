{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 17c}
{Un fabricante de tanques de agua está analizando las ventas de sus tanques durante el 2020.
La empresa fabrica tanques a medida, que pueden ser rectangulares (tanques “R”) o cilíndricos (tanques “C”).
•	De cada tanque R, se conoce su ancho (A), su largo (B) y su alto (C).
•	De cada tanque C, se conoce su radio y su alto.
Todas las medidas se ingresan en metros. Realizar un programa que lea la información de los tanques vendidos por la empresa.
La lectura finaliza al ingresar un tanque de tipo “Z”.
Al finalizar la lectura, el programa debe informar:
•	Volumen de los dos mayores tanques vendidos.
•	Volumen promedio de todos los tanques cilíndricos vendidos.
•	Volumen promedio de todos los tanques rectangulares vendidos.
•	Cantidad de tanques cuyo alto sea menor a 1.40 metros.
•	Cantidad de tanques cuyo volumen sea menor a 800 metros cúbicos.}

program TP2_E17c;
{$codepage UTF8}
uses crt;
const
  tanque_r='R'; tanque_c='C';
  tanque_salida='Z';
  alto_corte=1.40;
  volumen_corte=800.0;
procedure leer_tanque(var tanque: char; var alto, volumen: real);
var
  vector_tanques: array[1..2] of char=(tanque_r, tanque_c);
  i: int8;
  radio, ancho, largo: real;
begin
  i:=random(100);
  if (i=0) then
    tanque:=tanque_salida
  else
    tanque:=vector_tanques[1+random(2)];
  if (tanque<>tanque_salida) then
  begin
    if (tanque=tanque_r) then
    begin
      ancho:=1+random(391)/10;
      largo:=1+random(391)/10;
      alto:=1+random(21)/10;
      volumen:=ancho*largo*alto;
    end
    else
    begin
      radio:=1+random(391)/10;
      alto:=1+random(21)/10;
      volumen:=pi*radio*radio*alto;
    end;
  end;
end;
procedure calcular_a(volumen: real; var volumen_max1, volumen_max2: real);
begin
  if (volumen>volumen_max1) then
  begin
    volumen_max2:=volumen_max1;
    volumen_max1:=volumen;   
  end
  else
    if (volumen>volumen_max2) then
      volumen_max2:=volumen;
end;
procedure calcular_bc(tanque: char; volumen: real; var volumen_total_c, volumen_total_r: real; var tanques_c, tanques_r: int16);
begin
  if (tanque=tanque_c) then
  begin
    volumen_total_c:=volumen_total_c+volumen;
    tanques_c:=tanques_c+1;
  end
  else
  begin
    volumen_total_r:=volumen_total_r+volumen;
    tanques_r:=tanques_r+1;
  end;
end;
procedure calcular_d(alto: real; var tanques_corte_alto: int16);
begin
  if (alto<alto_corte) then
    tanques_corte_alto:=tanques_corte_alto+1;
end;
procedure calcular_e(volumen: real; var tanques_corte_volumen: int16);
begin
  if (volumen<volumen_corte) then
    tanques_corte_volumen:=tanques_corte_volumen+1;
end;
procedure leer_tanques(var volumen_max1, volumen_max2, volumen_total_c, volumen_total_r: real; var tanques_c, tanques_r, tanques_corte_alto, tanques_corte_volumen: int16);
var
  volumen, alto: real;
  tanque: char;
begin
  leer_tanque(tanque,alto,volumen);
  while (tanque<>tanque_salida) do
  begin
    calcular_a(volumen,volumen_max1,volumen_max2);
    calcular_bc(tanque,volumen,volumen_total_c,volumen_total_r,tanques_c,tanques_r);
    calcular_d(alto,tanques_corte_alto);
    calcular_e(volumen,tanques_corte_volumen);
    leer_tanque(tanque,alto,volumen);
  end;
end;
var
  tanques_c, tanques_r, tanques_corte_alto, tanques_corte_volumen: int16;
  volumen_max1, volumen_max2, volumen_total_c, volumen_total_r: real;
begin
  randomize;
  volumen_max1:=0; volumen_max2:=0;
  tanques_c:=0; volumen_total_c:=0;
  tanques_r:=0; volumen_total_r:=0;
  tanques_corte_alto:=0;
  tanques_corte_volumen:=0;
  leer_tanques(volumen_max1,volumen_max2,volumen_total_c,volumen_total_r,tanques_c,tanques_r,tanques_corte_alto,tanques_corte_volumen);
  if ((tanques_c>0) or (tanques_r>0)) then
  begin
    textcolor(green); write('El volumen de los mayores tanques vendidos es '); textcolor(red); write(volumen_max1:0:2); textcolor(green); write(' y '); textcolor(red); writeln(volumen_max2:0:2);
    if (tanques_c>0) then
    begin
      textcolor(green); write('El volumen promedio de todos los tanques cilíndricos (C) vendidos es '); textcolor(red); writeln(volumen_total_c/tanques_c:0:2);
    end
    else
    begin
      textcolor(red); writeln('No hay tanques cilíndricos (C) vendidos');
    end;
    if (tanques_r>0) then
    begin
      textcolor(green); write('El volumen promedio de todos los tanques rectangulares (R) vendidos es '); textcolor(red); writeln(volumen_total_r/tanques_r:0:2);
    end
    else
    begin
      textcolor(red); writeln('No hay tanques rectangulares (R) vendidos');
    end;
    textcolor(green); write('La cantidad de tanques cuyo alto es menor a '); textcolor(yellow); write(alto_corte:0:2); textcolor(green); write(' metros es '); textcolor(red); writeln(tanques_corte_alto);
    textcolor(green); write('La cantidad de tanques cuyo volumen es menor a '); textcolor(yellow); write(volumen_corte:0:2); textcolor(green); write(' metros cúbicos es '); textcolor(red); write(tanques_corte_volumen);
  end
  else
  begin
    textcolor(red); write('No hay tanques cilíndricos (C) o rectangulares (R) vendidos');
  end;
end.