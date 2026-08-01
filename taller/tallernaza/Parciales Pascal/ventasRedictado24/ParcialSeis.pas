program ParcialSEIS;
const
	dimf = 5;
type 
	rango = 1..dimf;
	venta = record
		codigo:integer;
		dni:integer;
		sucursal:rango;
		monto:real;
	end;
	
	vector = array [rango] of real;
	
	registroArbol = record
		dni:integer;
		sucursal:vector;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:registroArbol;
		hi:arbol;
		hd:arbol;
	end;
	

{-------------------------------}

procedure leerVenta(var ven:venta);
begin
	ven.codigo:=random(20);{puse poquitos para que cargue muchos al arbol y poder comprobar}
	if(ven.codigo <> 0) then begin
		ven.dni:=random(20)+1; {y aca puse poquitos tambien para que al menos alguno se repita}
		ven.sucursal:=random(5)+1;
		ven.monto:=5000+(random* 5001);
	end;
end;

procedure inicializoSucursales(var v:vector);
var
	i:integer;
begin
	for i:= 1 to dimf do
		v[i]:=0;
end;

procedure agregoNodo(var a:arbol; ven:venta);
begin
	if(a=nil) then begin
		new(a);
		a^.dato.dni:=ven.dni;
		inicializoSucursales(a^.dato.sucursal);
		a^.dato.sucursal[ven.sucursal]:=a^.dato.sucursal[ven.sucursal]+ven.monto;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else
		if(ven.dni = a^.dato.dni) then 
			a^.dato.sucursal[ven.sucursal]:=a^.dato.sucursal[ven.sucursal]+ven.monto
		else begin
			if(ven.dni < a^.dato.dni) then
				agregoNodo(a^.hi,ven)
			else
				agregoNodo(a^.hd,ven);
		end;
end;

procedure imprimirVector(v:vector);
var
	i:integer;
begin
	for i:= 1 to dimf do begin
		writeln('Sucursal ',i,': ',v[i]:0:2);
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbol(a^.hi);
		writeln('Dni del cliente: ',a^.dato.dni,' monto total en las 5 sucursales: ');
		imprimirVector(a^.dato.sucursal);
		imprimirArbol(a^.hd);
	end;
end;

procedure moduloA(var a:arbol);
var
	ven:venta;
begin
	a:=nil;
	leerVenta(ven);
	Randomize;
	while(ven.codigo <> 0) do begin
		agregoNodo(a,ven);
		leerVenta(ven);
	end;
	
	imprimirArbol(a);{para comprobar datos cargados}
end;

procedure recorroYbusco(a:arbol; sucu:integer; var cant:integer);
begin
	if(a<>nil) then begin
		if(a^.dato.sucursal[sucu] =0) then
			cant:=cant+1;
		recorroYbusco(a^.hi,sucu,cant);
		recorroYbusco(a^.hd,sucu,cant);
	end;
end;

procedure moduloB(a:arbol);
var
	sucu:integer;
	cant:integer;
begin
	writeln('Ingrese un numero de sucursal: ');
	readln(sucu);
	cant:=0;
	recorroYbusco(a,sucu,cant);
	writeln('La cantidad de clientes que no gastaron nada en la sucursal',sucu,' es: ', cant);
end;

procedure recorroVector(v:vector; var monto:real);
var 
	i:integer;
begin
	for i:= 1 to dimf do begin
		if(v[i] <> 0) then
			monto:= monto + v[i];
	end;
end;

procedure montoTotal(a:arbol; dni:integer; var monto:real);
begin
	if(a<>nil) then begin
		if (a^.dato.dni = dni) then
			recorroVector(a^.dato.sucursal,monto)
		else begin
			if(dni < a^.dato.dni) then
				montoTotal(a^.hi,dni,monto)
			else
				montoTotal(a^.hd,dni,monto);
		end;
	end;
end; 

procedure moduloC(a:arbol);
var
	dni:integer;
	monto:real;
begin
	monto:=0;
	writeln('ingrese un dni (de 1 a 20): ');
	readln(dni);
	montoTotal(a,dni,monto);
	writeln('El monto total gastado del dni ',dni,', es: ',monto:0:2);
end;
{--------------------------------}
var
	a:arbol;
BEGIN
	moduloA(a);
	moduloB(a);
	moduloC(a);
END.

