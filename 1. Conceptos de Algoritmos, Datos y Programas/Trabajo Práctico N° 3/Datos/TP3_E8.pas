{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 8}
{La Comisión Provincial por la Memoria desea analizar la información de los proyectos presentados en el programa Jóvenes y Memoria durante la convocatoria 2020.
Cada proyecto, posee un código único, un título, el docente coordinador (DNI, nombre y apellido, email),
la cantidad de alumnos que participan del proyecto, el nombre de la escuela y la localidad a la que pertenece.
Cada escuela puede presentar más de un proyecto. La información se ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela.
Realizar un programa que lea la información de los proyectos hasta que se ingrese el proyecto con código -1 (que no debe procesarse) e informe:
•	Cantidad total de escuelas que participan en la convocatoria 2020 y cantidad de escuelas por cada localidad.
•	Nombres de las dos escuelas con mayor cantidad de alumnos participantes.
•	Título de los proyectos de la localidad de Daireaux cuyo código posee igual cantidad de dígitos pares e impares.}

program TP3_E8;
{$codepage UTF8}
uses crt;
const
  proyecto_salida=-1;
  localidad_corte='Daireaux';
type
  t_registro_docente=record
    dni: int32;
    nombre: string;
    apellido: string;
    email: string;
  end;
  t_registro_proyecto=record
    proyecto: int16;
    titulo: string;
    docente: t_registro_docente;
    alumnos: int16;
    escuela: string;
    localidad: string;
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
procedure leer_docente(var registro_docente: t_registro_docente);
var
  vector_emails: array[1..3] of string=('@gmail.com', '@hotmail.com', '@yahoo.com');
begin
  registro_docente.dni:=10000000+random(30000001);
  registro_docente.nombre:=random_string(5+random(6));
  registro_docente.apellido:=random_string(5+random(6));
  registro_docente.email:=random_string(5+random(6))+vector_emails[1+random(3)];
end;
procedure leer_proyecto(var registro_proyecto: t_registro_proyecto; localidad, escuela: string);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_proyecto.proyecto:=proyecto_salida
  else
    registro_proyecto.proyecto:=1+random(high(int16));
  if (registro_proyecto.proyecto<>proyecto_salida) then
  begin
    registro_proyecto.titulo:='Proyecto '+random_string(5+random(6));
    leer_docente(registro_proyecto.docente);
    registro_proyecto.alumnos:=1+random(100);
    i:=random(2);
    if (i=0) then
      registro_proyecto.localidad:=localidad
    else
      registro_proyecto.localidad:='Localidad '+random_string(5+random(6));
    i:=random(2);
    if (i=0) then
      registro_proyecto.escuela:=escuela
    else
      registro_proyecto.escuela:='Escuela '+random_string(5+random(6));
  end;
end;
procedure actualizar_maximos(alumnos: int16; escuela: string; var alumnos_max1, alumnos_max2: int16; var escuela_max1, escuela_max2: string);
begin
  if (alumnos>alumnos_max1) then
  begin
    alumnos_max2:=alumnos_max1;
    escuela_max2:=escuela_max1;
    alumnos_max1:=alumnos;
    escuela_max1:=escuela;
  end
  else
    if (alumnos>alumnos_max2) then
    begin
      alumnos_max2:=alumnos;
      escuela_max2:=escuela;
    end;
end;
function contar_pares_impares(proyecto: int16): boolean;
var
  pares, impares: int16;
begin
  pares:=0; impares:=0;
  while (proyecto<>0) do
  begin
    if (proyecto mod 2=0) then
      pares:=pares+1
    else 
      impares:=impares+1;
    proyecto:=proyecto div 10;
  end;
  if (pares=impares) then
    contar_pares_impares:=true
  else
    contar_pares_impares:=false; 
end;
procedure leer_proyectos(var escuelas_total: int16; var escuela_max1, escuela_max2: string);
var
  registro_proyecto: t_registro_proyecto;
  escuelas_localidad, alumnos_escuela, alumnos_max1, alumnos_max2: int16;
  localidad, escuela: string;
begin
  alumnos_max1:=low(int16); alumnos_max2:=low(int16);
  localidad:=localidad_corte; escuela:='Escuela XXX';
  leer_proyecto(registro_proyecto,localidad,escuela);
  while (registro_proyecto.proyecto<>proyecto_salida) do
  begin
    localidad:=registro_proyecto.localidad;
    escuelas_localidad:=0;
    while ((registro_proyecto.proyecto<>proyecto_salida) and (registro_proyecto.localidad=localidad)) do
    begin
      escuela:=registro_proyecto.escuela;
      escuelas_localidad:=escuelas_localidad+1;
      alumnos_escuela:=0;
      while ((registro_proyecto.proyecto<>proyecto_salida) and (registro_proyecto.localidad=localidad) and (registro_proyecto.escuela=escuela)) do
      begin
        alumnos_escuela:=alumnos_escuela+registro_proyecto.alumnos;
        if ((registro_proyecto.localidad=localidad_corte) and (contar_pares_impares(registro_proyecto.proyecto)=true)) then
        begin
          textcolor(green); write('El título de este proyecto de la localidad '); textcolor(yellow); write(localidad_corte); textcolor(green); write(', cuyo código posee igual cantidad de dígitos pares e impares, es '); textcolor(red); writeln(registro_proyecto.titulo);
        end;
        leer_proyecto(registro_proyecto,localidad,escuela);
      end;
      actualizar_maximos(alumnos_escuela,escuela,alumnos_max1,alumnos_max2,escuela_max1,escuela_max2);
    end;
    escuelas_total:=escuelas_total+escuelas_localidad;
    textcolor(green); write('La cantidad de escuelas de la localidad '); textcolor(red); write(localidad); textcolor(green); write(' es '); textcolor(red); writeln(escuelas_localidad);
  end;
end;
var
  escuelas_total: int16;
  escuela_max1, escuela_max2: string;
begin
  randomize;
  escuelas_total:=0;
  escuela_max1:=''; escuela_max2:='';
  leer_proyectos(escuelas_total,escuela_max1,escuela_max2);
  textcolor(green); write('La cantidad total de escuelas que participan en la convocatoria 2020 es '); textcolor(red); writeln(escuelas_total);
  textcolor(green); write('Los nombres de las dos escuelas con mayor cantidad de alumnos participantes son '); textcolor(red); write(escuela_max1); textcolor(green); write(' y '); textcolor(red); write(escuela_max2);
end.