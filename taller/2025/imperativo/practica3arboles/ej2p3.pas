{2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:

i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.  

ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.

iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.}

//arbol 3: codigo / lista:contiene el reg ventasAux(fechas, cantidad)

program ej2p3;
Const
	cod_fin= 0;
Type
	//arbol 1
	venta=record
		codigo:integer;
		fecha:integer;
		cantVendidas:integer;
	end;
	
	arbol=^nodo;
	nodo=record
		dato:venta;
		HI:arbol;
		HD:arbol;
	end;
    //arbol 2
    venta2=record
        codigoP:integer;
        cantTotal:integer;
    end;
    
     arbol2=^nodo2;
	  nodo2=record
		dato:venta2;
		HI:arbol2;
		HD:arbol2;
	end;
	
	//III  
    ventaAuxIII=record
		fecha:integer;
		cantVendidas:integer;
	end;
    
	listaVentas=^nodoV;
	nodoV= record
		dato:ventaAuxIII;
		sig:listaVentas;
	end;
		
	venta3= record
		codigo:integer;
		lista:listaVentas;
	end;
	
	arbol3=^nodo3;
	nodo3=record
		dato:venta3;
		HI:arbol3;
		HD:arbol3;
	end;
	


procedure imprimir (a1:arbol);
begin
	if (a1<>nil) then
	begin
		imprimir(a1^.HI);
		writeln('-------------------------------ARBOL 1--------------------------------');
		writeln('Codigo: ',a1^.dato.codigo ,' | cantidad vendidas: '  , a1^.dato.cantVendidas, 'fecha: ',a1^.dato.fecha);
		imprimir(a1^.HD);
	end;
end;

procedure imprimirA2 (a2:arbol2);
begin
	if (a2<>nil) then
	begin
		imprimirA2(a2^.HI);
		writeln('--------------------------ARBOL 2------------------------------');
		writeln('Codigo: ',a2^.dato.codigoP ,' cantidad vendidas: '  , a2^.dato.cantTotal);
		imprimirA2(a2^.HD);
	end;
end;

procedure imprimirLista(l:listaVentas);
begin
	while(l<>nil) do begin
		writeln('---------------------------ARBOL 3----------------------------------');
		writeln('la fecha: ' ,l^.dato.fecha);
		writeln('la cantidad de ventas:  ',l^.dato.cantVendidas);
		l:=l^.sig;
	end;
end;

procedure imprimira3 (a3:arbol3);
begin
	if (a3<>nil) then
	begin
		imprimira3(a3^.HI);
		writeln('-------------------LISTA DE ARBOL 3---------------------');
		writeln('Codigo: ',a3^.dato.codigo ); 
		imprimirLista(a3^.dato.lista);
		imprimira3(a3^.HD);
	end;
end;



procedure cargarArboles(var a1:arbol; var a2:arbol2; var a3:arbol3);

procedure cargarVenta(var v:venta);
begin
	v.codigo:=random(50);
	if (v.codigo <> cod_fin) then
	begin
		v.fecha:=random(50);
		v.cantVendidas:=random(50);
	end;
end;

procedure AgA1(var a:arbol; v:venta);
begin
	if (a = nil) then begin
		new(a);
		a^.dato:=v;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else if (v.codigo >= a^.dato.codigo ) then
			AgA1(a^.HD,v)
		else
			AgA1(a^.HI,v);
end;

procedure AgA2(var a2:arbol2; v:venta);
begin
	if (a2 = nil) then begin
		new(a2);
		a2^.dato.codigoP:=v.codigo;
		a2^.dato.cantTotal:=v.cantVendidas;
		a2^.HI:=nil;
		a2^.HD:=nil;
	end
	else if (v.codigo > a2^.dato.codigoP ) then
			AgA2(a2^.HD,v)
		else if (v.codigo = a2^.dato.codigoP ) then
			a2^.dato.cantTotal:= a2^.dato.cantTotal + v.cantVendidas
			else
				AgA2(a2^.HI,v);
end;

procedure agregarAdelante(var l:listaVentas; v:ventaAuxIII);
var
	nue:listaVentas;
begin
	new(nue);
	nue^.dato:= v;
	nue^.sig:=l;
	l:= nue;
end;

procedure cargarVAux(var vAux:ventaAuxIII; v:venta);
begin
	vAux.fecha:=v.fecha;
	vAux.cantVendidas:=v.cantVendidas;
end;


procedure AgA3(var a3:arbol3; v:venta; vAux:ventaAuxIII);
begin
	if (a3 = nil) then begin
		new(a3); 
		a3^.dato.codigo := v.codigo;
		a3^.dato.lista:=NIL;
		agregarAdelante(a3^.dato.lista,vAux);
		a3^.HI:=nil;
		a3^.HD:=nil;
	end
	else if (v.codigo > a3^.dato.codigo ) then
			AgA3(a3^.HD,v,vAux)
		else if (v.codigo = a3^.dato.codigo ) then
			agregarAdelante(a3^.dato.lista,vAux)
			else
				AgA3(a3^.HI,v,vAux);
