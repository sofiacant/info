{3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
y menores a 1550 (incluidos ambos).
b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.}

program ej3p3;
Const
	dimF=20;
	min=300;
	max=1550;
	ret=-1;
Type
	vector = array [1..dimF]of integer;

procedure inicializarVector(var v:vector);
var
	i:integer;
begin
	for i:= 1 to dimF do
		v[i]:=0;
end;

{procedure cargarVector(var v:vector; var dl:integer);
var
	valor:integer;
begin
	
	if(dimL<dimF) then begin
		diml:=dimL+1;
		cargarVector(v,dimL);
		valor:=min + random(max-min+1);
		v[dimL]:=valor;
	end;
end; } //esta mal

procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
 var 
 valor: integer;
  begin
    valor:= min + random (max - min + 1);
    if (dimL < dimF)then begin
          dimL:= dimL + 1;
          v[dimL]:= valor;
          CargarVectorRecursivo (v, dimL);
         end;
  end;

procedure ordenarVSeleccion(var v:vector; dimL:integer);
var
	i,j,pos:integer;
	num:integer;
begin
	for i:= 1 to dimL-1 do begin
		pos:= i;
		for j:=i+1 to dimL do 
			if v[j] < v[pos] then
				pos:=j;
		num:=v[pos];
		v[pos]:=v[i];
		v[i]:=num;
	end;
end;

Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
var
	medio:integer;
begin
	medio:= ((ini+fin)div 2);
	if(ini<=fin)then begin
		if(valor[medio]= dato)then
			pos:=medio
		else if (v[medio]> valor)then
			busquedaDicotomica(v,ini,medio-1,dato,pos)
		else
			busquedaDicotomica(v,medio+1,fin,dato,pos);
	end;
	
end;

var
	v:vector;
	dimL,dato,pos:integer;
begin
	randomize;
	pos:=-1;
	dimL:=0;
	inicializarVector(v);
	cargarVectorRecursivo(v,dimL);
	ordenarVSeleccion(v,dimL);
	readln(pos);
	busquedaDicotomica(v,1,dimF,dato,pos);
end.

