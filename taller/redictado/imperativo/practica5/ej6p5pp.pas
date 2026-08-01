program ej6p5; 
Const
	max_gen=7;
	isbn_fin=0;
	
Type
	
	rango_gen= 1..max_gen;
	
	libro=record
		isbn:integer;
		codautor:integer;
		cod_gen: rango_gen;
	end;
	
	regArbol=record
		codautor:integer;
		cant:integer;
	end;
	
	 arbol=^nodoA;
	 nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
	
	regGenero=record
		cod_gen:integer;
		nombre:string;
		cant:integer;
	end;
	
	vGeneros= array[rango_gen]of regGenero;//PREGUNTAR SI REG O ENTERO
	v= array [1..7] of string;
Const

	vStrings:v =('Literario','filosofia','arte', 'biologia', 'computacion', 'medicina', 'ingenieria');
//-------------------------------------FIN TYPE-------------------

//----------------------CARGA DEL ARBOL---------------------------
procedure cargarArbolYVector(var a:arbol; var vg:vGeneros);

	procedure leerLibro(var l:libro);
	begin
		l.isbn:= random(100);
		if(l.isbn <> isbn_fin)then begin
			l.codautor:=100+ random(500);
			l.cod_gen:= 1+ random(7);
		end;
	end;

	procedure insertarArbol(var a:arbol; cod:integer);
	begin
	   if(a=nil)then begin
			new(a);
			a^.dato.codautor:=cod;
			a^.dato.cant:=1;
			a^.HI:=NIL;
			a^.HD:=NIL;
	   end
	   else begin
			if(cod =a^.dato.codautor)then
				a^.dato.cant:=a^.dato.cant+1
			else
				if(cod >a^.dato.codautor)then
					insertarArbol(a^.HD, cod)
				else
					insertarArbol(a^.HI,cod)
		end;
	end;
	   
	 procedure inicializarVector(var v:vGeneros);
	 var
		i:integer;
	 begin
			for i:= 1 to max_gen do begin
				v[i].cant:=0;
				v[i].nombre:= vStrings[i];
				v[i].cod_gen:=i;
			end;
		end;

		
var
	l:libro;

begin
	inicializarVector(vg);
	leerLibro(l);
	while(l.isbn <> isbn_fin)do begin
		insertarArbol(a,l.codautor);
		vg[l.cod_gen].cant := vg[l.cod_gen].cant + 1;
		leerLibro(l);
	end;
end;
//------------------------------------------------------INCISO B---------------------------------------------
procedure incisoB(var v:vGeneros);
var
	i,j,pos:integer;
	item:regGenero;
begin
	for i:= 1 to max_gen -1 do begin
		pos:=i;
		for j:= i+1 to max_gen do
			if (v[j].cant  > v[pos].cant)then
				pos:=j;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
end;


//--------------------------------------------INCISO C------------------------
function incisoC(a:arbol):integer;
	
	function cantidadTotal(a:arbol; cod1,cod2:integer):integer;
	begin
		if(a=nil)then
			cantidadTotal:=0
		else begin
			if(a^.dato.codautor> cod1)then
				if(a^.dato.codautor<cod2)then
					cantidadTotal:= a^.dato.cant+ cantidadTotal(a^.HI,cod1,cod2)+ cantidadTotal(a^.HD,cod1,cod2)
				else
					cantidadTotal:= 0+cantidadTotal(a^.HI,cod1,cod2)
			else
				cantidadTotal:=0+cantidadTotal(a^.HD,cod1,cod2);
		end;
	end;
//---------------------------------------------------------				

var
	cod1,cod2:integer;
begin
	writeln('Ingrese dos codigos:  ');
	readln(cod1);
	readln(cod2);
	incisoC:= cantidadTotal(a,cod1,cod2);
end;
//-----------------------------------IMPRIMIR VECTOR----------------------
procedure imprimirVector(v:vGeneros);
var
	i:integer;
begin
	for i := 1 to max_gen do begin
		writeln('codigo de genero:  ',v[i].cod_gen);
		writeln('nombre de genero: ',v[i].nombre);
		writeln('cantidad de libros del genero:  ',v[i].cant);
		writeln('--------------------------------------------------')
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('cod de autor:    ',a^.dato.codautor);
		writeln('cantidad :    ',a^.dato.cant);
		writeln('--------------------------------------------');
		imprimirArbol(a^.HD);
	end;
end;





//----------------------------PROGRAMA PRINCIPAL------------------
var
	a:arbol;
	vg:vGeneros;
begin
	a:=nil;
	randomize;
	cargarArbolyVector(a,vg);
	imprimirVector(vg);
	writeln('--------------------------------ARBOL--------------------------');
	imprimirArbol(a);
	incisoB(vg);
	writeln('-----------------------VECTOR ORDENADO-------------------');
	imprimirVector(vg);
	writeln('La cantidad total de libros entre autores ingresados es: ',incisoC(a));
end.
