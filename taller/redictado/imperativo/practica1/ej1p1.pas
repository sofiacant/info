{Se desea procesar la información de las ventas de productos de un comercio (como máximo 50). 
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el día de la venta, código del producto (entre 1 y 15)
 y cantidad vendida (como máximo 99 unidades). El código y el dia deben generarse automáticamente (random) y la cantidad se debe leer. 
 El ingreso de las ventas finaliza con el día de venta 0 
(no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a mayor) de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).
}

program ej1p1;
Const
	dimF=50;
	maxU=99;
	maxCod=15;
	maxDias=31;
Type
	rango_cod= 1..maxCod;
	rango_dia= 1..maxDias;
	rango_vector= 1..dimF;
	
	regVenta= record
		dia:rango_dia;
		codProd:rango_cod;
		cant:integer;
	end;
	vectorVentas= array [rango_vector]of regVenta;
	
procedure cargarVector(var v:vectorVentas; var dimL:integer);

	procedure leerVentas(var v:regVenta);
	begin
		randomize;
		writeln('Dia: ');
		v.dia:= random(32);
		if(v.dia<>0)then begin
			writeln('Codigo: ');
			v.codProd:= random(16)+1;
	
			writeln('ingrese una cantidad entre 1 y 99');
			readln(v.cant);
		end;
	end;

var
	rV:regVenta;
begin
	dimL:=0;
	leerVentas(rV);
	while(rV.dia<>0) and (dimL<dimF)do begin
		dimL:=dimL+1;
		v[dimL]:=rV;
		leerVentas(rV);
	end;
end;
		
//b: Un módulo que muestre el contenido del vector resultante
procedure imprimirVector(v:vectorVentas; dimL:integer) ;
var
	i:integer;
begin
	for i:= 1 to dimL do begin
		writeln('Dia: ', v[i].dia);
		writeln('Codigo de producto: ', v[i].cod);
		writeln('Cantidad de ventas: ', v[i].cant);
	end;
end;

//c. Un módulo que ordene el vector de ventas por código.
procedure ordenarVector(var v:vector; dimL:integer);
var
	pos,i,j:integer;
	item:regVenta;
begin
	for i:= 1 to dimL-1 do begin
		pos:=i;
		for j:=i+1 to dimL do begin
			if(v[j]< v[pos])then
				pos:=j;
		item:=v[pos];
		v[pos]:= v[i];
		v[i]:=item;
	end;
end;

//e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre dos valores que se ingresan como parámetros.	
procedure eliminar(var v:vectorVentas; var dimL:integer;num1,num2:integer);
var
	pos:integer;
begin
	if(v)

//--------------------------PROGRAMA PRINCIPAL-----------------------------------
var
	v:vectorVentas;  
	dimL:integer; 
	num1,num2:integer;
begin
	cargarVector(v,dimL);
	imprimirVector(v,dimL);
	ordenarVector(v,dimL);
	imprimirVector(v,dimL);
	writeln('Ingrese dos numeros');
	readln(num1);
	readln(num2);
	eliminar(v,num1,num2);
	
end.
