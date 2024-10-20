{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 2}
{Una agencia dedicada a la venta de autos ha organizado su stock y dispone, en papel, de la información de los autos en venta. Implementar un programa que:
(a) Lea la información de los autos (patente, año de fabricación (2010 .. 2018), marca y modelo) y los almacene en dos estructuras de datos:
  (i) Una estructura eficiente para la búsqueda por patente.
  (ii) Una estructura eficiente para la búsqueda por marca. Para cada marca, se deben almacenar todos juntos los autos pertenecientes a ella.
(b) Invoque a un módulo que reciba la estructura generado en (a) (i) y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.
(c) Invoque a un módulo que reciba la estructura generado en (a) (ii) y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.
(d) Invoque a un módulo que reciba el árbol generado en (a) (i) y retorne una estructura con la información de los autos agrupados por año de fabricación.
(e) Invoque a un módulo que reciba el árbol generado en (a) (i) y una patente y devuelva el modelo del auto con dicha patente.
(f) Invoque a un módulo que reciba el árbol generado en (a) (ii) y una patente y devuelva el modelo del auto con dicha patente.}

program TP5_E2;
{$codepage UTF8}
uses crt;
const
  anio_ini=2010; anio_fin=2018;
  marca_salida='MMM';
type
  t_anio=anio_ini..anio_fin;
  t_registro_auto1=record
    patente: string;
    anio: t_anio;
    marca: string;
    modelo: string;
  end;
  t_abb_patentes=^t_nodo_abb_patentes;
  t_nodo_abb_patentes=record
    ele: t_registro_auto1;
    hi: t_abb_patentes;
    hd: t_abb_patentes;
  end;
  t_registro_auto2=record
    patente: string;
    anio: t_anio;
    modelo: string;
  end;
  t_lista_autos1=^t_nodo_autos1;
  t_nodo_autos1=record
    ele: t_registro_auto2;
    sig: t_lista_autos1;
  end;
  t_registro_marca=record
    marca: string;
    autos: t_lista_autos1;
  end;
  t_abb_marcas=^t_nodo_abb_marcas;
  t_nodo_abb_marcas=record
    ele: t_registro_marca;
    hi: t_abb_marcas;
    hd: t_abb_marcas;
  end;
  t_registro_auto3=record
    patente: string;
    marca: string;
    modelo: string;
  end;
  t_lista_autos2=^t_nodo_autos2;
  t_nodo_autos2=record
    ele: t_registro_auto3;
    sig: t_lista_autos2;
  end;
  t_vector_autos=array[t_anio] of t_lista_autos2;
procedure inicializar_vector_autos(var vector_autos: t_vector_autos);
var
  i: t_anio;
begin
  for i:= anio_ini to anio_fin do
    vector_autos[i]:=nil;
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
procedure leer_auto(var registro_auto1: t_registro_auto1);
var
  i: int16;
begin
  i:=random(100);
  if (i=0) then
    registro_auto1.marca:=marca_salida
  else
    registro_auto1.marca:='Marca '+random_string(1);
  if (registro_auto1.marca<>marca_salida) then
  begin
    registro_auto1.patente:=random_string(2);
    registro_auto1.anio:=anio_ini+random(anio_fin-anio_ini+1);
    registro_auto1.modelo:='Modelo '+random_string(2);
  end;
end;
procedure agregar_abb_patentes(var abb_patentes: t_abb_patentes; registro_auto1: t_registro_auto1);
begin
  if (abb_patentes=nil) then
  begin
    new(abb_patentes);
    abb_patentes^.ele:=registro_auto1;
    abb_patentes^.hi:=nil;
    abb_patentes^.hd:=nil;
  end
  else
    if (registro_auto1.patente<=abb_patentes^.ele.patente) then
      agregar_abb_patentes(abb_patentes^.hi,registro_auto1)
    else
      agregar_abb_patentes(abb_patentes^.hd,registro_auto1);
end;
procedure cargar_registro_auto2(var registro_auto2: t_registro_auto2; registro_auto1: t_registro_auto1);
begin
  registro_auto2.patente:=registro_auto1.patente;
  registro_auto2.anio:=registro_auto1.anio;
  registro_auto2.modelo:=registro_auto1.modelo;
