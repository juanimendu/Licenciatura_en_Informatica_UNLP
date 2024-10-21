{TRABAJO PRÁCTICO N° 0}
{EJERCICIO 2}
{Implementar un programa que procese información de propiedades que están a la venta en una inmobiliaria.
(a) Implementar un módulo para almacenar, en una estructura adecuada, las propiedades agrupadas por zona.
Las propiedades de una misma zona deben quedar almacenadas ordenadas por tipo de propiedad.
Para cada propiedad, debe almacenarse el código, el tipo de propiedad y el precio total.
De cada propiedad, se lee: zona (1 a 5), código de propiedad, tipo de propiedad, cantidad de metros cuadrados y precio del metro cuadrado.
La lectura finaliza cuando se ingresa el precio del metro cuadrado -1.
(b) Implementar un módulo que reciba la estructura generada en (a), un número de zona y un tipo de propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido.}

program TP0_E2;
{$codepage UTF8}
uses crt;
const
  zona_ini=1; zona_fin=5;
  tipo_ini=1; tipo_fin=3;
  preciom2_salida=-1.0;
type
  t_zona=zona_ini..zona_fin;
  t_tipo=tipo_ini..tipo_fin;
  t_registro_propiedad1=record
    zona: t_zona;
    codigo: int16;
    tipo: t_tipo;
    m2: real;
    preciom2: real;
  end;  
  t_registro_propiedad2=record
    codigo: int16;
    tipo: t_tipo;
    precio_total: real;
  end;
  t_lista_propiedades1=^t_nodo_propiedades1;
  t_nodo_propiedades1=record
    ele: t_registro_propiedad2;
    sig: t_lista_propiedades1;
  end;
  t_lista_propiedades2=^t_nodo_propiedades2;
  t_nodo_propiedades2=record
    ele: int16;
    sig: t_lista_propiedades2;
  end;
  t_vector_propiedades=array[t_zona] of t_lista_propiedades1;
procedure inicializar_vector_propiedades(var vector_propiedades: t_vector_propiedades);
var
  i: t_zona;
begin
  for i:= zona_ini to zona_fin do
    vector_propiedades[i]:=nil;
end;
procedure leer_propiedad(var registro_propiedad1: t_registro_propiedad1);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_propiedad1.preciom2:=preciom2_salida
  else
    registro_propiedad1.preciom2:=1+random(100);
  if (registro_propiedad1.preciom2<>preciom2_salida) then
  begin
    registro_propiedad1.zona:=zona_ini+random(zona_fin);
    registro_propiedad1.codigo:=1+random(high(int16));
    registro_propiedad1.tipo:=tipo_ini+random(tipo_fin);
    registro_propiedad1.m2:=1+random(100);
  end;
end;
procedure cargar_registro_propiedad2(var registro_propiedad2: t_registro_propiedad2; registro_propiedad1: t_registro_propiedad1);
begin
  registro_propiedad2.codigo:=registro_propiedad1.codigo;
  registro_propiedad2.tipo:=registro_propiedad1.tipo;
  registro_propiedad2.precio_total:=registro_propiedad1.m2*registro_propiedad1.preciom2;
end;
procedure agregar_ordenado_lista_propiedades1(var lista_propiedades1: t_lista_propiedades1; registro_propiedad1: t_registro_propiedad1);
var
  anterior, actual, nuevo: t_lista_propiedades1;
begin
  new(nuevo);
  cargar_registro_propiedad2(nuevo^.ele,registro_propiedad1);
  anterior:=lista_propiedades1; actual:=lista_propiedades1;
  while ((actual<>nil) and (actual^.ele.tipo<nuevo^.ele.tipo)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_propiedades1) then
    lista_propiedades1:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure cargar_vector_propiedades(var vector_propiedades: t_vector_propiedades);
var
  registro_propiedad1: t_registro_propiedad1;
