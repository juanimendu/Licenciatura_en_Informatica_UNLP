{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 2}
{Dado el siguiente programa, completar las líneas indicadas, considerando que:
•	El módulo cargarVector debe leer números reales y almacenarlos en el vector que se pasa como parámetro.
Al finalizar, debe retornar el vector y su dimensión lógica. La lectura finaliza cuando se ingresa el valor 0 (que no debe procesarse) o cuando el vector está completo.
•	El módulo modificarVectorySumar debe devolver el vector con todos sus elementos incrementados con el valor n y también debe devolver la suma de todos los elementos del vector.}

program TP4_E2;
{$codepage UTF8}
uses crt;
const
  cant_datos=150;
  num_salida=0;
type
  vdatos=array[1..cant_datos] of real;
procedure cargarVector(var v: vdatos; var dimL: integer);
var
  num: real;
begin
  num:=num_salida+random(101)/10;
  while ((num<>num_salida) and (dimL<cant_datos)) do
  begin
    dimL:=dimL+1;
    v[dimL]:=num;
    num:=num_salida+random(101)/10;
  end;
end;
procedure modificarVectorySumar(var v: vdatos; dimL: integer; n: real; var suma: real);
var
  i: int16;
begin
  for i:= 1 to dimL do
  begin
    v[i]:=v[i]+n;
    suma:=suma+v[i];
  end;
end;
var
  datos: vdatos;
  dim: integer;
  num, suma: real;
begin
  randomize;
  dim:=0; suma:=0;
  cargarVector(datos,dim);
  num:=1+random(10);
  modificarVectorySumar(datos,dim,num,suma);
  textcolor(green); write('La suma de los valores es '); textcolor(red); writeln(suma:0:2);
  textcolor(green); write('Se procesaron '); textcolor(red); write(dim); textcolor(green); write(' números');
end.