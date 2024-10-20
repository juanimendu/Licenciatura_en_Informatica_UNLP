{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 17b}
{La cátedra de CADP está analizando los resultados de las autoevaluaciones que realizaron los alumnos durante el cuatrimestre.
Realizar un programa que lea, para cada alumno, su legajo, su condición (I para INGRESANTE, R para RECURSANTE) y la nota obtenida en cada una de las 5 autoevaluaciones.
Si un alumno no realizó alguna autoevaluación en tiempo y forma, se le cargará la nota -1. La lectura finaliza al ingresar el legajo -1.
Una vez ingresados todos los datos, el programa debe informar:
•	Cantidad de alumnos INGRESANTES en condiciones de rendir el parcial y porcentaje sobre el total de alumnos INGRESANTES.
•	Cantidad de alumnos RECURSANTES en condiciones de rendir el parcial y porcentaje sobre el total de alumnos RECURSANTES.
•	Cantidad de alumnos que aprobaron todas las autoevaluaciones.
•	Cantidad de alumnos cuya nota promedio fue mayor a 6.5 puntos.
•	Cantidad de alumnos que obtuvieron cero puntos en, al menos, una autoevaluación.
•	Código de los dos alumnos con mayor cantidad de autoevaluaciones con nota 10 (diez).
•	Código de los dos alumnos con mayor cantidad de autoevaluaciones con nota 0 (cero).
Nota: Recordar que, para poder rendir el EXAMEN PARCIAL, el alumno deberá obtener “Presente” en, al menos, el 75% del total de las autoevaluaciones propuestas.
Se considera “Presente” la autoevaluación que se entrega en tiempo y forma y con, al menos, el 40% de respuestas correctas.}

program TP6_E17b;
{$codepage UTF8}
uses crt;
const
  condicion_i='I'; condicion_r='R';
  autoeva_total=5;
  nota_incumple=-1;
  legajo_salida=-1;
  nota_corte=4;
  promedio_corte=6.5;
  nota_cero=0;
  nota_diez=10;
  presente_corte=0.75;
  alumnos_total=5000;
type
  t_registro_alumno=record
    legajo: int16;
    condicion: char;
    presente: int8;
    notas_cero: int8;
    notas_diez: int8;
    nota_total: int8;
  end;
  t_lista_alumnos=^t_nodo_alumnos;
  t_nodo_alumnos=record
    ele: t_registro_alumno;
    sig: t_lista_alumnos;
  end;
procedure leer_notas(var presente, notas_cero, notas_diez, nota_total: int8);
var
  i, nota: int8;
begin
  for i:= 1 to autoeva_total do
  begin
    textcolor(green); write('Introducir nota de autoevaluación ',i,' del alumno: ');
    textcolor(yellow); readln(nota);
    if ((nota<>nota_incumple) and (nota>=nota_corte)) then
      presente:=presente+1;
    if (nota=nota_cero) then
      notas_cero:=notas_cero+1;
    if (nota=nota_diez) then
      notas_diez:=notas_diez+1;
    if (nota<>nota_incumple) then
      nota_total:=nota_total+nota;
  end;
end;
procedure leer_alumno(var registro_alumno: t_registro_alumno);
begin
  textcolor(green); write('Introducir legajo del alumno: ');
  textcolor(yellow); readln(registro_alumno.legajo);
  if (registro_alumno.legajo<>legajo_salida) then
  begin
    textcolor(green); write('Introducir condición (I para INGRESANTE, R para RECURSANTE) del alumno: ');
    textcolor(yellow); readln(registro_alumno.condicion);
    registro_alumno.presente:=0; registro_alumno.notas_cero:=0; registro_alumno.notas_diez:=0; registro_alumno.nota_total:=0;
    leer_notas(registro_alumno.presente,registro_alumno.notas_cero,registro_alumno.notas_diez,registro_alumno.nota_total);
  end;
end;
procedure agregar_adelante_lista_alumnos(var lista_alumnos: t_lista_alumnos; registro_alumno: t_registro_alumno);
var
  nuevo: t_lista_alumnos;
