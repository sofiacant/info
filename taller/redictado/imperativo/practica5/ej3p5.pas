program ej3p5;
Const
	max_rubro=10;
	cod_fin=0;
Type
	rango_rubro= 1..max_rubro;
	producto= record
		cod:integer;
		rubro:rango_rubro;
		stock:integer;
		precio:real;
	end;
	
	regArbol=record
		cod:integer;
		stock:integer;
		precio:real;
	end;
		
	arbol=^nodoA;
	nodoA=record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
	
	regMax=record
		cod:integer;
		stock:integer;
	end;
	
	vRubros= array [rango_rubro]of  arbol;
	vMaximos= array[rango_rubro]of regMax;
	vContador= array [rango_rubro]of integer;


//-----------------------------------------FIN TYPE-------------------------

//-----------------CARGA VECTOR DE ARBOLES-----------------
procedure cargarVector(var v:vRubros);

	procedure inicializarVector(var v:vRubros);
	var
		i:rango_rubro;
	begin
		for i:= 1 to max_rubro do
			v[i]:= NIL;
	end;

	procedure leerProducto(var p:producto);
	begin
		p.cod:= random(50);
		if(p.cod<>cod_fin)then begin
			p.rubro:=1+random(10);
			p.stock:=random(100);
			p.precio:= (100 + random(100))/2;
		end;
	end;
	
	procedure cargarReg(p:producto; var r:regArbol);
	begin
		r.cod:=p.cod;
		r.stock:=p.stock;
		r.precio:=p.precio;
	end;
	
	procedure cargarArbol(var a:arbol; r:regArbol);
	begin
		if(a=nil)then begin
			new(a);
			a^.dato:=r;
			a^.HI:=NIL;
			a^.HD:=NIL;
		end
		else begin
			if(r.cod < a^.dato.cod )then
				cargarArbol(a^.HI,r)
			else
				cargarArbol(a^.HD,r)
		end;
	end;
//-------------------------------------------------------------------------------	
	
var
	p:producto;
	r:regArbol;
begin
	inicializarVector(v);
	leerProducto(p);
	while(p.cod <> cod_fin)do begin
		cargarReg(p,r);
		cargarArbol(v[p.rubro],r);
		leerProducto(p);
	end;
end;
		
		
		
//-----------------------------------------------FIN CARGA ARBOL-----------------------

//-------------------------INCISO B------------------BUSQUEDA-
function buscoCodArbol(a:arbol; cod:integer):boolean;
begin
	if(a= nil)then
		buscoCodArbol:= false
	else begin
		if(a^.dato.cod = cod)then
			buscoCodArbol:=true
		else
			if(cod < a^.dato.cod)then
				buscoCodArbol:=buscoCodArbol(a^.HI, cod)
			else
				buscoCodArbol:=buscoCodArbol(a^.HD, cod)
	end;
end;

function busquedaCodigo(v:vRubros; cod:integer; rubro:rango_rubro):boolean;
begin
		busquedaCodigo:= buscoCodArbol(v[rubro],cod);
end;
//----------------------------------------------INCISO C---------------------------------------
//retorne, para cada rubro, el código y stock del producto con mayor código. 
procedure maximoCod(a:arbol; var rm:regMax);
begin
   if(a<> nil)then begin
		if(a^.HD= nil)then begin
			rm.cod:=a^.dato.cod;               
			rm.stock:=a^.dato.stock;
		end
		else
			maximoCod(a^.HD,rm);
	end;
end;
 

procedure incisoC(v:vRubros; var vm:vMaximos);
var
	i:rango_rubro;
	rm:regMax;
begin
	for i:= 1 to max_rubro do begin
		rm.cod:=-999;
		rm.stock:=0;
		maximoCod(v[i],rm);
		vm[i]:=rm;
	end;
end;

//--------INCISO D----------------------------------------------
procedure inicializarVContador(var vc: vContador);
var
	i:rango_rubro;
begin
	for i:= 1 to max_rubro do
		vc[i]:=0;
end;

function contarProductos( a:arbol; cod1,cod2:integer):integer;   //SIN INCLUIRLOS 
begin
	if(a=nil)then 
		contarProductos:=0
	else begin
		if(a^.dato.cod > cod1)then
			if (a^.dato.cod < cod2)then
				contarProductos:= 1+ contarProductos(a^.HI, cod1, cod2)+contarProductos(a^.HD, cod1, cod2)
			else
				contarProductos:=contarProductos(a^.HI,cod1,cod2)
		else		
			contarProductos:=contarProductos(a^.HD,cod1,cod2);
	end;
end;


procedure incisoD(v:vRubros; cod1,cod2:integer; var vc:vContador);
var
	i:rango_rubro;
begin
	for i:= 1 to max_rubro do 
		vc[i]:=contarProductos(v[i],cod1,cod2);
end;



//--------------------PROGRAMA PRINCIPAL-----------------------
var
	v:vRubros;
	vm:vMaximos;
	vc:vContador;
	cod,cod1,cod2:integer;
	rubro:rango_rubro;
begin
	cargarVector(v);	
	writeln('Ingrese un codigo de producto: '); readln(cod);
	writeln('Ingrese un rubro de producto entre 1 y 10: '); readln(rubro);
	writeln(' El codigo existe:   ',busquedaCodigo(v,cod,rubro));
	incisoC(v,vm);
	inicializarVContador(vc);
	writeln('Ingrese dos codigos:  ');readln(cod1);readln(cod2);
	incisoD(v,cod1,cod2,vc)
end.
