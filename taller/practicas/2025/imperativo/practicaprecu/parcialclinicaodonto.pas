//Una clínica odontológica necesita un sistema para el procesamiento de las atenciones realizadas a los pacientes en julio de 2025.
//a) Implementar un módulo que lea información de las atenciones. De cada atención se lee: matrícula del
//odontólogo, dni del paciente, día y diagnóstico (valor entre 1 y 10). La lectura finaliza con el dni O. Se sugiere
//utilizar el módulo leerAtencion(). El módulo debe retornar un árbol binario de búsqueda ordenado por matrícula
//del odontólogo. Para cada matrícula de odontólogo deben almacenarse las atenciones realizadas.
//b) Implementar un módulo que reciba el árbol generado en a), dos matrículas y un valor entero. El módulo debe
//retornar la cantidad total de atenciones realizadas al paciente con DNI igual al valor ingresado por odontólogos
//con matrículas entre las dos matrículas ingresadas (sin incluir).
//c) Realizar un módulo que reciba el árbol generado en a), y retorne, para cada diagnóstico, la cantidad de
//atenciones realizadas.
program clinicaodontologica;
Const
	max_diag=10;
	max_dia=31;
	dni_fin=0;
Type
	rango_diag=1..max_diag;
	rango_dia= 1..max_dia;
	
	 atencion=record
		matricula:integer;
		dni:integer;
		dia:rango_dia;
		diagnostico:rango_diag;
	end;
	 
	 reglista=record
		dni:integer;
		dia:integer;
		diagnostico:rango_diag;
	end;
	
	 lista=^nodolista;
	 nodolista=record
		dato:reglista;
		sig:lista;
	end;
	 
	 regArbol=record
		matricula:integer;
		lista:lista;
	end;
	 
	 arbol=^nodoarbol;
		nodoarbol=record
			dato:regArbol;
			hi:arbol;
			hd:arbol;
		end;
		
	vectord= array [rango_diag]of integer;
//----------------------------CARGAR ARBOL--------------------------------
procedure cargarArbol(var a:arbol);

procedure cargarReg(ate:atencion; rl:regLista);
begin
	rl.dia:=ate.dia;
	rl.diagnostico:=ate.diagnostico;
	rl.dni:=ate.dni;
end;
procedure leerAtencion(var ate:atencion);
begin
	ate.dni:= 0+ random(100);
	if(ate.dni<> dni_fin)then begin
		ate.matricula:=random(100);
		ate.dia:=1+random(31);
		ate.diagnostico:=1+ random(10);
	end;
end;

procedure agregarAdelante(var l:lista; rl:regLista);
var
	nue:lista;
begin
	new(nue); nue^.dato:=rl;
	nue^.sig:=l;
	l:=nue;
end;
procedure insertarArbol(var a:arbol; matricula:integer; rl:regLista); 
begin
	if(a=nil)then begin
		new(a);
		a^.dato.matricula:=matricula;
		a^.dato.lista:=NIL;
		agregarAdelante(a^.dato.lista,rl);
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else 
		if (a^.dato.matricula=matricula)then 
			agregarAdelante(a^.dato.lista,rl)
		else
			if( a^.dato.matricula>matricula)then
				insertarArbol(a^.hi, matricula, rl)
			else
				insertarArbol(a^.hd, matricula, rl);
end;
	

var
	ate:atencion;
	rl:reglista;
begin
	leerAtencion(ate);
	while(ate.dni<>dni_fin)do begin
		cargarReg(ate,rl);
		insertarArbol(a,ate.matricula,rl);
		leerAtencion(ate);
	end;
end;
//-----------------------------IMPRIMIR--------------------------
procedure imprimirLista( l:lista);
begin
	while(l<>nil) do begin
		writeln('Dni:  ',l^.dato.dni);
		writeln('Dia:  ',l^.dato.dia);
		writeln('Diagnostico:  ',l^.dato.diagnostico);
		l:=l^.sig;
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbol(a^.hi);
		writeln('matricula: ', a^.dato.matricula);
		writeln('-----LISTA------');
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.hd);
	end;
end;
//-------------------INCISO B---------------------------------------
//b) Implementar un módulo que reciba el árbol generado en a), dos matrículas y un valor entero. El módulo debe
//retornar la cantidad total de atenciones realizadas al paciente con DNI igual al valor ingresado por odontólogos
//con matrículas entre las dos matrículas ingresadas (sin incluir).
function contarAtenciones(l:lista; valor:integer):integer;
var
	cant:integer;
begin
	cant:=0;
	while(l<>nil)do begin
		if(l^.dato.dni=valor)then 
			cant:=cant+1;
		l:=l^.sig;
	end;
	contarAtenciones:=cant;
end;	

procedure entreRangos(a:arbol; m1,m2,valor:integer; var cant:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.matricula>m1)then
			if(a^.dato.matricula>m2)then begin
				entreRangos(a^.hi,m1,m2,valor,cant);
				cant:= cant + (contarAtenciones(a^.dato.lista,valor));
				entreRangos(a^.hd,m1,m2,valor,cant);
			end
			else
				entreRangos(a^.hi,m1,m2,valor,cant)
	 else
		entreRangos(a^.hd,m1,m2,valor,cant);
	end;
end;
//--------------------------INCISO C----------------------
//c) Realizar un módulo que reciba el árbol generado en a), y retorne, para cada diagnóstico, la cantidad de atenciones realizadas.
procedure inicializarVector(var v:vectord);
var
	i:integer;
begin
	for i:= 1 to max_diag do
		v[i]:=0;
end;

procedure contabilizar(l:lista; var v:vectord);
begin
	while(l<>nil)do begin
		v[l^.dato.diagnostico]:=v[l^.dato.diagnostico]+1;
		l:=l^.sig;
	end;
end;
procedure atencionesporDiagnostico(a:arbol; var v:vectord);
begin
	if(a<>nil)then begin
		atencionesporDiagnostico(a^.hi,v);
		contabilizar(a^.dato.lista,v);
		atencionesporDiagnostico(a^.hd,v);
	end;
end;
//----------------PROGRAMA PRINCIPAL---------------
var
	a:arbol;
	m1,m2,valor,cant:integer;
	v:vectord;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	writeln('----------ARBOL---------');
	imprimirArbol(a);
	writeln('Ingrese una matricula ');readln(m1);
	writeln('Ingrese una matricula ');readln(m2);
	writeln('Ingrese un valor'); readln(valor); 
	cant:=0;
	entreRangos(a,m1,m2,valor,cant);
	writeln('La cantidad de atenciones es: ',cant); 
	inicializarVector(v);
	atencionesporDiagnostico(a, v)
end.
