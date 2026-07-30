{El supermercado HayDe Todo necesita un sistema para procesar la información de sus ventas. De cada venta se conoce
DNI de cliente, código de sucursal (1 a 10), número de factura y monto.
a) Implementar un módulo que lea información de las ventas (la lectura finaliza al ingresar código de cliente 0 y
retorne:

1. Una estructura de datos eficiente para la búsqueda por DNI de cliente. Para cada DNI debe almacenarse una
lista de todas sus compras (número de factura y monto).
ii. Una estructura de datos que almacene la cantidad de ventas de cada sucursal.
b) Realizar un módulo que reciba la estructura generada en el inciso a) i, un monto y un DNI. El módulo debe retornar
la cantidad de facturas cuyo monto es superior al monto Ingresado para el DNI ingresado.
c) Realizar un módulo recursivo que reciba la estructura generada en inciso ajil y retorne el código de sucursal con
mayor cantidad de ventas..
NOTA: Implementar el programa principal, que invoque a los incisos a, b y c. En caso de ser necesario, puede utilizar los
módulos que se encuentran a continuación.}

program
Const
	max_cod=10;
	cod_fin=0;
Type
	rangoCod=1..max_cod;
	venta=record
		dni:integer;
		codsuc:rangoCod;
		numFactura:integer;
		monto:real;
	end;
	
	regLista= ^nodo;
		nroF:integer;
		montoL:real;
	end;
	
	lista=^nodo
	nodo=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		dni:integer;
		l:lista;
	end;
	
	arbol=^nodoA
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;

	vectorVentasS = array [rangoCod] of integer;


procedure cargarArbol(var a:arbol);

procedure cargarVenta(var v:venta);
begin
	v.dni:= random (101);
	v.codsuc:= random (41);
	v.numFactura:= random (101);
	v.monto:= random + random(100);
end;

procedure cargarRegLista(v:venta; var rl:regLista);
begin
	rl.nroF:= v.numFactura;
	rl.montoL:= v.monto;
end;

procedure agregarAdelante(var l:lista; rl:regLista);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=rl;
	nue^.sig:=l;
	l:=nue;
end;

procedure insertarArbol(var a:arbol; dni:integer; rl:regLista);
begin
	if (a = nil) then begin
		new(a);
		a^.dato.dni:= dni;
		a^.dato.l:=NIL;
		agregarAdelante(a^.dato.l,rl);
		a^.HI:=NIL;
		a^.HD:= NIL;
	end
	else if (dni > a^.dato.dni) then
		insertarArbol(a^.HD,dni,rl)
		else 
			insertarArbol(a^.HI,dni,rl);
	else if (dni = a^.dato.dni) then
		agregarAdelante(a^.dato.l,rl);
end;


var
	v:venta;
	rl:regLista;
begin
	cargarVenta(v)
	while(v.dni<> cod_fin)do begin
		cargarRegLista(v,rl);
		insertarArbol(a,v.dni,rl);
		cargarVenta(v);
	end;
end;
		
		
procedure inicializarVector(var v:vectorVentasS);
var
	i:rangoCod;
begin
	for i:= 1 to 10 do
		v[i]:= 0
end;

procedure generarVector(l:lista; var v:vectorVentasS);
begin
	while (l <> NIL) do begin
		v[l^.dato.]
	end;
end;
	
var
	a:arbol;
begin
	a:=NIL;
	cargarArbol(a);
	inicializarVector(v);
	
end.
