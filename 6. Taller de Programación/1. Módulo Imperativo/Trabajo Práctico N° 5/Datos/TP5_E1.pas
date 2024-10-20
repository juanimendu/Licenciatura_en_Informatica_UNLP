{TRABAJO PRÁCTICO N° 5}
{EJERCICIO 1}
{El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. Implementar un programa con:
(a) Un módulo que retorne un vector, sin orden, con, a lo sumo, las 300 oficinas que administra.
Se debe leer, para cada oficina, el código de identificación, DNI del propietario y valor de la expensa.
La lectura finaliza cuando llega el código de identificación -1.
(b) Un módulo que reciba el vector retornado en (a) y retorne dicho vector ordenado por código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos vistos en la cursada.
(c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector generado en (b) y un código de identificación de oficina.
En el caso de encontrarlo, debe retornar la posición del vector donde se encuentra y, en caso contrario, debe retornar 0.
Luego, el programa debe informar el DNI del propietario o un cartel indicando que no se encontró la oficina.
(d) Un módulo recursivo que retorne el monto total de las expensas.}

program TP5_E1;
{$codepage UTF8}
uses crt;
const
  oficinas_total=300;
  codigo_salida=-1;
type
  t_oficina=1..oficinas_total;
  t_registro_oficina=record
    codigo: int16;
    dni: int32;
    expensa: real;
  end;
  t_vector_oficinas=array[t_oficina] of t_registro_oficina;
procedure leer_oficina(var registro_oficina: t_registro_oficina);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_oficina.codigo:=codigo_salida
  else
    registro_oficina.codigo:=random(high(int16));
  if (registro_oficina.codigo<>codigo_salida) then
  begin
    registro_oficina.dni:=10000000+random(40000001);
    registro_oficina.expensa:=1+random(100);
  end;
end;
procedure cargar_vector_oficinas(var vector_oficinas: t_vector_oficinas; var oficinas: int16);
var
  registro_oficina: t_registro_oficina;
begin
  leer_oficina(registro_oficina);
  while ((registro_oficina.codigo<>codigo_salida) and (oficinas<oficinas_total)) do
  begin
    oficinas:=oficinas+1;
    vector_oficinas[oficinas]:=registro_oficina;
    leer_oficina(registro_oficina);
  end;
end;
procedure imprimir_registro_oficina(registro_oficina: t_registro_oficina; oficina: t_oficina);
begin
  textcolor(green); write('El código de identificación de la oficina '); textcolor(yellow); write(oficina); textcolor(green); write(' es '); textcolor(red); writeln(registro_oficina.codigo);
  textcolor(green); write('El DNI del propietario de la oficina '); textcolor(yellow); write(oficina); textcolor(green); write(' es '); textcolor(red); writeln(registro_oficina.dni);
  textcolor(green); write('El valor de la expensa de la oficina '); textcolor(yellow); write(oficina); textcolor(green); write(' es $'); textcolor(red); writeln(registro_oficina.expensa:0:2);
end;
procedure imprimir_vector_oficinas(vector_oficinas: t_vector_oficinas; oficinas: int16);
var
  i: t_oficina;
begin
  for i:= 1 to oficinas do
  begin
    textcolor(green); write('La información de la oficina '); textcolor(yellow); write(i); textcolor(green); writeln(' es:');
    imprimir_registro_oficina(vector_oficinas[i],i);
    writeln();
  end;
end;
procedure ordenar_vector_oficinas(var vector_oficinas: t_vector_oficinas; oficinas: int16);
var
  item: t_registro_oficina;
  i, j, k: t_oficina;
begin
  for i:= 1 to (oficinas-1) do
  begin
    k:=i;
    for j:= (i+1) to oficinas do
      if (vector_oficinas[j].codigo<vector_oficinas[k].codigo) then
        k:=j;
    item:=vector_oficinas[k];
    vector_oficinas[k]:=vector_oficinas[i];
    vector_oficinas[i]:=item;
  end;
end;
function buscar_vector_oficinas(vector_oficinas: t_vector_oficinas; codigo, pri, ult: int16): int16;
var 
  medio: int8;
begin 
  if (pri<=ult) then
  begin
    medio:=(pri+ult) div 2;
    if (codigo=vector_oficinas[medio].codigo) then
      buscar_vector_oficinas:=medio
    else if (codigo<vector_oficinas[medio].codigo) then
      buscar_vector_oficinas:=buscar_vector_oficinas(vector_oficinas,codigo,pri,medio-1)
    else
      buscar_vector_oficinas:=buscar_vector_oficinas(vector_oficinas,codigo,medio+1,ult)
  end
  else
    buscar_vector_oficinas:=0;
end;
function sumar_vector_oficinas(vector_oficinas: t_vector_oficinas; oficinas: int16): real;
begin
  if (oficinas=1) then
    sumar_vector_oficinas:=vector_oficinas[oficinas].expensa
  else
    sumar_vector_oficinas:=sumar_vector_oficinas(vector_oficinas,oficinas-1)+vector_oficinas[oficinas].expensa;
end;
var
  vector_oficinas: t_vector_oficinas;
  oficinas, codigo, pri, ult, pos: int16;
begin
  randomize;
  oficinas:=0;
  writeln(); textcolor(red); writeln('INCISO (a):'); writeln();
  cargar_vector_oficinas(vector_oficinas,oficinas);
  if (oficinas>0) then
  begin
    imprimir_vector_oficinas(vector_oficinas,oficinas);
    writeln(); textcolor(red); writeln('INCISO (b):'); writeln();
    ordenar_vector_oficinas(vector_oficinas,oficinas);
    imprimir_vector_oficinas(vector_oficinas,oficinas);
    writeln(); textcolor(red); writeln('INCISO (c):'); writeln();
    codigo:=1+random(high(int16));
    pri:=1; ult:=oficinas;
    pos:=buscar_vector_oficinas(vector_oficinas,codigo,pri,ult);
    if (pos<>0) then
    begin
      textcolor(green); write('El código de identificación de oficina '); textcolor(yellow); write(codigo); textcolor(green); write(' se encontró en el vector, en la posición '); textcolor(red); writeln(pos);
      textcolor(green); write('El DNI del propietario de la oficina con código de identificación '); textcolor(yellow); write(codigo); textcolor(green); write(' es '); textcolor(red); writeln(vector_oficinas[pos].dni);
    end
    else
    begin
      textcolor(green); write('El código de identificación de oficina '); textcolor(yellow); write(codigo); textcolor(green); writeln(' no se encontró en el vector');
    end;
    writeln(); textcolor(red); writeln('INCISO (d):'); writeln();
    textcolor(green); write('El monto total de las expensas es $'); textcolor(red); write(sumar_vector_oficinas(vector_oficinas,oficinas):0:2);
  end;
end.