end;

//del proceso cargar arboles
var
	v:venta;
	vAux:ventaAuxIII;	
begin
	cargarVenta(v);
	while(v.codigo <> cod_fin)do begin
        AgA1(a1,v);
        AgA2(a2,v);
        cargarVAux(vAux,v);
        AgA3(a3,v,vAux);
        cargarVenta(v);
    end;
end;

//b. Implemente un módulo que reciba el árbol generado en i. y una fecha 
//y retorne la cantidad total de productos vendidos en la fecha recibida.
{procedure contarProductosA1(a1:arbol; f:integer; var cantTotal:integer); //       CONSULTA
begin
	if(a1<> NIL)then begin
		contarProductosA1(a1^.HI,f,cantTotal);
		if( a1^.dato.fecha = f)then
			cantTotal:= a1^.dato.cantVendidas;
		contarProductosA1(a1^.HD,f, cantTotal);
	end;
end;
}
function contarProductosA1f(a1:arbol; f:integer):integer;
begin
	if(a1=nil)then 
		contarProductosA1f:=0
	else begin
		if(a1^.dato.fecha= f)then
			contarProductosA1f := a1^.dato.cantVendidas + contarProductosA1f(a1^.HI,f)+ contarProductosA1f(a1^.HD,f);
		else
			contarProductosA1f := contarProductosA1f(a1^.HI, f) + contarProductosA1f(a1^.HD, f);
end;

//c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
//con mayor cantidad total de unidades vendidas. 	
procedure codigoMaximo(a2:arbol2; var cantMax,codMax:integer);
begin
	if(a2 <> nil)then begin
		if (a2^.dato.cantTotal > cantMax)then begin
			codMax:= a2^.dato.codigoP;
			cantMax := a2^.dato.cantTotal;
		end;
			codigoMaximo(a2^.HI, cantMax,codMax);
			codigoMaximo(a2^.HD, cantMax,codMax);
	end;
end;
			
	
//d. Implemente un módulo que reciba el árbol generado en iii. 
//y retorne el código de producto con mayor cantidad de ventas.
procedure codMaxListas(l:listaVentas; cod:integer; var codMax:integer; var maxVentas:integer);
var
	cantTotal:integer;
begin
	cantTotal:=0;
	if(a<>nil)then begin
		recorrerLista(a^.dato.lista,cantTotal);
		if (cantTotal > maxVentas) then begin
			maxVentas:= cantTotal;
			codMax:= cod;
	end;
end;

procedure recorrerLista(l:lista; var cantTotal:integer);
begin
	while(l<> nil )do begin
		cantTotal:=cantTotal+ l^.dato.cantVendidas;
		l:=l^.sig;
	end;
end;

function codigoMaximoIII(a3:arbol3;cod:integer;codMax3:integer; maxVentas:integer; cantTot:integer):integer;
begin
	if(a3 = nil)then 
		codigoMaximoIII:= -1
	else begin
		writeln('deb');
		codMaxListas(a3^.dato.lista,a3^.dato.codigo,codMax3,maxVentas);
		codigoMaximoIII(a3^.HI, a3^.dato.codigo ,codMax3 ,maxVentas);
		codigoMaximoIII(a3^.HD, a3^.dato.codigo ,codMax3 ,maxVentas);
	end;
	codigoMaximoIII:= codMax3;
end;




//variables del programa principal
var
	a1:arbol;
	a2:arbol2;
	a3:arbol3;
	f,cantTotal,cantMax,cod,codMax,codMaxIII,codMax3,maxVentas,cantTot:integer;
	
begin
	a1:=NIL;
	a2:=NIL;
	a3:=NIL;
	cod:=-1;
	cantTotal:=0;
	cantMax:=-999;
	codMax:=-1;
	maxVentas:=-999;
	codMax3:=-9999;
	cantTot:=0;
	randomize;
	cargarArboles(a1,a2,a3);
	imprimir(a1);
	imprimira2(a2);
	imprimira3(a3);
	writeln('Ingrese una fecha en la que se cuenten la totalidad de productos');
	readln(f);
	contarProductosA1f(a1,f);
	writeln('la cantidad total de productos vendidos en la fecha recibida es: ',cantTotal);
	codigoMaximo(a2,codMax,cantMax);
	codMaxIII:= codigoMaximoIII( a3,cod,codMax3,maxVentas,cantTot);
	writeln(codMaxIII);

	writeln('El codigo de producto con mayor cantidad de ventas es: ',codMaxIII);
end.

