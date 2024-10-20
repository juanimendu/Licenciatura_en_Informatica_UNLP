{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 1}
{Escribir un programa que:
(a) Implemente un módulo que lea información de socios de un club y las almacene en un árbol binario de búsqueda.
De cada socio, se lee número de socio, nombre y edad. La lectura finaliza con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
(b) Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetro y que:
  (i) Informe el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
  (ii) Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
  (iii) Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
  (iv) Aumente en 1 la edad de todos los socios.
  (v) Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
  (vi) Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
  (vii) Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
  (viii) Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso (vii) e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
  (ix) Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socio se encuentra entre los dos valores ingresados. Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha cantidad.
  (x) Informe los números de socio en orden creciente.
  (xi) Informe los números de socio pares en orden decreciente.}

program TP3_E1;
{$codepage UTF8}
uses crt;
const
  numero_salida=0;
type
  t_registro_socio=record
    numero: int16;
    nombre: string;
    edad: int8;
  end;
  t_abb_socios=^t_nodo_abb_socios;
  t_nodo_abb_socios=record
    ele: t_registro_socio;
    hi: t_abb_socios;
    hd: t_abb_socios;
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
procedure leer_socio(var registro_socio: t_registro_socio);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_socio.numero:=numero_salida
  else
    registro_socio.numero:=1+random(high(int16));
  if (registro_socio.numero<>numero_salida) then
  begin
    registro_socio.nombre:=random_string(5+random(6));
    registro_socio.edad:=1+random(high(int8)-1);
  end;
end;
procedure agregar_abb_socios(var abb_socios: t_abb_socios; registro_socio: t_registro_socio);
begin
  if (abb_socios=nil) then
  begin
    new(abb_socios);
    abb_socios^.ele:=registro_socio;
    abb_socios^.hi:=nil;
    abb_socios^.hd:=nil;
  end
  else
    if (registro_socio.numero<=abb_socios^.ele.numero) then
      agregar_abb_socios(abb_socios^.hi,registro_socio)
    else
      agregar_abb_socios(abb_socios^.hd,registro_socio);
end;
procedure cargar_abb_socios(var abb_socios: t_abb_socios);
var
  registro_socio: t_registro_socio;
begin
  leer_socio(registro_socio);
  while (registro_socio.numero<>numero_salida) do
  begin
    agregar_abb_socios(abb_socios,registro_socio);
    leer_socio(registro_socio);
  end;
end;
procedure imprimir_registro_socio(registro_socio: t_registro_socio);
begin
  textcolor(green); write('El número de socio del socio es '); textcolor(red); writeln(registro_socio.numero);
  textcolor(green); write('El nombre del socio es '); textcolor(red); writeln(registro_socio.nombre);
  textcolor(green); write('La edad del socio es '); textcolor(red); writeln(registro_socio.edad);
  writeln();
end;
procedure imprimir1_abb_socios(abb_socios: t_abb_socios);
begin
  if (abb_socios<>nil) then
  begin
    imprimir1_abb_socios(abb_socios^.hi);
    imprimir_registro_socio(abb_socios^.ele);
    imprimir1_abb_socios(abb_socios^.hd);
  end;
end;
function buscar_mayor_numero(abb_socios: t_abb_socios): int16;
begin
  if (abb_socios^.hd=nil) then
    buscar_mayor_numero:=abb_socios^.ele.numero
  else
    buscar_mayor_numero:=buscar_mayor_numero(abb_socios^.hd);
end;
function buscar_menor_numero(abb_socios: t_abb_socios): int16;
begin
  if (abb_socios^.hi=nil) then
    buscar_menor_numero:=abb_socios^.ele.numero
  else
    buscar_menor_numero:=buscar_menor_numero(abb_socios^.hi);
end;
procedure buscar_numero_mayor_edad(abb_socios: t_abb_socios; var edad_max: int8; var numero_max: int16);
begin
  if (abb_socios<>nil) then
  begin
    buscar_numero_mayor_edad(abb_socios^.hi,edad_max,numero_max);
    if (abb_socios^.ele.edad>edad_max) then
    begin
      edad_max:=abb_socios^.ele.edad;
      numero_max:=abb_socios^.ele.numero;
    end;
    buscar_numero_mayor_edad(abb_socios^.hd,edad_max,numero_max);
  end;
end;
procedure aumentar_edad(var abb_socios: t_abb_socios);
begin
  if (abb_socios<>nil) then
  begin
    aumentar_edad(abb_socios^.hi);
    abb_socios^.ele.edad:=abb_socios^.ele.edad+1;
    aumentar_edad(abb_socios^.hd);
  end;
end;
function buscar_numero(abb_socios: t_abb_socios; numero: int16): boolean;
begin
  if (abb_socios=nil) then
    buscar_numero:=false
  else
    if (numero=abb_socios^.ele.numero) then
      buscar_numero:=true
    else if (numero<abb_socios^.ele.numero) then
      buscar_numero:=buscar_numero(abb_socios^.hi,numero)
    else
      buscar_numero:=buscar_numero(abb_socios^.hd,numero);
end;
function buscar_nombre(abb_socios: t_abb_socios; nombre: string): boolean;
begin
  if (abb_socios=nil) then
    buscar_nombre:=false
  else
    if (nombre=abb_socios^.ele.nombre) then
      buscar_nombre:=true
    else
      buscar_nombre:=buscar_nombre(abb_socios^.hi,nombre) or buscar_nombre(abb_socios^.hd,nombre);
