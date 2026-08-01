program ejparcialtema124;

Const
	cod_fin=100;
Type
	rango_carga= 100..135;
	rango_codigo= 101..135;
	rango_mes=1..12;
	resultado=record
		legajo:integer;
		cod:rango_carga;
		mes:rango_mes;
		anio:integer;
		nota:real;
	end;
	
	regLista=record
		cod:rango_codigo;
		mes:rango_mes;
		anio:integer;
		nota:real;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		lista:lista;
		legajo:integer;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;

	vCantAplazos= array[rango_codigo]of integer;
	
//-----------------------------------------------------------FIN TYPE-------------

//---------------------------CARGA DEL ARBOL Y DEL VECTOR--------------------------

procedure cargarArbolYVector(var a:arbol; var v:vCantAplazos);

	procedure leerResultado(var r:resultado);
	begin
		r.cod:=100+ random(36);
		if(r.cod <> cod_fin)then begin
			r.legajo:= 1+random(100);
			r.mes:= 1+random(12);
			r.anio:= 2000+random(26);
			r.nota:= 1+ random(10);
		end;
	end;

	procedure cargarRegs(r:resultado;var rl:regLista );
	begin
		rl.cod:= r.cod;
		rl.mes:= r.mes;
		rl.anio:=r.anio;
		rl.nota:=r.nota
	end;
	
	procedure agregarAdelante(var l:lista; rl:regLista);
	var
		nue:lista;
	begin
		new(nue);
		nue^.dato:=rl;
		nue^.sig:= l;
		l:=nue;
	end;
	
	
	procedure insertarArbol(var a: arbol; legajo:integer; rl:regLista);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato.legajo:= legajo;
			a^.dato.lista:=NIL;
			agregarAdelante(a^.dato.lista, rl);
			a^.HI:=NIL;
			a^.HD:=NIL;
		end
		else begin
			if(legajo < a^.dato.legajo)then
				insertarArbol(a^.HI, legajo,rl)
			else
				if(legajo = a^.dato.legajo)then
					agregarAdelante(a^.dato.lista, rl)
				else
					insertarArbol(a^.HD, legajo, rl)
		end;
	end;
	
	procedure inicializarVector(var v:vCantAplazos);
	var 
		i:integer;
	begin
		for i:= 101 to 135 do
			v[i]:=0;
	end;
	
var
	rl:regLista;
	r:resultado;
begin
	inicializarVector(v);
	leerResultado(r);
	while(r.cod <> cod_fin)do begin
		cargarRegs(r,rl);
		insertarArbol(a, r.legajo, rl);
		if(r.nota < 4)then
			v[r.cod]:= v[r.cod]+1;
		leerResultado(r);
	end;
end;
//----------------------------------------------FIN CARGA-----------------------
function incisoB(a:arbol):real;
	
	procedure contarEnLista(l:lista; var cant:integer; var notas:real);
	begin
		while(l<> nil)do begin
				if(l^.dato.nota>= 4)then begin
					cant:= cant+1;
					notas:= notas+ l^.dato.nota;
				end;
			l:=l^.sig;
		end;
	end;
			

	function recorrerArbol(a:arbol; legajo:integer; cant:integer; notas:real):real;
	begin
		if(a=nil)then
			recorrerArbol:=0
		else begin
			if(a^.dato.legajo = legajo)then begin
				contarEnLista(a^.dato.lista, cant, notas);
				recorrerArbol:= (notas/cant );
			end
			else if(legajo < a^.dato.legajo)then
					recorrerArbol(a^.HI, legajo, cant,notas)
					else
						recorrerArbol(a^.HI, legajo, cant,notas);
		end;
	end;
				
var
	legajo,cant:integer;
    notas:real;
	
begin
	cant:=0;
	notas:=0;
	writeln('Ingrese un legajo:    ');
	readln(legajo);
	incisoB:= recorrerArbol(a, legajo,cant,notas);
end;
	

//--------------------------------------------------------FIN INCISO B-----------------


//----------------------------IMPRIMIR ARBOL------------------------------
procedure imprimirLista(l:lista);
begin
	while(l<>nil)do begin
		writeln('codigo:   ', l^.dato.cod);
		writeln('mes:   ', l^.dato.mes);
		writeln('anio:   ', l^.dato.anio);
		writeln('nota:   ', l^.dato.nota:2:2);
		writeln('............................................................');
		l:=l^.sig;
	end;
end;
		


procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('legajo:  ', a^.dato.legajo);
		writeln('Lista:        ');
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.HD);
	end;
end;
//-----------------------------------------------------------------------------------------------------
procedure  incisoC(v:vCantAplazos);

	procedure maxAplazos(v:vCantAplazos; i:integer; var max:integer; var cant:integer);
	begin	
		if(i<136)then begin
			if(v[i]> cant)then begin
				max:= i;
				cant:=v[i];
			end;
			maxAplazos(v,i+1, max, cant);
		end;
	end;


var
	max:integer;
	cant:integer;
begin
	cant:=-1;
	max:=-1;
	maxAplazos(v, 101, max, cant);
	writeln('El codigo de materia con mas aplazos es: ', max);
end;
//---------------------------------------------IMPRIMIR VECTOR-------------------------
procedure imprimirVector(v:vCantAplazos);
var
	i:integer;
begin
	for i:= 101 to 135 do
		writeln('Cantidad de aplazos en :', i, '  :  ', v[i]);
end;

//------------------------------------------PROGRAMA PRINCIPAL-------------------------------
var
	a:arbol;
	v:vCantAplazos;
begin
	a:=NIL;
	randomize;
	cargarArbolYVector(a,v);
	writeln('-------------------ARBOL-------------------');
	imprimirArbol(a);
	incisoB(a);
	writeln(' El promedio sin aplazos es: ',incisoB(a):2:2);
	
	writeln('---------------------------VECTOR---------------------');
	imprimirVector(v);
	incisoC(v);
end.
