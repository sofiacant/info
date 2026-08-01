program parcialartesano;
Const
	max_cod=8;
	dni_fin=0;
Type
	rango_cod= 1..8;
	artesania= record
		id:integer;
		dni:integer;
		cod:rango_cod;
	end;
	
	regArbol= record
		dni:integer;
		cant:integer;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
	
	regVector=record
		cod:rango_cod;
		cant:integer;
	end;
	
	vArtesanias= array [rango_cod]of regVector;
	
	vNombres= array[rango_cod]of string;
	
Const
	vN: vNombres = ('Madera', 'Yeso', 'Ceramica','Vidrio','Acero','Porcelana','Lana','Carton');
//----------------------------------FIN TYPE-----------------------------------

//--------------------------------CARGA DE ESTRUCTURAS-------------------------------------

procedure cargaEstructuras(var a:arbol; var v:vArtesanias);
	
	procedure inicializarVector(var v:vArtesanias);
	var
		i:integer;
	begin
		for i:= 1 to max_cod do begin
			v[i].cod:=i;
			v[i].cant:=0;
		end;			
	end;
	
	procedure leerArtesanias(var a:artesania);
	begin
		a.dni:=500+ random(50);
		if(a.dni<> dni_fin)then begin
			a.id:=random(100);
			a.cod:=1+ random(8);
		end;
	end;
	
	procedure cargarArbol(var a:arbol; ra:regArbol; dni:integer);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:= ra;
			a^.HI:=NIL;
			a^.HD:=NIL;
		end
		else begin
			if(dni < a^.dato.dni )then
				cargarArbol(a^.HI, ra,dni)
			else if(dni = a^.dato.dni)then
						a^.dato.cant:= a^.dato.cant+1
					else
						cargarArbol(a^.HD,ra,dni)
		end;
	end;

var
	art:artesania;
	ra:regArbol;
begin
	leerArtesanias(art);
	inicializarVector(v);
	while(art.dni <> dni_fin)do begin
		ra.dni:=art.dni;
		cargarArbol(a,ra,art.cod);
		v[art.cod].cant:= v[art.cod].cant+1;
		leerArtesanias(art);
	end;
end;
		
//-----------------------------------------FIN CARGA ESTRUCTURAS--------------------------

//-----------------------------INCISO B--------------------
function incisoB(var a:arbol):integer;

	function cantidadArtesanosDNI(a:arbol; dni:integer):integer;
	begin
		if(a=nil)then
			cantidadArtesanosDNI:=0
		else begin
			if(a^.dato.dni < dni)then
				cantidadArtesanosDNI:= 1+ cantidadArtesanosDNI(a^.HI,dni)+ cantidadArtesanosDNI(a^.HD,dni)
			else
				cantidadArtesanosDNI:= 0+ cantidadArtesanosDNI(a^.HI, dni)
		 end;
	end;
var
	dni:integer;
begin
	writeln('Ingrese un dni: ');
	readln(dni);
	incisoB:= cantidadArtesanosDNI(a,dni);
end;

//-----------------INCISO C---------------------------
procedure incisoC(var v:vArtesanias; var nombreMax:string);

	procedure ordenSeleccion(var v:vArtesanias);
	var
		item:regVector;
		i,j,pos:integer;
	begin
		for i:= 1 to max_cod -1 do begin
			pos:=i;
			for j:= i+1 to max_cod do
				if(v[j].cant< v[pos].cant)then
					pos:=j;
			item:=v[pos];
			v[pos]:=v[i];
			v[i]:=item;
		end;
	end;

begin
	ordenSeleccion(v);

	nombreMax:= vN[8];
end;	
//----------------------------------------------------------------------------------------------
//----------------IMPRESION DE ESTRUCTURAS-----------
procedure imprimirEstructuras(a:arbol; v:vArtesanias);

	procedure imprimirArbol(a:arbol);
	begin
		if(a<>nil)then begin
			imprimirArbol(a^.HI);
			writeln('Dni:     ',a^.dato.dni);
			writeln('Cantidad:     ',a^.dato.cant);
			writeln('-------------------------------');
			imprimirArbol(a^.HD);
		end;
	end;
	
	
	procedure imprimirVector(v:vArtesanias);
	var
		i:rango_cod;
	begin
		for i:= 1 to max_cod do begin
			writeln('Codigo: ', v[i].cod);
			writeln('Cantidad:    ', v[i].cant);
		end;
	end;


begin
	writeln('----------------ARBOL----------------');
	imprimirArbol(a);
	writeln(' ......................................');
	writeln('-----------------------VECTOR-----------------');
	imprimirVector(v);
end;

//-----------------VECTOR ORDENADO---------
procedure imprimirVector(v:vArtesanias);
	var
		i:rango_cod;
	begin
		for i:= 1 to max_cod do begin
			writeln('Codigo: ', v[i].cod);
			writeln('Cantidad:    ', v[i].cant);
		end;
	end;


//---------------------------------------PROGRAMA PRINCIPAL--------------------------------
var
	a:arbol;
	v:vArtesanias;
	nombreMax:string;
begin
	a:=nil;
	randomize;
	cargaEstructuras(a,v);
	imprimirEstructuras(a,v);//PRUEBA
	writeln('La cantidad de artesanos con dni menor es: ' ,incisoB(a));
	
	nombreMax:='A';
	incisoC(v,nombreMax);
	writeln('--------------VECTOR ORDENADO----------------');
	imprimirVector(v);
	writeln('El material con mayor cantida de artesanias es:     ',nombreMax);
end.


		
	
	
	
	
