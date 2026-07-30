{Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.
* 
b.Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el código de producto con mayor cantidad de unidades vendidas.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.
* e)retornar el monto total entre todos los codigos de productos comprendidos entre dos vaLores recibidos(sin incluir como parametros)}
program ej3p4;
Const
	cod_fin=-1;
Type
	producto=record
		cod:integer;
		cantTotal:integer;
		montoTotal:real;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:producto;
		HI:arbol;
		HD:arbol;
	end;
	
	venta=record
		codVenta:integer;
		codProd:integer;
		cantVendidas:integer;
		precioUni:real;
	end;
		

procedure cargarArbol(var a:arbol); //------------------------proceso de carga del arbol----------------------------------

procedure leerVenta(var v:venta);
begin
	v.codVenta:= random(30)-1;
	if(v.codVenta<>cod_fin)then begin
		v.codProd:= random(50)+1;
		v.cantVendidas:= random(50)+1;
		v.precioUni:= random(100);
	end;
end;

procedure cargarProducto(var p:producto; v:venta);
begin
	p.cod:=v.codProd;
	p.cantTotal:=v.cantVendidas;
	p.montoTotal:=v.precioUni*v.cantVendidas;
end;


procedure insertarArbol(var a:arbol; p:producto);
begin
	if(a = nil)then begin
		new(a); a^.dato:=p;
		a^.HI:=NIL;
		a^.HD:=NIL;
	end
	else if (p.cod = a^.dato.cod)then begin
		a^.dato.cantTotal:=a^.dato.cantTotal+ p.cantTotal;
		a^.dato.montoTotal:=a^.dato.montoTotal+p.montoTotal;
		end 
		else if (p.cod < a^.dato.cod)then 
			insertarArbol(a^.HI,p)
		else
			insertarArbol(a^.HD,p)
end;			
		

var
	v:venta;
	p:producto;
begin
	leerVenta(v);
	while(v.codVenta<>cod_fin)do begin
		cargarProducto(p,v);
		insertarArbol(a,p);
		leerVenta(v);
	end;
end;
	
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('  Codigo:  ',a^.dato.cod, '  Cantidad de ventas:  ', a^.dato.cantTotal, '  Monto total: ', a^.dato.montoTotal:0:2);
		imprimirArbol(a^.HD);
	end;
end;
//c. Retornar el código de producto con mayor cantidad de unidades vendidas		 
procedure codigoMaxVentas(a:arbol;var cantMax,codMax:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.cantTotal > cantMax)then begin
			cantMax:=a^.dato.cantTotal;
			codMax:= a^.dato.cod;
		end;
		codigoMaxVentas(a^.HI,cantMax,codMax);
		codigoMaxVentas(a^.HD,cantMax,codMax);
	end;
end;
		0
//d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro
function codigosMenores(a:arbol; valor:integer):integer;
begin
	if(a=nil)then 
		codigosMenores:=0
	else if(a^.dato.cod < valor)then 
		codigosMenores:=1+ codigosMenores(a^.HI,valor)+ codigosMenores(a^.HD,valor)
		else
			codigosMenores:=codigosMenores(a^.HI,valor)+ codigosMenores(a^.HD,valor);
end;
	
//e)retornar el monto total entre todos los codigos de productos comprendidos entre dos vaLores recibidos(sin incluir como parametros)}	
function montoTotalEnRangos(a:arbol; rangoA,rangoB:integer ):real;
begin
	if(a=nil)then 
		montoTotalEnRangos:=0
	else
		if(a^.dato.cod>rangoA)then begin
				if(a^.dato.cod<rangoB)then
						montoTotalEnRangos:=a^.dato.montoTotal + montoTotalEnRangos(a^.HI,rangoA,rangoB)+montoTotalEnRangos(a^.HD ,rangoA,rangoB)
				else
						montoTotalEnRangos:= montoTotalEnRangos(a^.HI,  rangoA, rangoB)
		end
		else
			montoTotalEnRangos:=montoTotalEnRangos(a^.HD,rangoA,rangoB)
end;



	
var
	a:arbol;
	codMax,cantMax,valor,cantMenores:integer;
	rangoA,rangoB:integer;
	montoTotal:real;
begin
	a:=NIL;
	randomize;
	cargarArbol(a);
	imprimirArbol(a);
	cantMax:=-9999;
	codMax:=-1;
	codigoMaxVentas(a,cantMax,codMax);
	writeln('El codigo:  ', codMax ,'es el codigo con mayor unidades vendidas:  ', cantMax);
	
	writeln('Ingrese un valor:  '); readln(valor);
	cantMenores:= codigosMenores(a,valor);
	writeln('la cantidad de codigos menores a ', valor, ' es: ', cantMenores);
	
	writeln('Ingrese dos codigos a funcionar como rangos:  ');
	readln(rangoA);readln(rangoB);
	montoTotal:=0;
	montoTotal:= montoTotalEnRangos(a,rangoA,rangoB);
	writeln('El monto total de todos los codigos entre rangos es:    ',montoTotal:0:2);
	
end.
