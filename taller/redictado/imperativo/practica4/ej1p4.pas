program ej1p4;
Const
	cod_FIN=0;
Type
	
	producto=record
		codP:integer;
		cantTotal:integer;
		montoTotal:real;
	end;
	
	venta=record
		codV:integer;
		codProd:integer;
		cantVentas:integer;
		precioUni:real;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:producto;
		HI:arbol;
		HD:arbol;
	end;
//--------------------------------------------------------------------------
{ Almacene los productos vendidos en una estructura eficiente para la búsqueda por código de producto. 
* De cada producto deben quedar almacenados la cantidad total de unidades vendidas y el monto total. }
procedure cargarArbol(var a:arbol);

	procedure leerVenta(var v:venta);
	begin
		v.codV:= random(51);
		if(v.codV <> cod_fin)then begin
			v.codProd:= random(100);
			v.cantVentas:= random(20)+1;
			v.precioUni:= (100 + random(100))/2;
		end;
	end;
	procedure cargarReg(v:venta; var p:producto);
	begin
		p.codP:=v.codProd;
		p.cantTotal:=v.cantVentas;
		p.montoTotal:=v.cantVentas*v.precioUni;
	end;
	
	procedure insertarArbol(var a:arbol; p:producto; precio:real);
	begin
		if(a=nil)then begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato:=p;
		end
		else 
			if(p.codP= a^.dato.codP)then begin
				a^.dato.cantTotal:=a^.dato.cantTotal+p.cantTotal; 
				a^.dato.montoTotal:=a^.dato.montoTotal+ (p.cantTotal *precio);
			end
			else if(p.codP < a^.dato.codP)then
				insertarArbol(a^.HI, p,precio)
				else
					insertarArbol(a^.HD,p,precio);
	end;
	
var
	v:venta;
	p:producto;
begin
	randomize;
	leerVenta(v);
	
	while(v.codV<> cod_fin)do begin
		cargarReg(v,p);
		insertarArbol(a,p,v.precioUni);
		leerVenta(v);
	end;
end;
//------------------------------------------------------
//b. Imprimir el contenido del árbol ordenado por código de producto. 
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('Codigo de producto:  ',a^.dato.codP);
		writeln('Cantidad total:  ',a^.dato.cantTotal);
		writeln('Monto total:  ',a^.dato.montoTotal);
		imprimirArbol(a^.HD);
	end;
end;	
//-c. Retornar el menor código de producto. 
function codMenor(a:arbol):integer;
begin
	if(a=nil)then 
		codMenor:=-1
	else
		if(a^.HI=nil)then
			codMenor:= a^.dato.codP
		else
			codMenor:= codMenor(a^.HI);
end;

//. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe
// como parámetro. 
function codigosMenores(a:arbol;valor:integer):integer;
begin
	if(a=nil)then
		codigosMenores:=0
	else
		if(a^.dato.codP < valor)then
			codigosMenores:=1+ codigosMenores(a^.HI,valor)+ codigosMenores(a^.HD, valor)
		else
			codigosMenores:= codigosMenores(a^.HI,valor)
end;
			
//e. Retornar el monto total entre todos los códigos de productos comprendidos entre 
//dos valores recibidos (sin incluir) como parámetros. 		
function montoTotalEntreValores(a:arbol; num1,num2:integer):real;
begin
	if(a= nil)then
		montoTotalEntreValores:=0
	else begin
		if(a^.dato.codP > num1)then
			if(a^.dato.codP < num2)then
				montoTotalEntreValores:= montoTotalEntreValores(a^.HI,num1,num2)+montoTotalEntreValores(a^.HD,num1,num2)+ a^.dato.montoTotal
			else
				montoTotalEntreValores:=montoTotalEntreValores(a^.HI,num1,num2)
		else
			montoTotalEntreValores:=montoTotalEntreValores(a^.HD,num1,num2)
	end;
end;			

//-----------------------------------PROGRAMA PRINCIPAL--------------------	
var
	a:arbol;
	valor,codMin:integer;
	num1,num2:integer;
	
begin
	a:=nil;
	codMin:=9999;
	cargarArbol(a);
	imprimirArbol(a);
	writeln('El codigo de producto menor es: ', codMenor(a));
	writeln('Ingrese un valor:  ');readln(valor);
	writeln('La cantidad de codigos menores a ', valor, ' es : ', codigosMenores(a,valor));
	writeln('Ingrese el valor 1 para usar como parametro: ');readln(num1);
	writeln('Ingrese el valor 2 para usar como parametro: ');readln(num2);
	writeln('El monto total entre los codigos recibidos es: ', montoTotalEntreValores(a,num1,num2));
end.
