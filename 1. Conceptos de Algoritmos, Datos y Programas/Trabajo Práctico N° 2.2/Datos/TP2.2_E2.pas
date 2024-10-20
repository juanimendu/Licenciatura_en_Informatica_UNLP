{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 2}
{Responder la pregunta en relación al siguiente programa:
¿Qué imprime si se lee la secuencia de valores 250, 35, 100?}

program TP2_E2;
{$codepage UTF8}
uses crt;
procedure digParesImpares(num: integer; var par, impar: integer);
var
  dig: integer;
begin
  while (num<>0) do
  begin
    dig:=num mod 10;
    if (dig mod 2=0) then
      par:=par+1
    else
      impar:=impar+1;
    num:=num div 10;
  end;
end;
var
  vector_nums: array[1..3] of integer=(250, 35, 100);
  dato, par, impar, pos: integer;
begin
  par:=0;
  impar:=0;
  pos:=0;
  repeat
    pos:=pos+1;
    dato:=vector_nums[pos];
    digParesImpares(dato,par,impar);
  until (dato=100);
  textcolor(green); write('Pares: '); textcolor(red); write(par); textcolor(green); write(' e Impares: '); textcolor(red); write(impar);
end.