{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 1}
{Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de escritorio.}

program TP5_E1;
{$codepage UTF8}
uses crt;
type
  cadena=string[50];
  puntero_cadena=^cadena;
var
  pc: puntero_cadena;
begin
  writeln(sizeof(pc),' bytes');
  new(pc);
  writeln(sizeof(pc),' bytes');
  pc^:='un nuevo nombre';
  writeln(sizeof(pc),' bytes');
  writeln(sizeof(pc^),' bytes');
  pc^:='otro nuevo nombre distinto al anterior';
  writeln(sizeof(pc^),' bytes');
end.