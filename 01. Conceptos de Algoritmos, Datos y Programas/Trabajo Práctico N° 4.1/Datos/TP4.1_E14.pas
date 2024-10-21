{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 14}
{El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en los proyectos que aloja.
Para ello, dispone de una tabla con información de los desarrolladores que participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
Realizar un programa que procese la información de los desarrolladores que participaron en los 1000 proyectos de software más activos durante el año 2017.
De cada participante, se conoce su país de residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en dicho proyecto (1 a 5) y la cantidad de horas trabajadas.
La lectura finaliza al ingresar el código de proyecto -1, que no debe procesarse.
Al finalizar la lectura, el programa debe informar:
•	El monto total invertido en desarrolladores con residencia en Argentina.
•	La cantidad total de horas trabajadas por Administradores de bases de datos.
•	El código del proyecto con menor monto invertido.
•	La cantidad de Arquitectos de software de cada proyecto.}

program TP4_E14;
{$codepage UTF8}
uses crt;
const
  proyecto_ini=1; proyecto_fin=1000;
  rol_ini=1; rol_fin=5;
  proyecto_salida=-1;
  pais_corte='Argentina';
  rol_corte1=3;
  rol_corte2=4;
type
  t_proyecto=proyecto_ini..proyecto_fin;
  t_rol=rol_ini..rol_fin;
   t_registro_participante=record
    pais: string;
    proyecto: int16;
    nombre: string;
    rol: t_rol;
    horas: int16;
  end;
  t_registro_proyecto=record
    monto: real;
    cantidad: int16;
  end;
  t_vector_proyectos=array[t_proyecto] of t_registro_proyecto;
  t_vector_salarios=array[t_rol] of real;
procedure cargar_vector_salarios(var vector_salarios: t_vector_salarios);
begin
  vector_salarios[1]:=35.20;
  vector_salarios[2]:=27.45;
  vector_salarios[3]:=31.03;
  vector_salarios[4]:=44.28;
  vector_salarios[5]:=39.87;
end;
procedure inicializar_vector_proyectos(var vector_proyectos: t_vector_proyectos);
var
  i: t_proyecto;
begin
  for i:= proyecto_ini to proyecto_fin do
  begin
    vector_proyectos[i].monto:=0;
    vector_proyectos[i].cantidad:=0;
  end;
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
procedure leer_participante(var registro_participante: t_registro_participante);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_participante.proyecto:=proyecto_salida
  else
    registro_participante.proyecto:=proyecto_ini+random(proyecto_fin);
  if (registro_participante.proyecto<>proyecto_salida) then
  begin
    i:=random(10);
    if (i=0) then
      registro_participante.pais:=pais_corte
    else
      registro_participante.pais:=random_string(5+random(6));
    registro_participante.nombre:=random_string(5+random(6));
    registro_participante.rol:=rol_ini+random(rol_fin);
    registro_participante.horas:=1+random(100);
  end;
end;
procedure cargar_vector_proyectos(var vector_proyectos: t_vector_proyectos; var monto_corte: real; var horas_corte: int16; vector_salarios: t_vector_salarios);
var
  registro_participante: t_registro_participante;
begin
  leer_participante(registro_participante);
  while (registro_participante.proyecto<>proyecto_salida) do
  begin
    if (registro_participante.pais=pais_corte) then
      monto_corte:=monto_corte+vector_salarios[registro_participante.rol]*registro_participante.horas;
    if (registro_participante.rol=rol_corte1) then
      horas_corte:=horas_corte+registro_participante.horas;
    vector_proyectos[registro_participante.proyecto].monto:=vector_proyectos[registro_participante.proyecto].monto+vector_salarios[registro_participante.rol]*registro_participante.horas;
    if (registro_participante.rol=rol_corte2) then
      vector_proyectos[registro_participante.proyecto].cantidad:=vector_proyectos[registro_participante.proyecto].cantidad+1;
    leer_participante(registro_participante);
  end;
end;
procedure procesar_vector_proyectos(vector_proyectos: t_vector_proyectos; var proyecto_min: int16);
var
  i: t_proyecto;
  monto_min: real;
begin
  monto_min:=9999999;
  for i:= proyecto_ini to proyecto_fin do
  begin
    if ((vector_proyectos[i].monto>0) and (vector_proyectos[i].monto<monto_min)) then
    begin
      monto_min:=vector_proyectos[i].monto;
      proyecto_min:=i;
    end;
    if (vector_proyectos[i].cantidad>0) then
    begin
      textcolor(green); write('La cantidad de Arquitectos de software del proyecto ',i,' es '); textcolor(red); writeln(vector_proyectos[i].cantidad);
    end;
  end;
end;
var
  vector_salarios: t_vector_salarios;
  vector_proyectos: t_vector_proyectos;
  horas_corte, proyecto_min: int16;
  monto_corte: real;
begin
  randomize;
  cargar_vector_salarios(vector_salarios);
  monto_corte:=0;
  horas_corte:=0;
  proyecto_min:=0;
  inicializar_vector_proyectos(vector_proyectos);
  cargar_vector_proyectos(vector_proyectos,monto_corte,horas_corte,vector_salarios);
  textcolor(green); write('El monto total invertido en desarrolladores con residencia en '); textcolor(yellow); write(pais_corte); textcolor(green); write(' es U$D '); textcolor(red); writeln(monto_corte:0:2);
  textcolor(green); write('La cantidad total de horas trabajadas por Administradores de bases de datos es '); textcolor(red); writeln(horas_corte);
  procesar_vector_proyectos(vector_proyectos,proyecto_min);
  textcolor(green); write('El código de proyecto con menor monto invertido es '); textcolor(red); write(proyecto_min);
end.