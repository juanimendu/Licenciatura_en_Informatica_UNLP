{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 11}
{El colectivo de fotógrafos ArgenPics desea conocer los gustos de sus seguidores en las redes sociales.
Para ello, para cada una de las 200 fotos publicadas en su página de Facebook, cuenta con la siguiente información:
título de la foto, el autor de la foto, cantidad de Me gusta, cantidad de clics y cantidad de comentarios de usuarios.
Realizar un programa que lea y almacene esta información.
Una vez finalizada la lectura, el programa debe procesar los datos e informar:
•	Título de la foto más vista (la que posee mayor cantidad de clics).
•	Cantidad total de Me gusta recibidos a las fotos cuyo autor es el fotógrafo "Art Vandelay".
•	Cantidad de comentarios recibidos para cada una de las fotos publicadas en esa página.}

program TP4_E11;
{$codepage UTF8}
uses crt;
const
  fotos_total=200;
  autor_corte='Art Vandelay';
type
  t_foto=1..fotos_total;
  t_registro_foto=record
    titulo: string;
    autor: string;
    megusta: int16;
    clics: int16;
    comentarios: int16;
  end;
  t_vector_fotos=array[t_foto] of t_registro_foto;
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
procedure leer_foto(var registro_foto: t_registro_foto);
var
  i: int8;
begin
  registro_foto.titulo:=random_string(5+random(6));
  i:=random(10);
  if (i=0) then
    registro_foto.autor:=autor_corte
  else
    registro_foto.autor:=random_string(5+random(6));
  registro_foto.megusta:=random(10001);
  registro_foto.clics:=random(10001);
  registro_foto.comentarios:=random(10001);
end;
procedure cargar_vector_fotos(var vector_fotos: t_vector_fotos);
var
  registro_foto: t_registro_foto;
  i: t_foto;
begin
  for i:= 1 to fotos_total do
  begin
    leer_foto(registro_foto);
    vector_fotos[i]:=registro_foto;
  end;
end;
procedure actualizar_maximo(clics: int16; titulo: string; var clics_max: int16; var titulo_max: string);
begin
  if (clics>clics_max) then
  begin
    clics_max:=clics;
    titulo_max:=titulo;
  end;
end;
procedure procesar_vector_fotos(vector_fotos: t_vector_fotos; var titulo_max: string; var megusta_corte: int16);
var
  i: t_foto;
  clics_max: int16;
begin
  clics_max:=low(int16);
  for i:= 1 to fotos_total do
  begin
    actualizar_maximo(vector_fotos[i].clics,vector_fotos[i].titulo,clics_max,titulo_max);
    if (vector_fotos[i].autor=autor_corte) then
      megusta_corte:=megusta_corte+1;
    textcolor(green); write('La cantidad de comentarios recibidos de la foto '); textcolor(red); write(vector_fotos[i].titulo); textcolor(green); write(' es '); textcolor(red); writeln(vector_fotos[i].comentarios);
  end;
end;
var
  vector_fotos: t_vector_fotos;
  megusta_corte: int16;
  titulo_max: string;
begin
  randomize;
  titulo_max:='';
  megusta_corte:=0;
  cargar_vector_fotos(vector_fotos);
  procesar_vector_fotos(vector_fotos,titulo_max,megusta_corte);
  textcolor(green); write('El título de la foto más vista (la que posee mayor cantidad de clics) es '); textcolor(red); writeln(titulo_max);
  textcolor(green); write('La cantidad total de Me gusta recibidas a las fotos cuyo autor es el fotógrafo "'); textcolor(yellow); write(autor_corte); textcolor(green); write('" es '); textcolor(red); write(megusta_corte);
end.