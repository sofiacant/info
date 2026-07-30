//l hipermercado Chango Más necesita un sistema para procesar la información de sus ventas. De cada venta se conoce: código de cliente, código de sucursal (1 a 10), número de factura y monto.
//a) Implementar un módulo que lea información de las ventas (a lectura finaliza al ingresar una venta con el código de cliente 1 que debe procesarse) y retorne:
//i. Una estructura de datos eficiente para la búsqueda por código de cliente que contenga por cada cliente el monto total gastado y todas sus ventas.
//ii. Una estructura de datos que almacene la cantidad de ventas de cada sucursal.
//b) Realizar un módulo que reciba la estructura generada en el inciso a) i y un monto M, y retorne la cantidad de facturas cuyo monto es superior al monto M para el cliente de menor código.
//c) Realizar un módulo que reciba la estructura generada en inciso alii y retorne la misma estructura con la información ordenada de mayor a menor.

program changomas;
Const 
	max_sucursal= 10;
Type
	rango_suc= 1..max_sucursal;
	
	venta=record
		codcliente:integer;
		codsuc:rango_suc;
		factura:integer;
		monto:real;
	end;
	
	regArbol=record
		
