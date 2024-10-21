{TRABAJO PRÁCTICO N° 7}
{EJERCICIO 1}
{Una productora nacional realiza un casting de personas para la selección de actores extras de una nueva película,
para ello se debe leer y almacenar la información de las personas que desean participar de dicho casting.
De cada persona, se lee: DNI, apellido y nombre, edad y el código de género de actuación que prefiere
(1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura finaliza cuando llega una persona con DNI 33555444,
la cual debe procesarse. Una vez finalizada la lectura de todas las personas, se pide:
•	Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
•	Informar los dos códigos de género más elegidos.
•	Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no existir. Invocar dicho módulo en el programa principal.}

program TP7_E1;
{$codepage UTF8}
uses crt;
const
  codigo_ini=1; codigo_fin=5; digito_ini=0; digito_fin=9; dni_salida=33555444;
type
  t_str20=string[20];
  t_codigos=0..codigo_fin;
  t_registro_persona=record
    dni: int32;
    apellido: t_str20;
    nombre: t_str20;
    edad: int16;
    codigo: t_codigos;
  end;
  t_vector_dni=array[digito_ini..digito_fin] of int8;
  t_vector_codigos=array[codigo_ini..codigo_fin] of int16;
  t_lista_personas=^t_nodo_personas;
  t_nodo_personas=record
    ele: t_registro_persona;
    sig: t_lista_personas;
  end;
procedure leer_persona(var registro_persona: t_registro_persona);
begin
  textcolor(green); write('Introducir DNI de la persona: ');
  textcolor(yellow); readln(registro_persona.dni);
  textcolor(green); write('Introducir apellido de la persona: ');
  textcolor(yellow); readln(registro_persona.apellido);
  textcolor(green); write('Introducir nombre de la persona: ');
  textcolor(yellow); readln(registro_persona.nombre);
  textcolor(green); write('Introducir edad de la persona: ');
  textcolor(yellow); readln(registro_persona.edad);
  textcolor(green); write('Introducir código de género de actuación de la persona (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror): ');
  textcolor(yellow); readln(registro_persona.codigo);
end;
procedure agregar_adelante_lista(var lista_personas: t_lista_personas; registro_persona: t_registro_persona);
var
  lista_nueva: t_lista_personas;
begin
  new(lista_nueva); lista_nueva^.ele:=registro_persona; lista_nueva^.sig:=nil;
  if (lista_personas=nil) then
    lista_personas:=lista_nueva
  else
  begin
    lista_nueva^.sig:=lista_personas;
    lista_personas:=lista_nueva;
  end;
end;
procedure descomponer_dni(var vector_dni: t_vector_dni; registro_persona: t_registro_persona);
var
  digito: int8;
begin
  while (registro_persona.dni<>0) do
  begin
    digito:=registro_persona.dni mod 10;
    vector_dni[digito]:=vector_dni[digito]+1;
    registro_persona.dni:=registro_persona.dni div 10;
  end;
end;
function contar_pares_impares(vector_dni: t_vector_dni): boolean;
var
  i, pares, impares: int8;
begin
  pares:=0; impares:=0;
  for i:= digito_ini to digito_fin do
    if (vector_dni[i]<>0) then
      if (i mod 2=0) then
        pares:=pares+vector_dni[i]
      else
        impares:=impares+vector_dni[i];
  contar_pares_impares:=(pares>impares);
end;
procedure actualizar_maximos(vector_codigos: t_vector_codigos; var codigo_max1, codigo_max2: t_codigos);
var
  i: int8;
  num_max1, num_max2: int16;
begin
  num_max1:=low(int16); num_max2:=low(int16);
  for i:= codigo_ini to codigo_fin do
  begin
    if (vector_codigos[i]>num_max1) then
    begin
      num_max2:=num_max1;
      codigo_max2:=codigo_max1;
      num_max1:=vector_codigos[i];
      codigo_max1:=i;
    end
    else
      if (vector_codigos[i]>num_max2) then
      begin
        num_max2:=vector_codigos[i];
        codigo_max2:=i;
      end;
  end;
end;
procedure leer_personas(var lista_personas: t_lista_personas; var personas_par: int16; var codigo_max1, codigo_max2: t_codigos);
var
  registro_persona: t_registro_persona;
  vector_dni: t_vector_dni;
  vector_codigos: t_vector_codigos;
  i: int8;
begin
  for i:= codigo_ini to codigo_fin do
    vector_codigos[i]:=0;
  repeat
    leer_persona(registro_persona);
    agregar_adelante_lista(lista_personas,registro_persona);
    for i:= digito_ini to digito_fin do
      vector_dni[i]:=0;
    descomponer_dni(vector_dni,registro_persona);
    if (contar_pares_impares(vector_dni)=true) then
      personas_par:=personas_par+1;
    vector_codigos[registro_persona.codigo]:=vector_codigos[registro_persona.codigo]+1;
  until (registro_persona.dni=dni_salida);
  actualizar_maximos(vector_codigos,codigo_max1,codigo_max2);
end;
procedure eliminar_dni(var lista_personas: t_lista_personas; var elimino: boolean; dni_eliminar: int32);
var
  actual, anterior: t_lista_personas;
begin
  actual:=lista_personas;
  while ((actual<>nil) and (actual^.ele.dni<>dni_eliminar)) do
  begin
    anterior:=actual;
    actual:=actual^.sig;
  end;
  if (actual<>nil) then
  begin
    if (actual=anterior) then
      lista_personas:=lista_personas^.sig
    else
      anterior^.sig:=actual^.sig;
    dispose(actual);
    elimino:=true;
  end
end;
var
  lista_personas: t_lista_personas;
  codigo_max1, codigo_max2: t_codigos;
  personas_par: int16;
  dni_eliminar: int32;
  elimino: boolean;
begin
  lista_personas:=nil; codigo_max1:=low(t_codigos); codigo_max2:=low(t_codigos); personas_par:=0; elimino:=false;
  leer_personas(lista_personas,personas_par,codigo_max1,codigo_max2);
  textcolor(green); write('La cantidad de personas cuyo DNI contiene más dígitos pares que impares es '); textcolor(red); writeln(personas_par);
  textcolor(green); write('Los dos códigos de género más elegidos son '); textcolor(red); write(codigo_max1); textcolor(green); write(' y '); textcolor(red); writeln(codigo_max2);
  textcolor(green); write('Introducir DNI que se desea eliminar: ');
  textcolor(yellow); readln(dni_eliminar);
  eliminar_dni(lista_personas,elimino,dni_eliminar);
  if (elimino=true) then
  begin
    textcolor(green); write('El DNI '); textcolor(yellow); write(dni_eliminar); textcolor(red); write(' SÍ'); textcolor(green); write(' fue encontrado y eliminado');
  end
  else
  begin
    textcolor(green); write('El DNI '); textcolor(yellow); write(dni_eliminar); textcolor(red); write(' NO'); textcolor(green); write(' fue encontrado y eliminado');
  end;
end.