//El supermercado Consumo necesita un sistema para procesar la información de sus ventas. De cada venta se conoce:
//DNI de cliente, código de sucursal (1 a 10), número de factura y monto.
//a) Implementár un módulo que lea información de las ventas (la lectura finaliza al ingresar código de cliente 0 y
//retorne:
//i) Una estructura de datos eficiente para la búsqueda por DNI de cliente. Para cada DNI debe almacenarse una lista
//de todas sus compras (número de factura y monto).
//ii) Una estructura de datos que almacene la cantidad de ventas de cada sucursal.
//b) Realizar un módulo que reciba la estructura generada en el inciso a) i, un monto y un DNI. El módulo debe retornar
//la cantidad de facturas cuyo monto es inferior al monto ingresado para el DNI ingresado.
//c) Realizar un módulo recursivo que reciba la estructura generada en inciso a)ii y un valor entero y retorne si existe o
//no una sucursal con cantidad de ventas igual al valor recibido.
//NOTA: Implementar el programa principal, que invoque a los incisos a, b y c. En caso de ser necesario, puede utilizar los
//módulos que se encuentran a continuación.

program parcialsupermercado;
Const
	max_sucursal=10;
	cod_fin=0;
Type
	rango_suc= 1..10;
	
	ventas=record
		dni:integer;
		codSuc:rango_suc;
		factura:integer;
		monto:real;
	end;
	
	regLista=record
		factura:integer;
		monto:real;
	end;
	
	lista=^nodo;
		nodo=record
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
			HI:arbol;
			HD:arbol;
		end;

	vectorVentas= array[rango_suc]of integer;


procedure cargarArbol(var a:arbol);

procedure leerVentas(var v:ventas);
begin
	v.dni:=random(100);
	if(v.dni <> cod_fin)then begin
		v.codSuc:= 1+ random(11);
		v.factura:= 1+ random(200);
		v.monto:= random(20000) / (random(10)+1);
	end;
end;

procedure cargarRegArbol(v:ventas; var  rA:regArbol; var rl:regLista);
begin
		rA.dni:= v.dni;
		rl.factura:=v.factura;
		rl.monto:=v.monto;
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

procedure insertarArbol(var a:arbol; rA:regArbol; rl:regLista);
begin
	if(a=nil)then begin
		new(a);
		a^.dato.dni:=rA.dni;
		a^.dato.lista:= nil;
		a^.HI:= NIL;
		a^.HD:= NIL;
		agregarAdelante(a^.dato.lista, rl);
	end
	else
		if(a^.dato.dni = rA.dni)then
			agregarAdelante(a^.dato.lista,rl)
		else 
			if(rA.dni < a^.dato.dni )then
				insertarArbol(a^.HI,rA,rL)
			else	
				insertarArbol(a^.HD,rA,rL)
end;
		

//------------------proc cargar arbol----------------------
var
	v:ventas;
	rA:regArbol;
	rl:regLista;
	vec:vectorVentas;
begin
		leerVentas(v);
		while(v.dni <> cod_fin)do begin
				cargarRegArbol(v,rA,rl);
				insertarArbol(a,rA,rl);
				vec[v.codSuc]:=vec[v.codSuc]+1;
				leerVentas(v);
		end;
end;

procedure inicializarVector(var v:vectorVentas);
var
	i:rango_suc;
begin
	for i:= 1 to max_sucursal do
		v[i]:= 0;
end;
//----------------------------------------inciso b--------------------
function recorrerLista(l:lista ;monto:real):integer;
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		if(l^.dato.monto < monto)then 
			cant:=cant+1;
		l:=l^.sig;
	end;
	recorrerLista:=cant;
end;
			
function cantidadFacturas(a:arbol; monto:real; dni:integer):integer;
begin
	if(a=nil)then
		cantidadFacturas:=0
	else begin
		if(a^.dato.dni= dni)then 
				cantidadFacturas:=recorrerLista(a^.dato.lista,monto)
		else 	
			if(a^.dato.dni > dni)then
				cantidadFacturas:=  cantidadFacturas(a^.HI,monto,dni)
			else
				cantidadFacturas:=  cantidadFacturas(a^.HD,monto,dni)
	end;
end;

//--------------inciso c
function existeSucursal(v:vectorVentas; i:integer; valor:integer):boolean;
begin
	if(i<=12)then begin
		if(v[i]= valor)then
			existeSucursal:=true
		else
			existeSucursal:= existeSucursal(v,i+1,valor);
	end;
end;
	
procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('factura:  ',l^.dato.factura);
		writeln('monto:   ',l^.dato.monto :0:2);
		l:=l^.sig;
	end;
end;
		
		
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('dni:    ' , a^.dato.dni);
		writeln('--lista--');
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.HD);
	end;
end;
	

//------------------programa principal--------------------
var
	a:arbol;
	v:vectorVentas;
	monto:real;
	dni,valor,i,cantF:integer;
begin
	a:=nil;
	cargarArbol(a);
	inicializarVector(v);
	writeln('-----------Arbol----------');
	imprimirArbol(a);
	writeln('Ingrese un monto:    '); readln(monto);
	writeln('Ingrese un dni:    '); readln(dni);
	cantF:= (cantidadFacturas(a,monto,dni));
	writeln('La cantidad de facturas con monto inferior al ingresado es:    ', cantF);
	
	writeln('Ingrese un valor'); readln(valor);
	i:=1;
	if (existeSucursal(v,i,valor)) then
		writeln('Existe una sucursal con la misma cantidad ')
	else
		writeln('No existe ');
	
end.
