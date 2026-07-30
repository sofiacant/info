program biblioteca;
const
min_rango=1;
max_rango=15;
fin_isbn=0;
type
	rango_genero=min_rango..max_rango;

	libro=record
		isbn:integer;
		anio_edicion:integer;
		cod_autor:integer;
		cod_genero:rango_genero;
	end;
	
	lista=^nodoLista;
	nodoLista=record
		dato:libro;
		sig:lista;
	end;
	
	autor=record
		cod_autor:integer;
		libros:lista;
	end;
	
	arbol=^nodoArbol;
	nodoArbol=record
		dato:autor;
		HI:arbol;
		HD:arbol;
	end;
	
	vector=array[rango_genero] of integer;
	
procedure cargarArbol (var a:arbol);
procedure leerLibro (var l:libro);
begin
	l.isbn:=random(50);
	if (l.isbn <> 0) then begin
	l.anio_edicion:=2000+random(2025-2000+1);
	l.cod_autor:=random(50);
	l.cod_genero:=1+random(15-1+1);
end;
end;

procedure agregarAdelante (var l:lista; lib:libro);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=lib;
	nue^.sig:=l;
	l:=nue;
end;

procedure generarNodo (var a:arbol; lib:libro);
begin
	if (a=nil) then
	begin
		new(a);
		a^.dato.cod_autor:=lib.cod_autor;
		a^.dato.libros:=nil;
		agregarAdelante(a^.dato.libros,lib);
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else
	if (lib.cod_autor = a^.dato.cod_autor) then
		agregarAdelante(a^.dato.libros,lib)
	else 
	if (lib.cod_autor < a^.dato.cod_autor) then
			generarNodo(a^.HI,lib)
			else
				generarNodo(a^.HD,lib);
end;

var
		lib:libro;
begin
	leerLibro(lib);
	while (lib.isbn <> 0) do 
	begin
		generarNodo(a,lib);
		leerLibro(lib);
	end;
end;
	
	procedure imprimirArbol (a:arbol);
	procedure recorrerLista (l:lista);
	begin
		while (l<>nil) do 
		begin
			writeln('ISBN:',l^.dato.isbn);
			writeln('Anio de edicion: ',l^.dato.anio_edicion);
			writeln('codigo del autor: ',l^.dato.cod_autor);
			writeln('codigo de genero: ',l^.dato.cod_genero);
			writeln('');			

			l:=l^.sig;
		end;
	end;
	begin
		if(a<>nil) then
		begin
			writeln('-----------------------------');
			writeln('[/// Codigo del autor: ',a^.dato.cod_autor,' ///]');
			writeln('');		
			recorrerLista(a^.dato.libros);
			
			imprimirArbol(a^.HI);
			imprimirArbol(a^.HD);
		end;
	end;
	
procedure inicializarVector( var v:vector);
var
	i:rango_genero;
begin
	for i := 1 to max_rango do
		v[i]:=0;
end;	
	
procedure cargarVector (var v:vector; cod:integer; a:arbol);
procedure recorrerLista (l:lista; var v:vector);
begin
	while (l<> nil) do begin
		v[l^.dato.cod_genero]:=v[l^.dato.cod_genero] + 1;
		l:=l^.sig;
	end;
end;

begin
	if (a <>nil) then
	begin
		if (a^.dato.cod_autor = cod) then
			recorrerLista(a^.dato.libros,v);
		cargarVector(v,cod,a^.HI);
		cargarVector(v,cod,a^.HD);
	end;
end;	
	
procedure imprimirVector (v:vector);
var
	i:rango_genero;
begin
	for i:= 1 to max_rango do
		writeln('Genero: ',i, ' Cantidad: ',v[i]);
end;
	
procedure maximo (v:vector; var cantMax,codMax:integer; pos:integer);

begin
if (pos <= max_rango) then begin
	if (v[pos] > cantMax) then 
	begin
		codMax:=pos;
		cantMax:=v[pos];
	end;
	maximo( v,cantMax,codMax,pos+1);
end;
end;

var
	v:vector;
	a:arbol;
	cod,pos:integer;
	cantMax,codMax:integer;
begin
	pos:=1;
	cantMax:=-1;
	codMax:=0;

	a:=nil;
	randomize;
	cargarArbol(a);
	imprimirArbol(a);
	inicializarVector(v);
	writeln('Ingresar un codigo: '); readln(cod);
	cargarVector(v,cod,a);
	imprimirVector (v);
	maximo(v,cantMax,codMax,pos);
	if  (cantMax = 0) then
		writeln('No se pudo encontrar el maximo')
		else
	writeln('Genero con mas libros: ',codMax, ' Cantidad: ',cantMax);
end.
