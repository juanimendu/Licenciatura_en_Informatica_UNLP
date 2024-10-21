{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 9}
{Utilizando el programa del Ejercicio 1, realizar los siguientes módulos:
(a) EstaOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada o false en caso contrario.
(b) Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si existe). Nota: La lista podría no estar ordenada.
(c) Sublista: recibe como parámetros la lista y dos valores enteros A y B, y retorna una nueva lista con todos los elementos de la lista mayores que A y menores que B.
(d) Modificar el módulo Sublista del inciso anterior, suponiendo que la lista se encuentra ordenada de manera ascendente.
(e) Modificar el módulo Sublista del inciso anterior, suponiendo que la lista se encuentra ordenada de manera descendente.}

program TP6_E9;
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
end;procedure armarNodo5(var L: lista; v: integer);
var
  anterior, actual, nuevo: lista;
begin
  new(nuevo);
  nuevo^.num:=v;
  anterior:=L; actual:=L;
  while ((actual<>nil) and (actual^.num>nuevo^.num)) do
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
  i:=0;
  while (L<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('Elemento ',i,' de la lista: '); textcolor(yellow); writeln(L^.num);
    L:=L^.sig;
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
function EstaOrdenadaAscendente(L: lista): boolean;
begin
  while ((L^.sig<>nil) and ((L^.num<L^.sig^.num))) do
    L:=L^.sig;
  EstaOrdenadaAscendente:=(L^.sig=nil);
end;
function EstaOrdenadaDescendente(L: lista): boolean;
begin
  while ((L^.sig<>nil) and ((L^.num>L^.sig^.num))) do
    L:=L^.sig;
  EstaOrdenadaDescendente:=(L^.sig=nil);
end;
procedure Eliminar(var L: lista; valor: integer);
var
  anterior, actual: lista;
begin
  anterior:=L; actual:=L;
  while (actual<>nil) do
  begin
    if (actual^.num<>valor) then
    begin
      anterior:=actual;
      actual:=actual^.sig;
    end
    else
    begin
      if (actual=L) then
        L:=L^.sig
      else
        anterior^.sig:=actual^.sig;
      dispose(actual);
      actual:=anterior;
    end;
  end;
end;
procedure verificar_valores(var valorA, valorB: integer);
var
  aux: integer;
begin
  if (valorA>valorB) then
  begin
    aux:=valorA;
    valorA:=valorB;
    valorB:=aux;
  end;
end;
procedure Sublista1(L: lista; valorA, valorB: integer; var L2: lista);
begin
  while (L<>nil) do
  begin
    if ((L^.num>valorA) and (L^.num<valorB)) then
      armarNodo2(L2,L^.num);
    L:=L^.sig;
  end;
end;
procedure Sublista2(L: lista; valorA, valorB: integer; var L2: lista);
begin
  while ((L<>nil) and (L^.num<valorB)) do
  begin
    if (L^.num>valorA) then
      armarNodo2(L2,L^.num);
    L:=L^.sig;
  end;
end;
procedure Sublista3(L: lista; valorA, valorB: integer; var L2: lista);
begin
  while ((L<>nil) and (L^.num>valorA)) do
  begin
    if (L^.num<valorB) then
      armarNodo2(L2,L^.num);
    L:=L^.sig;
  end;
end;
var
  vector_numeros: array[1..5] of integer=(10, 21, 13, 48, 0);
  pri, ult, pri2: lista;
  pos, valor, valorA, valorB: integer;
  ordenada_ascendente, ordenada_descendente: boolean;
begin
  randomize;
  pri:=nil; ult:=nil; pri2:=nil;
  ordenada_ascendente:=false; ordenada_descendente:=false;
  writeln(); textcolor(red); writeln('EJERCICIO 1. INCISO (b):'); writeln();
  pos:=1;
  valor:=vector_numeros[pos];
  while (valor<>0) do
  begin
    armarNodo1(pri,valor);
    //armarNodo2(pri,valor);
    //armarNodo3(pri,ult,valor);
    //armarNodo4(pri,valor);
    //armarNodo5(pri,valor);
    pos:=pos+1;
    valor:=vector_numeros[pos];
  end;
  if (pri<>nil) then
  begin
    writeln(); textcolor(red); writeln('EJERCICIO 1. INCISO (c):'); writeln();
    imprimir_lista(pri);
    writeln(); textcolor(red); writeln('EJERCICIO 1. INCISO (d):'); writeln();
    valor:=1+random(100);
    modificar_lista(pri,valor);
    imprimir_lista(pri);
    writeln(); textcolor(red); writeln('EJERCICIO 4. INCISO (a):'); writeln();
    textcolor(green); write('El elemento de valor máximo de la lista es '); textcolor(red); writeln(calcular_maximo(pri));
    writeln(); textcolor(red); writeln('EJERCICIO 4. INCISO (b):'); writeln();
    textcolor(green); write('El elemento de valor mínimo de la lista es '); textcolor(red); writeln(calcular_minimo(pri));
    writeln(); textcolor(red); writeln('EJERCICIO 4. INCISO (c):'); writeln();
    valor:=1+random(10);
    textcolor(green); write('La cantidad de elementos de la lista que son múltiplos de '); textcolor(yellow); write(valor); textcolor(green); write(' es '); textcolor(red); writeln(calcular_multiplos(pri,valor));
    writeln(); textcolor(red); writeln('EJERCICIO 9. INCISO (a):'); writeln();
    ordenada_ascendente:=EstaOrdenadaAscendente(pri);
    textcolor(green); write('¿La lista está ordenada (ascendentemente)?: '); textcolor(red); writeln(ordenada_ascendente);
    if (ordenada_ascendente=false) then
    begin
      ordenada_descendente:=EstaOrdenadaDescendente(pri);
      textcolor(green); write('¿La lista está ordenada (descendentemente)?: '); textcolor(red); writeln(ordenada_descendente);
    end;
    writeln(); textcolor(red); writeln('EJERCICIO 9. INCISO (b):'); writeln();
    valor:=1+random(100);
    Eliminar(pri,valor);
    if (pri<>nil) then
    begin
      imprimir_lista(pri);
      writeln(); textcolor(red); writeln('EJERCICIO 9. INCISOS (c) (d) (e):'); writeln();
      valorA:=calcular_minimo(pri); valorB:=calcular_maximo(pri);
      verificar_valores(valorA,valorB);
      if ((ordenada_ascendente=false) and (ordenada_descendente=false)) then
      begin
        textcolor(green); write('La lista pri está '); textcolor(red); write('desordenada'); textcolor(green); write(', por lo que se genera la lista pri2 utilizando el procedure '); textcolor(red); writeln('Sublista1');
        Sublista1(pri,valorA,valorB,pri2);
      end
      else
        if (ordenada_ascendente=true) then
        begin
          textcolor(green); write('La lista pri está '); textcolor(red); write('ordenada de manera ascendente'); textcolor(green); write(', por lo que se genera la lista pri2 utilizando el procedure '); textcolor(red); writeln('Sublista2');
          Sublista2(pri,valorA,valorB,pri2);
        end
        else
          if (ordenada_descendente=true) then
          begin
            textcolor(green); write('La lista pri está '); textcolor(red); write('ordenada de manera descendente'); textcolor(green); write(', por lo que se genera la lista pri2 utilizando el procedure '); textcolor(red); writeln('Sublista3');
            Sublista3(pri,valorA,valorB,pri2);
          end;
      imprimir_lista(pri2);
    end;
  end;
end.