{Una empresa de alquiler de autos desea procesar informacion de los alquileres.

	a) Implementar un modulo que lea informacion sobre los alquileres y retorne un vector que agrupe los alquileres de acuerdo a la cantidad
	de dias de alquiler. Para cada cantidad de dias, los alquileres deben almacenarse en un arbol binario de busqueda ordenado por numero de chasis del auto.
	De cada alquiler se lee: dni del cliente, numero de chasis y cantidad de dias(de 1 a 7. La lectura finaliza con el numero de chasis 0).
	 
	b) Implementar un modulo que reciba la estructura generada en a) y un dni D. Este modulo debe retornar la cantidad de alquileres realizados por el dni D.
	
	c)	Implementar un modulo que reciba la estructura generada en a), un dia D y dos numeros de chasis N1 y N2. Este modulo debe retornar la cantidad de 
		alquileres realizados en el dia D, para los chasis entre N1 y N2 (ambos incluidos).
		
	NOTA: implementar el programa principal, que invoque a los incisos a, b y c.}

program ParcialTRES;
const
	dimf = 7;
type
	sub_dias=1..dimf;
	alquiler = record
		dni:integer;
		chasis:integer;
		dia:sub_dias;
	end;
	
	arbol = ^nodo;
	nodo = record
		dni:integer;
		chasis:integer;
		hi:arbol;
		hd:arbol;
	end;
	
	vector = array [sub_dias] of arbol;
{--------------------------------------------------------------}
procedure leerAlquiler(var al:alquiler);
begin
	al.chasis:=Random(30);{Puse 30 para no cargar tantos}
	if(al.chasis <> 0) then begin
		al.dni:=random(2000 - 1000+1)+1000;
		al.dia:=random(7)+1;
	end;
end;

procedure inicializoVector(var v:vector);
var
	i:integer;
begin
	for i:= 1 to dimf do
		v[i]:=nil;
end;

procedure agregoArbol(var a:arbol; al:alquiler);
begin
	if(a=nil) then begin
		new(a);
		a^.dni:=al.dni;
		a^.chasis:=al.chasis;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(al.dni < a^.dni) then
			agregoArbol(a^.hi,al)
		else
			agregoArbol(a^.hi,al);		
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		imprimirArbol(a^.hi);
		writeln('(Dni del cliente: ',a^.dni,', numero de chasis: ',a^.chasis,')');
		imprimirArbol(a^.hd);
	end;
end;

procedure imprimirArboles(v:vector);
var
	i:integer;
begin
	for i:= 1 to dimf do begin
		if(v[i] <> nil) then 
			writeln('ALQUILERES DEL DIA: ',i);
			imprimirArbol(v[i]);
	end;
end;

procedure moduloA(var v:vector);
var
	al:alquiler;
begin
	Randomize;
	inicializoVector(v);
	leerAlquiler(al);
	while(al.chasis <> 0) do begin
		agregoArbol(v[al.dia],al);
		leerAlquiler(al);
	end;
	
	imprimirArboles(v);
end;

procedure recorroArbol(a:Arbol; D:integer; var cant:integer);
begin
	if(a<>nil) then begin
		if(a^.dni=D) then 
			cant:=cant+1;
		recorroArbol(a^.hi,D,cant);
		recorroArbol(A^.hd,D,cant);
	end;
end;

procedure moduloB(v:vector);
var
	D,i,cant:integer;
begin
	cant:=0;
	writeln('Ingrese un DNI para buscar: ');
	readln(D);
	for i:= 1 to dimf do begin
		if(v[i] <> nil) then 
			recorroArbol(v[i],D,cant);
	end;
	writeln('La cantidad de alquileres que realizo el cliente con dni ',D,' fue: ',cant);
end;

procedure buscoChasis(a:arbol; N1,N2:integer; var cant:integer);
begin
	if(a<>nil) then begin
		if(a^.chasis >= N1) then begin
			if(a^.chasis <=N2) then begin
				cant:=cant+1;
				buscoChasis(a^.hi,N1,N2,cant);
				buscoChasis(a^.hd,N1,N2,cant);
			end
			else
				buscoChasis(a^.hi,N1,N2,cant);
		end
		else
			buscoChasis(a^.hd,N1,N2,cant);
	end;
end;

procedure moduloC(v:vector);
var
	N1,N2,cant:integer;
	D:sub_dias;
begin
	writeln('Ingrese un dia D: ');
	readln(D);
	writeln('Ingrese el primer numero de chasis: ');
	readln(N1);
	writeln('Ingrese el segundo numero de chasis: ');
	readln(N2);
	cant:=0;
	buscoChasis(v[D],N1,N2,cant);
	writeln('La cantidad de alquileres entre los chasis ingresados es: ',cant);
end;

{---------------------------------------------------------------}
var 
	v:vector;
BEGIN
	moduloA(v);
	moduloB(v);
	moduloC(v);
END.

