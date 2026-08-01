program ej3p3;
Const
	leg_fin=0;
	dias=31;
Type
	rango_dias= 1..31;
	finales=record
		legajo:integer;
		materia:integer;
		fecha:rango_dias;
		nota:integer;
	end;
	
	regLista=record
		materia:integer;
		fecha:integer;
		nota:integer;
	end;
	
	lista=^nodo;
	nodo=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		legajo:integer;
		lista:lista;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
//------------------------------------------------MODULOS-----------------------------------------
procedure cargarArbol(var a:arbol);
	procedure leerFinales(var f:finales);
	begin
		writeln('Ingrese un legajo: '); readln(f.legajo);
	    if(f.legajo<> leg_fin)then begin
			f.fecha:= random(31)+14;
			f.materia:=random(7))
			f.nota:=random(11)+1;
		end;
	end;
	procedure cargarReg(f:finales; var rl:regLista);
	begin
		rl.materia:=f.materia;
		rl.fecha:=f.fecha;
		rl.nota:=f.nota;
	end;
	
	procedure insertarArbol(var a:arbol; legajo:integer; rl:regLista);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato.legajo:=legajo;
			a^.dato.lista:=nil;
			a^.HI:=nil;
			a^.HD:=nil;
			agregarAdelante(a^.dato.lista,rl);
		end
		else begin
			if(legajo < a^.dato.legajo )then
				insertarArbol(a^.HI, legajo, rl)
			else 
				if(legajo= a^.dato.legajo)then
					agregarAdelante(a^.dato.lista,rl)
				else
					insertarArbol(a^.HD, legajo, rl)
		end;
	end;




var	
	f:finales;
	rl:regLista;
begin
	leerFinales(f);
	while(f.legajo<>leg_fin)do begin
		cargarReg(f,rl);
		insertarArbol(a,f.legajo);
		leerFinales(f);
	end;
end;

		




//--------------------------PROGRAMA PRINCIPAL---------------------------------------------
var
	a:arbol;
begin
	a:=NIL;
	cargarArbol(a);
end.



