{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 4c}
{Indicar los valores que imprime el siguiente programa en Pascal. Justificar mediante prueba de escritorio.}

program TP5_E4c;
{$codepage UTF8}
uses crt;
type
  cadena=string[50];
  puntero_cadena=^cadena;
procedure cambiarTexto(pun: puntero_cadena);
begin
  pun^:='Otro texto';
end;
var
  pc: puntero_cadena;
begin
  new(pc);
  pc^:='Un texto';
  writeln(pc^);
  cambiarTexto(pc);
  writeln(pc^);
end.