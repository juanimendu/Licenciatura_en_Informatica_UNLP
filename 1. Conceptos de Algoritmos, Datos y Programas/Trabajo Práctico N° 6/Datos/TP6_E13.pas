{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 13}
{El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte de los usuarios.
Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal.
De cada usuario, se conoce su nombre, su email, su rol (1. Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que participa y cantidad de días desde el último acceso.
•	Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios de la revista Económica.
El listado debe ordenarse a partir de la cantidad de días desde el último acceso (orden ascendente).
•	Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
•	Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.}

program TP6_E13;
{$codepage UTF8}
uses crt;
const
  usuarios_total=3600;
  rol_ini=1; rol_fin=4;
  revista_corte='Economica';
type
  t_usuario=1..usuarios_total;
  t_rol=rol_ini..rol_fin;
  t_registro_usuario=record
    nombre: string;
    email: string;
    rol: t_rol;
    revista: string;
    dias: int16;
  end;
  t_vector_usuarios=array[t_usuario] of t_registro_usuario;
  t_vector_roles=array[t_rol] of int16;
  t_lista_usuarios=^t_nodo_usuarios;
  t_nodo_usuarios=record
    ele: t_registro_usuario;
    sig: t_lista_usuarios;
  end;
procedure inicializar_vector_roles(var vector_roles: t_vector_roles);
var
  i: t_rol;
begin
  for i:= rol_ini to rol_fin do
    vector_roles[i]:=0;
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
procedure leer_usuario(var registro_usuario: t_registro_usuario);
var
  vector_emails: array[1..3] of string=('@gmail.com', '@hotmail.com', '@yahoo.com');
  i: int8;
begin
  registro_usuario.nombre:=random_string(5+random(6));
  registro_usuario.email:=random_string(5+random(6))+vector_emails[1+random(3)];
  registro_usuario.rol:=rol_ini+random(rol_fin);
  i:=random(100);
  if (i=0) then
    registro_usuario.revista:=revista_corte
  else
    registro_usuario.revista:=random_string(5+random(6));
  registro_usuario.dias:=1+random(high(int16));
end;
procedure cargar_vector_usuarios(var vector_usuarios: t_vector_usuarios);
var
  i: t_usuario;
  registro_usuario: t_registro_usuario;
begin
  for i:= 1 to usuarios_total do
  begin
    leer_usuario(registro_usuario);
    vector_usuarios[i]:=registro_usuario;
  end;
end;
procedure agregar_ordenado_lista_usuarios(var lista_usuarios: t_lista_usuarios; registro_usuario: t_registro_usuario);
var
  anterior, actual, nuevo: t_lista_usuarios;
begin
  new(nuevo);
  nuevo^.ele:=registro_usuario;
  anterior:=lista_usuarios; actual:=lista_usuarios;
  while ((actual<>nil) and (actual^.ele.dias<nuevo^.ele.dias)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual=lista_usuarios) then
    lista_usuarios:=nuevo
  else
    anterior^.sig:=nuevo;
  nuevo^.sig:=actual;
end;
procedure actualizar_maximos(dias: int16; email: string; var dias_max1, dias_max2: int16; var email_max1, email_max2: string);
begin
  if (dias>dias_max1) then
  begin
    dias_max2:=dias_max1;
    email_max2:=email_max1;
    dias_max1:=dias;
    email_max1:=email;
  end
  else
    if (dias>dias_max2) then
    begin
      dias_max2:=dias;
      email_max2:=email;
    end;
end;
procedure procesar_vector_usuarios(vector_usuarios: t_vector_usuarios; var lista_usuarios: t_lista_usuarios; var vector_roles: t_vector_roles; var email_max1, email_max2: string);
var
  i: t_usuario;
  dias_max1, dias_max2: int16;
begin
  dias_max1:=low(int16); dias_max2:=low(int16);
  for i:= 1 to usuarios_total do
  begin
    if (vector_usuarios[i].revista=revista_corte) then
      agregar_ordenado_lista_usuarios(lista_usuarios,vector_usuarios[i]);
    vector_roles[vector_usuarios[i].rol]:=vector_roles[vector_usuarios[i].rol]+1;
    actualizar_maximos(vector_usuarios[i].dias,vector_usuarios[i].email,dias_max1,dias_max2,email_max1,email_max2);
  end;
end;
procedure imprimir_lista_usuarios(lista_usuarios: t_lista_usuarios);
begin
  while (lista_usuarios<>nil) do
  begin
    textcolor(green); write('El nombre de usuario y la cantidad de días desde el último acceso de este usuario de la revista '); textcolor(yellow); write(revista_corte); textcolor(green); write(' son '); textcolor(red); write(lista_usuarios^.ele.nombre); textcolor(green); write(' y '); textcolor(red); write(lista_usuarios^.ele.dias); textcolor(green); writeln(', respectivamente');
    lista_usuarios:=lista_usuarios^.sig;
  end;
end;
procedure imprimir_vector_roles(vector_roles: t_vector_roles);
var
  i: t_rol;
begin
  for i:= rol_ini to rol_fin do
  begin
    textcolor(green); write('La cantidad de usuarios para el rol ',i,' para todas las revistas del portal es '); textcolor(red); writeln(vector_roles[i]); 
  end;
end;
var
  vector_usuarios: t_vector_usuarios;
  vector_roles: t_vector_roles;
  lista_usuarios: t_lista_usuarios;
  email_max1, email_max2: string;
begin
  randomize;
  lista_usuarios:=nil;
  inicializar_vector_roles(vector_roles);
  email_max1:=''; email_max2:='';
  cargar_vector_usuarios(vector_usuarios);
  procesar_vector_usuarios(vector_usuarios,lista_usuarios,vector_roles,email_max1,email_max2);
  if (lista_usuarios<>nil) then
    imprimir_lista_usuarios(lista_usuarios);
  imprimir_vector_roles(vector_roles);
  textcolor(green); write('Los emails de los dos usuarios que hace más tiempo que no ingresan al portal son '); textcolor(red); write(email_max1); textcolor(green); write(' y '); textcolor(red); write(email_max2);
end.