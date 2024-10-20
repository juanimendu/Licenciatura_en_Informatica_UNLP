{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 7b}
{Dado el siguiente programa:
(b) En el programa principal, la función calcularPromedio es invocada dos veces, pero esto podría mejorarse.
¿Cómo debería modificarse el programa principal para invocar a dicha función una única vez?}

program TP2_E7b;
{$codepage UTF8}
uses crt;
var
  suma, cant: int16;
  prom: real;
function calcularPromedio: real;
begin
  if (cant=0) then
    prom:=-1
  else
    prom:=suma/cant;
  calcularPromedio:=prom;
end;
begin
  randomize;
  suma:=random(101);
  cant:=random(101);
  if (calcularPromedio<>-1) then
  begin
    textcolor(green); write('El promedio entre '); textcolor(yellow); write(suma); textcolor(green); write(' y '); textcolor(yellow); write(cant); textcolor(green); write(' es '); textcolor(red); write(prom:0:2);
  end
  else
  begin
    textcolor(red); write('Dividir por cero no parece ser una buena idea');
  end;
end.