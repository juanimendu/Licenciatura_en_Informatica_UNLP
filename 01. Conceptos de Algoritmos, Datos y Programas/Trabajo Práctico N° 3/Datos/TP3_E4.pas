{TRABAJO PRÁCTICO N° 3}
{EJERCICIO 4}
{Una compañía de telefonía celular debe realizar la facturación mensual de sus 9300 clientes con planes de consumo ilimitados (clientes que pagan por lo que consumen).
Para cada cliente, se conoce su código de cliente y cantidad de líneas a su nombre.
De cada línea, se tiene el número de teléfono, la cantidad de minutos consumidos y la cantidad de MB consumidos en el mes.
Se pide implementar un programa que lea los datos de los clientes de la compañía e informe el monto total a facturar para cada uno.
Para ello, se requiere:
•	Realizar un módulo que lea la información de una línea de teléfono.
•	Realizar un módulo que reciba los datos de un cliente, lea la información de todas sus líneas (utilizando el módulo desarrollado en el inciso (a)) y retorne la cantidad total de minutos y la cantidad total de MB a facturar del cliente.
Nota: Para realizar los cálculos tener en cuenta que cada minuto cuesta $3,40 y cada MB consumido cuesta $1,35.}

program TP3_E4;
{$codepage UTF8}
uses crt;
const
  clientes_total=9300;
  costo_minuto=3.40; costo_MB=1.35;
type
  t_cliente=1..clientes_total;
  t_registro_cliente=record
    cliente: int16;
    lineas: int8;
  end;
  t_registro_linea=record
    numero: int16;
    minutos: int16;
    MBs: int16;
  end;
procedure leer_cliente(var registro_cliente: t_registro_cliente);
begin
  registro_cliente.cliente:=1+random(high(int16));
  registro_cliente.lineas:=1+random(5);
end;
procedure leer_linea(var registro_linea: t_registro_linea);
begin
  registro_linea.numero:=1+random(high(int16));
  registro_linea.minutos:=1+random(10000);
  registro_linea.MBs:=1+random(10000);
end;
procedure leer_lineas(lineas: int8; var minutos_cliente, MBs_cliente: int32);
var
  registro_linea: t_registro_linea;
  i: int8;
begin
  for i:= 1 to lineas do
    begin
      leer_linea(registro_linea);
      minutos_cliente:=minutos_cliente+registro_linea.minutos;
      MBs_cliente:=MBs_cliente+registro_linea.MBs;
    end;
end;
var
  registro_cliente: t_registro_cliente;
  i: t_cliente;
  minutos_cliente, MBs_cliente: int32;
  monto_cliente: real;
begin
  randomize;
  for i:= 1 to clientes_total do
  begin
    minutos_cliente:=0; MBs_cliente:=0;
    leer_cliente(registro_cliente);
    leer_lineas(registro_cliente.lineas,minutos_cliente,MBs_cliente);
    monto_cliente:=minutos_cliente*costo_minuto+MBs_cliente*costo_MB;
    textcolor(green); write('El monto total a facturar del cliente '); textcolor(yellow); write(i); textcolor(green); write(' es $'); textcolor(red); writeln(monto_cliente:0:2);
  end;
end.