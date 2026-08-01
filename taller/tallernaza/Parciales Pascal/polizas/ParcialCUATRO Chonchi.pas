program ParcialTRES;
type
	sub_anio=2000..2023;
	fecha = record
		dia:integer;
		mes:integer;
		anio:sub_anio;
	end;
	
	poliza = record
		dni:integer;
		suma_asegurada:real;
		cuota:integer;
		vencimiento:fecha;
	end;
	
	arbol = ^nodo;
	nodo = record
		dato:poliza;
		hi:arbol;
		hd:arbol;
	end;
	lista = ^nodol;
	nodol = record
		dato:poliza;
		sig:lista;
	end;
	
	vector = array[2000..2023] of lista;
{----------------------------------------}
procedure leerPoliza(var po:poliza);
begin
	po.dni:=random(42)-1;{genera un numero entre -1 y 40}
	if(po.dni <> -1) then begin
		po.suma_asegurada:=random(40000)+random(100)/10;
		po.cuota:=random(12)+1;
		po.vencimiento.dia:=random(30)+1;
		po.vencimiento.mes:=random(12)+1;
		po.vencimiento.anio:=random(2023-2000+1)+2000;
	end;
end;

procedure agregoAlArbol(var a:arbol; po:poliza);
begin
	if(a=nil) then begin
		new(a);
		a^.dato:=po;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
		if(po.suma_asegurada < a^.dato.suma_asegurada) then
			agregoAlArbol(a^.hi,po)
		else
			agregOAlArbol(a^.hd,po);
	end;
end;
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil) then begin
		writeln('Dni: ',a^.dato.dni,', suma asegurada: ',a^.dato.suma_asegurada:0:2,', cuota: ',a^.dato.cuota,', vencimiento: ', a^.dato.vencimiento.dia,'/',a^.dato.vencimiento.mes,'/',a^.dato.vencimiento.anio);
		imprimirArbol(a^.hi);
		imprimirArbol(a^.hd);
	end;
end;

procedure moduloA(var a:arbol);
var
	po:poliza;
begin
	a:=nil;
	Randomize;
	leerPoliza(po);
	while(po.dni <> -1) do begin
		agregoAlArbol(a,po);
		leerPoliza(po);
	end;
	writeln('DATOS DEL ARBOL----------------');
	imprimirArbol(a);
end;

procedure inicializoVector(var v:vector);
var
	i:sub_anio;
begin
	for i:= 2000 to 2023 do 
		v[i]:=nil;
end;

procedure agregarLista(var L:lista; dato:poliza); {aca use el codigo viejo de agregar ordenado porque no me acuerdo el otro :(}
var
  nue: lista;
  act, ant: lista; {punteros auxiliares para recorrido}
begin
  new (nue);
  nue^.dato := dato;
  act := L; {ubico act y ant al inicio de la lista}
  ant := L;
  while( act <> nil)and(l^.dato.dni > act^.dato.dni)do
  begin
    ant := act;
    act:= act^.sig;
  end;
  if (act = ant) then {al inicio o lista vacía}
    L:= nue
  else {al medio o al final}
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure recorroArbol(a:arbol; valor:real; var v:vector);
begin
	if(a<>nil) then begin
		if(a^.dato.suma_asegurada < valor) then begin
			agregarLista(v[a^.dato.vencimiento.anio],a^.dato);
			recorroArbol(a^.hi,valor,v);
			recorroArbol(a^.hd,valor,v);
		end
		else
			recorroArbol(a^.hi,valor,v);
	end;
end;

procedure imprimoVector(v:Vector);
var
	i:sub_anio;
	l:lista;
begin
	for i:= 2000 to 2023 do begin
		if(v[i] <> nil) then begin
			writeln('LISTA DEL ANIO ',i);
			l:=v[i];
			while(l<>nil) do begin
				writeln('Dni: ',l^.dato.dni,', suma asegurada: ',l^.dato.suma_asegurada:0:2,', cuota: ',l^.dato.cuota,', vencimiento: ', l^.dato.vencimiento.dia,'/',l^.dato.vencimiento.mes,'/',l^.dato.vencimiento.anio);
				l:=l^.sig;
			end;
			writeln();
		end;
	end;
end;
procedure moduloB(a:arbol; var v:vector);
var
	valor:real;
begin
	inicializoVector(v);
	writeln('Ingrese un valor (punto b): ');
	readln(valor);
	recorroArbol(a,valor,v);
	
	writeln();
	writeln('IMPRIMO VECTOR DE LISTA----------');
	imprimoVector(v);
	
end;

procedure recorroListas(l:lista; DNI:integer; var cant:integer);
begin
	if(l<>nil) then begin
		if(l^.dato.dni = DNI) then 
			cant:=cant+1;
		recorroListas(l^.sig,DNI,cant);
	end;
end;

procedure moduloC(v:vector);
var
	DNI,cant:integer;
	i:sub_anio;
begin
	cant:=0;
	writeln('Ingrese un DNI (punto b): ');
	readln(DNI);
	for i:= 2000 to 2023 do begin
		if (v[i] <> nil) then 
			recorroListas(v[i],DNI,cant);
	end;
	writeln('La cantidad de polizas del dni ingresado es: ',cant);
end;

{----------------------------------------}
var 
	a:arbol;
	v:vector;
BEGIN
	moduloA(a);
	moduloB(a,v);
	moduloC(v);
END.

