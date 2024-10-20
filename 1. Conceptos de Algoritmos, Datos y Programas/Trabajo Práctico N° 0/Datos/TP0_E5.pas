{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 5}
{Un kiosquero debe vender una cantidad X de caramelos entre Y clientes, dividiendo cantidades iguales entre todos los clientes. Los que le sobren se los quedará para él.
(a) Realizar un programa que lea la cantidad de caramelos que posee el kiosquero (X), la cantidad de clientes (Y) e imprima en pantalla un mensaje informando la cantidad de caramelos que le corresponderá a cada cliente y la cantidad de caramelos que se quedará para sí mismo.
(b) Imprimir en pantalla el dinero que deberá cobrar el kiosquero si cada caramelo tiene un valor de $1,60.}

program TP0_E5;
{$codepage UTF8}
uses crt;
const
  precio=1.6;
var
  clientes: int8;
  caramelos, caramelos_cliente, caramelos_kiosquero, caramelos_vendidos: int16;
begin
  randomize;
  caramelos:=1+random(high(int16));
  clientes:=1+random(high(int8));
  caramelos_cliente:=caramelos div clientes;
  caramelos_kiosquero:=caramelos mod clientes;
  caramelos_vendidos:=caramelos-caramelos_kiosquero;
  textcolor(green); write('La cantidad de caramelos que le corresponderá a cada cliente es '); textcolor(red); writeln(caramelos_cliente);
  textcolor(green); write('La cantidad de caramelos que se quedará el kioskero es '); textcolor(red); writeln(caramelos_kiosquero);
  textcolor(green); write('El dinero que deberá cobrar el kiosquero si cada caramelo tiene un valor de $'); textcolor(yellow); write(precio:0:2); textcolor(green); write(' es $'); textcolor(red); write(caramelos_vendidos*precio:0:2);
end.