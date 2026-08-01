program parcialpolizas;
Const
	anioA=2000;
	anioB=2023;
	dni_fin=-1;
Type
	rango_anios= anioA..anioB;
	poliza=record
		dni:integer;
		suma:real;
		cuota:real;
		fecha:integer;
	end;
	
	 arbol=^nodoA;
	 nodoA= record
		dato:poliza;
		HI,HD:arbol;
	end;
	
	regLista= record
		dni:integer;
		suma:real;
		cuota:real;
	end; 
	
	lista= ^nodoL;
	nodoL=record
		dato: regLista;
		sig:lista;
	end;
	
	vPolizas= array [rango_anios] of lista;
	
	//------------------------------------------FIN TYPE---------------------------
	
//----------------------------------------------CARGA DEL ARBOL-----------------------------
procedure cargarArbol(var a:arbol);

	procedure leerPoliza(var p:poliza);
	begin
		p.dni:= -1 + random(20);
		writeln('dni: ', p.dni);
		if(p.dni <> dni_fin)then begin
			p.suma:= random(500)/ (random(10)+1);
			writeln('suma: ',p.suma:2:2);
			p.cuota:= random(100);
			writeln('cuota:  ',p.cuota:2:2);
			p.fecha:=2000 + random(24);
			writeln('fecha:  ',p.fecha);
		end;
	end;

	procedure insertarArbol(var a:arbol; p:poliza);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:=p;
			a^.HI:=nil;
			a^.HD:=nil;
		end
		else begin
			if(p.suma < a^.dato.suma)then 
				insertarArbol(a^.HI,p)
			else
				insertarArbol(a^.HD, p)
		end;
	end;

var
	p:poliza;
begin
	leerPoliza(p);
	while(p.dni <> dni_fin)do begin
		insertarArbol(a, p);
		leerPoliza(p);
	end;
end;
		
//-------------------------------INCISO B--------------------------------
procedure incisoB(a:arbol; var v:vPolizas);

	procedure inicializarVector( var v:vPolizas);
	var
		i:rango_anios;
	begin
		for i:= 2000 to 2023 do
			v[i]:= NIL
	end;
	
	procedure cargarReg(p:poliza; var rl:regLista);
	begin
		rl.dni:=p.dni;
		rl.cuota:=p.cuota;
		rl.suma:= p.suma;
	end;
	
	procedure insertarOrdenado(var l:lista; rl:regLista);
	var
		nue, act,ant:lista;
	begin
		new(nue);
		nue^.dato:= rl;
		act:= l;
		ant:=l;
		while(act<> nil)and (act^.dato.dni < rl.dni )do begin
			ant:= act;
			act:= act^.sig;
		end;
		if(ant= act)then
			l:=nue
		else
			ant^.sig:=nue;
		nue^.sig:= act
	end;
	
	procedure procesarArbol(a:arbol;var v:vPolizas; valor:real);
	var
		rl:regLista;
	begin
		if(a<>nil)then begin
			if(a^.dato.suma < valor)then begin
				cargarReg(a^.dato, rl);
				insertarOrdenado(v[a^.dato.fecha], rl );
				procesarArbol(a^.HI,v,valor);
				procesarArbol(a^.HD,v,valor);
			end
			else
				procesarArbol(a^.HI, v,valor);
	end;
end;
	
var
	valor:real;

begin
	inicializarVector(v);
	writeln('Ingrese un valor de suma asegurada:   '); readln(valor);
	procesarArbol(a,v, valor);
end;
//--------------------------------------------FIN INCISO B----------------------	
	
	
//-----------------------------------------INCISO C--------------------------
function incisoC(v:vPolizas): integer;
	
	procedure recorrerLista(l:lista; dni:integer; var cant:integer);
	begin
		while(l<> nil)do begin
			if(l^.dato.dni = dni)then
				cant:=cant+1;
			l:=l^.sig;
		end;
	end;
	
	procedure cantidadPolizas(v:vPolizas; dni:integer; var cant:integer);
	var
		i:rango_anios;
	begin
		for i:= anioA to anioB do 
			recorrerLista(v[i], dni,cant);
	end;
				
			
var
	dni:integer;
	cant:integer;
begin
	writeln('Ingrese un dni');
	readln(dni);
	cant:=0;
	cantidadPolizas(v,dni,cant);
	incisoC:= cant;
	writeln('La cantidad de polizas es: ',cant);
end;
	
//------------------------------------------IMPRIMIR ESTRUCTURAS-------------------
procedure imprimirEstructuras(a:arbol; v:vPolizas);

	procedure imprimirArbol(a:arbol);
	begin
		if(a<> nil)then begin
			imprimirArbol(a^.HI);
			writeln('dni: ', a^.dato.dni);
			writeln('suma: ',a^.dato.suma);
			writeln('cuota', a^.dato.cuota );
			writeln('fecha: ',a^.dato.fecha);
			imprimirArbol(a^.HD);
		end;
	end;
	
	procedure imprimirLista(l:lista);
	begin
		while(l <> nil) do begin
			writeln('dni: ',l^.dato.dni);
			writeln('suma: ',l^.dato.suma);
			writeln('cuota: ',l^.dato.cuota);
			l:=l^.sig;
		end;
	end;
	
	procedure imprimirVector(v:vPolizas);
	var
		i:rango_anios;
	begin
		for i:= 2000 to 2023 do begin
			writeln('Anio:   ', i);
			writeln('-----------------LISTA---------------');
			imprimirLista(v[i]);
		end;
	end;

begin
	writeln('--------------------ARBOL------------------');
	imprimirArbol(a);
	writeln('---------------------------VECTOR---------------');
	imprimirVector(v);
end;
	
//------------------------------PROGRAMA PRINCIPAL-------------------------------
var
	a:arbol;
	v:vPolizas;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	incisoB(a,v);
	incisoC(v);
	imprimirEstructuras(a,v);
end.
	
