{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 2}
{Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número leído, sus dígitos en el orden en que aparecen en el número.
Debe implementarse un módulo recursivo que reciba el número e imprima lo pedido. Ejemplo, si se lee el valor 256, se debe imprimir 2 5 6.}

program TP2_E2;
{$codepage UTF8}
uses crt;
const
  num_salida=0;
procedure leer_numero(var num: int8);
begin
  num:=num_salida+random(high(int8));
end;
procedure descomponer_numero(var digito: int8; var num: int16);
begin
  digito:=num mod 10;
  num:=num div 10;
end;
procedure imprimir_digitos(num: int16);
var
  digito: int8;
begin
  if (num<>num_salida) then
  begin
    descomponer_numero(digito,num);
    imprimir_digitos(num);
    textcolor(red); write(digito,' ');
  end;
end;
procedure leer_numeros();
var
  num: int8;
begin
  leer_numero(num);
  if (num<>num_salida) then
  begin
    textcolor(green); writeln(); write('Número entero: '); textcolor(red); writeln(num);
    textcolor(green); write('Número entero (dígito por dígito): ');
    imprimir_digitos(num);
    writeln();
    leer_numeros();
  end;
end;
begin
  leer_numeros();
end.