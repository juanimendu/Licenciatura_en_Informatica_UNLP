{TRABAJO PRÁCTICO N° 1.3}
{EJERCICIO 3}
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

program TP1_E3;
{$codepage UTF8}
uses crt;
const
  tanque_r='R'; tanque_c='C';
  tanque_salida='Z';
  alto_corte=1.40;
  volumen_corte=800.0;
var
  vector_tanques: array[1..2] of char=(tanque_r, tanque_c);
  i, tanques_c, tanques_r, tanques_corte_alto, tanques_corte_volumen: int8;
  radio, alto, ancho, largo, volumen, volumen_max1, volumen_max2, volumen_total_c, volumen_total_r: real;
  tanque: char;
begin
  randomize;
  volumen_max1:=0; volumen_max2:=0;
  volumen_total_c:=0; tanques_c:=0;
  volumen_total_r:=0; tanques_r:=0;
  tanques_corte_alto:=0;
  tanques_corte_volumen:=0;
  i:=random(100);
  if (i=0) then
    tanque:=tanque_salida
  else
    tanque:=vector_tanques[1+random(2)];
  while (tanque<>tanque_salida) do
  begin
    if (tanque=tanque_r) then
    begin
      ancho:=1+random(391)/10;
      largo:=1+random(391)/10;
      alto:=1+random(21)/10;
      volumen:=ancho*largo*alto;
      volumen_total_r:=volumen_total_r+volumen;
      tanques_r:=tanques_r+1;
    end
    else
    begin
      radio:=1+random(391)/10;
      alto:=1+random(21)/10;
      volumen:=pi*radio*radio*alto;
      volumen_total_c:=volumen_total_c+volumen;
      tanques_c:=tanques_c+1;
    end;
    if (volumen>volumen_max1) then
    begin
      volumen_max2:=volumen_max1;
      volumen_max1:=volumen;
    end
    else
      if (volumen>volumen_max2) then
        volumen_max2:=volumen;
    if (alto<alto_corte) then
      tanques_corte_alto:=tanques_corte_alto+1;
    if (volumen<volumen_corte) then
      tanques_corte_volumen:=tanques_corte_volumen+1;
    i:=random(100);
    if (i=0) then
      tanque:=tanque_salida
    else
      tanque:=vector_tanques[1+random(2)];
  end;
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