{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas 
oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa
 el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa 
 el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program ej;
Const
	cod_fin=-1;
	max_ofi=300;
Type
	rango_ofi= 1..max_ofi;
	regoficina=record
		cod_id: integer;
		dni:integer;
		expensa:real;
	end;
	
	vOficinas = array [rango_ofi] of regoficina;
	
procedure leerOficina(var o:regoficina);
begin
	writeln('Ingrese un codigo de identificacion');
	readln(o.cod_id);
	if(o.cod_id<> cod_fin)then begin
		o.dni:= random(100);
		o.expensa:=random(50);
	end;
end;

procedure cargarVector(var v:vOficinas; o:regoficina; var dimL:integer);
begin
	leerOficina(o);
	while(dimL <= max_ofi)and(o.cod_id <> cod_fin)do begin
		diml:=diml+1;
		v[dimL]:= o;
		leerOficina(o);
	end;
end;
procedure imprimirVector(v:vOficinas; dimL:integer);
var
	i:integer;
begin
	for i:= 1 to dimL do begin
		writeln(v[i].cod_id);
		writeln(v[i].dni);
		writeln(v[i].expensa:0:2);
	end;
end;
//---------------------------PP------------------------------------------------
var  
	o :regoficina;
	v :vOficinas;
	dimL:integer;
begin
	dimL:=0;
	randomize;
	cargarVector(v,o,dimL);
	imprimirVector(v,dimL);
end.
	
