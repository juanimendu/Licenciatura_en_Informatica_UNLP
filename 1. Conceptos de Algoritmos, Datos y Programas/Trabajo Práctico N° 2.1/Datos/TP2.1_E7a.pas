{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 7a}
{Dado el siguiente programa:
(a) La función calcularPromedio calcula y retorna el promedio entre las variables globales suma y cant, pero parece incompleta.
¿Qué se debería agregar para que funcione correctamente?}

program TP2_E7a;
{$codepage UTF8}
uses crt;
var
  suma, cant: int16;
function calcularPromedio: real;
var
  prom: real;
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
    textcolor(green); write('El promedio entre '); textcolor(yellow); write(suma); textcolor(green); write(' y '); textcolor(yellow); write(cant); textcolor(green); write(' es '); textcolor(red); write(calcularPromedio:0:2);
  end
  else
  begin
    textcolor(red); write('Dividir por cero no parece ser una buena idea');
  end;
end.