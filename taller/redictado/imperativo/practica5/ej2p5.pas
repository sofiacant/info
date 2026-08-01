program ej2p5;
Const
	anioA=2015;
	anioB=2024;
	marca_fin='MMM';
Type
	str15=string[15];
	rango_anios=anioA..anioB;
	
	autos=record
		patente:integer;
		anio:rango_anios;
		marca:str15;
		color:str15;
		modelo:str15;
	end;
	
	arbol1=^nodoArbol1;
	nodoArbol1= record
		dato:autos;
		HI: arbol1;
		HD:arbol1;
	end;
	
	regLista=record
		patente:integer;
		color:str15;
	end;
	
	listaM2= ^nodoLista;
	nodoLista=record
		dato:regLista;
		sig:listaM2;
	end;
	
	regArbol2=record
		marca:str15;
		listaM2:listaM2;
	end;
	
	arbol2=^nodoArbol2;
	nodoArbol2=record
		dato:regArbol2;
		HI:arbol2;
		HD:arbol2;
	end;
	
	regAutos= record
		patente:integer;
		marca:str15;
		color:str15;
		modelo:str15;
	end;
	
	listaV= ^nodoLV;
	nodoLV=record
		dato:regAutos;
		sig:listaV;
	end;
	
	vListas= array[rango_anios]of listaV;
	
//------------------------------------------------------FIN TYPE------------------------------------
procedure cargarArboles(var a1:arbol1; var a2:arbol2);
	
	procedure leerAutos(var a:autos);
	begin
		writeln('Ingrese una marca:   ');
		readln(a.marca);
		if(a.marca <> marca_fin)then begin
			writeln('Ingrese una patente:   '); readln(a.patente);
			writeln('Ingrese un anio:   ');  readln(a.anio);
			writeln('Ingrese un color :   '); readln(a.color);
			writeln('Ingrese un modelo:   '); readln(a.modelo);
		end;
	end;

	procedure insertarArbol1(var a: arbol1; auto:autos);
	begin
		if(a=nil)then begin
			new(a);
			a^.HI:=NIL;
			a^.HD:=NIL;
			a^.dato:= auto;
		end
		else begin
			if( auto.patente < a^.dato.patente)then
					insertarArbol1(a^.HI, auto)
			else
				insertarArbol1(a^.HD,auto)
		end;
	end;
	
	procedure cargarRegistros(var rl:regLista; var ra2:regArbol2; a:autos);
	begin
		rl.patente:=a.patente;
		rl.color:=a.color;
		ra2.marca:=a.marca;
	end;
	
	
	procedure agregarAdelante(var l:listaM2; rl:regLista);
	var
		nue:listaM2;
	begin
		new(nue);
		nue^.dato:=rl;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure insertarArbol2(var a:arbol2; rl:regLista;  marca:str15; auto:autos);
	begin
		if(a=nil)then begin
			new(a);
			a^.HI:=nil;
			a^.HD:=nil;
			a^.dato.listaM2:=nil;
			agregarAdelante(a^.dato.listaM2, rl);
			a^.dato.marca:=marca;
		end
		else begin
			if(marca < a^.dato.marca)then
				insertarArbol2(a^.HI,rl,marca,auto)
			else
				if(marca = a^.dato.marca)then
					agregarAdelante(a^.dato.listaM2, rl)
				else
					insertarArbol2(a^.HD , rl ,marca, auto)
		end;
	end;		
	
	
var
	auto:autos;
	rl:regLista;
	ra2:regArbol2;
begin
	leerAutos(auto);
	while(auto.marca <> marca_fin)do begin
		insertarArbol1(a1,auto);
		cargarRegistros(rl,ra2,auto);
		insertarArbol2(a2, rl, ra2.marca , auto);
		leerAutos(auto);
	end;
end;

//-------------------------------------------------INCISO B---------------------------
function incisoB(a:arbol1; marca:str15):integer;
begin
	if(a=nil)then 
		incisoB:=0
	else
		if(a^.dato.marca= marca)then
			incisoB:= 1+ incisoB(a^.HI,marca)+ incisoB(a^.HD,marca)
		else
			incisoB:= 0+incisoB(a^.HI,marca)+ incisoB(a^.HD,marca)