end;
procedure agregar_adelante_lista_autos1(var lista_autos1: t_lista_autos1; registro_auto1: t_registro_auto1);
var
  nuevo: t_lista_autos1;
begin
  new(nuevo);
  cargar_registro_auto2(nuevo^.ele,registro_auto1);
  nuevo^.sig:=lista_autos1;
  lista_autos1:=nuevo;
end;
procedure cargar_registro_marca(var registro_marca: t_registro_marca; registro_auto1: t_registro_auto1);
begin
  registro_marca.marca:=registro_auto1.marca;
  registro_marca.autos:=nil;
  agregar_adelante_lista_autos1(registro_marca.autos,registro_auto1);
end;
procedure agregar_abb_marcas(var abb_marcas: t_abb_marcas; registro_auto1: t_registro_auto1);
begin
  if (abb_marcas=nil) then
  begin
    new(abb_marcas);
    cargar_registro_marca(abb_marcas^.ele,registro_auto1);
    abb_marcas^.hi:=nil;
    abb_marcas^.hd:=nil;
  end
  else
    if (registro_auto1.marca=abb_marcas^.ele.marca) then
      agregar_adelante_lista_autos1(abb_marcas^.ele.autos,registro_auto1)
    else if (registro_auto1.marca<abb_marcas^.ele.marca) then
      agregar_abb_marcas(abb_marcas^.hi,registro_auto1)
    else
      agregar_abb_marcas(abb_marcas^.hd,registro_auto1);
end;
procedure cargar_abbs(var abb_patentes: t_abb_patentes; var abb_marcas: t_abb_marcas);
var
  registro_auto1: t_registro_auto1;
begin
  leer_auto(registro_auto1);
  while (registro_auto1.marca<>marca_salida) do
  begin
    agregar_abb_patentes(abb_patentes,registro_auto1);
    agregar_abb_marcas(abb_marcas,registro_auto1);
    leer_auto(registro_auto1);
  end;
end;
procedure imprimir_registro_auto1(registro_auto1: t_registro_auto1);
begin
  textcolor(green); write('La patente del auto es '); textcolor(red); writeln(registro_auto1.patente);
  textcolor(green); write('El año de fabricación del auto es '); textcolor(red); writeln(registro_auto1.anio);
  textcolor(green); write('La marca del auto es '); textcolor(red); writeln(registro_auto1.marca);
  textcolor(green); write('El modelo del auto es '); textcolor(red); writeln(registro_auto1.modelo);
  writeln();
end;
procedure imprimir_abb_patentes(abb_patentes: t_abb_patentes);
begin
  if (abb_patentes<>nil) then
  begin
    imprimir_abb_patentes(abb_patentes^.hi);
    imprimir_registro_auto1(abb_patentes^.ele);
    imprimir_abb_patentes(abb_patentes^.hd);
  end;
end;
procedure imprimir_registro_auto2(registro_auto2: t_registro_auto2; marca: string; auto: int16);
begin
  textcolor(green); write('La patente del auto '); textcolor(yellow); write(auto); textcolor(green); write(' de la marca '); textcolor(yellow); write(marca); textcolor(green); write(' es '); textcolor(red); writeln(registro_auto2.patente);
  textcolor(green); write('El año de fabricación del auto '); textcolor(yellow); write(auto); textcolor(green); write(' de la marca '); textcolor(yellow); write(marca); textcolor(green); write(' es '); textcolor(red); writeln(registro_auto2.anio);
  textcolor(green); write('El modelo del auto '); textcolor(yellow); write(auto); textcolor(green); write(' de la marca '); textcolor(yellow); write(marca); textcolor(green); write(' es '); textcolor(red); writeln(registro_auto2.modelo);
end;
procedure imprimir_lista_autos1(lista_autos1: t_lista_autos1; marca: string);
var
  i: int16;
begin
  i:=0;
  while (lista_autos1<>nil) do
  begin
    i:=i+1;
    imprimir_registro_auto2(lista_autos1^.ele,marca,i);
    lista_autos1:=lista_autos1^.sig;
  end;
end;
procedure imprimir_registro_marca(registro_marca: t_registro_marca);
begin
  textcolor(green); write('La marca del auto es '); textcolor(red); writeln(registro_marca.marca);
  imprimir_lista_autos1(registro_marca.autos,registro_marca.marca);
  writeln();
