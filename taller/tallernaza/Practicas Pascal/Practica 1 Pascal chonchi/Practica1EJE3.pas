program Practica1EJE3;
const
	dimf = 8;
type
	rango = 1..dimf;
	pelicula = record
		codigo:integer;
		genero:integer;
		puntaje:real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:pelicula;
		sig:lista;
	end;
	
	vector = array [1..dimf] of lista; {VECTOR PRINCIPAL}
	
	registro = record {REGISTRO PARA EL SEGUNDO VECTOR}
		codigo:integer;
		puntaje:real;
	end;
	
	vector2 =  array [1..dimf] of registro;
{PROCESOS---------------------------------------------------------------}
procedure InicializarVector(var v:vector);
var
	i:integer;
begin
	for i:= 1 to dimf do 
		v[i]:=nil;
end;


procedure LeerPelicula(var p:pelicula);
begin
	with p do begin
		writeln('INGRESE EL CODIGO DE LA PELICULA:');
		readln(codigo);
		if(codigo <> -1) then begin
			writeln('INGRESE EL GENERO DE LA PELCULA:');
			readln(genero);
			writeln('INGRESE EL PUNTAJE DE LA PELICULA');
			readln(puntaje);
		end;
	end
end;

procedure agregarAtras(var l:lista; dato: pelicula);
var
	nue, act, ant: lista;
begin
	new(nue);
	nue^.dato := dato;
	ant := l;
	act := l;
	while (act <> nil) do begin
		ant := act;
		act := act^.sig;
	end;
	if (ant = act) then
		l := nue
	else
		ant^.sig := nue;
	nue^.sig := act;
end;

procedure CargarVector(var v:vector);
var
	peli:pelicula;
begin
	InicializarVector(v);
	LeerPelicula(peli);
	while(peli.codigo <> -1) do begin
		agregarAtras(v[peli.genero],peli);
		LeerPelicula(peli);
	end;
end;

procedure mayorPuntaje(l:lista; var registroNuevo:registro);
begin
	while(l <> nil) do begin
		if(l^.dato.puntaje > registroNuevo.puntaje)  then begin
			registroNuevo.puntaje:= l^.dato.puntaje;
			registroNuevo.codigo:=l^.dato.codigo;			
		end;
		l:=l^.sig;
	end;
end;

procedure CargarVector2(v:vector; var v2:vector2);
var
	i:integer;
	registroNuevo: registro;
begin
	for i:= 1 to dimf do begin
		registroNuevo.puntaje:= -1.0;
		mayorPuntaje(v[i],registroNuevo);
		v2[i]:=registroNuevo;
	end;
end;

procedure ImprimirVector(v2:vector2);
var
	i:integer;
begin
	for i:= 1 to dimf do
		if(v2[i].codigo <> 0) then
			writeln('El codigo de la posicion ', i,' es: ',v2[i].codigo,' con puntaje ',v2[i].puntaje:0:2);
end;

procedure Seleccion(var v2:vector2);
var
	i,j,pos:integer;
	item:registro;
begin
	for i:= 1 to (dimf-1) do begin 
			pos:=i;
			for j:= i+1 to dimf do begin
				if (v2[j].puntaje) < (v2[pos].puntaje) then
					pos:=j;
			end;
			item:=v2[pos];
			v2[pos]:=v2[i];
			v2[i]:=item;
	end;
end;

{-----------------------------------------------------------------------}
var 
	v:vector;
	v2:vector2;
BEGIN
	CargarVector(v); {PUNTO A}
	CargarVector2(v,v2); {PUNTO B}
	
	writeln('VECTOR SIN ORDENAR-----------------------------------------');
	ImprimirVector(v2); {IMPRIMO EL VECTOR SIN ORDENAR, SOLO PARA COMPROBAR}
	
	Seleccion(v2);
	writeln('VECTOR ORDENADO POR PUNTAJE--------------------------------');
	ImprimirVector(v2);
	
	writeln('La película con el menor puntaje tiene el cOdigo: ', v2[1].codigo, ' y un puntaje de: ', v2[1].puntaje:0:2);
	writeln('La película con el mayor puntaje tiene el cOdigo: ', v2[dimf].codigo, ' y un puntaje de: ', v2[dimf].puntaje:0:2);
END.