end;
function contar_socios1(abb_socios: t_abb_socios): int16;
begin
  if (abb_socios=nil) then
    contar_socios1:=0
  else
    contar_socios1:=contar_socios1(abb_socios^.hi)+contar_socios1(abb_socios^.hd)+1;
end;
function contar_edades(abb_socios: t_abb_socios): int16;
begin
  if (abb_socios=nil) then
    contar_edades:=0
  else
    contar_edades:=contar_edades(abb_socios^.hi)+contar_edades(abb_socios^.hd)+abb_socios^.ele.edad;
end;
function calcular_edad_promedio(abb_socios: t_abb_socios): real;
begin
  calcular_edad_promedio:=contar_edades(abb_socios)/contar_socios1(abb_socios);
end;
procedure verificar_numeros(var numero1, numero2: int16);
var
  aux: int8;
begin
  if (numero1>numero2) then
  begin
    aux:=numero1;
    numero1:=numero2;
    numero2:=aux;
  end;
end;
function contar_socios2(abb_socios: t_abb_socios; numero1, numero2: int16): int16;
begin
  if (abb_socios=nil) then
    contar_socios2:=0
  else
    if (numero1>=abb_socios^.ele.numero) then
      contar_socios2:=contar_socios2(abb_socios^.hd,numero1,numero2)
    else if (numero2<=abb_socios^.ele.numero) then
      contar_socios2:=contar_socios2(abb_socios^.hi,numero1,numero2)
    else
      contar_socios2:=contar_socios2(abb_socios^.hi,numero1,numero2)+contar_socios2(abb_socios^.hd,numero1,numero2)+1;
end;
procedure imprimir2_abb_socios(abb_socios: t_abb_socios);
begin
  if (abb_socios<>nil) then
  begin
    imprimir2_abb_socios(abb_socios^.hi);
    textcolor(green); write('Número de socio: '); textcolor(red); writeln(abb_socios^.ele.numero);
    imprimir2_abb_socios(abb_socios^.hd);
  end;
end;
procedure imprimir3_abb_socios(abb_socios: t_abb_socios);
begin
  if (abb_socios<>nil) then
  begin
    imprimir3_abb_socios(abb_socios^.hd);
    if (abb_socios^.ele.numero mod 2=0) then
    begin
      textcolor(green); write('Número de socio: '); textcolor(red); writeln(abb_socios^.ele.numero);
    end;
    imprimir3_abb_socios(abb_socios^.hi);
  end;
end;
var
  abb_socios: t_abb_socios;
  edad_max: int8;
  numero_max, numero, numero1, numero2: int16;
  nombre: string;
begin
  randomize;
  abb_socios:=nil;
  edad_max:=low(int8); numero_max:=numero_salida;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_abb_socios(abb_socios);
  if (abb_socios<>nil) then
  begin
    imprimir1_abb_socios(abb_socios);
    writeln(); textcolor(red); writeln('INCISO (b.i):'); writeln();
    textcolor(green); write('El número de socio más grande es '); textcolor(red); writeln(buscar_mayor_numero(abb_socios));
    writeln(); textcolor(red); writeln('INCISO (b.ii):'); writeln();
    textcolor(green); write('El número de socio más chico es '); textcolor(red); writeln(buscar_menor_numero(abb_socios));
    writeln(); textcolor(red); writeln('INCISO (b.iii):'); writeln();
    buscar_numero_mayor_edad(abb_socios,edad_max,numero_max);
    textcolor(green); write('El número de socio con mayor edad es '); textcolor(red); writeln(numero_max);
    writeln(); textcolor(red); writeln('INCISO (b.iv):'); writeln();
    aumentar_edad(abb_socios);
    imprimir1_abb_socios(abb_socios);
    writeln(); textcolor(red); writeln('INCISO (b.v):'); writeln();
    numero:=1+random(high(int16));
    textcolor(green); write('¿El número de socio '); textcolor(yellow); write(numero); textcolor(green); write(' se encuentra en el abb?: '); textcolor(red); writeln(buscar_numero(abb_socios,numero));
    writeln(); textcolor(red); writeln('INCISO (b.vi):'); writeln();
    nombre:=random_string(5+random(6));
    textcolor(green); write('¿El nombre de socio '); textcolor(yellow); write(nombre); textcolor(green); write(' se encuentra en el abb?: '); textcolor(red); writeln(buscar_nombre(abb_socios,nombre));
    writeln(); textcolor(red); writeln('INCISO (b.vii):'); writeln();
    textcolor(green); write('La cantidad de socios es '); textcolor(red); writeln(contar_socios1(abb_socios));
    writeln(); textcolor(red); writeln('INCISO (b.viii):'); writeln();
    textcolor(green); write('El promedio de edad de los socios es '); textcolor(red); writeln(calcular_edad_promedio(abb_socios):0:2);
    writeln(); textcolor(red); writeln('INCISO (b.ix):'); writeln();
    numero1:=1+random(high(int16)); numero2:=1+random(high(int16));
    verificar_numeros(numero1,numero2);
    textcolor(green); write('La cantidad de socios en el abb cuyo número de socio se encuentra entre '); textcolor(yellow); write(numero1); textcolor(green); write(' y '); textcolor(yellow); write(numero2); textcolor(green); write(' es '); textcolor(red); writeln(contar_socios2(abb_socios,numero1,numero2));
    writeln(); textcolor(red); writeln('INCISO (b.x):'); writeln();
    imprimir2_abb_socios(abb_socios);
    writeln(); textcolor(red); writeln('INCISO (b.xi):'); writeln();
    imprimir3_abb_socios(abb_socios);
  end;
end.