program Practica1EJE1;
const
	dimf = 50;
type
	rango = 1..15;
	rango2 = 1..99;
	venta = record
		dia:integer;
		codigo:integer;
		cant:integer;
	end;
	
	vector = array [1..dimf] of venta;
	
	venta2 = record 
		codigo:integer;
		cant:integer;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:venta2;
		sig:lista;
	end;
{PROCESOS---------------------------------------------------------------}	

procedure CargarVector(var v:vector; var diml:integer);
var
	dia,codigo,cant:integer;
begin
	Randomize;
	diml:=0;
	writeln('INGRESE EL DIA DE LA VENTA');
	read(dia);
	codigo:= random(15 - 1 +1)+1;
	writeln('INGRESE LA CANTIDAD VENDIDA');
	read(cant);
	while(dia <> 0) and (diml < dimf) do begin
		diml:= diml+1;
		v[diml].dia:=dia;
		v[diml].codigo:=codigo;
		v[diml].cant:=cant;
		writeln('INGRESE EL DIA DE LA VENTA');
		read(dia);
		if(dia>0) then begin
			codigo:= random(15 - 1 +1)+1;
			writeln('INGRESE LA CANTIDAD VENDIDA');
			read(cant);
		end;
	end;
end;

procedure ImprimirVector(v:vector; diml:integer);
var 
	i:integer;
begin
	for i:=1 to diml do begin
		writeln('Dia de venta: ',v[i].dia,', codigo: ',v[i].codigo,', cantidad vendida: ',v[i].cant);
	end;
end;

procedure OrdenarVector(var v:vector; diml:integer);
var
	i,j,pos:integer;
	item:venta;
begin
	for i:= 1 to (diml-1) do begin
		pos:=i;
		for j:= i+1 to diml do begin
			if(v[j].codigo < v[pos].codigo) then 
				pos:=j;
		end;
		
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
end;

procedure agregarOrdenado(dato:venta; var l:lista);
var
  nue: lista;
  act, ant: lista; 
begin
  new (nue);
  nue^.dato.codigo := dato.codigo;;
  nue^.dato.cant:= dato.cant;
  act := l; 
  ant := l;
  while( act <> nil)and(dato.codigo > act^.dato.codigo)do
  begin
    ant := act;
    act:= act^.sig;
  end;
  if (act = ant) then 
    l:= nue
  else 
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure RetornarLista(v:vector; diml:integer; var l:lista);
var
	i:integer;
begin
	l:=nil;
	for i:= 1 to diml do begin
		if(v[i].codigo mod 2 = 0) then
			agregarOrdenado(v[i],l);
	end;
end;

procedure ImprimirLista(l:lista);
begin
	while(l<>nil) do begin
		writeln('Codigo de venta: ',l^.dato.codigo,', cantidad vendida: ',l^.dato.cant);
		l:=l^.sig;
	end;
end;


procedure EliminarEnRango(var v:vector; var diml:integer; parametro1:integer; parametro2:integer);
var
	i,j:integer;
begin
	j:=1;
	for i:= 1 to diml do begin
		if(v[i].codigo < parametro1) or (v[i].codigo > parametro2) then begin {ES DECIR QUE EL CODIGO NO SE ENCUENTRA EN EL RANGO}
			v[j]:=v[i];
			j:=j+1;
		end;
	end;
	diml:= j-1;
end;

{PROGRAMA PRINCIPAL-----------------------------------------------------}
var 
	vec:vector;
	diml,parametro1,parametro2:integer;
	lis:lista;
BEGIN
	CargarVector(vec,diml); {PUNTO A}
	ImprimirVector(vec,diml);{PUNTO B}
	
	OrdenarVector(vec,diml);{PUNTO C}
	writeln('VECTOR ORDENADO--------------------------------------------');
	ImprimirVector(vec,diml);{PUNTO D}

	writeln('INGRESE EL PRIMER PARAMETRO DEL RANGO (entre 1 y 15): ');
	readln(parametro1);
	writeln('INGRESE EL SEGUNDO PARAMETRO DEL RANGO (entre 1 y 15): ');
	readln(parametro2);
	EliminarEnRango(vec,diml,parametro1,parametro2);{PUNTO E}
	writeln('VECTOR CON VALORES ELIMINADOS------------------------------');
	ImprimirVector(vec,diml);{PUNTO F}
	
	
	RetornarLista(vec,diml,lis);{PUNTO G}
	writeln('LISTA CON CODIGO PAR---------------------------------------');
	ImprimirLista(lis);{PUNTO H}
END.
