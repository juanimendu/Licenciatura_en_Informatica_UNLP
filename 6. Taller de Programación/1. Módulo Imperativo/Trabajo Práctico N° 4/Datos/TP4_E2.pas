{TRABAJO PRÁCTICO N° 4}
{EJERCICIO 2}
{Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante el año 2021.
De cada préstamo, se conoce el ISBN del libro, el número de socio, día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
(a) Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de los préstamos. La lectura de los préstamos finaliza con ISBN -1.
Las estructuras deben ser eficientes para buscar por ISBN.
  (i) En una estructura, cada préstamo debe estar en un nodo.
  (ii) En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN (prestar atención sobre los datos que se almacenan).
(b) Un módulo recursivo que reciba la estructura generada en (i) y retorne el ISBN más grande.
(c) Un módulo recursivo que reciba la estructura generada en (ii) y retorne el ISBN más pequeño.
(d) Un módulo recursivo que reciba la estructura generada en (i) y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
(e) Un módulo recursivo que reciba la estructura generada en (ii) y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
(f) Un módulo que reciba la estructura generada en (i) y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
(g) Un módulo que reciba la estructura generada en (ii) y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
(h) Un módulo recursivo que reciba la estructura generada en (g) y muestre su contenido.
(i) Un módulo recursivo que reciba la estructura generada en (i) y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos).
(j) Un módulo recursivo que reciba la estructura generada en (ii) y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos).}

program TP4_E2;
{$codepage UTF8}
uses crt;
const
  dia_ini=1; dia_fin=31;
  mes_ini=1; mes_fin=12;
  isbn_salida=-1;
type
  t_dia=dia_ini..dia_fin;
  t_mes=mes_ini..mes_fin;
  t_registro_prestamo1=record
    isbn: int8;
    socio: int8;
    dia: t_dia;
    mes: t_mes;
    dias_prestados: int8;
  end;
  t_abb_prestamos=^t_nodo_abb_prestamos;
  t_nodo_abb_prestamos=record
    ele: t_registro_prestamo1;
    hi: t_abb_prestamos;
    hd: t_abb_prestamos;
  end;
  t_registro_prestamo2=record
    socio: int8;
    dia: t_dia;
    mes: t_mes;
    dias_prestados: int8;
  end;
  t_lista_prestamos=^t_nodo_prestamos;
  t_nodo_prestamos=record
    ele: t_registro_prestamo2;
    sig: t_lista_prestamos;
  end;
  t_registro_isbn1=record
    isbn: int8;
    prestamos: t_lista_prestamos;
  end;
  t_abb_isbns=^t_nodo_abb_isbns;
  t_nodo_abb_isbns=record
    ele: t_registro_isbn1;
    hi: t_abb_isbns;
    hd: t_abb_isbns;
  end;
  t_registro_isbn2=record
    isbn: int8;
    prestamos: int16;
  end;
  t_lista_isbns=^t_nodo_isbns;
  t_nodo_isbns=record
    ele: t_registro_isbn2;
    sig: t_lista_isbns;
  end;
