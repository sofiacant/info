{1. El administrador de un edificio de oficinas tiene la información del pago de las expensas de dichas oficinas.
 Implementar un programa con:
  a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que administra. Se deben cargar, para cada oficina, el código de identificación, 
  DNI del propietario y valor de la expensa. La lectura finaliza cuando llega el código de identificación 0. 
 b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por código de identificación de la oficina.
 Ordenar el vector aplicando uno de los métodos vistos en la cursada. 
  c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector generado en b) y un código de identificación de oficina. 
  En caso de encontrarlo, debe retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0. 
  Luego el programa debe informar el DNI del propietario o un cartel indicando que no se encontró la oficina. 
  d) Un módulo recursivo que retorne el monto total acumulado de las expensas. }
  
program parcialoficinas;
Const
	dimF=300;
	cod_fin=0;
Type
	oficina=record
		codId:integer;
		dniProp:integer;
		valor:integer;
	end;
	
	vector= array[1..DimF]of oficina;


procedure leerOficina(var o:oficina);
begin
	o.codId:= random(100)+1;
	if(o.codID <> cod_fin)then begin
		o.dniProp:= random(100)+1;
		o.valor:= 100+ random(1000);
end;


procedure cargarVector(var v:vector;var dimL:integer);
var
	o:oficina;
begin
	leerOficina(O);
	while(dimL<dimF)(o.codId <> cod_fin)then
		dimL:=dimL+1;
		v[dimL]:=o;
		leerOficina(O);
	end;
end;

procedure ordenarVector(var v:vector; dimL:integer);
var
	item:integer;
	i,j,pos:integer;
begin
	for i:= 1 to dimL-1 do begin
		pos:= i;
		for j:=i+1 to dimL do begin
			if( v[j].codId < v[pos].codID)then
				pos:=j;
			item:= v[pos].codId:
			v[pos].codID:= v[i].codId;
			v[i].codId:=item;
		end;
	end;
end;


Function busquedaDicotomica (v:vector; dL:integer; cod:integer): boolean;  //retornar la posicion del vector si esta, sino 0
Var  
	pri, ult, medio integer;  
	ok: boolean  
Begin  
	ok:= false;  
	pri:= 1; ult:= dL; medio:= (pri ult) div 2;  
	While (pri <= ult) and (cod <> v[medio]) do  begin  
		if(cod < v[medio] ) then  
			ult: medio -1;  
		else
			pri: medio+1;  
		medio: (pri + ult) div 2;  
	end;  

	if (pri <=ult) and (cod = vec[medio]) then 
			ok:=true;  
  
	 busquedaDicotomica:=ok;  
end;



var
	v:vector;
	dimL,codOfi:integer;
	
begin
	dimL:=0;
	cargarVector(v,dimL);
	ordenarVector  (v,dimL);
	writeln('Ingrese un codigo de oficina a buscar: ');readln(codOfi);
	busquedaDicotomica(v,dimL,codOfi);
	
	