end;
procedure imprimir_abb_marcas(abb_marcas: t_abb_marcas);
begin
  if (abb_marcas<>nil) then
  begin
    imprimir_abb_marcas(abb_marcas^.hi);
    imprimir_registro_marca(abb_marcas^.ele);
    imprimir_abb_marcas(abb_marcas^.hd);
  end;
end;
function contar_abb_patentes(abb_patentes: t_abb_patentes; marca: string): int8;
begin
  if (abb_patentes=nil) then
    contar_abb_patentes:=0
  else
    if (marca=abb_patentes^.ele.marca) then
      contar_abb_patentes:=contar_abb_patentes(abb_patentes^.hi,marca)+contar_abb_patentes(abb_patentes^.hd,marca)+1
    else
      contar_abb_patentes:=contar_abb_patentes(abb_patentes^.hi,marca)+contar_abb_patentes(abb_patentes^.hd,marca);
end;
function contar_autos(lista_autos1: t_lista_autos1): int8;
var
  autos: int8;
begin
  autos:=0;
  while (lista_autos1<>nil) do
  begin
    autos:=autos+1;
    lista_autos1:=lista_autos1^.sig;
  end;
  contar_autos:=autos;
end;
function contar_abb_marcas(abb_marcas: t_abb_marcas; marca: string): int8;
begin
  if (abb_marcas=nil) then
    contar_abb_marcas:=0
  else
    if (marca=abb_marcas^.ele.marca) then
      contar_abb_marcas:=contar_autos(abb_marcas^.ele.autos)
    else if (marca<abb_marcas^.ele.marca) then
      contar_abb_marcas:=contar_abb_marcas(abb_marcas^.hi,marca)
    else
      contar_abb_marcas:=contar_abb_marcas(abb_marcas^.hd,marca)
end;
procedure cargar_registro_auto3(var registro_auto3: t_registro_auto3; registro_auto1: t_registro_auto1);
begin
  registro_auto3.patente:=registro_auto1.patente;
  registro_auto3.marca:=registro_auto1.marca;
  registro_auto3.modelo:=registro_auto1.modelo;
end;
procedure agregar_adelante_lista_autos2(var lista_autos2: t_lista_autos2; registro_auto1: t_registro_auto1);
var
  nuevo: t_lista_autos2;
begin
  new(nuevo);
  cargar_registro_auto3(nuevo^.ele,registro_auto1);
  nuevo^.sig:=lista_autos2;
  lista_autos2:=nuevo;
end;
procedure cargar_vector_autos(var vector_autos: t_vector_autos; abb_patentes: t_abb_patentes);
begin
  if (abb_patentes<>nil) then
  begin
    cargar_vector_autos(vector_autos,abb_patentes^.hi);
    agregar_adelante_lista_autos2(vector_autos[abb_patentes^.ele.anio],abb_patentes^.ele);
    cargar_vector_autos(vector_autos,abb_patentes^.hd);
  end
end;
procedure imprimir_registro_auto3(registro_auto3: t_registro_auto3; anio: t_anio; auto: int16);
begin
  textcolor(green); write('La patente del auto '); textcolor(yellow); write(auto); textcolor(green); write(' del año de fabricación '); textcolor(yellow); write(anio); textcolor(green); write(' es '); textcolor(red); writeln(registro_auto3.patente);
  textcolor(green); write('La marca el auto '); textcolor(yellow); write(auto); textcolor(green); write(' del año de fabricación '); textcolor(yellow); write(anio); textcolor(green); write(' es '); textcolor(red); writeln(registro_auto3.marca);
  textcolor(green); write('El modelo del auto '); textcolor(yellow); write(auto); textcolor(green); write(' del año de fabricación '); textcolor(yellow); write(anio); textcolor(green); write(' es '); textcolor(red); writeln(registro_auto3.modelo);
end;
procedure imprimir_lista_autos2(lista_autos2: t_lista_autos2; anio: t_anio);
var
  i: int16;
begin
  i:=0;
  while (lista_autos2<>nil) do
  begin
    i:=i+1;
    imprimir_registro_auto3(lista_autos2^.ele,anio,i);
    lista_autos2:=lista_autos2^.sig;
  end;
