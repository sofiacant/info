program biblioteca;
Const
	max_genero=15;
	isbn_fin=0;
Type
	rango_genero= 1..max_genero;
	libro=record
		isbn:integer;
		codAutor:integer;
		codGenero:rango_genero;
	end;
	
	regLista=record
		isbn:integer;
		codGenero:rango_genero;
	end;
	
	lista=^nodol;
	nodol=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		codAutor:integer;
		lista:lista;
	end;
	
	arbol=^nodo;
	nodo=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
	
	regListaB=record
		codAutor:integer;
		cantLibros:integer;
	end;
	
	listaNueva= ^nodoln;
	nodoln=record
		dato:regListaB;
		sig:listaNueva;
	end;
	
//---------------------CARGAR ARBOL------------------
procedure cargarArbol(var a:arbol);

procedure cargarRegistro(l:libro; var rl:regLista);
begin
	rl.isbn:=l.isbn;
	rl.codGenero:=l.codgenero;
end;

procedure leerLibro(var l:libro);
begin
	l.isbn:= random(50);
	if(l.isbn <> isbn_fin)then begin
		l.codAutor:= random(100);
		l.codGenero:= 1+ random(15);
	end;
end;

procedure agregarAdelante(var l:lista; rl:regLista);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:= rl;
	nue^.sig:=l;
	l:=nue;
end;

procedure insertarArbol(var a:arbol; codAutor:integer  ; rl:regLista );
begin
	if(a=nil)then begin
		new(a);
		a^.dato.lista:=nil;
		a^.dato.codAutor:=codAutor;
		a^.HI:= nil;
		a^.HD:= nil;
		agregarAdelante(a^.dato.lista,rL);
	end
	else if (a^.dato.codAutor=codAutor)then
			agregarAdelante(a^.dato.lista,rL)
			else
				if (a^.dato.codAutor < codAutor)then
					insertarArbol(a^.HD,codAutor,rl)
				else
					insertarArbol(a^.HI,codAutor, rl);
end;

var
	l:libro;
	rL:regLista;
begin
	leerLibro(l);
	while(l.isbn <> isbn_fin)do begin
			cargarRegistro(l,rl);
			insertarArbol(a,l.codAutor, rl);
			leerLibro(l);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while (l<>nil)do begin
		writeln('isbn:    ',l^.dato.isbn);
		writeln('codigo de genero:    ',l^.dato.codGenero);
		l:=l^.sig;
	end;
end;
		
procedure imprimirArbol(a:arbol);
begin
	if(a<> nil)then begin
		imprimirArbol(a^.HI);
		writeln('-------------------------------------');
		writeln('Codigo de autor:       ',a^.dato.codAutor);
		writeln('-LISTA:  ');
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.HD);
	end;
end;

procedure agregarAdelante(var l:listaNueva; rn:regListaB);
var
	nue:listaNueva;
begin
	new(nue);
	nue^.dato:= rn;
	nue^.sig:= l;
	l:=nue;
end;

procedure contarEnLista(l:lista; codAutor:integer; codG:integer; var lN:listaNueva);
var
		regN:regListaB;
begin
	regN.codAutor:=codAutor;
	regN.cantLibros:= 0;
	while(l<>nil)do begin
		if(l^.dato.codGenero =codG)then 
				regN.cantLibros:= regN.cantLibros + 1;
		l:=l^.sig;
	end;
	agregarAdelante(lN,regN);
end;


procedure retornarLista(a:arbol;codaut,codgen:integer; var lNueva:listaNueva);
begin
	if(a<>nil)then begin
		if(a^.dato.codAutor > codAut)then 
			contarEnLista(a^.dato.lista,a^.dato.codAutor, codgen, lNueva);
			retornarLista(a^.HI,codaut,codgen,lNueva);
			retornarLista(a^.HD,codaut,codgen,lNueva);
	end;
end;

procedure imprimirListaNueva(l:listaNueva);
begin
	while (l<>nil)do begin
		writeln('---------------');
		writeln('El codigo de autor:  ', l^.dato.codAutor);
		writeln('La cantidad de libros:   ', l^.dato.cantLibros);
		writeln('--------------');
		l:=l^.sig;
	end;
end;

//------------inciso c
procedure obtenerMayor(ln:listaNueva; var cantMax, codMax:integer);
begin
	if(ln<>nil)then begin
		if(ln^.dato.cantLibros > cantMax)then begin
			cantMax:=ln^.dato.cantLibros;
			codMax:=ln^.dato.codAutor;
		end;
		obtenerMayor(ln^.sig,cantMax, codMax);
	end;
end;



//-------------------------programa principal-------------------------
var
	a:arbol;
	codgen,codaut:integer;
	lN:listaNueva;
	codMax,cantMax:integer;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	writeln('--------ARBOL--------');
	imprimirArbol(a);
	writeln('Ingrese un codigo de autor:  ');readln(codaut);
	writeln('Ingrese un codigo de genero:  ');readln(codgen);
	retornarLista(a,codaut,codgen,ln);
	imprimirListaNueva(ln);
	cantMax:=-1;
	codMax:=-1;
	obtenerMayor(ln,cantMax,codMax);
	writeln('El codigo del autor con mayor cantidad de ventas:   ' ,codMax, 'con:    ', cantMax , ' ventas '); 
	
end.
