{TRABAJO PRÁCTICO N° 1.2}
{EJERCICIO 1b}
{Modificar el ejercicio anterior para que, además, informe la cantidad de números mayores a 5.}

program TP1_E1b;
{$codepage UTF8}
uses crt;
const
  num_total=10;
  num_corte=5;
var
  i, nums_corte: int8;
  num: int16;
  suma: int32;
begin
  randomize;
  suma:=0;
  nums_corte:=0;
  for i:= 1 to num_total do
  begin
    num:=random(10);
    suma:=suma+num;
    if (num>num_corte) then
      nums_corte:=nums_corte+1;
  end;
  textcolor(green); write('La suma total de los números leídos es '); textcolor(red); writeln(suma);
  textcolor(green); write('La cantidad de números leídos mayores a '); textcolor(yellow); write(num_corte); textcolor(green); write(' es '); textcolor(red); write(nums_corte);
end.