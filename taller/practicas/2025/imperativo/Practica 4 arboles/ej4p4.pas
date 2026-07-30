{Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante el año 2021. De cada préstamo se conoce el ISBN del libro, 
* el número de socio, día y mes del préstamo y cantidad de días prestados. Implementar un programa con:
	a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
	ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos insertarlos a la derecha.}
{ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN. (prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.}
{e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.}
{h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN
* comprendidos entre los dos valores recibidos (incluidos).}

program biblioteca;
Const
	isbn_fin=0;
Type 
	prestamo=record
		isbn:integer;
		nroSocio:integer;
		dia:integer;
		mes:integer;
		cantDias:integer;
	end;
	
	arbol1=^nodo1;
	nodo1=record
		dato:prestamo;
		HI:arbol1;
		HD:arbol1;
	end;
	
	prestamolis=record
		numS:integer;
		dia:integer;
		mes:integer;
		cantDias:integer;
	end;
	
	lista=^nodol;
	nodol=record
		dato:prestamolis;
		sig:lista;
	end;
	
	regArbol2=record
		isbn:integer;
		l:lista;
	end;
		
	arbol2=^nodo2;
	nodo2=record
		dato:regArbol2;
		HI:arbol2;
		HD:arbol2;
	end;
	
	regLista=record
		isbn:integer;
		cantVeces:integer
	end;
	
	listaf=^nodo;
	nodo=record
		dato:regLista;
		sig:lista;
	end;
	
//---------------------------------------------------------------------carga de arboles--------------------------
	
procedure cargarArboles(var a1:arbol1; var a2:arbol2);

procedure leerPrestamo(var p:prestamo);
begin
	p.isbn:= random(50);
	if(p.isbn <> isbn_fin)then begin
		p.nroSocio:=random(100);
		p.dia:=random(31)+1;
		p.mes:=random(12)+1;
		p.cantDias:=random(100);
	end;
end;

procedure cargarPrestamoLista(p:prestamo; var pl:prestamolis);
begin
	pl.numS:=p.nroSocio;
	pl.dia:=p.dia;
	pl.mes:=p.mes;
	pl.cantDias:=p.cantDias;
end;


procedure insertarArbol1 (var a1:arbol1; p:prestamo);
begin
	if(a1=nil)then begin
			new(a1); a1^.dato:=p;
			a1^.HI:=NIL; a1^.HD:=NIL;
	end
	else 
		if (p.isbn >= a1^.dato.isbn)then 
				insertarArbol1(a1^.hd,p)
		else
				insertarArbol1(a1^.hI,p);
	end;	

//----------------------CARGA ARBOL DE LISTAS 2------------
procedure agregarAdelante(var l:lista; pl:prestamoLis);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=pl;
	nue^.sig:=l;
	l:=nue;
end;
	
procedure insertarArbol2 (var a2:arbol2; pl:prestamoLis; isbn:integer);
begin
	if(a2=NIL)then begin
		new(a2);
		a2^.dato.isbn:=pl.numS;
		a2^.dato.l:=NIL;
		agregarAdelante(a2^.dato.l, pl);
		a2^.HI:=nil;
		a2^.HD:=nil;		
	end
	else if (isbn = a2^.dato.isbn)then
		agregarAdelante(a2^.dato.l, pl)
		else if(isbn < a2^.dato.isbn)then
		insertarArbol2(a2^.HI,pl,isbn)
		else
			insertarArbol2(a2^.HD,pl,isbn)
	
end;

//-------------------------------------CARGAR ARBOL	----------------
var
	p:prestamo;
	pl:prestamolis;
	l:lista;
begin
	l:=nil;
	leerPrestamo(p);
	while(p.isbn <> isbn_fin)do begin
		insertarArbol1(a1,p);
		cargarPrestamoLista(p,pl);
		insertarArbol2(a2,pl,p.isbn);
		leerPrestamo(p);
	end;
		
end;

//b. Un módulo recursivo que reciba la estructura generada en i. 
//y retorne el ISBN más grande.
function isbnMasGrande(a1:arbol; isbn:integer):integer;
begin
	if(a1= nil)then 
		isbnMasGrande:= 0
	else begin
		if (a1^.dato.isbn > isbn)then 
			isbn:=a1^.dato.isbn
		else
			isbnMasGrande(a1^.HI,isbn);
			isbnMasGrande(a1^.HD ,isbn);
	end;
end;
//c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más pequeño
function isbnMasChico (a2:arbol2; isbn:integer):integer;
begin
	if(a2=nil)then
		isbnMasChico:=0
	else begin
		if(a2^.dato.isbn < isbn)then
			isbn:=a2^.dato.isbn
		else
			isbnMasGrande(a2^.HI,isbn);
			isbnMasGrande(a2^.HD ,isbn);
	end;
end;

//d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.}		
function cantidadPrestamos(a1:arbol1; numSocio:integer):integer;
begin
	if(a1=nil)then
		cantidadPrestamos:=0
	else begin
		if (a1^.dato.nroSocio= numSocio)then 
			cantidadPrestamos:= 1+ cantidadPrestamos(a1^.HI,numSocio)+ cantidadPrestamos(a1^.HD,numSocio)
		else 
			cantidadPrestamos:= cantidadPrestamos(a1^.HI,numSocio)+cantidadPrestamos(a1^.HD,numSocio);
	end;
end;

//e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
function recorrerLista(l:lista; num:integer):integer;
var
	cantP:integer;
begin
	cantP:=0;
	while(l<>NIL)do begin
		if(num = l^.dato.numS)then
			cantP:=cantP+1;
	end;
	recorrerLista:=cantP;
end;		

function cantidadPrestamosII(a2:arbol2; numSocioII:integer):integer;
var
	cantPres:integer;
begin
	if(a2= NIL)then
		cantidadPrestamosII:=0
	else if(a2^.dato.l<>nil)then begin
		cantPres:=recorrerLista(a2^.dato.l,numSocioII);
		cantidadPrestamosII:= cantPres+ cantidadPrestamosII(a2^.HI,numSocioII)+cantidadPrestamosII(a2^.HD,numSocioII);
	end
			else
					cantidadPrestamosII:= cantidadPrestamosII(a2^.HI,numSocioII)+cantidadPrestamosII(a2^.HD,numSocioII);
end;

//f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.
procedure agregarAdelante(var l:listaf; rl:regLista);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=rl;
	nue^.sig:=l;
	lf:=nue;
end;

procedure nuevoRegLista(var l:listaf; var rl:regLista);
begin
		if(l<>nil)then begin
			if(l^.dato.isbn = rl.isbn)then
				 l^.dato.cantVeces:= l^.dato.cantVeces+1;
			else begin
				rl.cantVeces:=1;
				agregarAdelante(l,rl);
			end;
		end;
end; 
							

procedure nuevaEstructura(a1:arbol;var l:listaf);
var
	rl:regLista;
begin
	if(a1<>nil)then begin
			nuevaEstructura(a1^.HI,l);
			rl.isbn:= a1^.dato.isbn
			nuevoRegLista(a1^.dato,rl);
			nuevaEstructura(a1^.HD,lf);
	end;
end;     
//-------------------------inciso g-----------------------
//g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó.}
procedure nuevaEstructuraII(a2:arbol2; var lg:listaF);
var
	rl:regLista;
	aux:lista;
begin
		if(a<>nil )then begin
			nuevaEstructuraII(a2^.HI);
			rl.isbn:=a2^.dato.isbn;          //asigno el isbn
			rl.cantVeces:=0;					//reinicio la cantidad de veces
			aux:=a2^.dato.l
			while(aux<>NIL)do begin       ///cuento la cantidad de  prestamos de la lista de arbol2
					rl.cantVeces:=rl.cantVeces+1
					aux_=aux^.sig;
			end;
			agregarAdelante(lg,rl);       //agrego el nodo
			nuevaEstructuraII(a2^.HD);
		end;
end;
			
//{h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.	
procedure imprimirListag(l:listaF);
begin
	if(l<>nil)then begin
			writeln('El  isbn es:   ',l^.dato.isbn);
			 writeln('La cantidad de prestamos es:  ',l^.dato.cantVeces);
			 imprimirListag(l^.sig);
	end;
end; 
//. i- Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN
//comprendidos entre los dos valores recibidos (incluidos).			
function entreRangos(a:arbol1; rangoA,rangoB:integer):integer
begin
	if(a=nil)the
		entreRangos:=0
	else begin
		if(a^.dato.isbn> rangoA)then
				if(a^.dato.isbn<= rangoB)then
						entreRangos:=1+entreRangos(a^.HI,rangoA,rangoB)+entreRangos(a^.HD,rangoA,rangoB)
				else
						entreRangos:=entreRangos(a^.HI,rangoA,rangoB)
		else
			entreRangos:= entreRangos(a^.HD,rangoA,rangoB)
	end;
end;
				
//.j- Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El módulo debe retornar la cantidad total de préstamos realizados a los ISBN
// comprendidos entre los dos valores recibidos (incluidos).}			
procedure entreRangosII(a:arbol2; rangoA,rangoB:integer;var cant:integer)
begin
	if(a<>nil)then begin
			if(a^.dato.isbn>rangoA)then
					if(a^.dato.isbn<rangoB)then begin
							aux:=a^.dato.l;
							while(aux<>nil)do begin
									cant:=cant+1
									aux:=aux^.sig;
							end;
							entreRangosII(a^.HI,rangoA,rangoB,cant);
							entreRangosII(a^.HD,rangoA,rangoB,cant);
					end
					else
						entreRangosII(a^.HI,rangoA,rangoB,cant);
			else
				entreRangosII(a^.HD,rangoA,rangoB,cant);
	end;
end;
			

//---------------------------------------PROGRAMA PRINCIPAL-----------------------------------
var
	a1:arbol1; a2:arbol2;
	isbnMax,isbnMin,isbn:integer;
	numSocio,numSocio2,cantPrest,cantPres2:integer;
	lf:listaf; lg:listaf;
	rango1,rango2:integer;
begin
	a1:=nil;
	a2:=nil;
	lf:=nil;
	
	cargarArboles(a1,a2);
	imprimirA
	isbnMax:=-9999;
	isbn:=isbnMasGrande(a1,isbnMax);
	writeln('el isbn mas grande es: ',isbn);
	isbnMin:=9999;
	isbnII:=isbnMasChico(a2,isbnMin);
	writeln('EL isbn mas chico es: ', isbnII)
	writeln('Ingrese un numero de socio para luego contar sus prestamos:  ')readln(numSocio);
	cantPrest:=cantidadPrestamos(a1,numSocio);
	writeln('La cantidad de prestamos del arbol 1 es:   ', cantPrest);
	
	writeln('Ingrese un numero de socio para luego contar sus prestamos:  ')readln(numSocio2);
	cantPrest2:= cantidadPrestamosii(a2,numSocio2);
	writeln('La cantidad de prestamos del arbol 1 es:   ', cantPrest2);
	nuevaEstructura(a1,lf);
	nuevaEstructuraII(a2,lg)
	imprimirListag(lg);
	
	writeln('Ingrese dos numeros de isbn:  '); readln(rango1);readln(rango2);  
	entreRangosI(a,rango1,rango2;
	
	writeln('Ingrese dos numeros de isbn:  '); readln(rango1);readln(rango2);  
	entreRangosII(a,rango1,rango2;
	
	
end.
