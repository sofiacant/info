program Practica1EJE4;
const
	dimf = 8;
type
	rango = 1..dimf;
	producto = record
		codigo:integer;
		rubro:rango;
		precio:real;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:producto;
		sig:lista;
	end;
	
	vector = array [1..dimf] of lista;
	vector2 = array [1..dimf] of producto;
	
{PROCESOS---------------------------------------------------------------}
procedure InicializarVector(var vec:vector);
var
	i:integer;
begin
	for i:= 1 to dimf do begin
		vec[i]:=nil;
	end;
end;

procedure LeerProducto(var pro:producto);
begin
	with pro do begin
		writeln('INGRESE EL PRECIO DEL PRODUCTO: ');
		readln(precio);
		if(precio <> 0) then begin
			writeln('INGRESE EL CODIGO DEL PRODUCTO: ');
			readln(codigo);
			writeln('INGRESE EL RUBRO DEL PRODUCTO: ');
			readln(rubro);
		end;
	end;
end;

procedure InsertarOrdenado(var L:lista; pro:producto);
var
  nue: lista;
  act, ant: lista; 
begin
  new (nue);
  nue^.dato := pro;
  act := L; 
  ant := L;
  while( act <> nil)and(pro.codigo > act^.dato.codigo)do
  begin
    ant := act;
    act:= act^.sig;
  end;
  if (act = ant) then 
    L:= nue
  else 
    ant^.sig:= nue;
  nue^.sig:= act;
end;

procedure CargarVector(var vec:vector);
var
	pro:producto;
begin
	InicializarVector(vec);
	LeerProducto(pro);
	while(pro.precio <> 0) do begin
		InsertarOrdenado(vec[pro.rubro],pro);
		LeerProducto(pro);
	end;
end;

procedure ImprimirListas(vec:vector);
var
	i:integer;
	l:lista;
begin
	for i:= 1 to dimf do begin
		l:=vec[i];
		writeln('PRODUCTOS DEL RUBRO: ',i);
		while(l <> nil) do begin		
			writeln('Codigo: ',l^.dato.codigo,', precio: ',l^.dato.precio);
			l:= l^.sig;
		end;
	end;
end;
procedure GenerarVector(vec:vector; var v2:vector2;  var diml:integer);
var
	l:lista;
begin
	l:=vec[3];
	while(l <> nil) and (diml < dimf) do begin
		diml:=diml+1;
		v2[diml]:=l^.dato;
		l:=l^.sig;
	end;
end;

procedure Seleccion (var v2:vector2; diml:integer);
var
	pos,i,j:integer;
	item:producto;
begin
	for i:= 1 to (diml-1) do begin
		pos:=i;
		for j:= i+1 to diml do begin
			if(v2[j].precio < v2[pos].precio) then
				pos:=j;
		end;
		item:=v2[pos];
		v2[pos]:=v2[i];
		v2[i]:=item;
	end;
end;

procedure ImprimirVector(v2:vector2; diml:integer);
var
	i:integer;
begin
	writeln('LISTA DE PRODUCTOS ORDENADA POR PRECIO');
	for i:= 1 to diml do begin
		writeln('Precio de la poscion: ',i,' $',v2[i].precio:0:2);
	end;
end;

procedure Promedio(v2:vector2; diml:integer);
var
	i:integer;
	promedio,suma:real;
begin
	suma:=0;
	for i:= 1 to diml do 
		suma:= suma + v2[i].precio;
	promedio:= suma / diml;
	Writeln();
	Writeln('El promedio de los precios es: ',promedio:0:2);
end;

{PROGRAMA PRINCIPAL-----------------------------------------------------}	
var 
	vec:vector;
	v2:vector2; diml:integer;
BEGIN
	CargarVector(vec);{PUNTO A}
	ImprimirListas(vec); {PUNTO B}
	diml:=0;
	GenerarVector(vec,v2,diml);{PUNTO C}
	Seleccion(v2,diml);	{PUNTO D}
	ImprimirVector(v2,diml);{PUNTO E}
	Promedio(v2,diml);{PUNTO F}
END.
