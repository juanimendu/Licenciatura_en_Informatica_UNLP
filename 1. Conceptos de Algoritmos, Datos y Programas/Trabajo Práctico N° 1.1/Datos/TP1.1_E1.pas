{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 1}
{Realizar un programa que lea 2 números enteros desde teclado e informe en pantalla cuál de los dos números es el mayor.
Si son iguales, debe informar en pantalla lo siguiente: “Los números leídos son iguales”.}

program TP1_E1;
{$codepage UTF8}
uses crt;
var
  num1, num2: int16;
begin
  randomize;
  num1:=random(high(int16));
  num2:=random(high(int16));
  if (num1>num2) then
  begin
    textcolor(green); write('El número '); textcolor(yellow); write(num1); textcolor(green); write(' es mayor al número '); textcolor(yellow); write(num2); 
  end
  else if (num2>num1) then
  begin
    textcolor(green); write('El número '); textcolor(yellow); write(num2); textcolor(green); write(' es mayor al número '); textcolor(yellow); write(num1); 
  end
  else
  begin
    textcolor(red); write('Los números leídos son iguales');
  end;
end.