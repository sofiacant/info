program Practica1EJE2;
const
	dimf = 300;
type
	oficina = record
		codigo:integer;
		dni:integer;
		valor:real;
	end;
	
	vector = array[1..dimf] of oficina;
{PROCESOS---------------------------------------------------------------}
procedure LeerOficina(var ofi:oficina);
begin
	with ofi do begin
		writeln('INGRESE EL CODIGO D ID');
		readln(codigo);
		if(codigo <> -1) then begin
			writeln('INGRESE UN DNI');
			readln(dni);
			writeln('INGRESE EL VALOR DE LA EXPENSA');
			readln(valor);
		end;
	end;
end;


procedure CargarVector(var v:vector; var diml:integer);
var
	ofi:oficina;
begin
	diml:=0;
	LeerOficina(ofi);
	while(ofi.codigo <> -1) and (diml < dimf) do begin
		diml:=diml+1;
		v[diml]:=ofi;
		LeerOficina(ofi);
	end;
end;


procedure ImprimirVector(v:vector; diml:integer);
var 
	i:integer;
begin
	for i:= 1 to diml do 
		writeln('Codigo de id: ',v[i].codigo,', dni: ',v[i].dni,', valor de expensa: ',v[i].valor);
end;


procedure Insercion(var v:vector; diml:integer);
var
	i,j:integer;
	actual:oficina;
begin
	for i:= 2 to diml do begin
		actual:=v[i];
		j:=i-1;
		while(j>0) and (v[j].codigo > actual.codigo) do begin
			v[j+1]:=v[j];
			j:= j-1;
		end;
		v[j+1]:=actual;
	end;
end;


procedure Seleccion(var v:vector; diml:integer);
var
	i,j,pos:integer;
	item:oficina;
begin
	for i:= 1 to (diml-1) do begin
		pos:=i;
		for j:= i+1 to diml do begin
			if(v[j].codigo < v[pos].codigo) then
				pos:=j;
		end;
		item:=v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;


{PROGRAMA PRINCIPAL-----------------------------------------------------}
var
	v:vector;
	diml:integer;
BEGIN
	CargarVector(v,diml);
	writeln('VECTOR SIN ORDENAR-----------------------------------------');
	ImprimirVector(v,diml);
	Insercion(v,diml);
	writeln('VECTOR ORDENADO POR INSERCION------------------------------');
	ImprimirVector(v,diml);	
	Seleccion(v,diml);
	writeln('VECTOR ORDENADO POR SELECCION------------------------------');
	ImprimirVector(v,diml);
END.