procedure leer_prestamo(var registro_prestamo1: t_registro_prestamo1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_prestamo1.isbn:=isbn_salida
  else
    registro_prestamo1.isbn:=1+random(high(int8));
  if (registro_prestamo1.isbn<>isbn_salida) then
  begin
    registro_prestamo1.socio:=1+random(high(int8));
    registro_prestamo1.dia:=dia_ini+random(dia_fin);
    registro_prestamo1.mes:=mes_ini+random(mes_fin);
    registro_prestamo1.dias_prestados:=1+random(high(int8));
  end;
end;
procedure agregar_abb_prestamos(var abb_prestamos: t_abb_prestamos; registro_prestamo1: t_registro_prestamo1);
begin
  if (abb_prestamos=nil) then
  begin
    new(abb_prestamos);
    abb_prestamos^.ele:=registro_prestamo1;
    abb_prestamos^.hi:=nil;
    abb_prestamos^.hd:=nil;
  end
  else
    if (registro_prestamo1.isbn<=abb_prestamos^.ele.isbn) then
      agregar_abb_prestamos(abb_prestamos^.hi,registro_prestamo1)
    else
      agregar_abb_prestamos(abb_prestamos^.hd,registro_prestamo1);
end;
procedure cargar_registro_prestamo2(var registro_prestamo2: t_registro_prestamo2; registro_prestamo1: t_registro_prestamo1);
begin
  registro_prestamo2.socio:=registro_prestamo1.socio;
  registro_prestamo2.dia:=registro_prestamo1.dia;
  registro_prestamo2.mes:=registro_prestamo1.mes;
  registro_prestamo2.dias_prestados:=registro_prestamo1.dias_prestados;
end;
procedure agregar_adelante_lista_prestamos(var lista_prestamos: t_lista_prestamos; registro_prestamo1: t_registro_prestamo1);
var
  nuevo: t_lista_prestamos;
begin
  new(nuevo);
  cargar_registro_prestamo2(nuevo^.ele,registro_prestamo1);
  nuevo^.sig:=lista_prestamos;
  lista_prestamos:=nuevo;
end;
procedure cargar_registro_isbn1(var registro_isbn1: t_registro_isbn1; registro_prestamo1: t_registro_prestamo1);
begin
  registro_isbn1.isbn:=registro_prestamo1.isbn;
  registro_isbn1.prestamos:=nil;
  agregar_adelante_lista_prestamos(registro_isbn1.prestamos,registro_prestamo1);
end;
procedure agregar_abb_isbns(var abb_isbns: t_abb_isbns; registro_prestamo1: t_registro_prestamo1);
begin
  if (abb_isbns=nil) then
  begin
    new(abb_isbns);
    cargar_registro_isbn1(abb_isbns^.ele,registro_prestamo1);
    abb_isbns^.hi:=nil;
    abb_isbns^.hd:=nil;
  end
  else
    if (registro_prestamo1.isbn=abb_isbns^.ele.isbn) then
      agregar_adelante_lista_prestamos(abb_isbns^.ele.prestamos,registro_prestamo1)
    else if (registro_prestamo1.isbn<abb_isbns^.ele.isbn) then
      agregar_abb_isbns(abb_isbns^.hi,registro_prestamo1)
    else
      agregar_abb_isbns(abb_isbns^.hd,registro_prestamo1);
end;
procedure cargar_abbs(var abb_prestamos: t_abb_prestamos; var abb_isbns: t_abb_isbns);
var
  registro_prestamo1: t_registro_prestamo1;
begin
  leer_prestamo(registro_prestamo1);
  while (registro_prestamo1.isbn<>isbn_salida) do
  begin
    agregar_abb_prestamos(abb_prestamos,registro_prestamo1);
    agregar_abb_isbns(abb_isbns,registro_prestamo1);
    leer_prestamo(registro_prestamo1);
  end;
end;
procedure imprimir_registro_prestamo1(registro_prestamo1: t_registro_prestamo1);
begin
  textcolor(green); write('El ISBN del préstamo es '); textcolor(red); writeln(registro_prestamo1.isbn);
  textcolor(green); write('El número de socio del préstamo es '); textcolor(red); writeln(registro_prestamo1.socio);
  textcolor(green); write('El día del préstamo es '); textcolor(red); writeln(registro_prestamo1.dia);
  textcolor(green); write('El mes del préstamo es '); textcolor(red); writeln(registro_prestamo1.mes);
  textcolor(green); write('La cantidad de días prestados del préstamo es '); textcolor(red); writeln(registro_prestamo1.dias_prestados);
  writeln();
end;
procedure imprimir_abb_prestamos(abb_prestamos: t_abb_prestamos);
begin
  if (abb_prestamos<>nil) then
  begin
    imprimir_abb_prestamos(abb_prestamos^.hi);
    imprimir_registro_prestamo1(abb_prestamos^.ele);
    imprimir_abb_prestamos(abb_prestamos^.hd);
  end;
end;
procedure imprimir_registro_prestamo2(registro_prestamo2: t_registro_prestamo2; isbn: int8; prestamo: int16);
begin
  textcolor(green); write('El número de socio del préstamo '); textcolor(yellow); write(prestamo); textcolor(green); write(' del ISBN '); textcolor(yellow); write(isbn); textcolor(green); write(' es '); textcolor(red); writeln(registro_prestamo2.socio);
  textcolor(green); write('El día del préstamo '); textcolor(yellow); write(prestamo); textcolor(green); write(' del ISBN '); textcolor(yellow); write(isbn); textcolor(green); write(' es '); textcolor(red); writeln(registro_prestamo2.dia);
  textcolor(green); write('El mes del préstamo '); textcolor(yellow); write(prestamo); textcolor(green); write(' del ISBN '); textcolor(yellow); write(isbn); textcolor(green); write(' es '); textcolor(red); writeln(registro_prestamo2.mes);
  textcolor(green); write('La cantidad de días prestados del préstamo '); textcolor(yellow); write(prestamo); textcolor(green); write(' del ISBN '); textcolor(yellow); write(isbn); textcolor(green); write(' es '); textcolor(red); writeln(registro_prestamo2.dias_prestados);
end;
procedure imprimir_lista_prestamos(lista_prestamos: t_lista_prestamos; isbn: int8);
var
  i: int16;
begin
  i:=0;
  while (lista_prestamos<>nil) do
  begin
    i:=i+1;
    imprimir_registro_prestamo2(lista_prestamos^.ele,isbn,i);
    lista_prestamos:=lista_prestamos^.sig;
  end;
end;
procedure imprimir_registro_isbn1(registro_isbn1: t_registro_isbn1);
begin
  textcolor(green); write('El ISBN del préstamo es '); textcolor(red); writeln(registro_isbn1.isbn);
  imprimir_lista_prestamos(registro_isbn1.prestamos,registro_isbn1.isbn);
  writeln();
end;
procedure imprimir_abb_isbns(abb_isbns: t_abb_isbns);
begin
  if (abb_isbns<>nil) then
  begin
    imprimir_abb_isbns(abb_isbns^.hi);
    imprimir_registro_isbn1(abb_isbns^.ele);
    imprimir_abb_isbns(abb_isbns^.hd);
  end;
end;
function buscar_mayor_isbn(abb_prestamos: t_abb_prestamos): int8;
begin
  if (abb_prestamos^.hd=nil) then
    buscar_mayor_isbn:=abb_prestamos^.ele.isbn
  else
    buscar_mayor_isbn:=buscar_mayor_isbn(abb_prestamos^.hd);
end;
function buscar_menor_isbn(abb_isbns: t_abb_isbns): int8;
begin
  if (abb_isbns^.hi=nil) then
    buscar_menor_isbn:=abb_isbns^.ele.isbn
  else
    buscar_menor_isbn:=buscar_menor_isbn(abb_isbns^.hi);
end;
function contar_abb_prestamos(abb_prestamos: t_abb_prestamos; socio: int8): int16;
begin
  if (abb_prestamos=nil) then
    contar_abb_prestamos:=0
  else
    if (socio=abb_prestamos^.ele.socio) then
      contar_abb_prestamos:=contar_abb_prestamos(abb_prestamos^.hi,socio)+contar_abb_prestamos(abb_prestamos^.hd,socio)+1
    else
      contar_abb_prestamos:=contar_abb_prestamos(abb_prestamos^.hi,socio)+contar_abb_prestamos(abb_prestamos^.hd,socio);
end;
function contar_socios(lista_prestamos: t_lista_prestamos; socio: int8): int16;
var
  socios: int16;
begin
  socios:=0;
  while (lista_prestamos<>nil) do
  begin
    if (socio=lista_prestamos^.ele.socio) then
      socios:=socios+1;
    lista_prestamos:=lista_prestamos^.sig;
  end;
  contar_socios:=socios;
end;
function contar_abb_isbns(abb_isbns: t_abb_isbns; socio: int8): int16;
begin
  if (abb_isbns=nil) then
    contar_abb_isbns:=0
  else
    contar_abb_isbns:=contar_abb_isbns(abb_isbns^.hi,socio)+contar_abb_isbns(abb_isbns^.hd,socio)+contar_socios(abb_isbns^.ele.prestamos,socio);
end;
procedure cargar1_registro_isbn2(var registro_isbn2: t_registro_isbn2; isbn: int8);
begin
  registro_isbn2.isbn:=isbn;
  registro_isbn2.prestamos:=1;
end;
procedure agregar_adelante_lista_isbns1(var lista_isbns1: t_lista_isbns; isbn: int8);
var
  nuevo: t_lista_isbns;
begin
  new(nuevo);
  cargar1_registro_isbn2(nuevo^.ele,isbn);
  nuevo^.sig:=lista_isbns1;
  lista_isbns1:=nuevo;
end;
procedure cargar_lista_isbns1(var lista_isbns1: t_lista_isbns; abb_prestamos: t_abb_prestamos);
begin
  if (abb_prestamos<>nil) then
  begin
    cargar_lista_isbns1(lista_isbns1,abb_prestamos^.hd);
    if ((lista_isbns1<>nil) and (lista_isbns1^.ele.isbn=abb_prestamos^.ele.isbn)) then
      lista_isbns1^.ele.prestamos:=lista_isbns1^.ele.prestamos+1
    else
      agregar_adelante_lista_isbns1(lista_isbns1,abb_prestamos^.ele.isbn);
    cargar_lista_isbns1(lista_isbns1,abb_prestamos^.hi);
  end;
end;
function contar_prestamos(lista_prestamos: t_lista_prestamos): int16;
var
  prestamos: int16;
begin
  prestamos:=0;
  while (lista_prestamos<>nil) do
  begin
    prestamos:=prestamos+1;
    lista_prestamos:=lista_prestamos^.sig;
  end;
  contar_prestamos:=prestamos;
end;
procedure cargar2_registro_isbn2(var registro_isbn2: t_registro_isbn2; registro_isbn1: t_registro_isbn1);
begin
  registro_isbn2.isbn:=registro_isbn1.isbn;
  registro_isbn2.prestamos:=contar_prestamos(registro_isbn1.prestamos);
end;
procedure agregar_adelante_lista_isbns2(var lista_isbns2: t_lista_isbns; registro_isbn1: t_registro_isbn1);
var
  nuevo: t_lista_isbns;
begin
  new(nuevo);
  cargar2_registro_isbn2(nuevo^.ele,registro_isbn1);
  nuevo^.sig:=lista_isbns2;
  lista_isbns2:=nuevo;
end;
procedure cargar_lista_isbns2(var lista_isbns2: t_lista_isbns; abb_isbns: t_abb_isbns);
begin
  if (abb_isbns<>nil) then
  begin
    cargar_lista_isbns2(lista_isbns2,abb_isbns^.hd);
    agregar_adelante_lista_isbns2(lista_isbns2,abb_isbns^.ele);
    cargar_lista_isbns2(lista_isbns2,abb_isbns^.hi);
  end;
end;
procedure imprimir_registro_isbn2(registro_isbn2: t_registro_isbn2);
begin
  textcolor(green); write('El ISBN es '); textcolor(red); writeln(registro_isbn2.isbn);
  textcolor(green); write('La cantidad total de veces que se prestó es '); textcolor(red); writeln(registro_isbn2.prestamos);
end;
procedure imprimir1_lista_isbns(lista_isbns: t_lista_isbns);
begin
  while (lista_isbns<>nil) do
  begin
    imprimir_registro_isbn2(lista_isbns^.ele);
    writeln();
    lista_isbns:=lista_isbns^.sig;
  end;
end;
procedure imprimir2_lista_isbns(lista_isbns: t_lista_isbns);
begin
  if (lista_isbns<>nil) then
  begin
    imprimir_registro_isbn2(lista_isbns^.ele);
    imprimir2_lista_isbns(lista_isbns^.sig);
  end;
end;
procedure verificar_isbns(var isbn1, isbn2: int8);
var
  aux: int8;
begin
  if (isbn1>isbn2) then
  begin
    aux:=isbn1;
    isbn1:=isbn2;
    isbn2:=aux;
  end;
end;
function contar_isbns1(abb_prestamos: t_abb_prestamos; isbn1, isbn2: int8): int16;
begin
  if (abb_prestamos=nil) then
    contar_isbns1:=0
  else
    if (isbn1>abb_prestamos^.ele.isbn) then
      contar_isbns1:=contar_isbns1(abb_prestamos^.hd,isbn1,isbn2)
    else if (isbn2<abb_prestamos^.ele.isbn) then
      contar_isbns1:=contar_isbns1(abb_prestamos^.hi,isbn1,isbn2)
    else
      contar_isbns1:=contar_isbns1(abb_prestamos^.hi,isbn1,isbn2)+contar_isbns1(abb_prestamos^.hd,isbn1,isbn2)+1;
end;
function contar_isbns2(abb_isbns: t_abb_isbns; isbn1, isbn2: int8): int16;
begin
  if (abb_isbns=nil) then
    contar_isbns2:=0
  else
    if (isbn1>abb_isbns^.ele.isbn) then
      contar_isbns2:=contar_isbns2(abb_isbns^.hd,isbn1,isbn2)
    else if (isbn2<abb_isbns^.ele.isbn) then
      contar_isbns2:=contar_isbns2(abb_isbns^.hi,isbn1,isbn2)
    else
      contar_isbns2:=contar_isbns2(abb_isbns^.hi,isbn1,isbn2)+contar_isbns2(abb_isbns^.hd,isbn1,isbn2)+contar_prestamos(abb_isbns^.ele.prestamos);
end;
var
  lista_isbns1, lista_isbns2: t_lista_isbns;
  abb_prestamos: t_abb_prestamos;
  abb_isbns: t_abb_isbns;
  socio, isbn1, isbn2: int8;
begin
  randomize;
  abb_prestamos:=nil; abb_isbns:=nil;
  lista_isbns1:=nil; lista_isbns2:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abbs(abb_prestamos,abb_isbns);
  if ((abb_prestamos<>nil) and (abb_isbns<>nil)) then
  begin
    writeln(); textcolor(red); writeln('ABB_PRESTAMOS:'); writeln();
    imprimir_abb_prestamos(abb_prestamos);
    writeln(); textcolor(red); writeln('ABB_ISBNS:'); writeln();
    imprimir_abb_isbns(abb_isbns);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    textcolor(green); write('El ISBN más grande es '); textcolor(red); writeln(buscar_mayor_isbn(abb_prestamos));
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    textcolor(green); write('El ISBN más chico es '); textcolor(red); writeln(buscar_menor_isbn(abb_isbns));
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    socio:=1+random(high(int8));
    textcolor(green); write('La cantidad de préstamos en el abb_prestamos realizados al número de socio '); textcolor(yellow); write(socio); textcolor(green); write(' es '); textcolor(red); writeln(contar_abb_prestamos(abb_prestamos,socio));
    writeln(); textcolor(red); writeln('INCISO (e):'); writeln();
    socio:=1+random(high(int8));
    textcolor(green); write('La cantidad de préstamos en el abb_isbns realizados al número de socio '); textcolor(yellow); write(socio); textcolor(green); write(' es '); textcolor(red); writeln(contar_abb_isbns(abb_isbns,socio));
    writeln(); textcolor(red); writeln('INCISO (f):'); writeln();
    cargar_lista_isbns1(lista_isbns1,abb_prestamos);
    imprimir1_lista_isbns(lista_isbns1);
    writeln(); textcolor(red); writeln('INCISO (g):'); writeln();
    cargar_lista_isbns2(lista_isbns2,abb_isbns);
    imprimir1_lista_isbns(lista_isbns2);
    writeln(); textcolor(red); writeln('INCISO (h):'); writeln();
    imprimir2_lista_isbns(lista_isbns1);
    writeln();
    imprimir2_lista_isbns(lista_isbns2);
    writeln(); textcolor(red); writeln('INCISO (i):'); writeln();
    isbn1:=1+random(high(int8)); isbn2:=1+random(high(int8));
    verificar_isbns(isbn1,isbn2);
    textcolor(green); write('La cantidad total de préstamos en el abb_prestamos cuyo ISBN se encuentra entre '); textcolor(yellow); write(isbn1); textcolor(green); write(' y '); textcolor(yellow); write(isbn2); textcolor(green); write(' (incluídos) es '); textcolor(red); writeln(contar_isbns1(abb_prestamos,isbn1,isbn2));
    writeln(); textcolor(red); writeln('INCISO (j):'); writeln();
    textcolor(green); write('La cantidad total de préstamos en el abb_isbns cuyo ISBN se encuentra entre '); textcolor(yellow); write(isbn1); textcolor(green); write(' y '); textcolor(yellow); write(isbn2); textcolor(green); write(' (incluídos) es '); textcolor(red); write(contar_isbns2(abb_isbns,isbn1,isbn2));
  end;
end.