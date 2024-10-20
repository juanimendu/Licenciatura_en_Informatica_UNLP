{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 8b}
{Dado el siguiente programa:
(b) La función analizarLetra parece incompleta, ya que no cubre algunos valores posibles de la variable letra.
(i) ¿De qué valores se trata?
(ii) ¿Qué sucede en nuestro programa si se ingresa uno de estos valores?
(iii) ¿Cómo se puede resolver este problema?}

program TP2_E8b;
{$codepage UTF8}
uses crt;
var
  letra: char;
function analizarLetra: int8;
begin
  if ((letra>='a') and (letra<='z')) then
    analizarLetra:=1
  else if ((letra>='A') and (letra<='Z')) then
    analizarLetra:=2
  else
    analizarLetra:=-1;
end;
procedure leer;
begin
  textcolor(green); write('Introducir letra: ');
  textcolor(yellow); readln(letra);
  if (analizarLetra=1) then
  begin
    textcolor(green); writeln('Se trata de una minúscula');
  end
  else if (analizarLetra=2) then
  begin
    textcolor(green); writeln('Se trata de una mayúscula');
  end
  else
  begin
    textcolor(green); writeln('No es una letra');
  end;
end;
var
  ok: int8;
begin
  leer;
  ok:=analizarLetra;
  if (ok=1) then
  begin
    textcolor(green); write('Gracias, vuelva pronto');
  end;
end.