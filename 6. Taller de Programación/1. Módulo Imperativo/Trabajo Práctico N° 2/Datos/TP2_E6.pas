{TRABAJO PRÁCTICO N° 2}
{EJERCICIO 6}
{Realizar un programa que lea números y que utilice un módulo recursivo que escriba el equivalente en binario de un número decimal.
El programa termina cuando el usuario ingresa el número 0 (cero).
Ayuda: Analizando las posibilidades, se encuentra que Binario (N) es N si el valor es menor a 2. ¿Cómo se obtienen los dígitos que componen al número?
¿Cómo se achica el número para la próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar 10111.}

program TP2_E6;
{$codepage UTF8}
uses crt;
const
  num_salida=0;
procedure leer_numero(var num: int8);
begin
  num:=num_salida+random(high(int8));
end;
procedure convertir_binario(num: int16);
var
  digito: int16;
begin
  if (num<>num_salida) then
  begin
    digito:=num mod 2;
    convertir_binario(num div 2);
    write(digito);
  end;
end;
var
  num: int8;
  i: int16;
begin
  randomize;
  i:=0;
  leer_numero(num);
  while (num<>num_salida) do
  begin
    i:=i+1;
    textcolor(green); write(i,'. Número en decimal: '); textcolor(red); writeln(num);
    textcolor(green); write(i,'. Número en binario: '); textcolor(red);
    convertir_binario(num);
    leer_numero(num);
    writeln();
  end;
end.