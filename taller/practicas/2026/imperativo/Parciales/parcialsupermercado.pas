program parcialSupermercado;

Const
	cod_max=10;
	cli_fin=0;
Type
	rango_cod= 1..cod_max;
	
	venta=record
		dni:integer;
		codSuc:rango_cod;
		factura:integer;
		monto:real;
	end;
	
	regLista=record
		factura:integer;
		monto:real;
	end;
	
	lista=^nodoL;
	nodoL=record
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
	
	vVentas= array[rango_cod]of integer;
//------------------------------------------------FIN TYPE---------------------------

//------------------------------------CARGA DE ESTRUCTURAS-----------------------
procedure cargarEstructuras( var a:arbol; var v:vVentas);

	procedure leerVenta(var v:venta);
	begin
		v.dni:=random(50);
			if(v.dni <> cli_fin)then begin
				v.codSuc:=1+ random(10);
				v.factura:= random(100);
				v.monto:=  random(2000)/(random(10)+1);
			end;
	end;

	procedure inicializarVContador(var v:vVentas);
	var
		i:rango_cod;
	begin
		for i:= 1 to cod_max do
			v[i]:=0;
	end;
	
	procedure cargarReg(rv:venta; var rl:regLista);
	begin
		rl.factura:=rv.factura;
		rl.monto:= rv.monto;
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
	
	
	procedure cargarArbol(var a:arbol; rl:regLista;dni:integer);
	begin
		if(a=nil)then begin
			new(a);
			a^.HI:=NIL;
			a^.HD:=NIL;
			a^.dato.dni:=dni;
			a^.dato.lista:=nil;
			agregarAdelante(a^.dato.lista,rl);
		end
		else begin	
			if(dni<a^.dato.dni)then
				cargarArbol(a^.HI, rl,dni)
			else
				if(a^.dato.dni= dni)then
					agregarAdelante(a^.dato.lista,rl)
				else
					cargarArbol(a^.HD,rl,dni)
		end;
	end;


var
	rL:regLista;
	rv:venta;
begin
	inicializarVContador(v);
	leerVenta(rv);
	while(rv.dni <> cli_fin)do begin
		cargarReg(rv,rl);
		cargarArbol(a,rl,rv.dni);
		v[rv.codSuc]:=v[rv.codSuc]+1;
		leerVenta(rv);
	end;
end;
//----------------------------------------FIN CARGA DE ESTRUCTURAS----------------------------

//--------------------------IMPRIMIR ESTRUCTURAS PARA PRUEBA---------------
procedure imprimirEstructuras(a:arbol; v:vVentas);

	procedure imprimirLista(l:lista);
	begin
		while(l<>nil)do begin
			writeln('factura:    ',l^.dato.factura);
			writeln('monto:    ',l^.dato.monto :2:2);
			writeln('.................................................');
			l:=l^.sig;
		end;
	end;
	
	procedure imprimirArbol(a:arbol);
	begin
		if(a<>nil)then begin
			imprimirArbol(a^.HI);
			writeln('dni:    ',a^.dato.dni);
			writeln('--------LISTA-------');
			imprimirLista(a^.dato.lista);
			imprimirArbol(a^.HD);
		end;
	end;			

	procedure imprimirVector(v:vVentas);
	var
		i:rango_cod;
	begin
		for i:= 1 to cod_max do begin
			writeln('cantidad de ventas de ', i , ' es: ', v[i]);
			writeln('---------------------------------');
		end;
	end;
			

begin
	writeln('-----------------------ARBOL----------------------');
	imprimirArbol(a);
	writeln();
	writeln('-------------------------VECTOR-------------');
	imprimirVector(v);
end;

//---------------------------------------------------------------------------
//--------------------------------INCISO B-------------------------------------------
function incisoB(a:arbol):integer;

	function contarEnLista(l:lista; monto:real):integer;
	var
		cant:integer;
	begin
		cant:=0;
		while(l<> nil)do begin
			if(l^.dato.monto> monto)then 
				cant:= cant+1;
			l:=l^.sig;
		end;
		contarEnLista:=cant;
	end;
				

	function cantidadFacturas(a:arbol; monto:real; dni:integer):integer;
	begin
		if(a=nil)then 
			cantidadFacturas:=0
		else begin
			if (a^.dato.dni = dni)then
				cantidadFacturas:= contarEnLista(a^.dato.lista, monto)
			else if(dni < a^.dato.dni)then
				cantidadFacturas:= cantidadFacturas(a^.HI, monto,dni)
				else
					cantidadFacturas:= cantidadFacturas(a^.HD, monto,dni);
		end;
	end;
	
var
	monto:real;
	dni:integer;

begin
	writeln('Ingresar un  monto');
	readln(monto);
	writeln('Ingresar un dni');
	readln(dni);
	incisoB:=cantidadFacturas(a,monto,dni);
end;
//---------------------------------------------------------------------------
//-------------------INCISO C--------------------------------------
function incisoC(v:vVentas):integer;
	
	procedure sucursalMasVentas(v:vVentas;  i:integer; var maxS,cantMax:integer);
	begin
		if(i<11)then begin
			if(v[i]> cantMax)then begin
				cantMax:=v[i];
				maxS:=i;
			end;
			sucursalMasVentas(v, i+1, maxS, cantMax);
		end;
	end;
		
var
	cantMax, maxS:integer;
	
begin
	maxS:=-1;
	cantMax:=-1;
	sucursalMasVentas(v, 1, maxS ,cantMax);
	incisoC:= maxS;
end;

//---------------------------------PROGRAMA PRINCIPAL-------------------------------
var
	v:vVentas;
	a:arbol;
begin
	a:=NIL;
	randomize;
	cargarEstructuras(a,v);
	imprimirEstructuras(a,v);
	writeln('La cantidad de facturas con monto mayor al ingresado es ', incisoB(a));
	writeln('La sucursal con mayor cantidad de ventas es:  ',incisoC(v));
	
	
end.	
	
	