end;

//---------------------------------------INCISO C-----------------------------------------------
function contabilizarLista(l:listaM2):integer;
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		cant:= cant+1;
		l:=l^.sig;
	end;
	contabilizarLista:=cant;
end;


function incisoC(a:arbol2; marca:str15):integer;
begin
	if(a=nil)then
		incisoC:=0
	else
		if(a^.dato.marca= marca)then
			incisoC:= contabilizarLista(a^.dato.listaM2)
		else
			incisoC:= incisoC(a^.HI,marca)+incisoC(a^.HD,marca);
end;
		
//---------------------------------------INCISO D--------------------- PREGUNTAR POR REGISTROS Y REUSABILIDAD!!!!!!!!!!!!!!
procedure incisoD(a:arbol1; var v:vListas);

	procedure inicializarVector(var v:vListas);
	var
		i:integer;
	begin
		for i:= anioA to anioB do
			v[i]:= NIL;
	end;

	procedure cargarRegLista(a:autos; var auto:regAutos);
	begin
		auto.patente:=a.patente;
		auto.marca:=a.marca;
		auto.modelo:=a.modelo;
		auto.color:=a.color;
	end;

	procedure cargarLista(var l:listaV; a:regAutos);
	var
		nue:listaV;
	begin
		new(nue);
		nue^.dato:=a;
		nue^.sig:=l;
		l:=nue;
	end;
	
	procedure recorrerArbol(a:arbol1; var v:vListas; auto:regAutos);
	begin
		if(a<> nil)then begin
			cargarLista(v[a^.dato.anio],auto);
			recorrerArbol(a^.HI,v,auto);
			recorrerArbol(a^.HD,v,auto);
		end;
	end;
var
	auto:regAutos;
begin
	inicializarVector(v);
	cargarRegLista(a^.dato, auto);
	recorrerArbol(a,v,auto);
end;
//----------------------------------------------------------INCISO E------------------------------------
procedure incisoE(a:arbol1; patente:integer; var modelo:str15);
begin
	if(a<>nil)then begin
		if(patente <a^.dato.patente )then 
				incisoE(a^.HI,patente,modelo)
		else
			if(a^.dato.patente=patente)then
				modelo:= a^.dato.modelo
			else
				incisoE(a^.HD,patente,modelo);
	end;
end;

//-----------------------------------INCISO F-------------------------------------
procedure busquedaPatente(l:listaM2; patente:integer; var color:str15);
begin
	while(l<>nil)do begin
		if(l^.dato.patente = patente)then
			color:=l^.dato.color;
		l:=l^.sig;
	end;
end;


procedure incisoF(a:arbol2; patente:integer; var color:str15);

begin
	if(a<>nil)then begin
		busquedaPatente(a^.dato.listaM2,patente,color);               //PREGUNTAR POR COLOR
		if(color <> 'no esta')then begin
			incisoF(a^.HI, patente,color);
			incisoF(a^.HD,patente,color);
		end;
	end;
end;
			


//-----------------------------PROGRAMA PRINCIPAL---------------------------------------		
var
	a1:arbol1;
	a2:arbol2;
	marca,modelo,color:str15;
	patente:integer;
	v:vListas;
begin
	a1:=nil;
	a2:=nil;
	cargarArboles(a1,a2);
	//imprimirArboles(a1,a2);
	writeln('Ingrese una marca');readln(marca);
	writeln('La cantidad de autos de  ',marca, ' es: ' ,incisoB(a1,marca));
	writeln('Ingrese una marca');readln(marca);
	writeln('La cantidad de autos de  ',marca, ' es: ' ,incisoC(a2,marca));
	incisoD(a1, v);
	writeln('Ingrese una patente:  '); readln(patente);
	incisoE(a1,patente,modelo);
	writeln('El modelo del auto es:   ',modelo);
	writeln('Ingrese una patente:  '); readln(patente);
	color:= 'no esta';
	incisoF(a2,patente,color);
end.	
