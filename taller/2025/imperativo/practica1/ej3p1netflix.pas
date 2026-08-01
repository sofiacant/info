{
    Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
    septiembre de 2025. De cada película se conoce: código de película, código de género (1:
    acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y
    puntaje promedio otorgado por las críticas.
    Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
        a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
    género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
    código de la película -1.
        b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
    obtenido entre todas las críticas, a partir de la estructura generada en a)..
        c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
    métodos vistos en la teoría.
        d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
    del vector obtenido en el punto c).
}

program netflixtaller;
Const
	codigo_fin = -1;
	max_genero = 8;
Type
	rango_genero = 1..max_genero;
	
	pelicula=record
		codigo: integer;
		cod_genero: rango_genero;
		puntaje: real; 
	end;
	
	lista= ^nodo;

    nodo=record
        dato: pelicula;
        sig: lista;
    end;

	vectorPeliculas = array[rango_genero] of lista;	
	
	vectorGeneros = array[rango_genero] of pelicula;
	
procedure inicializarVectorListas (var vp:vectorPeliculas);
var
	i: rango_genero;
begin
	for i := 1 to max_genero do 
		vp[i] := NIL;
end;

procedure inicializarVectorGeneros(var vg: VectorGeneros);
var i: rango_genero;
begin 
	for i := 1 to max_genero do 
		vg[i].codigo := -1;
end;

function obtenerGenero(g: rango_genero): string;
begin 
    case (g) of 
        1: obtenerGenero := 'acción';
        2: obtenerGenero := 'aventura';
        3: obtenerGenero := 'drama';
        4: obtenerGenero := 'suspenso';
        5: obtenerGenero := 'comedia';
        6: obtenerGenero := 'bélico';
        7: obtenerGenero := 'documental';
        8: obtenerGenero := 'terror';
    end;
end; 

procedure imprimirVectorGeneros(vg: vectorGeneros);
var i: rango_genero;
begin 
    for i := 1 to max_genero do begin 
        if (vg[i].codigo <> -1) then writeln('Pelicula con mejor puntaje para el genero ', obtenerGenero(i), ': ', vg[i].codigo, ' con un puntaje de ', vg[i].puntaje:0:2);
    end; 
end; 

procedure imprimirLista(l: lista);
begin 
    while (l <> NIL) do begin 
        writeln('Pelicula: <', l^.dato.codigo, '>, genero ', obtenerGenero(l^.dato.cod_genero), ' con puntaje ', l^.dato.puntaje:0:2);
        // avanzo en la lista 
        l := l^.sig;
    end; 
end; 

procedure imprimirVectorPeliculas(vp: vectorPeliculas);
var i: rango_genero;
begin 
    for i := 1 to max_genero do begin 
        if (vp[i] <> NIL) then imprimirLista(vp[i]);
    end;
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
	nue: lista;
begin
	new(nue);
	nue^.dato := p;
	nue^.sig := NIL;
	if (l=NIL) then
		l := nue
	else
		ult^.sig := nue;
	ult := nue;
end;

// obtener la pelicula con el mayor puntaje 
procedure obtenerPelicula(l:lista; var p: pelicula);
var
	max: real;
begin
	max := -999;
	while(l<> NIL)do begin
		if (l^.dato.puntaje > max) then p := l^.dato;
	    l := l^.sig;
	end;
end;

procedure procesarVectorPeliculas(vp: vectorPeliculas; var vg: vectorGeneros);
var
	i: rango_genero;
begin
	for i := 1 to max_genero do 
		obtenerPelicula(vp[i], vg[i]);
end;
		

procedure cargarVectorP(var vp: vectorPeliculas);
var
	p: pelicula;
	vUlt: vectorPeliculas;
begin
	inicializarVectorListas(vp);
	leerPelicula(p);
	while(p.codigo <> codigo_fin)do begin
		agregarAtras(vp[p.cod_genero], vUlt[p.cod_genero], p);
		leerPelicula(p);
	end;
end;

// ordenar vector por selección 
procedure ordenarVector(var vg: vectorGeneros);
var
	i, j, pos: rango_genero; 
    p: pelicula;
begin 
    for i := 1 to max_genero - 1 do begin 
        pos := i; 
        for j := i + 1 to max_genero do if (vg[j].puntaje < vg[pos].puntaje) then pos := j;
        
        { intercambia v[i] y v[pos] }
        p := vg[pos];
        vg[pos] := vg[i];
        vg[i] := p;
    end; 
end;

procedure puntajeMaxYMin(v:vectorGeneros);
var
	 i,codMax,codMin:integer;
	 maxPunt,minPunt:real;
begin
	codMax:=-1;
	codMin:=9999;
	maxPunt:=-1;
	minPunt:=9999;
	for i:= 1 to max_genero do begin
		if(v[i].puntaje > maxPunt)then begin
			maxPunt:=v[i].puntaje;
			codMax:= v[i].codigo;
		end;
		if(v[i].puntaje < minPunt)then begin
			minPunt:=v[i].puntaje;
			codMin:= v[i].codigo;
		end;
	end;
	writeln('el codigo de pelicula con mayor puntaje es: ',codMax);
	writeln('el codigo de pelicula con menor puntaje es: ',codMin);
end;
			
	 
var
	vp: vectorPeliculas;
	vg: vectorGeneros;
begin
	cargarVectorP(vp);
    inicializarVectorGeneros(vg);
	procesarVectorPeliculas(vp,vg);
    writeln; writeln(' --- VECTOR DE PELICULAS ---'); writeln;
    imprimirVectorPeliculas(vp);
    writeln; writeln(' --- VECTOR DE GENEROS ---'); writeln;
    imprimirVectorGeneros(vg);
    ordenarVector(vg);
    puntajeMaxYMin(vg);
end.
