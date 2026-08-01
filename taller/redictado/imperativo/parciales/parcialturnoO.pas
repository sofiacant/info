program parcialturnoO;
Const
	cli_fin=0;
Type
	rango_dia=1..31;
	rango_mes=1..12;
	compra=record
		cod:integer;
		cli:integer;
		dia:rango_dia;
		mes:rango_mes;
	end;
	
	regArbol=record
		cod:integer;
		cli:integer;
		dia:rango_dia;
	end;
	
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
	
	vCompras= array [rango_mes]of arbol;
	
	
//.----------------------------------------------------------FIN TYPE--------------------

//-----------------------------CARGA DEL VECTOR DE ARBOLES-------------------------------
procedure cargarVector(var v:vCompras);
	
	procedure inicializarVector(var v:vCompras);
	var
		i:rango_mes;
	begin
		for i:= 1 to 12 do
			v[i]:= NIL;
	end;

	procedure leerCompra(var c:compra);
	begin
		c.cli:=random(100);
		if(c.cli <> cli_fin)then begin
			c.cod:= random(100);
			c.dia:= 1+random(31);
			c.mes:= 1+ random(12);
		end;
	end;

	procedure cargarReg(c:compra; var ra:regArbol);
	begin
		ra.cod:=c.cod;
		ra.cli:=c.cli;
		ra.dia:=c.dia;
	end;
	
	procedure insertarArbol(var a:arbol; ra:regArbol);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:=ra;
			a^.HI:=NIL;
			a^.HD:=NIL;
		end
		else begin
			if( ra.cod < a^.dato.cod )then
				insertarArbol(a^.HI,ra)
			else
				insertarArbol(a^.HD,ra)
		end;
	end;

var
	c:compra;
	ra:regArbol;
begin
	inicializarVector(v);
	leerCompra(c);
	while(c.cli <> cli_fin)do begin
		cargarReg(c,ra);
		insertarArbol(v[c.mes],ra);
		leerCompra(c);
	end;
end;
//------------------------------------------FIN CARGA--------------------------


//----------------------------------INCISO B--------------------------------
function recorrerArbol( a:arbol):integer;   //cuenta compras del arbo
begin
	if(a=nil)then
		recorrerArbol:=0
	else
		recorrerArbol:= 1+   recorrerArbol(a^.HI)+recorrerArbol(a^.HD);
end;



procedure  incisoB(v:vCompras; i:integer; var max, mes:integer);
begin
	if(i<13)then begin
		if( recorrerArbol(v[i]> max)then begin
			max:= recorrerArbol(v[i],i)
			mes:=i;
		end
		incisoB(v, i+1, max,mes);
	end;
end;		

//----------------------------------}
function incisoB(v:vCompras; i:integer):integer;
var
	mesSig, cantAct, cantSig:integer;
 begin
	if(i=12)then 
		incisoB:=12
	else begin
		mesSig:=incisoB(v,i+1);    // llega al caso base. La 1ra vez tiene mes 12
		cantAct:=recorrerArbol(v[i]);   //me guardo la cant del arbol(cant del mes)
		cantSig:= recorrerArbol(v[mesSig]);   //asigna la cantidad del mes del llamado ant: la 1 vez ve la cant de mes12
		if(cantAct> cantSig)then
			incisoB:= i
		else
			incisoB:= mesSig;
	end;
end;
// Cuando llega al caso base devuelve 12 y cierra ejecucion,, regresa a la llamada 11






//---------------------------------------------------
function buscarCompra(a:arbol; cod:integer):boolean;
begin
	if(a=nil)then
		buscarCompra:=false
	else begin
		if(a^.dato.cod = cod)then
			buscarCompra:=true
		else if(cod <a^.dato.cod)then
					buscarCompra:=buscarCompra(a^.HI,cod)
			   else
					buscarCompra:= buscarCompra(a^.HD,cod);
	end;
end; 

function incisoC(v:vCompras; mes:integer; cod:integer): boolean;
begin
	incisoC:= buscarCompra(v[mes], cod);
end;
//--------------------------------------IMPRIMIR------------------------
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('cod:   ', a^.dato.cod);
		writeln('cliente:  ', a^.dato.cli);
		writeln('dia:   ', a^.dato.dia);
		writeln('-------------------------------------');
		imprimirArbol(a^.HD);
	end;
end;


procedure imprimirVector(v:vCompras);
var
	i:integer;
begin
	for i:= 1 to 12 do begin
		writeln('Mes  ', i);
		writeln('----------------------ARBOL-------------------------');
		imprimirArbol(v[i]);
		writeln('----------------')
	end;
end;


//----------------------PROGRAMA PRINCIPAL-------------------
var 
	v:vCompras;
	cod,mes:integer;
begin
	randomize;
	cargarVector(v);
	imprimirVector(v);
	writeln('El mes con mayor cantidad de compras es:   ', incisob(v,1));
	writeln('ingrese un numero de mes:   ');readln(mes);
	writeln('ingrese un codigo de producto:   ');readln(cod);
	writeln('fue comprado:   ', incisoC(v,mes,cod));
	
end.
