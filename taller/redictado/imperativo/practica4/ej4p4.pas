program ej4p4;
Const
	isbn_fin=-1;
Type
	rango_dia= 1..31;
	rango_mes= 1..12;
	prestamo=record
		isbn:integer;
		socio:integer;
		dia:rango_dia;
		mes:rango_mes;
		cantPrest:integer;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:prestamo;
		HI:arbol;
		HD:arbol;
	end;
	
	regLista= record
		socio:integer;
		dia:rango_dia;
		mes:rango_mes;
		cantPrest:integer;
	end;
	
	lista=^nodo;
	nodo=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol2=record
		isbn:integer;
		lista: lista;
	end;
		
	arbol2=^nodoA2;
	nodoA2= record
		dato:regArbol2;
		HI:arbol2;
		HD:arbol2;
	end;
	
	regListaf=record
		isbn:integer;
		cantVeces:integer;
	end;
	
	listaF=nodoLF;
	nodoA3=record
		dato:regListaF;
		sig:listaF;
	end;
	
//--------------------------------------------------------------------
procedure cargarArbol(var a1:arbol1; var a2:arbol2);

	procedure leerPrestamo(var p:prestamo);
	begin
		p.isbn:=(-1 + random(50));
		if(p.isbn <> isbn_fin)then begin
			p.socio:=random(100);
			p.dia:=(1+random(30));
			p.mes= 1+ random(11);
			p.cantPrest:= random(15);
		end;
	end;
	
	
	procedure insertarArbol(var a1:arbol1; p:prestamo);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:=p;
			a^.HI:= nil;
			a^.HD:= nil;
		end
		else
			if(p.isbn< a^.dato.isbn)then
				insertarArbol(a^.HI,p)
			else
				insertarArbol(a^.HD,p)
	end;

procedure cargarRegs(p:prestamo; var rl:regLista; var ra2:regArbol2);
begin
	rl.socio:=p.socio;
	rl.mes:=p.mes;
	rl.dia:=p.dia;
	rl.cantPrest:=p.cantPrest;
	ra2.isbn:=p.isbn;
end;

procedure agregarAdelante(var l:lista; rl:regLista );
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=rl;
	nue^.sig:=l;
	l:=nue;
end;

procedure insertarArbol2(var a:arbol2; rl:regLista; isbn:integer);
begin
	if(a=nil)then begin
		new(a);
		a^.HI:=nil;
		a^.HD:=nil;
		a^.dato.isbn:= ra2;
		a^.dato.lista:= nil;
		agregarAdelante(a^.dato.lista, rl);
	end
	else
		if(a^.dato.isbn = isbn )then
			agregarAdelante(a^.dato.lista, rl)
		else
			if(isbn < a^.dato.isbn)then 
				insertarArbol2(a^.HI,rl,isbn)
			else
				insertarArbol2(a^.HD,rl,isbn)
end;
	
var
	p:prestamo;
	rl:regLista;
	ra2:regArbol2;
begin
	leerPrestamo(p);
	while(p.isbn<> isbn_fin)do begin
		insertarArbol(a,p);
		cargarRegs(p,rl,ra2);
		insertarArbol2(a2,rl,ra2.isbn);
		leerPrestamo(p);
	end;
end;
//--------------------------------------------------------------------------
//b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más grande.  
function isbnMaximo(a1:arbol1):integer;
begin
	if(a=nil)then
		isbnMaximo:=-1;
	else
		if(a^.HD =nil)then
			isbnMaximo:= a1^.dato.isbn
		else
			isbnMaximo:= isbnMaximo(a^.HD);
end;

//c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más pequeño. 
function isbnMinimo(a2:arbol2):integer;
begin
	if(a2=nil)then
		isbnMinimo:=-1
	else
		if(a2^.HI= nil)then 
			isbnMinimo:=a2^.dato.isbn
		else
			isbnMinimo:=isbnMinimo(a2^.HI);
end;

//d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. 
//El módulo debe retornar la cantidad de préstamos realizados a dicho socio. 
function cantidadPrestamosSocio(a:arbol1; socio:integer):integer;
begin
	if(a= nil)then
		cantidadPrestamosSocio:=0
	else
		if(a^.dato.socio= socio)then
			cantidadPrestamosSocio:= 1 +cantidadPrestamosSocio(a^.HD,socio)
		else
			if(a^.dato.socio< socio)then
				cantidadPrestamosSocio(a^.HD,socio)
			else
				cantidadPrestamosSocio(a^.HI,socio)
end;

//e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. 
//El módulo debe retornar la cantidad de préstamos realizados a dicho socio.
function contabilizarPrestamos(l:lista; socio:integer):integer;
begin
	if(l=nil)then
		contabilizarPrestamos:=0
	else
		contabilizarPrestamos:=1+ contabilizarPrestamos(l^.sig);
end;

function cantidadPrestamosSocioII(a:arbol2,socio:integer):integer; 
begin
	if(a=nil)then
		cantidadPrestamosSocioII:=0
	else
		if(a^.dato.lista=socio)then
			cantidadPrestamosSocioII:= contabilizarPrestamos(a^.dato.lista,socio) ;
		else
			if(a^.dato.l< socio)then
				cantidadPrestamosSocioII:=cantidadPrestamosSocioII(a^.HD,socio)+cantidadPrestamosSocioII(a^.HI,socio) 
			else
				cantidadPrestamosSocioII:=cantidadPrestamosSocioII(a^.HI,socio)+cantidadPrestamosSocioII(a^.HD,socio);
end;

