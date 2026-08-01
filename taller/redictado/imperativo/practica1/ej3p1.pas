{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de septiembre de 2025. 
De cada película se conoce: código de película, código de género
 (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) 
 y puntaje promedio otorgado por las críticas.  Implementar un programa que invoque a módulos 
 para cada uno de los siguientes puntos: 
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de género,
 y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1.  
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje obtenido 
entre todas las críticas, a partir de la estructura generada en a)..
 c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos 
 en la teoría. 
  d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, 
 del vector obtenido en el punto c). }
 
 program ej3p1;
 Const
	codFin=-1;
	max_gen= 8;
Type
	rango_gen= 1..max_gen;
	
	pelicula=record
		cod:integer;
		cod_gen:rango_gen;
		puntaje:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:pelicula;
		sig:lista;
	end;
	
	vectorPeliculas= array[rango_gen]of lista;   //agrupados por cod de genero
	vectorGeneros= array[rango_gen]of integer; 
	
	
procedure cargarVectorP(var vp:vectorPeliculas);

	procedure inicializarVector(var v:vectorPeliculas);
	var
		i:rango_gen;
	begin
		for i:= 1 to max_gen do
			v[i]:=NIL;
	end;
	
	procedure leerPelicula(var p:pelicula);
	begin
		writeln('Ingrese un codigo de pelicula');
		readln(p.cod);
		if(p.cod <> codFin)then begin
			writeln('Ingrese un codigo de genero');
			readln(p.cod_gen);
			writeln('Ingrese un puntaje de pelicula');
			readln(p.puntaje);
		end;
	end;
	procedure agregarAtras(var l,ult:lista; p:pelicula);
	var
		nue:lista;
	begin
		new(nue);
		nue^.dato:= p;
		nue^.sig:=NIL;
		if(l=nil)then
			l:=nue
		else
			ult^.sig:= nue;
		ult:= nue;
	end;
	
var
	i:rango_gen;
	p:pelicula;
	vUlt: vectorPeliculas;
begin
	inicializarVector(vp);
	leerPelicula(p);
	while(p.cod<> codFin)do begin
		agregarAtras( vp[p.cod_gen], vUlt[p.cod_gen], p);
		leerPelicula(p);
	end;
end;

//----b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje obtenido 
//entre todas las críticas, a partir de la estructura generada en a)..	
procedure inicializarVectorGeneros(var vg:vectorGeneros);
var
	i:rango_gen;
begin
	for i:= 1 to max_gen do
		vg[i]:= 0;
end;


function obtenerCodMaxPuntaje( l:lista):integer;
var
	max:real;
	codMax:integer;
begin
	max:=-999;
	while(l<>nil)do begin
		if(l^.dato.puntaje > max)then begin
			max:=l^.dato.puntaje;
			codMax:= l^.dato.cod;
		end;
		l:=l^.sig;
	end;
	obtenerCodMaxPuntaje:= codMax;
end;
	
	
procedure procesarVector(var vp:vectorPeliculas; var vg:vectorGeneros);
var
	i:rango_gen;
begin
	for i:= 1 to max_gen do
		vg[i]:= obtenerCodMaxPuntaje(vp[i]);
end;

//INCISO C
// ordenar vector por selección 
procedure ordenarVector(var vg: vectorGeneros);
var
	i, j, pos: rango_gen; 
    c:real;
begin 
    for i := 1 to max_gen - 1 do begin 
        pos := i; 
        for j := i + 1 to max_gen do 
			if (vg[j].puntaje < vg[pos].puntaje) then 
				pos := j;
        
        { intercambia v[i] y v[pos] }
        c := vg[pos];
        vg[pos] := vg[i];
        vg[i] := c;
    end; 
end;	
 

//INCISO D
//d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, 
 //del vector obtenido en el punto c). 
 
 procedure puntajeMaxYMin(v:vectorGeneros);
 var
	i,codMin,codMax:integer;
	puntMin,puntMax:real;
begin
	codMin:=9999;
	codMax:=-9999;
	puntMin:=9999;
	puntMax:=-9999;
	for i:= 1 to max_gen do begin
		if(v[i].puntaje< puntMin)then begin
			puntMin:=v[i].puntaje;
			codMin:=v[i].cod;
		end;
		if(v[i].puntaje> puntMax)then begin
			puntMax:= v[i].puntaje;
			codMax:= v[I].cod;
		end;
	end;
	writeln('El codigo de pelicula con mayor puntaje es: ', codMax);
	writeln('El codigo de pelicula con menor puntaje es: ', codMin);
end;
 
 
 
 
//----------------PROGRAMA PRINCIPAL---------------
var
	vp:vectorPeliculas;
	vg:vectorGeneros;
begin
	cargarVectorP(vp);
	inicializarVectorGeneros(vg);
	procesarVector(vp,vg);
	ordenarVector(vg);
	puntajeMaxYMin(vg);
end.
	
	
	
 
