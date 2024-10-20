{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 4}
{Se dispone de un vector con 100 números enteros.
Implementar los siguientes módulos:
(a)	posicion: dado un número X y el vector de números, retorna la posición del número X en dicho vector o el valor -1 en caso de no encontrarse.
(b)	intercambio: recibe dos valores x e y (entre 1 y 100) y el vector de números y retorna el mismo vector, donde se intercambiaron los valores de las posiciones x e y.
(c)	sumaVector: retorna la suma de todos los elementos del vector.
(d)	promedio: devuelve el valor promedio de los elementos del vector.
(e)	elementoMaximo: retorna la posición del mayor elemento del vector.
(f)	elementoMinimo: retorna la posicion del menor elemento del vector.}

program TP4_E4;
{$codepage UTF8}
uses crt;
const
  num_total=100;
type
  t_numero=1..num_total;
  t_vector_numeros=array[t_numero] of int16;
procedure cargar_vector_numeros(var vector_numeros: t_vector_numeros);
var
  i: t_numero;
begin
  for i:= 1 to num_total do
    vector_numeros[i]:=1+random(200);
end;
function posicion(vector_numeros: t_vector_numeros; numX: int16): int16;
var
  pos: int16;
begin
  pos:=1;
  while ((pos<=num_total) and (vector_numeros[pos]<>numX)) do
    pos:=pos+1;
  if (pos<=num_total) then
    posicion:=pos
  else
    posicion:=-1;
end;
procedure intercambio(var vector_numeros: t_vector_numeros; numX, numY: int16);
var
  num_aux: int16;
begin
  num_aux:=vector_numeros[numX];
  vector_numeros[numX]:=vector_numeros[numY];
  vector_numeros[numY]:=num_aux;
end;
function sumaVector(vector_numeros: t_vector_numeros): int16;
var
  i: t_numero;
  suma: int16;
begin
  suma:=0;
  for i:= 1 to num_total do
    suma:=suma+vector_numeros[i];
  sumaVector:=suma;
end;
function promedio(vector_numeros: t_vector_numeros): real;
begin
  promedio:=sumaVector(vector_numeros)/num_total;
end;
function elementoMaximo(vector_numeros: t_vector_numeros): int16;
var
  i: t_numero;
  ele_max, pos_max: int16;
begin
  ele_max:=low(int16); pos_max:=0;
  for i:= 1 to num_total do
    if (vector_numeros[i]>ele_max) then
    begin
      ele_max:=vector_numeros[i];
      pos_max:=i;
    end;
  elementoMaximo:=pos_max;
end;
function elementoMinimo(vector_numeros: t_vector_numeros): int16;
var
  i: t_numero;
  ele_min, pos_min: int16;
begin
  ele_min:=high(int16); pos_min:=0;
  for i:= 1 to num_total do
    if (vector_numeros[i]<ele_min) then
    begin
      ele_min:=vector_numeros[i];
      pos_min:=i;
    end;
  elementoMinimo:=pos_min;
end;
var
  vector_numeros: t_vector_numeros;
  numX, posX, posY: int16;
begin
  randomize;
  cargar_vector_numeros(vector_numeros);
  numX:=1+random(200);
  textcolor(green); write('La posición del número '); textcolor(red); write(numX); textcolor(green); write(' en el vector es '); textcolor(red); writeln(posicion(vector_numeros,numX));
  posX:=1+random(100);
  posY:=1+random(100);
  textcolor(green); write('Pre-intercambio, en las posiciones '); textcolor(red); write(posX); textcolor(green); write(' y '); textcolor(red); write(posY); textcolor(green); write(', se tienen los valores '); textcolor(red); write(vector_numeros[posX]); textcolor(green); write(' y '); textcolor(red); write(vector_numeros[posY]); textcolor(green); writeln(', respectivamente');
  intercambio(vector_numeros,posX,posY);
  textcolor(green); write('Post-intercambio, en las posiciones '); textcolor(red); write(posX); textcolor(green); write(' y '); textcolor(red); write(posY); textcolor(green); write(', se tienen los valores '); textcolor(red); write(vector_numeros[posX]); textcolor(green); write(' y '); textcolor(red); write(vector_numeros[posY]); textcolor(green); writeln(', respectivamente');
  textcolor(green); write('La suma de todos los elementos del vector es '); textcolor(red); writeln(sumaVector(vector_numeros));
  textcolor(green); write('El valor promedio de los elementos del vector es '); textcolor(red); writeln(promedio(vector_numeros):0:2);
  textcolor(green); write('La posición del mayor elemento del vector es '); textcolor(red); writeln(elementoMaximo(vector_numeros));
  textcolor(green); write('La posición del menor elemento del vector es '); textcolor(red); write(elementoMinimo(vector_numeros));
end.