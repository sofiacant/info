
{El supermercado GranVariedad necesita un sistema para procesar la información de sus ventas. De cada venta se
conoce: DNi de cliente, código de sucursal (1 a 10), número de factura y monto.
a) Implementar un modulo que lea información de las ventas (la lectura finaliza al ingresar DNI de cliente Oj v
retorne:
Una estructura de datos eficiente para la búsqueda por DNI de cliente. Para cada DNI debe almacenarse una
lista de todas sus compras (número de factura y monto).
Una estructura de datos que almacene la cantidad de ventas de cada sucursal.
b) Realizar un módulo que reciba la estructura generada en el inciso a) i, un monto y un DNI. El módulo debe
retornar la cantidad de facturas cuyo monto es superior al monto ingresado para el DNI ingresado.
c)Realizar un módulo recursivo que reciba la estructura generada en inciso a) ii. y retorne el código de sucursal
con mayor cantidad de ventas.
NOTA: Implementar el programa principal, que invoque a los incisos a, by e. En caso de ser necesario, puede utilizar los
módulos que se encuentran a continuación}


program granvariedad;
Const
	max_suc=10;
	dni_fin=0;
Type
	rango_suc=1..max_suc;
	ventas= record
		dni:integer;
		cod_suc:integer;
		factura:integer;
		monto:real;
	end;
	
	regLista= record
		factura:integer;
		monto:real;
	end;
	
	lista=^nodol;
	nodol=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		dni:integer;
		lista:lista;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI: arbol;
		HD: arbol;
	end;
	
	vectorVentas= array [rango_suc] of integer;
//-----------------------MODULOS---------------	
procedure inicializarVector(var v:vectorVentas);
var 
	i:integer;
begin
	for i:=1 to max_suc do
		v[i]:=0;
end;


procedure cargarArbolyV(var a :arbol; var vec:vectorVentas);

procedure leerVentas(var v:ventas);
begin
		v.dni:= random(101);
		if(v.dni <> dni_fin)then begin
			v.cod_suc:= 1 + random(10);
			v.factura:= 1000 + random(2000);
			v.monto:= random(2000)/ (random(10)+1);
		end;
end;

procedure cargarRegistros(v:ventas; var rl:regLista);
begin
		rL.monto:= v.monto;
		rL.factura:= v.factura;
end;

procedure agregarAdelante(var l:lista; rL:regLista);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=rL;
	nue^.sig:=l;
	l:=nue;
end;
		
procedure insertarArbol(var a:arbol; dni:integer; rL:regLista);
begin
	if(a=nil)then begin
		new(a);
		a^.dato.lista:=nil;
		a^.dato.dni:=dni;
		a^.HI:=nil;
		a^.HD:=nil;
		agregarAdelante(a^.dato.lista,rL);
	end
	else begin
		if(a^.dato.dni = dni)then
			agregarAdelante(a^.dato.lista , rL)
		else 
			if	(a^.dato.dni < dni)then
				insertarArbol(a^.HD,dni,rL)
			else
				insertarArbol(a^.HI,dni,rL)
	end;
end;
			
	
	

var
	v:ventas;
	rl:regLista;
begin
	leerVentas(v);
	while(v.dni<>dni_fin)do begin
			cargarRegistros(v, rL);
			vec[v.cod_suc]:=vec[v.cod_suc]+1;
			insertarArbol(a, v.dni,rL);
			leerVentas(v);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<> nil) do begin
		writeln('monto:   ',l^.dato.monto:0:2);
		writeln('factura:   ',l^.dato.factura);
		l:=l^.sig;
	end;
end;
		
		
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbol(a^.HI);
		writeln('---------------');
		writeln('dni:  ',a^.dato.dni);
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirVector(v:vectorVentas);
var
	i:rango_suc;
begin
	for i:= 1 to max_suc do 
		writeln('Posicion ', i, ' cantidad:   ',v[i]);
end;

	
//------------inciso b----------
//b) Realizar un módulo que reciba la estructura generada en el inciso a) i, un monto y un DNI. El módulo debe
//retornar la cantidad de facturas cuyo monto es superior al monto ingresado para el DNI ingresado

 function recorrerLista(l:lista; monto:real):integer;
 var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		if(l^.dato.monto > monto)then
			cant:=cant+1;
		l:=l^.sig;
	end;
	recorrerLista:=cant;
end;
	
 
 
 function cantFacturas(a:arbol; dni:integer; monto:real):integer;
 begin
		if(a=nil)then
			cantFacturas:=0
		else begin
			if(a^.dato.dni = dni)then
				cantFacturas:=recorrerLista(a^.dato.lista,monto)
			else
				if(a^.dato.dni > dni)then
					cantFacturas:=cantFacturas(a^.HI,dni,monto)
				else
					cantFacturas:=cantFacturas(a^.HD,dni,monto)
		end;
end;
 
 //Realizar un módulo recursivo que reciba la estructura generada en inciso a) ii. y retorne el código de sucursal con mayor cantidad de ventas
 
 procedure sucursalMax(v:vectorVentas;  i:integer; var iMax, maxV:integer);
 begin
	if(i <=10)then begin
		if(v[i]>maxV)then begin
			maxV:=v[i];
			iMax:=i;
		end;
		sucursalMax(v, i+1, iMax,maxV);
	end;
end;

	
//----------------PROGRAMA PRINCIPAL------------	
var
	a:arbol;
	vec:vectorVentas;
	cantF,dni:integer;
	monto:real;
	maxV,i, iMax:integer;
begin
	a:=nil;
	randomize;
	inicializarVector(vec);
	cargarArbolyV(a,vec);
	writeln('--------ARBOL-------');
	imprimirArbol(a);
	writeln('----------VECTOR------');
	imprimirVector(vec);
	writeln('Ingrese un dni:   ');readln(dni);
	writeln('Ingrese un monto:   ');readln(monto);
	cantF:=cantFacturas(a,dni,monto);
	writeln('La cantidad de facturas con el monto superior al ingresado es:    ', cantF);	
	maxV:=-1;
	iMax:=-1;
	i:=1;
	sucursalMax(vec,i,iMax,maxV);
	writeln('La sucursal con mayor cantidad de ventas es:   ', iMax ,  'con '  ,maxV,'  ventas  ');
	 
end.




