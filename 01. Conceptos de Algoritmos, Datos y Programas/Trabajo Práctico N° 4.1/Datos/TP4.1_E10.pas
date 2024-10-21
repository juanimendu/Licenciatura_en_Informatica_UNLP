{TRABAJO PRÁCTICO N° 4.1}
{EJERCICIO 10}
{Realizar un programa que lea y almacene el salario de los empleados de una empresa de turismo (a lo sumo, 300 empleados).
La carga finaliza cuando se lea el salario 0 (que no debe procesarse) o cuando se completa el vector.
Una vez finalizada la carga de datos, se pide:
(a) Realizar un módulo que incremente el salario de cada empleado en un 15%.
Para ello, implementar un módulo que reciba como parámetro un valor real X, el vector de valores reales y su dimensión lógica y retorne el mismo vector en el cual cada elemento fue multiplicado por el valor X.
(b) Realizar un módulo que muestre en pantalla el sueldo promedio de los empleados de la empresa.}

program TP4_E10;
{$codepage UTF8}
uses crt;
const
  empleados_total=300;
  salario_salida=0;
  incremento=1.15;
type
  t_empleado=1..empleados_total;
  t_vector_salarios=array[t_empleado] of real;
procedure inicializar_vector_salarios(var vector_salarios: t_vector_salarios);
var
  i: t_empleado;
begin
  for i:= 1 to empleados_total do
    vector_salarios[i]:=0;
end;
procedure cargar_vector_salarios(var vector_salarios: t_vector_salarios; var empleados: int16);
var
  salario: real;
begin
  salario:=salario_salida+random(1001)/10;
  while ((salario<>salario_salida) and (empleados<empleados_total)) do
  begin
    empleados:=empleados+1;
    vector_salarios[empleados]:=salario;
    salario:=salario_salida+random(1001)/10;
  end;
end;
procedure incrementar_salarios(incremento: real; var vector_salarios: t_vector_salarios; empleados: int16);
var
  i: t_empleado;
begin
  for i:= 1 to empleados do
    vector_salarios[i]:=vector_salarios[i]*incremento;
end;
procedure calcular_salario_promedio(vector_salarios: t_vector_salarios; empleados: int16);
var
  i: t_empleado;
  salario_total, salario_prom: real;
begin
  salario_total:=0;
  for i:= 1 to empleados do
    salario_total:=salario_total+vector_salarios[i];
  salario_prom:=salario_total/empleados;
  textcolor(green); write('El sueldo promedio de los empleados de la empresa es $'); textcolor(red); write(salario_prom:0:2);
end;
var
  vector_salarios: t_vector_salarios;
  empleados: int16;
begin
  randomize;
  empleados:=0;
  inicializar_vector_salarios(vector_salarios);
  cargar_vector_salarios(vector_salarios,empleados);
  if (empleados>0) then
  begin
    incrementar_salarios(incremento,vector_salarios,empleados);
    calcular_salario_promedio(vector_salarios,empleados);
  end;
end.