{TRABAJO PRÁCTICO N° 6}
{EJERCICIO 10}
{Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes.
Su funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un número (que es el siguiente al último número entregado).
El cliente quedará esperando a ser llamado por su número, en cuyo caso sale de la lista de espera.
Se pide:
(a) Definir una estructura de datos apropiada para representar la lista de espera de clientes.
(b) Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes en espera, asigna un número al cliente y retorna la lista de espera actualizada.
(c) Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera y retorna el número y DNI del cliente a ser atendido y la lista actualizada.
El cliente atendido debe eliminarse de la lista de espera.
(d) Implementar un programa que simule la atención de los clientes.
En dicho programa, primero llegarán todos los clientes juntos, se les dará un número de espera a cada uno de ellos y, luego, se los atenderá de a uno por vez.
El ingreso de clientes se realiza hasta que se lee el DNI 0, que no debe procesarse.}

program TP6_E10;
{$codepage UTF8}
uses crt;
const
  dni_salida=0;
type
  t_registro_cliente=record
    dni: int32;
    numero: int16;
  end;
  t_lista_clientes=^t_nodo_clientes;
  t_nodo_clientes=record
    ele: t_registro_cliente;
    sig: t_lista_clientes;
  end;
procedure leer_dni(var dni: int32);
var
  i: int8;
begin
  i:=random(high(int8));
  if (i=0) then
    dni:=dni_salida
  else
    dni:=10000000+random(40000001);
end;
procedure RecibirCliente(dni: int32; var lista_clientes: t_lista_clientes);
var
  nuevo, ult: t_lista_clientes;
begin
  new(nuevo);
  nuevo^.ele.dni:=dni;
  nuevo^.sig:=nil;
  if (lista_clientes=nil) then
  begin
    nuevo^.ele.numero:=1;
    lista_clientes:=nuevo;
  end
  else
  begin
    ult:=lista_clientes;
    while (ult^.sig<>nil) do
      ult:=ult^.sig;
    nuevo^.ele.numero:=ult^.ele.numero+1;
    ult^.sig:=nuevo;
  end;
end;
procedure cargar_lista_clientes(var lista_clientes: t_lista_clientes);
var
  dni: int32;
begin
  leer_dni(dni);
  while (dni<>dni_salida) do
  begin
    RecibirCliente(dni,lista_clientes);
    leer_dni(dni);
  end;
end;
procedure AtenderCliente(var lista_clientes: t_lista_clientes; var numero: int16; var dni: int32);
var
  lista_clientes_aux: t_lista_clientes;
begin
  if (lista_clientes<>nil) then
  begin
    lista_clientes_aux:=lista_clientes;
    dni:=lista_clientes_aux^.ele.dni; 
    numero:=lista_clientes_aux^.ele.numero;
    lista_clientes:=lista_clientes^.sig;
    dispose(lista_clientes_aux);
  end;
end;
procedure vaciar_lista_clientes(var lista_clientes: t_lista_clientes);
var
  numero: int16;
  dni: int32;
begin
  numero:=0; dni:=0;
  while (lista_clientes<>nil) do
  begin
    AtenderCliente(lista_clientes,numero,dni);
    textcolor(green); write('El número y el DNI del cliente a ser atendido son '); textcolor(red); write(numero); textcolor(green); write(' y '); textcolor(red); write(dni); textcolor(green); writeln(', respectivamente');
  end;
end;
procedure imprimir_lista_clientes(lista_clientes: t_lista_clientes);
begin
  while (lista_clientes<>nil) do
  begin
    textcolor(green); write('El DNI del cliente es '); textcolor(red); writeln(lista_clientes^.ele.dni);
    textcolor(green); write('El número del cliente es '); textcolor(red); writeln(lista_clientes^.ele.numero);
    writeln();
    lista_clientes:=lista_clientes^.sig;
  end;
end;
var
  lista_clientes: t_lista_clientes;
begin
  randomize;
  lista_clientes:=nil;
  cargar_lista_clientes(lista_clientes);
  if (lista_clientes<>nil) then
  begin
    imprimir_lista_clientes(lista_clientes);
    vaciar_lista_clientes(lista_clientes);
    imprimir_lista_clientes(lista_clientes);
  end;
end.