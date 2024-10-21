{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 4b}
{Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de escritorio.}

program TP5_E4b;
{$codepage UTF8}
uses crt;
type
  cadena=string[50];
  puntero_cadena=^cadena;
var
  pc: puntero_cadena;
begin
  new(pc);
  pc^:='un nuevo nombre';
  writeln(sizeof(pc^),' bytes');
  writeln(pc^);
  dispose(pc);
  pc^:='otro nuevo nombre';
end.