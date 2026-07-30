program odontologia;
Const
	max_diag= 10;
	dni_fin=0;
Type
	rango_diag= 1..max_diag;
	rango_dia= 1..31;
	
	atencion= record
		matricula: integer;
		dni:integer;
		dia:rango_dia;
		diag:rango_diag;
	end;
	
	regLista=record
		dni:integer;
		dia:rango_dia;
		diag:rango_diag;
	end;
	
	lista=^nodoL;
	nodoL= record
		dato:regLista;
		sig:lista;
	end;
	
	
	regArbol= record
		matricula:integer;
		lista:lista;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;

	vector= array[rango_diag]of integer;


procedure cargarArbol(var a:arbol);

procedure leerAtencion(var at:atencion);
begin
	at.dni:= random(50);
	if(at.dni <> dni_fin)then begin
		at.matricula:= random(100);
		at.dia:=1+ random(31);
		at.diag:= 1+ random(10);
	end;
end;

procedure cargarReg(at:atencion; var rl:regLista);
begin
		rl.dni:=at.dni;
		rl.dia:=at.dia;
		rl.diag:=at.diag;
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

procedure insertarArbol(var a:arbol; matricula:integer; rl:regLista);
begin
	if(a=nil)then begin
		new(a);
		a^.dato.matricula:=matricula;
		a^.dato.lista:=nil;
		agregarAdelante(a^.dato.lista,rl);
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else 
		if(a^.dato.matricula = matricula)then
			agregarAdelante(a^.dato.lista,rl)
		else
			if(a^.dato.matricula > matricula)then
			insertarArbol(a^.HI,matricula,rl)
			else
				insertarArbol(a^.HD,matricula,rl)
end;
	

var
	at:atencion;
	rl:regLista;
begin
	leerAtencion(at);
	while(at.dni <> dni_fin)do begin
		cargarReg(at,rL);
		insertarArbol(a,at.matricula,rl);
		leerAtencion(at);
	end;
end;

//-------------------
procedure imprimirLista(l:lista);
begin
	while (l<>nil)do begin
		writeln('dni:  ', l^.dato.dni);
		writeln('dia:  ', l^.dato.dia);
		writeln('diagnostico:  ', l^.dato.diag);
		l:=l^.sig;
	end;
end;



procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		
		imprimirArbol(a^.HI);
		writeln('----------------------------');
		writeln('Matricula:     ',a^.dato.matricula);
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.Hd);
	end;
end;
//-----------------------------INCISO B-------------------
function recorrerLista(l:lista; valor:integer):integer;
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		if(l^.dato.dni = valor)then
			cant:=cant+1;
		l:=l^.sig;
	end;
	recorrerLista:=cant;
end;


procedure cantidadAtenciones(a:arbol; m1,m2:integer;  valor:integer; var cant:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.matricula >m1 )then
			if(a^.dato.matricula <m2 )then begin
				cantidadAtenciones(a^.HI,m1,m2,valor,cant);
				cant:=cant+(recorrerLista(a^.dato.lista,valor));
				cantidadAtenciones(a^.HD,m1,m2,valor,cant);
			end
			else
				cantidadAtenciones(a^.HI,m1,m2,valor,cant)
		else
			cantidadAtenciones(a^.HD,m1,m2,valor,cant);
	end;
end;
	
procedure inicializarVector(var v:vector);
var
	i:integer;
begin
	for i:= 1 to max_diag do
		v[i]:=0
end;

procedure cargarVector(l:lista; var v:vector);
begin
	while(l<>nil)do begin
		v[l^.dato.diag]:=v[l^.dato.diag]+1;
		l:=l^.sig;
	end;
end;


procedure retornarVector(a:arbol; var v:vector);
begin
	if(a<>nil)then begin
		retornarVector(a^.HI,v);
		cargarVector(a^.dato.lista,v);
		retornarVector(a^.HD,v);
	end;
end;
	
procedure imprimirVector(v:vector);
var
	i:integer;
begin
	for i:= 1 to max_diag do
		writeln('La cantidad de atenciones es:  ', v[i]);
end;
	
//------------------	PROGRAMA PRINCIPAL-----------------
var
	a:arbol;
	m1,m2,valor,cant:integer;
	v:vector;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	writeln('-----ARBOL----');
	imprimirArbol(a);
	writeln('Ingrese dos matriculas:    ');readln(m1); readln(m2);
	writeln('Ingrese un valor:   '); readln(valor);
	cantidadAtenciones(a,m1,m2,valor,cant);
	writeln('La cantidad de atenciones con el mismo dni:  ',cant);
	inicializarVector(v);
	retornarVector(a,v);
	imprimirVector(v);
end.
