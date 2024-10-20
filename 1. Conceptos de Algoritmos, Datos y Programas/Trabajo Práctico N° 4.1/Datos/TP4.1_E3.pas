{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 3}
{Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
(a) Realizar un módulo que imprima el vector desde la primera posición hasta la última.
(b) Realizar un módulo que imprima el vector desde la última posición hasta la primera.
(c) Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y desde la mitad más uno hacia la última posición.
(d) Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector desde la posición X hasta la Y. Asumir que tanto X como Y son menores o igual a la dimensión lógica. Y considerar que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
(e) Utilizando el módulo implementado en el inciso anterior, volver a realizar los incisos (a), (b) y (c).}

program TP4_E3;
{$codepage UTF8}
uses crt;
type
  t_vector_numeros=array of int16;
procedure crear_vector_numeros(var vector_numeros: t_vector_numeros; dimF: int16);
begin
  setLength(vector_numeros,dimF);
end;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros; dimL: int16);
var
  i: int16;
begin
  for i:= 1 to dimL do
    vector_numeros[i]:=random(high(int16));
end;
procedure imprimir_1adimL(vector_numeros: t_vector_numeros; dimL: int16);
var
  i: int16;
begin
  for i:= 1 to dimL do
    if (i<dimL) then
      write(vector_numeros[i],', ')
    else
      writeln(vector_numeros[i]);
end;
procedure imprimir_dimLa1(vector_numeros: t_vector_numeros; dimL: int16);
var
  i: int16;
begin
  for i:= dimL downto 1 do
    if (i>1) then
      write(vector_numeros[i],', ')
    else
      writeln(vector_numeros[i]);
end;
procedure imprimir_dimLdiv2(vector_numeros: t_vector_numeros; dimL: int16);
var
  i, dimLdiv2, dimLdiv2mas1: int16;
begin
  dimLdiv2:=dimL div 2; dimLdiv2mas1:=dimLdiv2+1;
  for i:= dimLdiv2 downto 1 do
    if (i>1) then
      write(vector_numeros[i],', ')
    else
      writeln(vector_numeros[i]);
  for i:= dimLdiv2mas1 to dimL do
    if (i<dimL) then
      write(vector_numeros[i],', ')
    else
      writeln(vector_numeros[i]);
end;
procedure imprimir_general(vector_numeros: t_vector_numeros; numX, numY: int16);
var
  i: int16;
begin
  if (numX<=numY) then
    for i:= numX to numY do
      if (i<numY) then
        write(vector_numeros[i],', ')
      else
        writeln(vector_numeros[i])
  else
    for i:= numX downto numY do
      if (i>numY) then
        write(vector_numeros[i],', ')
      else
        writeln(vector_numeros[i]);
end;
var
  vector_numeros: t_vector_numeros;
  dimF, dimL: int16;
begin
  randomize;
  dimF:=2+random(9);
  dimL:=2+random(dimF-1);
  crear_vector_numeros(vector_numeros,dimF);
  if (dimL>0) then
  begin
    cargar_vector_numeros(vector_numeros,dimL);
    textcolor(green); writeln('INCISO (a):'); textcolor(yellow);
    imprimir_1adimL(vector_numeros,dimL);
    textcolor(green); writeln('INCISO (b):'); textcolor(yellow);
    imprimir_dimLa1(vector_numeros,dimL);
    textcolor(green); writeln('INCISO (c):'); textcolor(yellow);
    imprimir_dimLdiv2(vector_numeros,dimL);
    textcolor(green); writeln('INCISO (d):'); textcolor(yellow);
    imprimir_general(vector_numeros,1,2);
    textcolor(green); writeln('INCISO (e.a):'); textcolor(yellow);
    imprimir_general(vector_numeros,1,dimL);
    textcolor(green); writeln('INCISO (e.b):'); textcolor(yellow);
    imprimir_general(vector_numeros,dimL,1);
    textcolor(green); writeln('INCISO (e.c):'); textcolor(yellow);
    imprimir_general(vector_numeros,dimL div 2,1);
    imprimir_general(vector_numeros,dimL div 2+1,dimL);
  end;
end.