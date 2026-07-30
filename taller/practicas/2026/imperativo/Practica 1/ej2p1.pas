{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
 Implementar un programa que invoque a módulos para cada uno de los siguientes puntos: 
 a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, 
 DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa. 
 b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina. 
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina. }

program ej2p1;
Const
	codFin= -1;
	dimF=300;
Type
	rango_ofi= 0..dimF;    //para que corte poner rango desde 0;
	oficina=record
		id:integer;
		dni:integer;
		expensa:real;
	end;
	vectorOficinas= array [rango_ofi]of oficina;
	
procedure cargarVector(var v:vectorOficinas; var dimL:integer);
		
		procedure leerRegistro(var o:oficina);
		begin
			 writeln('Ingrese un codigo de identificacion');
			 readln(o.id);
			 if(o.id <> codFin)then begin
				 readln(o.dni);
				 writeln('Ingrese el dni del propietario');
				 writeln('Ingrese el valor de las expensas');
			end;
		end;
var
	o:oficina;
begin
	dimL:=0;
	leerRegistro(o);
	while (dimL<dimF) and(o.id <>codFin)do begin
		dimL:=dimL+1;
		v[dimL]:= o;
		leerRegistro(o);
	end;
end;
		
//---------------inciso b: ordenar el vector por insercion, por codigo de identificacion de la oficina
procedure ordenarInsercion(var v:vectorOficinas; dimL:integer);
var
	actual, i, j: integer;
begin	
	for i:= 2 to dimL do begin
		actual:= v[i].id;
		j:=i-1;
		while(j>0) and (v[j].id > actual)do begin
			v[j+1]:= v[j];
			j:=j-1;
		end;
		v[j+1].id:= actual;
	end;
end;

//----------------------c : ordenar por seleccion
procedure ordenarSeleccion(var v:vectorOficinas; dimL:integer);
var
	item:integer;
	i,j,pos:integer;
begin
	for i:= 1 to dimL-1 do begin
		pos:=i;
		for j:= i+1 to dimL do 
			if(v[j].id < v[pos].id)then 
				pos:= j;
		item:= v[pos].id;
		v[pos].id:=v[i].id;
		v[i].id:=item;
	end;
end;
	
			
		
	
//----------------------------PROGRAMA PRINCIPAL-----------------------------------	
var
	v:vectorOficinas;
	dimL:integer;
begin
	cargarVector(v,dimL);
	ordenarInsercion(v,dimL);
end.
	
