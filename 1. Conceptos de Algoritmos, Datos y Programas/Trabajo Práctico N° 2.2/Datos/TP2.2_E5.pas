{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 5}
{(a) Realizar un módulo que reciba un par de números (numA, numB) y retorne si numB es el doble de numA.
(b) Utilizando el módulo realizado en el inciso (a), realizar un programa que lea secuencias de pares de números hasta encontrar el par (0,0),
e informe la cantidad total de pares de números leídos y la cantidad de pares en las que numB es el doble de numA.
Ejemplo: si se lee la siguiente secuencia (1,2) (3,4) (9,3) (7,14) (0,0), el programa debe informar los valores 4 (cantidad de pares leídos) y 2 (cantidad de pares en los que numB es el doble de numA).}

program TP2_E5;
{$codepage UTF8}
uses crt;
const
  numA_salida=0; numB_salida=0;
  multiplo_corte=2;
procedure leer_numeros(var numA, numB: int16);
begin
  numA:=numA_salida+random(101);
  numB:=numB_salida+random(101);
end;
function cumple_criterio(numA, numB: int16): boolean;
begin
  cumple_criterio:=(numB=multiplo_corte*numA);
end;
var
  numA, numB: int16;
  pares_total, pares_doble: int32;
begin
  randomize;
  pares_total:=0; pares_doble:=0;
  leer_numeros(numA,numB);
  while ((numA<>numA_salida) or (numB<>numB_salida)) do
  begin
    pares_total:=pares_total+1;
    if (cumple_criterio(numA,numB)=true) then
      pares_doble:=pares_doble+1;
      leer_numeros(numA,numB);
  end;
  textcolor(green); write('La cantidad total de pares leídos es '); textcolor(red); writeln(pares_total);
  textcolor(green); write('La cantidad de pares en las que numB es el doble de numA es '); textcolor(red); write(pares_doble);
end.