begin
  leer_propiedad(registro_propiedad1);
  while (registro_propiedad1.preciom2<>preciom2_salida) do
  begin
    agregar_ordenado_lista_propiedades1(vector_propiedades[registro_propiedad1.zona],registro_propiedad1);
    leer_propiedad(registro_propiedad1);
  end;
end;
procedure imprimir_registro_propiedad2(registro_propiedad2: t_registro_propiedad2; zona: t_zona; propiedad: int16);
begin
  textcolor(green); write('El código de la propiedad '); textcolor(yellow); write(propiedad); textcolor(green); write(' de la zona '); textcolor(yellow); write(zona); textcolor(green); write(' es '); textcolor(red); writeln(registro_propiedad2.codigo);
  textcolor(green); write('El tipo de la propiedad '); textcolor(yellow); write(propiedad); textcolor(green); write(' de la zona '); textcolor(yellow); write(zona); textcolor(green); write(' es '); textcolor(red); writeln(registro_propiedad2.tipo);
  textcolor(green); write('El precio total de la propiedad '); textcolor(yellow); write(propiedad); textcolor(green); write(' de la zona '); textcolor(yellow); write(zona); textcolor(green); write(' es '); textcolor(red); writeln(registro_propiedad2.precio_total:0:2);
end;
procedure imprimir_lista_propiedades1(lista_propiedades1: t_lista_propiedades1; zona: t_zona);
var
  i: int16;
begin
  i:=0;
  while (lista_propiedades1<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('La información de la propiedad '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_propiedad2(lista_propiedades1^.ele,zona,i);
    writeln();
    lista_propiedades1:=lista_propiedades1^.sig;
  end;
end;
procedure imprimir_vector_propiedades(vector_propiedades: t_vector_propiedades);
var
  i: t_zona;
begin
  for i:= zona_ini to zona_fin do
    imprimir_lista_propiedades1(vector_propiedades[i],i);
end;
procedure agregar_adelante_lista_propiedades2(var lista_propiedades2: t_lista_propiedades2; codigo: int16);
var
  nuevo: t_lista_propiedades2;
begin
  new(nuevo);
  nuevo^.ele:=codigo;
  nuevo^.sig:=lista_propiedades2;
  lista_propiedades2:=nuevo;
end;
procedure cargar_lista_propiedades2(var lista_propiedades2: t_lista_propiedades2; vector_propiedades: t_vector_propiedades; zona: t_zona; tipo: t_tipo);
begin
  while ((vector_propiedades[zona]<>nil) and (vector_propiedades[zona]^.ele.tipo<=tipo)) do
  begin
    if (vector_propiedades[zona]^.ele.tipo=tipo) then
      agregar_adelante_lista_propiedades2(lista_propiedades2,vector_propiedades[zona]^.ele.codigo);
    vector_propiedades[zona]:=vector_propiedades[zona]^.sig;
  end;
end;
procedure imprimir_lista_propiedades2(lista_propiedades2: t_lista_propiedades2);
var
  i: int16;
begin
  i:=0;
  while (lista_propiedades2<>nil) do
  begin
    i:=i+1;
    textcolor(green); write('El código de la propiedad '); textcolor(yellow); write(i); textcolor(green); write(' es '); textcolor(red); writeln(lista_propiedades2^.ele);
    lista_propiedades2:=lista_propiedades2^.sig;
  end;
end;
var
  vector_propiedades: t_vector_propiedades;
  lista_propiedades2: t_lista_propiedades2;
  zona: t_zona;
  tipo: t_tipo;
begin
  randomize;
  inicializar_vector_propiedades(vector_propiedades);
  lista_propiedades2:=nil;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_propiedades(vector_propiedades);
  imprimir_vector_propiedades(vector_propiedades);
  writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
  zona:=zona_ini+random(zona_fin);
  tipo:=tipo_ini+random(tipo_fin);
  cargar_lista_propiedades2(lista_propiedades2,vector_propiedades,zona,tipo);
  if (lista_propiedades2<>nil) then
    imprimir_lista_propiedades2(lista_propiedades2);
end.