{Se desea procesar las pólizas de una compañía de seguros. De cada póliza se conoce: DNI del cliente, suma asegurada, 
valor cuota y fecha de vencimiento. 
Un cliente puede tener más de una póliza. Las pólizas se comenzaron a emitir a partir del 2000 y finalizaron 
de emitirse en 2023.
Realice un programa que contenga:
	a) Un módulo que lea pólizas, hasta leer una póliza con DNI -1, y las almacene en una estructura eficiente para la 
búsqueda por suma asegurada.
	b) Un módulo que reciba la estructura generada en a) y devuelva otra estructura con las pólizas cuya suma asegurada 
sea menor a un valor recibido por parámetro. Esta estructura debe estar agrupada por año de vencimiento 
y ordenada por DNI de cliente.
	c) Un módulo que reciba la estructura generada en b) y devuelva la cantidad de pólizas de un cliente cuyo DNI se 
recibe por parámetro.
* }

program parcial8;
Const
	dni_fin= -1;
Type
	rango_anios= 2000..2023 ;
	poliza=record 
		dni:integer;
		suma:integer; //real
		valorCuota:integer;   //real
		fecha:rango_anios;
	end;
	
	poliza2=record
		dni:integer;
		suma:integer;
		valorCuota:integer;
	end;
	
	lista=^nodolis;
	
	nodolis=record
		dato:poliza2;
		sig:lista;
	end;

	
	arbol=^NodoArbol; 
	
	NodoArbol=record
		dato:poliza;
		HI:arbol;
		HD:arbol;
	end;
	
	VectorListas = array [rango_anios] of lista;
	
// --- MODULOS 

procedure agregarArbol(var a: arbol; p: poliza);
begin 
	if (a = NIL) then begin 
		new(a); a^.dato := p; 
		a^.hi := NIL; 
		a^.hd := NIL;
	end else begin 
		if (p.suma < a^.dato.suma) then begin 
			agregarArbol(a^.hi, p);
		end else begin 
			agregarArbol(a^.hd, p);
		end;
	end; 
end; 

procedure leerPoliza(var p: poliza);
begin 
	writeln('Ingrese el DNI del cliente: '); 		p.dni := random(15) - 1; 
	writeln(p.dni);
	if (p.dni <> dni_fin) then begin 
		writeln('Ingrese la suma asegurada: '); 		p.suma := random(1000)+1; 
		writeln(p.suma);
		writeln('Ingrese el valor de la cuota: '); 		p.valorCuota := random(1000)+1; 
		writeln(p.valorCuota);
		writeln('Ingrese la fecha de vencimiento: '); 	p.fecha := 2000 +random(24); 
		writeln(p.fecha);
	end;
end;

procedure cargarArbolPolizas(var a: arbol);
var p: poliza;
begin 
	leerPoliza(p);
	while (p.dni <> dni_fin) do begin 
		agregarArbol(a,p);
		leerPoliza(p);
	end; 
end;

procedure inicializarVectorListas(var vL: VectorListas);
var i: rango_anios;
begin 
	for i := 2000 to 2023 do vl[i] := NIL;
end; 

{b) Un módulo que reciba la estructura generada en a) y devuelva otra estructura con las pólizas cuya suma asegurada 
sea menor a un valor recibido por parámetro. Esta estructura debe estar agrupada por año de vencimiento 
y ordenada por DNI de cliente.}
//-----------------------------------------------------------------CREACION DE LISTA----------------------------------------
procedure insertarOrdenadoV(var l:lista ;p2:poliza2);
var
	nue,ant,act:lista;
begin
	new(nue);
	nue^.dato:=p2;
	ant:=l;
	act:=l;
	while(act<>NIL)and(p2.dni > act^.dato.dni)do begin
		ant:=act;
		act:=act^.sig;
	end;
	if(act=L)then
		l:=nue
	else
		ant^.sig:= nue;
	nue^.sig:= act;
end;


procedure cargarPoliza2(p:poliza;var p2:poliza2);
begin
	p2.dni:= p.dni;
	p2.suma:=p.suma;
	p2.valorCuota:=p.valorcuota;
end;

//b) Un módulo que reciba la estructura generada en a) y devuelva otra estructura con las pólizas cuya suma asegurada 
//sea menor a un valor recibido por parámetro. Esta estructura debe estar agrupada por año de vencimiento  y ordenada por DNI de cliente.
procedure procesarArbol(a: arbol; valor: real; var v:vectorListas);//preguntar
var
  p2:poliza2;
begin 
	if (a <> NIL) then begin 		
		if (a^.dato.suma < valor) then begin
			cargarpoliza2(a^.dato,p2);
			write('------',a^.dato.fecha);
			insertarOrdenadoV(v[a^.dato.fecha],p2);
			procesarArbol(a^.hi,valor,v);
			procesarArbol(a^.hd,valor,v);
		end
		
		else begin
			writeln(a^.dato.suma);
			procesarArbol(a^.hi,valor,v);
		end	
	end
	else 
		writeln('nil');
end; 

//	c) Un módulo que reciba la estructura generada en b) y devuelva la cantidad de pólizas de un cliente cuyo DNI se 
//recibe por parámetro.
procedure recorrerLista(l:lista; dni:integer; var cantL:integer);
begin
	while (l<>NIL)and(l^.dato.dni <= dni)do begin
		if(l^.dato.dni= dni)then
			cantL:= cantL + 1;
		l:=l^.sig;
	end;
	writeln('La cantidad de polizas de la lista es: ',cantL );
end;


procedure cantidadPolizas(v:vectorListas; dni:integer; var cantL:integer);
var
	i:integer;	
begin
	for i:= 2000 to 2023 do 
		recorrerLista(v[i],dni,cantL);
end;


procedure imprimirArbol(a:arbol);
begin
	if(a<>NIL)then begin
	
		writeln('dni: ',a^.dato.dni,' suma: ', a^.dato.suma,' valor cuota: ',a^.dato.valorCuota,  ' fecha:  ',a^.dato.fecha);
		imprimirArbol(a^.HI);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<>NIL)do begin
		writeln('-------LISTA DE POLIZAS--------');
		writeln('El dni:   ', l^.dato.dni);
		writeln('La suma:   ' , l^.dato.suma); 
		writeln('El valor de la cuota: ' , l^.dato.valorCuota);
		l:=l^.sig;
	end;
end;

procedure imprimirVector(v:vectorListas);
var
	i:integer;
begin
	for i:= 2000 to 2023 do begin
	
		imprimirLista(v[i]);
		if(v[i]= nil)then
			writeln('NIL: esta lista esta vacia');
	end;
	
end;

// ------------------------------------- VARIABLES LOCALES AL PROGRAMA --------------------------------------------
var 
	a: arbol; 
	valor: real;
	v: VectorListas;
	cantL:integer;
	dniLeido:integer;
// ----------------------------------------- PROGRAMA PRINCIPAL --------------------------------
begin 
	a := NIL;
	randomize;
	cargarArbolPolizas(a);
    writeln('------ARBOL DE POLIZAS-------');
	imprimirArbol(a);
	writeln('Ingrese un valor para filtrar las polizas: '); readln(valor);
	inicializarVectorListas(v);	
	procesarArbol(a,valor,v);
	imprimirVector(v);
	writeln('Ingrese un numero de dni: '); 
	readln(dniLeido);
	cantL:=0;
	cantidadPolizas(v,dniLeido,cantL);
	writeln('La cantidad de polizas de la lista es: ',cantL );
end.