begin
  new(nuevo);
  nuevo^.ele:=registro_alumno;
  nuevo^.sig:=lista_alumnos;
  lista_alumnos:=nuevo;
end;
procedure cargar_lista_alumnos(var lista_alumnos: t_lista_alumnos);
var 
  registro_alumno: t_registro_alumno;
begin
  leer_alumno(registro_alumno);
  while (registro_alumno.legajo<>legajo_salida) do
  begin
    agregar_adelante_lista_alumnos(lista_alumnos,registro_alumno);
    leer_alumno(registro_alumno);
  end;
end;
procedure calcular_ab(condicion: char; presente: int8; var ingresantes_total, ingresantes_parcial, recursantes_total, recursantes_parcial: int16);
begin
  if (condicion=condicion_i) then
  begin
    if (presente>=presente_corte*autoeva_total) then
      ingresantes_parcial:=ingresantes_parcial+1;
    ingresantes_total:=ingresantes_total+1;
  end
  else
  begin
    if (presente>=presente_corte*autoeva_total) then
      recursantes_parcial:=recursantes_parcial+1;
    recursantes_total:=recursantes_total+1;
  end;
end;
procedure calcular_c(presente: int8; var alumnos_autoeva: int16);
begin
  if (presente=autoeva_total) then
    alumnos_autoeva:=alumnos_autoeva+1;
end;
procedure calcular_d(nota_total: int8; var alumnos_corte: int16);
begin
  if (nota_total/autoeva_total>promedio_corte) then
    alumnos_corte:=alumnos_corte+1;
end;
procedure calcular_e(notas_cero: int8; var alumnos_cero: int16);
begin
  if (notas_cero>=1) then
    alumnos_cero:=alumnos_cero+1;
end;
procedure calcular_f(notas_diez: int8; legajo: int16; var notas_diez_max1, notas_diez_max2: int8; var legajo_diez_max1, legajo_diez_max2: int16);
begin
  if (notas_diez>notas_diez_max1) then
  begin
    notas_diez_max2:=notas_diez_max1;
    legajo_diez_max2:=legajo_diez_max1;
    notas_diez_max1:=notas_diez;
    legajo_diez_max1:=legajo;
  end
  else
    if (notas_diez>notas_diez_max2) then
    begin
      notas_diez_max2:=notas_diez;
      legajo_diez_max2:=legajo;
    end;
end;
procedure calcular_g(notas_cero: int8; legajo: int16; var notas_cero_max1, notas_cero_max2: int8; var legajo_cero_max1, legajo_cero_max2: int16);
begin
  if (notas_cero>notas_cero_max1) then
  begin
    notas_cero_max2:=notas_cero_max1;
    legajo_cero_max2:=legajo_cero_max1;
    notas_cero_max1:=notas_cero;
    legajo_cero_max1:=legajo;
  end
  else
    if (notas_cero>notas_cero_max2) then
    begin
      notas_cero_max2:=notas_cero;
      legajo_cero_max2:=legajo;
    end;
end;
procedure procesar_lista_alumnos(lista_alumnos: t_lista_alumnos; var ingresantes_parcial, ingresantes_total, recursantes_parcial, recursantes_total, alumnos_autoeva, alumnos_corte, alumnos_cero, legajo_diez_max1, legajo_diez_max2, legajo_cero_max1, legajo_cero_max2: int16);
var
  notas_diez_max1, notas_diez_max2, notas_cero_max1, notas_cero_max2: int8;
