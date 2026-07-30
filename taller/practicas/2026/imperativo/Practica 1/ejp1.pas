{4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el código del producto,
 código de rubro (del 1 al 6) y precio.  Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
  a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada
  . El ingreso de los productos finaliza cuando se lee el precio -1. 
  b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro. 
  c. Genere un vector (de a lo sumo 20 elementos) con los productos del rubro 3. Considerar que puede haber más o menos de 20 productos 
  del rubro 3. Si la cantidad de productos del rubro 3 es mayor a 20, almacenar los primeros 20 que están en la lista e ignore el resto.
    d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos métodos vistos en la teoría. 
     e. Muestre los precios del vector resultante del punto d). 
f. Calcule el promedio de los precios del vector resultante del punto d). }

program ej4p1;
Const
	rubro_max= 6;
	precio_fin= -1;
	dimF=20;
Type
	rango_rubro= 1..rubro_max;
	
	producto=record
		cod:integer;
		rubro:rango_rubro;
		precio:real;
	end;
	
	lista=^nodo;
	nodo=record
		dato:producto;
		sig:lista;
	end;
	 
	 vProductos= array[rango_rubro]of lista;
	 
procedure cargarVector(var vp:vProductos);
	
	procedure inicializarVectorListas(var vp:vProductos);
	var
		i:rango_rubro;
	begin
		for i:= 1 to max_rubro do
			v[i]:=NIL;
	end;
	
	procedure leerProducto(var p:producto);
	begin
		writeln('Ingrese un precio de producto');
		readln(p.precio);
		if(p.precio<> precio_fin)then begin
			writeln('Ingrese un codigo de producto');
			readln(p.cod);
			writeln('Ingrese un codigo de producto');
			readln(p.rubro);
	end;
	
	procedure insertarOrdenado(var l:lista; p:producto);
	var
		nue,act,ant:lista;
	begin
		new(nue);
		nue^.dato:=p;
		ant:=l;
		act:=l;
		while(act<>nil)and (act^.dato.cod < nue^.dato.cod)do begin
			ant:=act;
			act:=act^.sig;
		end;
		if(act=ant)then
			l:=nue
		else
			ant^.sig:=nue;
		nue^.sig:=act;
	end;
	
	
var
	p:producto;
begin
	inicializarVectorListas(vp);
	leerProducto(p);
	while(p.producto <> precio_fin)do begin
		insertarOrdenado(vp[p.rubro],p);
		leerProducto(p);
	end;
end;

//INCISO B    imprimir
procedure imprimirLista(l:lista );
begin

end;
procedure imprimirVector(vp:vProductos);
var
	i:rango_rubro;
begin
	for i:= 1 to max_rubro do
		while(v[i]<>NIL )do 
			imprimirLista(v[i]);
	end;
end;


//------------------PROGRAMA PRINCIPAL----------------
var
	vp:vProductos;
begin
	cargarVector(vp);
end.
	
