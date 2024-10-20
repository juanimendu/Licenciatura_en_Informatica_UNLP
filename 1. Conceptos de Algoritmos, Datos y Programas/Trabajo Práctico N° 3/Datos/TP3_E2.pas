{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 2}
{El registro civil de La Plata ha solicitado un programa para analizar la distribución de casamientos durante el año 2019.
Para ello, cuenta con información de las fechas de todos los casamientos realizados durante ese año.
(a) Analizar y definir un tipo de dato adecuado para almacenar la información de la fecha de cada casamiento.
(b) Implementar un módulo que lea una fecha desde teclado y la retorne en un parámetro cuyo tipo es el definido en el inciso (a).
(c) Implementar un programa que:
•	Lea la fecha de todos los casamientos realizados en 2019. La lectura finaliza al ingresar el año 2020, que no debe procesarse.
•	Informe la cantidad de casamientos realizados durante los meses de verano (enero, febrero y marzo) y la cantidad de casamientos realizados en los primeros 10 días de cada mes.
Nota: Utilizar el módulo realizado en (b) para la lectura de fecha.}

program TP3_E2;
{$codepage UTF8}
uses crt;
const
  anio_salida=2020;
  dia_ini=1; dia_fin=31;
  mes_ini=1; mes_fin=12;
  mes_corte1=1; mes_corte2=2; mes_corte3=3;
  dia_corte=10;
type
  t_dia=dia_ini..dia_fin;
  t_mes=mes_ini..mes_fin;
  t_registro_casamiento=record
    dia: t_dia;
    mes: t_mes;
    anio: int16;
  end;
procedure leer_casamiento(var registro_casamiento: t_registro_casamiento);
var
  i: int8;
begin
  i:=random(100);
  if (i=0) then
    registro_casamiento.anio:=anio_salida
  else
    registro_casamiento.anio:=2019;
  if (registro_casamiento.anio<>anio_salida) then
  begin
    registro_casamiento.dia:=dia_ini+random(dia_fin);
    registro_casamiento.mes:=mes_ini+random(mes_fin);
  end;
end;
procedure leer_casamientos(var casamientos_corte_mes, casamientos_corte_dia: int16);
var
  registro_casamiento: t_registro_casamiento;
begin
  leer_casamiento(registro_casamiento);
  while (registro_casamiento.anio<>anio_salida) do
  begin
    if ((registro_casamiento.mes=mes_corte1) or (registro_casamiento.mes=mes_corte2) or (registro_casamiento.mes=mes_corte3)) then
      casamientos_corte_mes:=casamientos_corte_mes+1;
    if (registro_casamiento.dia<=dia_corte) then
      casamientos_corte_dia:=casamientos_corte_dia+1;
    leer_casamiento(registro_casamiento);
  end;
end;
var
  casamientos_corte_mes, casamientos_corte_dia: int16;
begin
  randomize;
  casamientos_corte_mes:=0;
  casamientos_corte_dia:=0;
  leer_casamientos(casamientos_corte_mes,casamientos_corte_dia);
  textcolor(green); write('La cantidad de casamientos realizados durante los meses de verano (enero, febrero y marzo) es '); textcolor(red); writeln(casamientos_corte_mes);
  textcolor(green); write('La cantidad de casamientos realizados en los primeros '); textcolor(yellow); write(dia_corte); textcolor(green); write(' días de cada mes es '); textcolor(red); write(casamientos_corte_dia);
end.