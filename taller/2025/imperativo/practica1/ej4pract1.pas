program libreria;
Const
	max_rubro=8;
	precio_corte= -1;
	max_prod=30;
Type
	rango_rubro= 1..max_rubro;
	producto= record
		codigo:integer;
		cod_rubro:rango_rubro;
		precio:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:producto;
		sig:lista;
	end;
	
	vectorProductos= array [rango_rubro]of lista;
	vectorRubroTres= array [1..max_prod]of producto;
	
	
procedure inicializarVectorListas(var v:vectorProductos);
var
	i:integer;
begin
	for i:= 1 to max_rubro do
		v[i]:=NIL;
end;

procedure leerProducto(var p:producto);
begin
		writeln('Ingrese un precio de producto:');readln(p.precio);
		if(p.precio <> precio_corte)then begin
			writeln('Ingrese un codigo de producto');readln(p.codigo);
			writeln('Ingrese un codigo de rubro :');readln(p.cod_rubro);
		end;
end;

procedure insertarOrdenado(var l:lista;p:producto);
var
	nue,act,ant:lista;
begin
	new(nue);
	nue^.dato:=p;
	ant:=l;
	act:=l;
	while(act<>NIL)and (act^.dato.codigo < nue^.dato.codigo)do begin
		ant:=act;
		act:= act^.sig;
	end;
	if(ant=act)then
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;
		

procedure cargarVector(var v:vectorProductos);
var
	p:producto;
begin
	inicializarVectorListas(v);
	leerProducto(p);
	while(p.precio <> precio_corte)do begin
		insertarOrdenado(v[p.cod_rubro],p);
		leerProducto(p);
	end;
end;

procedure imprimirLista(l:lista);
begin
	while(l<> NIL)do begin
		writeln('El codigo del producto: ', l^.dato.codigo,'pertenece al rubro: ',l^.dato.cod_rubro);
		l:=l^.sig;
	end;
end;

procedure imprimirCodigos(v:vectorProductos);
var
	i:integer;
begin
	for i:= 1 to max_rubro do begin
		while(v[i]<>NIL)do
			imprimirLista(v[i]);
	end;
end;
		
procedure generarVector(l:lista; var vT:vectorRubroTres;var DL:integer);
begin
	DL:=-1;
	while(l<>NIL)and(DL <= max_prod)do begin
		DL:=DL+1;
		VT[DL]:=l^.dato;
		l:=l^.sig;
	end;
end;
	
procedure ordenacionInsercion(v:vectorRubroTres; dl:integer);
var
	i,j:integer;
	actual:producto;
begin
	for i:= 2 to dl do begin
		actual:=v[i];
		j:=i-1;
		while(j>0)and(v[j].precio > actual.precio)do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actual;
	end;
end;

procedure imprimirPreciosvt(vt:vectorRubroTres; dimL:integer);
var
	i:integer;
begin
	for i:= 1 to dimL do
		writeln('El precio es: ', vt[i].precio);
end;

function calcularPromedio(vt:vectorRubroTres;dimL:integer):real;
var
	i:integer;
	precioTotal:real;
begin
	precioTotal:=0;
	 for i:=1 to dimL do 
		precioTotal:=precioTotal + vt[i].precio;
	 calcularPromedio:= (precioTotal/dimL);
end;
		
		
var
	v:vectorProductos;
	vt:vectorRubroTres;
	dimL:integer;
begin
	cargarVector(v);
	imprimirCodigos(v);
	generarVector(v[3],vT,dimL);
	ordenacionInsercion(vT,dimL);
	imprimirPreciosvt(vt,dimL);
	calcularPromedio(vt,dimL)
end.
