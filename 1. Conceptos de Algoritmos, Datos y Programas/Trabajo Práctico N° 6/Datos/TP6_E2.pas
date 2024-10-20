{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 2}
{Dado el siguiente código que lee información de personas hasta que se ingresa la persona con DNI 0 y, luego, imprime dicha información en el orden inverso al que fue leída, identificar los 9 errores.}

program TP6_E2;
{$codepage UTF8}
uses crt;
type
  lista=^nodo;
  persona=record
    dni: int32;
    nombre: string;
    apellido: string;
  end;
  nodo=record
    dato: persona;
    sig: lista;
  end;
function random_string(length: int8): string;
var
  i: int8;
  string_aux: string;
begin
  string_aux:='';
  for i:= 1 to length do
    string_aux:=string_aux+chr(ord('A')+random(26));
  random_string:=string_aux;
end;
procedure leerPersona(var p: persona);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    p.dni:=0
  else
    p.dni:=10000000+random(40000001);
  if (p.dni<>0) then
  begin
    p.nombre:=random_string(5+random(6));
    p.apellido:=random_string(5+random(6));
  end;
end;
procedure agregarAdelante(var l: lista; p: persona);
var
  aux: lista;
begin
  new(aux);
  aux^.dato:=p;
  aux^.sig:=l;
  l:=aux;
end;
procedure generarLista(var l: lista);
var
  p: persona;
begin
  leerPersona(p);
  while (p.dni<>0) do
  begin
    agregarAdelante(l,p);
    leerPersona(p);
  end;
end;
procedure imprimirInformacion(l: lista);
begin
  while (l<>nil) do
  begin
    writeln('DNI: ',l^.dato.dni,'; Nombre: ',l^.dato.nombre,'; Apellido: ',l^.dato.apellido);
    l:=l^.sig;
  end;
end;
var
  l: lista;
begin
  randomize;
  l:=nil;
  generarLista(l);
  if (l<>nil) then
    imprimirInformacion(l);
end.