{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 6}
{Realizar un programa que informe el valor total en pesos de una transacción en dólares.
Para ello, el programa debe leer el monto total en dólares de la transacción, el valor del dólar al día de la fecha y el porcentaje (en pesos) de la comisión que cobra el banco por la transacción.
Por ejemplo, si la transacción se realiza por 10 dólares, el dólar tiene un valor 189,32 pesos y el banco cobra un 4% de comisión, entonces, el programa deberá informar:
“La transacción será de 1968,93 pesos argentinos” (resultado de multiplicar 10 * 189,32 y adicionarle el 4%).}

program TP0_E6;
{$codepage UTF8}
uses crt;
var
  monto_dolares, valor_dolar, comision, monto_pesos: real;
begin
  randomize;
  monto_dolares:=1+random(9991)/10;
  valor_dolar:=1+random(991)/10;
  comision:=1+random(91)/10;
  monto_pesos:=monto_dolares*valor_dolar*(1+comision/100);
  textcolor(green); write('La transacción será de '); textcolor(red); write(monto_pesos:0:2); textcolor(green); write(' pesos argentinos');
end.