{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 3}
{Encontrar los 6 errores que existen en el siguiente programa.
Utilizar los comentarios entre llaves como guía, indicar en qué línea se encuentra cada error y en qué consiste.}

program TP2_E3;
{$codepage UTF8}
uses crt;
procedure sumar(a, b: integer; var c: integer);
var
  i, suma: integer;
begin
  suma:=0;
  for i:= a to b do
    suma:=suma+i;
  c:=c+suma;
end;
var
  result, a, b: integer;
  ok: boolean;
begin
  randomize;
  result:=0;
  a:=random(100); b:=a+random(100-a);
  sumar(a,b,result);
  textcolor(green); write('La suma total es '); textcolor(red); writeln(result);
  ok:=((result>=10) or (result<=30));
  if (not ok) then
  begin
    textcolor(green); write('La suma no quedó entre 10 y 30');
  end;
end.