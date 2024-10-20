{TRABAJO PRÁCTICO N° 2.2}
{EJERCICIO 4}
{El siguiente programa intenta resolver un enunciado. Sin embargo, el código posee 5 errores. Indicar en qué línea se encuentra cada error y en qué consiste el error.
Enunciado: Realizar un programa que lea datos de 130 programadores Java de una empresa. De cada programador, se lee el número de legajo y el salario actual.
El programa debe imprimir el total del dinero destinado por mes al pago de salarios y el salario del empleado mayor legajo.}

program TP2_E4;
{$codepage UTF8}
uses crt;
procedure leerDatos(var legajo: integer; var salario: real);
begin
  legajo:=1+random(high(integer));
  salario:=1+random(100);
end;
procedure actualizarMaximo(nuevoLegajo: integer; nuevoSalario: real; var maxLegajo: integer; var maxSalario: real);
begin
  if (nuevoLegajo>maxLegajo) then
  begin
    maxLegajo:=nuevoLegajo;
    maxSalario:=nuevoSalario;
  end;
end;
var
  legajo, maxLegajo, i: integer;
  salario, maxSalario, sumaSalarios: real;
begin
  randomize;
  maxLegajo:=0; maxSalario:=0;
  sumaSalarios:=0;
  for i:= 1 to 130 do
  begin
    leerDatos(legajo,salario);
    actualizarMaximo(legajo,salario,maxLegajo,maxSalario);
    sumaSalarios:=sumaSalarios+salario;
  end;
  textcolor(green); write('En todo el mes, se gastan '); textcolor(red); write(sumaSalarios:0:2); textcolor(green); writeln(' pesos');
  textcolor(green); write('El salario del empleado más nuevo es '); textcolor(red); write(maxSalario:0:2);
end.