begin
  notas_diez_max1:=0; notas_diez_max2:=0;
  notas_cero_max1:=0; notas_cero_max2:=0;
  while (lista_alumnos<>nil) do
  begin
    calcular_ab(lista_alumnos^.ele.condicion,lista_alumnos^.ele.presente,ingresantes_total,ingresantes_parcial,recursantes_total,recursantes_parcial);
    calcular_c(lista_alumnos^.ele.presente,alumnos_autoeva);
    calcular_d(lista_alumnos^.ele.nota_total,alumnos_corte);
    calcular_e(lista_alumnos^.ele.notas_cero,alumnos_cero);
    calcular_f(lista_alumnos^.ele.notas_diez,lista_alumnos^.ele.legajo,notas_diez_max1,notas_diez_max2,legajo_diez_max1,legajo_diez_max2);
    calcular_g(lista_alumnos^.ele.notas_cero,lista_alumnos^.ele.legajo,notas_cero_max1,notas_cero_max2,legajo_cero_max1,legajo_cero_max2);
    lista_alumnos:=lista_alumnos^.sig;
  end;
end;
var
  lista_alumnos: t_lista_alumnos;
  ingresantes_parcial, ingresantes_total, recursantes_parcial, recursantes_total, alumnos_autoeva, alumnos_corte, alumnos_cero, legajo_diez_max1, legajo_diez_max2, legajo_cero_max1, legajo_cero_max2: int16;
begin
  lista_alumnos:=nil;
  ingresantes_parcial:=0; ingresantes_total:=0;
  recursantes_parcial:=0; recursantes_total:=0;
  alumnos_autoeva:=0;
  alumnos_corte:=0;
  alumnos_cero:=0;
  legajo_diez_max1:=0; legajo_diez_max2:=0;
  legajo_cero_max1:=0; legajo_cero_max2:=0;
  cargar_lista_alumnos(lista_alumnos);
  if (lista_alumnos<>nil) then
  begin
    procesar_lista_alumnos(lista_alumnos,ingresantes_parcial,ingresantes_total,recursantes_parcial,recursantes_total,alumnos_autoeva,alumnos_corte,alumnos_cero,legajo_diez_max1,legajo_diez_max2,legajo_cero_max1,legajo_cero_max2);
    if (ingresantes_total>0) then
    begin
      textcolor(green); write('La cantidad de alumnos INGRESANTES en condiciones de rendir el parcial y el porcentaje sobre el total de alumnos INGRESANTES son '); textcolor(red); write(ingresantes_parcial); textcolor(green); write(' y '); textcolor(red); write(ingresantes_parcial/ingresantes_total*100:0:2); textcolor(green); writeln('%, respectivamente');
    end
    else
    begin
      textcolor(red); writeln('No hay alumnos INGRESANTES (I)');
    end;
    if (recursantes_total>0) then
    begin
      textcolor(green); write('La cantidad de alumnos RECURSANTES en condiciones de rendir el parcial y el porcentaje sobre el total de alumnos RECURSANTES son '); textcolor(red); write(recursantes_parcial); textcolor(green); write(' y '); textcolor(red); write(recursantes_parcial/recursantes_total*100:0:2); textcolor(green); writeln('%, respectivamente');
    end
    else
    begin
      textcolor(red); writeln('No hay alumnos RECURSANTES (R)');
    end;
    textcolor(green); write('La cantidad de alumnos que aprobaron todas las autoevaluaciones es '); textcolor(red); writeln(alumnos_autoeva);
    textcolor(green); write('La cantidad de alumnos cuya nota promedio fue mayor a '); textcolor(yellow); write(promedio_corte:0:2); textcolor(green); write(' puntos es '); textcolor(red); writeln(alumnos_corte);
    textcolor(green); write('La cantidad de alumnos que obtuvieron cero puntos en, al menos, una autoevaluación es '); textcolor(red); writeln(alumnos_cero);
    textcolor(green); write('Los legajos de los dos alumnos con mayor cantidad de autoevaluaciones con nota 10 (diez) son '); textcolor(red); write(legajo_diez_max1); textcolor(green); write(' y '); textcolor(red); writeln(legajo_diez_max2);
    textcolor(green); write('Los legajos de los dos alumnos con mayor cantidad de autoevaluaciones con nota 0 (cero) son '); textcolor(red); write(legajo_cero_max1); textcolor(green); write(' y '); textcolor(red); write(legajo_cero_max2);
  end
  else
  begin
    textcolor(red); write('No hay alumnos INGRESANTES (I) o RECURSANTES (R)');
  end;
end.