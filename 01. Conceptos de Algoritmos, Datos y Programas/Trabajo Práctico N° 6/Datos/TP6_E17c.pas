{TRABAJO PRÁCTICO N° 6}
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

program TP6_E17c;
{$codepage UTF8}
uses crt;
const
  tanque_r='R'; tanque_c='C';
  tanque_salida='Z';
  alto_corte=1.40;
  volumen_corte=800.0;
type
  t_registro_tanque=record
    tanque: char;
    radio: real;
    alto: real;
    ancho: real;
    largo: real;
    volumen: real;
  end;
  t_lista_tanques=^t_nodo_tanques;
  t_nodo_tanques=record
    ele: t_registro_tanque;
    sig: t_lista_tanques;
  end;
procedure leer_tanque(var registro_tanque: t_registro_tanque);
var
  vector_tanques: array[1..2] of char=(tanque_r, tanque_c);
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_tanque.tanque:=tanque_salida
  else
    registro_tanque.tanque:=vector_tanques[1+random(2)];
  if (registro_tanque.tanque<>tanque_salida) then
  begin
    if (registro_tanque.tanque=tanque_r) then
    begin
      registro_tanque.ancho:=1+random(391)/10;
      registro_tanque.largo:=1+random(391)/10;
      registro_tanque.alto:=1+random(21)/10;
      registro_tanque.volumen:=registro_tanque.ancho*registro_tanque.largo*registro_tanque.alto;
      registro_tanque.radio:=-1;
    end
    else
    begin
      registro_tanque.radio:=1+random(391)/10;
      registro_tanque.alto:=1+random(21)/10;
      registro_tanque.volumen:=pi*registro_tanque.radio*registro_tanque.radio*registro_tanque.alto;
      registro_tanque.ancho:=-1;
      registro_tanque.largo:=-1;
    end;
  end;
end;
procedure agregar_adelante_lista_tanques(var lista_tanques: t_lista_tanques; registro_tanque: t_registro_tanque);
var
  nuevo: t_lista_tanques;
begin
  new(nuevo);
  nuevo^.ele:=registro_tanque;
  nuevo^.sig:=lista_tanques;
  lista_tanques:=nuevo;
end;
procedure cargar_lista_tanques(var lista_tanques: t_lista_tanques);
var
  registro_tanque: t_registro_tanque;
begin
  leer_tanque(registro_tanque);
  while (registro_tanque.tanque<>tanque_salida) do
  begin
    agregar_adelante_lista_tanques(lista_tanques,registro_tanque);
    leer_tanque(registro_tanque);
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
procedure procesar_lista_tanques(lista_tanques: t_lista_tanques; var volumen_max1, volumen_max2, volumen_total_c, volumen_total_r: real; var tanques_c, tanques_r, tanques_corte_alto, tanques_corte_volumen: int16);
begin
  while (lista_tanques<>nil) do
  begin
    calcular_a(lista_tanques^.ele.volumen,volumen_max1,volumen_max2);
    calcular_bc(lista_tanques^.ele.tanque,lista_tanques^.ele.volumen,volumen_total_c,volumen_total_r,tanques_c,tanques_r);
    calcular_d(lista_tanques^.ele.alto,tanques_corte_alto);
    calcular_e(lista_tanques^.ele.volumen,tanques_corte_volumen);
    lista_tanques:=lista_tanques^.sig;
  end;
end;
var
  lista_tanques: t_lista_tanques;
  tanques_c, tanques_r, tanques_corte_alto, tanques_corte_volumen: int16;
  volumen_max1, volumen_max2, volumen_total_c, volumen_total_r: real;
begin
  randomize;
  lista_tanques:=nil;
  volumen_max1:=0; volumen_max2:=0;
  tanques_c:=0; volumen_total_c:=0;
  tanques_r:=0; volumen_total_r:=0;
  tanques_corte_alto:=0;
  tanques_corte_volumen:=0;
  cargar_lista_tanques(lista_tanques);
  if (lista_tanques<>nil) then
  begin
    procesar_lista_tanques(lista_tanques,volumen_max1,volumen_max2,volumen_total_c,volumen_total_r,tanques_c,tanques_r,tanques_corte_alto,tanques_corte_volumen);
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