end;
procedure imprimir_vector_autos(vector_autos: t_vector_autos);
var
  i: t_anio;
begin
  for i:= anio_ini to anio_fin do
  begin
    textcolor(green); write('La información de los autos del año de fabricación '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_lista_autos2(vector_autos[i],i);
    writeln();
  end;
end;
function buscar_abb_patentes(abb_patentes: t_abb_patentes; patente: string): string;
begin
  if (abb_patentes=nil) then
    buscar_abb_patentes:='No existe la patente'
  else
    if (patente=abb_patentes^.ele.patente) then
      buscar_abb_patentes:=abb_patentes^.ele.modelo
    else if (patente<abb_patentes^.ele.patente) then
      buscar_abb_patentes:=buscar_abb_patentes(abb_patentes^.hi,patente)
    else
      buscar_abb_patentes:=buscar_abb_patentes(abb_patentes^.hd,patente);
end;
function buscar_patente(lista_autos1: t_lista_autos1; patente: string): string;
begin
  while ((lista_autos1<>nil) and (lista_autos1^.ele.patente<>patente)) do
    lista_autos1:=lista_autos1^.sig;
  if (lista_autos1<>nil) then
    buscar_patente:=lista_autos1^.ele.modelo
  else
    buscar_patente:='No existe la patente';
end;
function buscar_abb_marcas(abb_marcas: t_abb_marcas; patente: string): string;
var
  modelo: string;
begin
  if (abb_marcas=nil) then
    buscar_abb_marcas:='No existe la patente'
  else
  begin
    modelo:=buscar_patente(abb_marcas^.ele.autos,patente);
    if (modelo='No existe la patente') then
      modelo:=buscar_abb_marcas(abb_marcas^.hi,patente);
    if (modelo='No existe la patente') then
      modelo:=buscar_abb_marcas(abb_marcas^.hd,patente);
    buscar_abb_marcas:=modelo;
  end;
end;
var
  vector_autos: t_vector_autos;
  abb_patentes: t_abb_patentes;
  abb_marcas: t_abb_marcas;
  marca, patente: string;
begin
  randomize;
  abb_patentes:=nil; abb_marcas:=nil;
  inicializar_vector_autos(vector_autos);
  writeln(); textcolor(red); writeln('INCISO (a)'); writeln();
  cargar_abbs(abb_patentes,abb_marcas);
  if ((abb_patentes<>nil) and (abb_marcas<>nil)) then
  begin
    writeln(); textcolor(red); writeln('ABB_PATENTES:'); writeln();
    imprimir_abb_patentes(abb_patentes);
    writeln(); textcolor(red); writeln('ABB_MARCAS:'); writeln();
    imprimir_abb_marcas(abb_marcas);
    writeln(); textcolor(red); writeln('INCISO (b)'); writeln();
    marca:='Marca '+random_string(1);
    textcolor(green); write('La cantidad de autos en el abb_patentes de la marca '); textcolor(yellow); write(marca); textcolor(green); write(' es '); textcolor(red); writeln(contar_abb_patentes(abb_patentes,marca));
    writeln(); textcolor(red); writeln('INCISO (c)'); writeln();
    textcolor(green); write('La cantidad de autos en el abb_marcas de la marca '); textcolor(yellow); write(marca); textcolor(green); write(' es '); textcolor(red); writeln(contar_abb_marcas(abb_marcas,marca));
    writeln(); textcolor(red); writeln('INCISO (d)'); writeln();
    cargar_vector_autos(vector_autos,abb_patentes);
    imprimir_vector_autos(vector_autos);
    writeln(); textcolor(red); writeln('INCISO (e)'); writeln();
    patente:=random_string(2);
    textcolor(green); write('El modelo del auto de la patente '); textcolor(yellow); write(patente); textcolor(green); write(' es '); textcolor(red); writeln(buscar_abb_patentes(abb_patentes,patente));
    writeln(); textcolor(red); writeln('INCISO (f)'); writeln();
    textcolor(green); write('El modelo del auto de la patente '); textcolor(yellow); write(patente); textcolor(green); write(' es '); textcolor(red); write(buscar_abb_marcas(abb_marcas,patente));
  end;
end.