program netflixtaller;
Const
	codigo_fin=-1;
	max_genero=8;
Type
	rango_genero=1..max_genero;
	
	pelicula=record
		codigo:integer;
		cod_genero:rango_genero;
		puntaje:real; 
	end;
	
	lista=^nodo;
		nodo=record
			dato:pelicula;
			sig:lista;
		end;
	vectorPeliculas= array[rango_genero] of lista;	
	
	vectorGeneros= array[rango_genero] of integer;
	
procedure inicializarVectorListas (var vp:vectorPeliculas);
var
	i:rango_genero;
begin
	for i:= 1 to max_genero do 
		vp[i]:= NIL;
end;

procedure inicializarVectorGeneros(var vg: VectorGeneros);
var i: rango_genero;
begin 
	for i := 1 to max_rango do 
		vg[i] := 0;
end;

procedure leerPelicula(var p:pelicula);
begin
	writeln('Ingrese el codigo de pelicula: ');
	readln(p.codigo);
	if(p.codigo<> codigo_fin)then begin
		writeln('Ingrese el codigo de genero: ');
		readln(p.cod_genero);
		writeln('Ingrese el puntaje promedio: '); 
		readln(p.puntaje);
	end;
end;

procedure agregarAtras(var l,ult:lista; p:pelicula);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:= NIL;
	if(l=NIL)then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;

function obtenerCodigoMax(l:lista):integer;
var
	max:integer;
	codMax:integer;
begin
	max:= -999;
	while(l<> NIL)do begin
		if(l^.dato.puntaje > maximo)then begin
			maximo:= l^.dato.puntaje;
			codMax:=l^.dato.codigo;
		end;
	l:=l^sig;
	end;
	obtenerCodigoMax:= codMax;
end;

procedure procesarVectorPeliculas(vp:vectorPeliculas; var vg:vectorGeneros);
var
	i:rango_genero;
begin
	for i:= 1 to max_genero do 
		vg[i]:= obtenerCodigoMax(vp[i]);
end;
		

procedure cargarVector(var vp:vectorPeliculas);
var
	i:rango_genero;
	p:pelicula;
	vUlt:vectorPeliculas;
begin
	inicializarVectorListas(vp);
	leerPelicula(p);
	while(p.codigo <> codigo_fin)do begin
		agregarAtras(vp[p.cod_genero],vUlt[p.cod_genero] ,p);
		leerPelicula(p);
	end;
end;
	
var
	vp:vectorPeliculas;
	vg:vectorGenero;
begin
	cargarVectorP(vp);
	inicializarVectorGeneros(vg);
	procesarVectorPeliculas(vp,vg);
	
		
end.
