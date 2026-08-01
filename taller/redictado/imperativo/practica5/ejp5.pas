program ej1p5;
Const
	id_fin=0;
	dimF=300;
Type
	rango_ofi=1..dimF;
	oficina=record
		id:integer;
		dni:integer;
		expensa:real;
	end;
	
	vOficinas= array[rango_ofi]of oficina;
	
procedure cargarVector(var v:vOficinas);

	procedure leerOficina(var o:oficina);
	begin
		o.id:= random(301);
		if(o.id <> id_fin)then begin
			o.dni:=200 + random(300);
			o.expensa:=10+ random*(200-10);
		end:
	end;

	procedure agregarVector(var v:vOficinas; o:oficina; var dimL:integer);
	begin
		if(dimL< dimF)then begin
			dimL:=dimL+1;
			v[dimL]:=o;
		end;
	end;
		
var
	o:oficina;
	dimL:integer;
begin
	
	leerOficina(o);
	dimL:=0;
	while(o.id<> id_fin)then begin
		agregarVector(v,o,dimL);
		leerOficina(o);
	end;
end;
	
//-------------INCISO B:ORDENAR-------------------------------------
procedure ordenarVector(var v:vector);
var
	i,j:integer;
	actual:o;
begin
	for i:= 2 to dimL do begin
		actual:= v[i];
		j:=i-1;
		while(j>0)and (v[j]> actual) do begin	
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= actual;
	end;
end;
		
//.----------------------INCISO D-------------------
function montoTotalExpensas()


	
//----------------------PROGRAMA PRINCIPAL-----------------	
var
	v:vOficinas;
	dimL:integer;
begin
	randomize;
	cargarVector(v);
	ordenarVector(v, dimL);
	
	
end;
	
