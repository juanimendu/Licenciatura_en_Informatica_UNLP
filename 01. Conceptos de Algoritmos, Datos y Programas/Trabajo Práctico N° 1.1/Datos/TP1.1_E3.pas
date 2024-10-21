{TRABAJO PRÁCTICO N° 1.1}
{EJERCICIO 3}
{Realizar un programa que lea 3 números enteros y los imprima en orden descendente. Por ejemplo, si se ingresan los valores 4, -10 y 12, deberá imprimir: “12 4 -10”.}

program TP1_E3;
{$codepage UTF8}
uses crt;
var
  num1, num2, num3: int16;
begin
  randomize;
  num1:=random(high(int16)); num2:=random(high(int16)); num3:=random(high(int16));
  if ((num1>=num2) and (num2>=num3)) then
  begin
    textcolor(green); write('El ordenamiento descendente es '); textcolor(red); write(num1); write(' '); write(num2); write(' '); write(num3);
  end
  else if ((num1>=num3) and (num3>=num2)) then
  begin
    textcolor(green); write('El ordenamiento descendente es '); textcolor(red); write(num1); write(' '); write(num3); write(' '); write(num2);
  end
  else if ((num2>=num1) and (num1>=num3)) then
  begin
    textcolor(green); write('El ordenamiento descendente es '); textcolor(red); write(num2); write(' '); write(num1); write(' '); write(num3);
  end
  else if ((num2>=num3) and (num3>=num1)) then
  begin
    textcolor(green); write('El ordenamiento descendente es '); textcolor(red); write(num2); write(' '); write(num3); write(' '); write(num1);
  end
  else if ((num3>=num1) and (num1>=num2)) then
  begin
    textcolor(green); write('El ordenamiento descendente es '); textcolor(red); write(num3); write(' '); write(num1); write(' '); write(num2);
  end
  else
  begin
    textcolor(green); write('El ordenamiento descendente es '); textcolor(red); write(num3); write(' '); write(num2); write(' '); write(num1);
  end;
end.