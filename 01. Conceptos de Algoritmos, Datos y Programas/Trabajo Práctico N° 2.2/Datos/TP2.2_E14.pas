{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 14}
{Realizar un programa modularizado que lea 10 pares de números (X, Y) e informe, para cada par de números, la suma y el producto de todos los números entre X e Y.
Por ejemplo, dado el par (3, 6), debe informar:
“La suma es 18” (obtenido de calcular 3+4+5+6).
“El producto es 360” (obtenido de calcular 3*4*5*6).}

program TP2_E14;
{$codepage UTF8}
uses crt;
const
  pares_total=10;
procedure leer_numeros(var numX, numY: int8);
begin
  numX:=1+random(10);
  numY:=1+random(10);
end;
procedure verificar_numeros(var numX, numY: int8);
var
  aux: int8;
begin
  if (numX>numY) then
  begin
    aux:=numX;
    numX:=numY;
    numY:=aux;
  end;
end;
procedure calcular_suma_producto(var numX, numY: int8; var suma, producto: real);
var
  i: int8;
begin
  for i:= numX to numY do
  begin
    suma:=suma+i;
    producto:=producto*i;
  end;
end;
var
  i: int8;
  numX, numY: int8;
  suma, producto: real;
begin
  randomize;
  for i:= 1 to pares_total do
  begin
    leer_numeros(numX,numY);
    verificar_numeros(numX,numY);
    suma:=0; producto:=1;
    calcular_suma_producto(numX,numY,suma,producto);
    textcolor(green); write('Para el par '); textcolor(yellow); write('(',numX,', ',numY,')'); textcolor(green); write(', la suma es '); textcolor(red); write(suma:0:2); textcolor(green); write(' y el producto es '); textcolor(red); writeln(producto:0:2);
  end;
end.