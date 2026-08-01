program ej4p5;
Const
	cod_fin=0;
Type
	reclamo=record
		cod:integer;
		dni:integer;
		anio:integer;
		tipo:integer;
	end;
	
	regLista=record
		cod:integer;
		anio:integer;
		tipo:integer;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato: regLista;
		sig:lista;
	end;
	
	regArbol=record
		dni:integer;
		lista:lista;
		cant:integer;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
		
	listaD=^nodoD;
	nodoD=record
		dato:integer;
		sig:listaD;
	end;
	
//--------------------------------------------------------
procedure cargarArbol(var a:arbol);

	procedure leerReclamo(var r:reclamo);
	begin
		r.cod:= random(100);
	
		if(r.cod <>cod_fin)then begin
			r.dni:= random(50);
			r.anio:= random(50);
			r.tipo:= random(50);
		end;
	end;

	procedure cargarRegistros(r:reclamo; var ra:regArbol; var rl:regLista);
	begin
		ra.dni:=r.dni;
		
		rl.cod:=r.cod;
		rl.anio:=r.anio;
		rl.tipo:=r.tipo;
	end;
		
	procedure agregarAdelante(var l:lista; rl:regLista);
	var
		nue:lista;
	begin
		new(nue);
		nue^.dato:= rl;
		nue^.sig:= l;
		l:=nue;
	end;
		
	procedure insertarArbol(var a:arbol; rl:regLista; ra:regArbol);
	begin
		if(a=nil)then begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato:=ra;
			a^.dato.lista:=NIL;
			ra.cant:=0;
			a^.dato.cant:= a^.dato.cant+1;
			agregarAdelante(a^.dato.lista,rl);
		end
		else begin
			if(ra.dni < a^.dato.dni)then 
				insertarArbol(a^.HI, rl,ra)
			else
				if(ra.dni = a^.dato.dni)then begin
					agregarAdelante(a^.dato.lista, rl);
					a^.dato.cant:= a^.dato.cant+1;
				end
				else
					insertarArbol(a^.HD, rl,ra)
		end;
	end;
	
//-----------------------------	
var
	r:reclamo;
	ra:regArbol;
	rl:regLista;
begin

	leerReclamo(r);
	while(r.cod<> cod_fin)do begin
		cargarRegistros(r,ra,rl);
		insertarArbol(a,rl,ra);
		leerReclamo(r);
	end;
end;

//----------------------------------INCISO B-----------------------------------------------
procedure incisoB(a:arbol);

	function cantDni(a:arbol; dni:integer):integer;
	begin
		if(a=nil)then 
			cantDni:=0
		else begin
			if(a^.dato.dni= dni)then
				cantDni:= a^.dato.cant
			else
				if(dni<a^.dato.dni )then
					cantDni:= cantDni(a^.HI,dni)
				else
					cantDni:= cantDni(a^.HD,dni);
		end;
	end;

var
	dni:integer;
begin
	writeln('Ingrese un dni');
	readln(dni);
	writeln('La cantidad de reclamos con el dni:  ', dni, ' es:  ',cantDni(a,dni));
	
end;


//----------------------------IMPRESION PARA PRUEBA---------------------------------------------------

procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('cod: ', l^.dato.cod);
		writeln('anio: ', l^.dato.anio);
		writeln('tipo: ', l^.dato.tipo);
		writeln('  _______ ');
		l:=l^.sig;
	end;
end;
		
		
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('dni:  ',a^.dato.dni);
		writeln('cant:  ',a^.dato.cant);
		imprimirLista(a^.dato.lista);
		writeln('---------------------------');
		imprimirArbol(a^.HD);
	end;
end;
//-----------------------------------INCISO C------------------------------------------------------------------------------
procedure incisoC(a:arbol);
	

	function cantidadReclamos(a:arbol; dni1,dni2:integer):integer;
	begin
		if(a=nil)then
			cantidadReclamos:=0
		else begin
			if(a^.dato.dni > dni1)then
				if(a^.dato.dni < dni2)then
					cantidadReclamos:=a^.dato.cant + cantidadReclamos(a^.HI,dni1,dni2)+cantidadReclamos(a^.HD,dni1,dni2)
				else
					cantidadReclamos:=cantidadReclamos(a^.HI,dni1,dni2)
			else
				cantidadReclamos:=cantidadReclamos(a^.HD,dni1,dni2);
		end;
	end;



var
	dni1,dni2:integer;
begin
	writeln('Ingrese dos dnis: ');readln(dni1);readln(dni2);
	writeln('La cantidad de reclamos efectuados por el dni:  ',dni1 ,' y ' ,dni2,' es:'  ,cantidadReclamos(a,dni1,dni2));
end;
//------------------------------------------------------------------------------------------------------------------------
//---------------------------------INCISO D----------------------------------
//d) Un módulo que reciba la estructura generada en a)  y un año y retorne los códigos de los reclamos realizados en el año recibido.  

procedure incisoD(a:arbol);

	procedure agregarAdelante(var l:listaD; cod:integer);
	var
		nue:listaD;
	begin
		new(nue);
		nue^.dato:= cod;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure buscarAnio(l:lista; anio:integer; var ld:listaD);
	begin
		while(l<>nil)do begin
			if(l^.dato.anio = anio)then
				agregarAdelante(ld, l^.dato.cod);
			l:=l^.sig;
		end;
	end;

	procedure codigosReclamo(a:arbol; anio:integer; var l:listaD);
	begin
		if(a<>nil)then begin
			buscarAnio(a^.dato.lista,anio,l);
			codigosReclamo(a^.HI,anio,l);
			codigosReclamo(a^.HD,anio,l);
		end;
	end;

	procedure imprimirListaD(l:listaD);
	begin
		while(l<>nil)do begin
			writeln('cod:      ', l^.dato);
			l:=l^.sig;
		end;
	end;
	
var
	anio:integer;
	l:listaD;
begin
	writeln('ingrese un anio');readln(anio);
	l:=nil;
	codigosReclamo(a,anio,l);
	imprimirListaD(l);
end;

//-------------------------PROGRAMA PRINCIPAL------------------
var
	a:arbol;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	imprimirArbol(a);
	incisoB(a);
	incisoC(a);
	incisoD(a);
end.

