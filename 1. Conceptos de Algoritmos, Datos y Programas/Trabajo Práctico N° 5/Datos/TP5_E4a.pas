{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 4a}
{Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de escritorio.}

program TP5_E4a;
{$codepage UTF8}
uses crt;
type
  cadena=string[50];
  puntero_cadena=^cadena;
var
  pc: puntero_cadena;
begin
  pc^:='un nuevo texto';
  new(pc);
  writeln(pc^);
end.