//f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura ordenada ISBN,
// donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó. 
procedure agregarAdelantef(var lf:lista ;rlf:regListaF);
var
	nue:listaf;
begin
	new(nue);
	nue^.dato:=rlf;
	nue^.sig:=lf;
	lf:=nue;
end;

procedure actualizarCantLista(var lf:listaf; rlf:regListaf);
begin
	if(l<>nil)then begin
		if(l^.dato.isbn = rlf.isbn)then
			l^.dato.cantVeces:=l^.dato.cantVeces+1
		else
			rlf.cantVeces:=1;
			agregarAdelantef(lf,rlf);
end;

procedure generarNuevaEstructura(a1:arbol1; var lf:listaf)
var
	rlf:regListaF;
begin
	if(a1<>nil)then begin
		generarNuevaEstructura(a^.hd, lf);
		rlf.isbn:= a^.dato.isbn;
		actualizarCantLista(lf,rlf);
		generarNuevaEstructura(a^.hi,lf);
	end;
end;

//g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura ordenada ISBN, 
//donde cada ISBN aparezca una vez junto a la cantidad total de veces que se prestó. 
procedure generarNuevaEstructuraII(a2:arbol; lg:listaf);
var
	rl:regListaF;
	aux:lista;
begin
	if(a2<>nil)then begin
		generarNuevaEstructuraII(a2^.HI,lg);
		rl.isbn:= a2^.dato.isbn;
		rl.cantVeces:=0;
		aux:= a2^.dato.lista;
		while(aux<>nil)do begin
			rl.cantVeces:=rl.cantVeces+1;
			aux:=aux^.sig;
		end;
		agregarAdelante(aux,rl);
		generarNuevaEstructuraII(a^.HD,lg);
	end;
end;
		

//h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido. 
procedure imprimirLista(l:listaf);
begin
	if(a<>nil)then begin
		writeln('El  isbn es:   ',l^.dato.isbn);
		writeln('La cantidad de prestamos es:  ',l^.dato.cantVeces);
		imprimirListag(l^.sig);
	end;
end;

//i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
//módulo debe retornar la cantidad total de préstamos realizados a los ISBN
//comprendidos entre los dos valores recibidos (incluidos).
procedure cantPrestamosEntreISBN(a:arbol1; isbn1,isbn2:integer):integer;
begin
	if(a=nil)then
		cantPrestamosEntreISBN:=0
	else begin
		if(a^.dato.isbn>= isbn1)then
			if(a^.dato.isbn<= isbn2)then
				cantPrestamosEntreISBN:=1+cantPrestamosEntreISBN(a^.HI,isbn1,isbn2)+cantPrestamosEntreISBN(a^.HD,isbn1,isbn2)
			else
				 cantPrestamosEntreISBN:= cantPrestamosEntreISBN(a^.HI,isbn1,isbn2)
		else 
			cantPrestamosEntreISBN:=cantPrestamosEntreISBN(a^.HD,isbn1,isbn2);
	end;
end;

//j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El módulo debe retornar
// la cantidad total de préstamos realizados a los ISBN comprendidos entre los dos valores recibidos (incluidos). 
function contarPrestamos(l:lista):integer;
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		cant:=cant+1;
		l:=l^.sig;
	end;
	contarPrestamos:=cant;
end;

function cantPrestamosEntreISBNII(a:arbol2; isbn1, isbn2:integer):integer;
begin
	if(a=nil)then 
		cantPrestamosEntreISBNII:=0
	else begin
		if(a^.dato.isbn >=isbn1)then
			if(a^.dato.isbn <=isbn2)then
				cantPrestamosEntreISBNII:= contarPrestamos(a^.dato.lista)+ cantPrestamosEntreISBNII(a^.HI,isbn1,isbn2)+ cantPrestamosEntreISBNII(a^.HD,isbn1,isbn2)			
			else
				cantPrestamosEntreISBNII:= cantPrestamosEntreISBNII(a^.HI)
		else
			cantPrestamosEntreISBNII(a^.Hd,isbn1,isbn2);
	end;
end;

//----------------------------PROGRAMA PRINCIPAL------------	
var
	a1:arbol1;
	a2:arbol2;
	lf,lg:listaF;
	socio1,socio2:integer;
	isbn1,isbn2:integer;
begin
	a1:=nil;
	a2:=nil;
	cargarArbol(a1,a2)
	writeln('El isbn mas grande es: ',isbnMaximo(a1));
	writeln('El isbn mas pequeño es: ',isbnMinimo(a2));
	writeln('Ingrese un codigo de socio');readln(socio1);
	writeln('Ingrese un codigo de socio');readln(socio2);
	writeln('La cantidad de prestamos realizados a ', socio1, ' es:  ', cantidadPrestamosSocio(a1,socio1));
	writeln('La cantidad de prestamos realizados a ', socio2, ' es:  ', cantidadPrestamosSocioII(a2,socio2));
	a3:=nil;
	generarNuevaEstructura(a1,lf);
	generarNuevaEstructurag(a2,lg);
	imprimirLista(lg);
	
	writeln('Ingrese dos isbn:  ');readln(isbn1);readln(isbn2);
	writeln('La cantidad total de prestamos entre ', isbn1, ' y ', isbn2, ' es: ',cantPrestamosEntreISBN(a1,isbn1,isbn2));
	
	writeln('Ingrese dos isbn:  ');readln(isbn1);readln(isbn2);
	writeln('La cantidad total de prestamos entre ', isbn1, ' y ', isbn2, ' es: ',cantPrestamosEntreISBNII(a2,isbn1,isbn2));
end.
	
