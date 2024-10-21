{TRABAJO PRÁCTICO N° 2.1}
{EJERCICIO 8a}
{Dado el siguiente programa:
(a) La función analizarLetra fue declarada como un submódulo dentro del procedimiento leer. Pero esto puede traer problemas en el código del programa principal.
(i) ¿Qué clase de problema se encuentra?
(ii) ¿Cómo se puede resolver el problema para que el programa compile y funcione correctamente?}

program TP2_E8a;
{$codepage UTF8}
uses crt;
var
  letra: char;
function analizarLetra: boolean;
begin
  if ((letra>='a') and (letra<='z')) then
    analizarLetra:=true
  else if ((letra>='A') and (letra<='Z')) then
    analizarLetra:=false;
end;
procedure leer;
begin
  textcolor(green); write('Introducir letra: ');
  textcolor(yellow); readln(letra);
  if (analizarLetra=true) then
  begin
    textcolor(green); writeln('Se trata de una minúscula');
  end
  else
  begin
    textcolor(green); writeln('Se trata de una mayúscula');
  end;
end;
var
  ok: boolean;
begin
  leer;
  ok:=analizarLetra;
  if (ok=true) then
  begin
    textcolor(green); write('Gracias, vuelva pronto');
  end;
end.