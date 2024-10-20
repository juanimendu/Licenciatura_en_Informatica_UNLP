{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 8}
{Utilizando el programa del Ejercicio 1, modificar el módulo armarNodo para que los elementos de la lista queden ordenados de manera ascendente (insertar ordenado).}

program TP6_E8;
{$codepage UTF8}
uses crt;
type
  lista=^nodo;
  nodo=record
    num: integer;
    sig: lista;
  end;
procedure armarNodo1(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.num:=v;
  aux^.sig:=L;
  L:=aux;
end;
procedure armarNodo2(var L: lista; v: integer);
var
  aux, ult: lista;
begin
  new(aux);
  aux^.num:=v;
  aux^.sig:=nil;
  if (L=nil) then
    L:=aux
  else
  begin
    ult:=L;
    while (ult^.sig<>nil) do
      ult:=ult^.sig;
    ult^.sig:=aux;
  end;
end;
procedure armarNodo3(var L, ult: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.num:=v;
  aux^.sig:=nil;
  if (L=nil) then
    L:=aux
  else
    ult^.sig:=aux;
  ult:=aux;
end;
procedure armarNodo4(var L: lista; v: integer);
var
  anterior, actual, nuevo: lista;
begin
  new(nuevo);
  nuevo^.num:=v;
  anterior:=L; actual:=L;
  while ((actual<>nil) and (actual^.num<nuevo^.num)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=L) then
    L:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure imprimir_lista(L: lista);
var
  i: int16;
begin
  i:=1;
  while (L<>nil) do
  begin
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(yellow); writeln(L^.num);
    L:=L^.sig;
    i:=i+1;
  end;
end;
procedure modificar_lista(var L: lista; valor: int16);
var
  aux: lista;
begin
  aux:=L;
  while (aux<>nil) do
  begin
    aux^.num:=aux^.num+valor;
    aux:=aux^.sig;
  end;
end;
function calcular_maximo(L: lista): integer;
var
  maximo: integer;
begin
  maximo:=low(integer);
  while (L<>nil) do
  begin
    if (L^.num>maximo) then
      maximo:=L^.num;
    L:=L^.sig;
  end;
  calcular_maximo:=maximo;
end;
function calcular_minimo(L: lista): integer;
var
  minimo: integer;
begin
  minimo:=high(integer);
  while (L<>nil) do
  begin
    if (L^.num<minimo) then
      minimo:=L^.num;
    L:=L^.sig;
  end;
  calcular_minimo:=minimo;
end;
function calcular_multiplos(L: lista; divisor: integer): integer;
var
  multiplos: integer;
begin
  multiplos:=0;
  while (L<>nil) do
  begin
    if (L^.num mod divisor=0) then
      multiplos:=multiplos+1;
    L:=L^.sig;
  end;
  calcular_multiplos:=multiplos;
end;
var
  pri, ult: lista;
  valor, divisor: integer;
begin
  pri:=nil; ult:=nil;
  textcolor(green); write('Introducir número entero: ');
  textcolor(yellow); readln(valor);
  while (valor<>0) do
  begin
    //armarNodo1(pri,valor);
    //armarNodo2(pri,valor);
    //armarNodo3(pri,ult,valor);
    armarNodo4(pri,valor);
    textcolor(green); write('Introducir número entero: ');
    textcolor(yellow); readln(valor);
  end;
  if (pri<>nil) then
  begin
    imprimir_lista(pri);
    textcolor(green); write('Introducir número entero con el cual se desea incrementar cada dato de la lista: ');
    textcolor(yellow); readln(valor);
    modificar_lista(pri,valor);
    imprimir_lista(pri);
    textcolor(green); write('El elemento de valor máximo de la lista es '); textcolor(red); writeln(calcular_maximo(pri));
    textcolor(green); write('El elemento de valor mínimo de la lista es '); textcolor(red); writeln(calcular_minimo(pri));
    textcolor(green); write('Introducir número entero como divisor para calcular cuántos elementos de la lista son múltiplos de él: ');
    textcolor(yellow); readln(divisor);
    textcolor(green); write('La cantidad de elementos de la lista que son múltiplos de '); textcolor(yellow); write(divisor); textcolor(green); write(' es '); textcolor(red); write(calcular_multiplos(pri,divisor));
  end;
end.