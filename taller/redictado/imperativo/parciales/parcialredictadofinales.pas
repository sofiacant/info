program parcial070425finales;
Const
	anioA=2011;
	anioB=2024;
	legajo_fin=-1;
Type
	rango_anios= anioA..anioB;
	
	fecha=record
		dia,mes,anio:integer;
	end;
	
	final=record
		legajo:integer;
		nota:real;
		fecha:fecha;
	end;
	
	regLista= record
		legajo:integer;
		nota:real;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:regLista;
		sig:lista;
	end;
	
	vFinales= array[rango_anios]of lista;
	
	regListaA= record
		nota:real;
		fecha:fecha;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:final;
		HI:arbol;
		HD:arbol;
	end;
//--------------------------------------------------CARGA DEL VECTOR-------------------------------
procedure cargarVector(var v: vFinales);
  
  procedure inicializarVector(var v:vFinales);
  var
	i:integer;
  begin
	for i:= anioA to anioB do
		v[I]:=nil;
  end;
  
  procedure leerFinal(var f:final);
  begin
	f.legajo:=random(102)-1;
	if(f.legajo <> legajo_fin)then begin
		f.nota:= random(11);
		f.fecha.dia:= random(30)+1;
		f.fecha.mes:= random(11)+1;
		f.fecha.anio:= random(14)+2011;
	end;
 end;

	procedure cargarRegLista(f:final; var rl:regLista);
	begin
		rl.legajo:=f.legajo;
		rl.nota:=f.nota;
	end;
	
	procedure insertarOrdenado(var l:lista; rl:regLista);
	var
		nue,ant,act:lista;
	begin
		
		new(nue);
		nue^.dato:=rl;
		ant:=l;
		act:=l;
		while(act<> nil)  and (act^.dato.nota > rl.nota)do begin
			ant:=act;
			act:=act^.sig;
		end;
		if(ant=act)then
			l:=nue
		else
			ant^.sig:=nue;
		nue^.sig:= act;   
	end;
	 

 var 
	f:final;
	rl:regLista;		
 begin
	randomize;
	inicializarVector(v);
	leerFinal(f);
	while(f.legajo <> legajo_fin)do begin
		cargarRegLista(f,rl);
		insertarOrdenado(v[f.fecha.anio],rl)
		leerFinal(f);
	end;
end;		
//-----------------------------------------------FIN CARGA VECTOR----------------------------------
procedure generarNuevaEstructura(v:vFinales; var a:arbol; valor:integer);
	
	procedure insertarArbol(var a:arbol; f:final );
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:=f;
			a^.HI:=nil;
			a^.HD:=nil;
		end
		else begin
			if(e.legajo< a^.dato.legajo )then
				insertarArbol(a^.HI, f)
			else
				insertarArbol(a^.HD, f)
		end;
	end;
	
	procedure cumpleCondicion(l:lista; v:integer; var a:arbol);
	begin
		while(l<>nil )do begin
			if(l^.dato.nota> n)then
				insertarArbol(a,l^.dato);
			l:=l^.sig;
		end;
	end;
	
	var
		i:integer;
	begin
		for i:= anioA to anioB do 
			cumpleCondicion(v[i],valor,a);
	end;
		//------------------------------------------------------------------
		//--------INCISO C---------------------------

{proceso incisoC(a:arbol; legajo:integer; var cant: m integer)
   if(a<>nil)then 
   *    if(a^.dato.legajo = legajo) then begin
    		cant:=cant+1)
			incisoC(a^.HD,legajo,cant);
		end
		else if (a^.dato.legajo<legajo)then
		 	incisoC(a^.HD,legajo,cant)
		else
		 	incisoC(a^.HO,legajo,cant):
end;

}
function incisoC(a:arbol; leg:integer):integer;
begin
	if(a=nil)then
			incisoC:=0
	else begin
		if(a^.dato.legajo = leg)then
			incisoC:=1+incisoC(a^.HD,leg)
		else
			incisoC:=incisoC(a^.HI,leg)+ incisoC(a^.HD,leg)
end;


//--------------------------PROGRAMA PRINCIPAL---------------------
var
	v:vFinales;
	a:arbol;
	valor,leg:integer;
begin
	cargarVector(v);
	a:=nil;
	writeln('Ingrese una nota menor a 10'); readln(valor);
	generarNuevaEstructura(v,a, valor);
	writeln('Ingrese un legajo de alumno'); readln(leg);
	writeln('La cantidad de examenes que rindio el alumno  con legajo ', leg, ' : ', incisoC(a,leg));
end.





























