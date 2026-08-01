//MrStore requiere procesar las compras realizadas por sus clientes durante el año 2024.
//a) Implementar un módulo que lea compras de productos. De cada compra se lee código del producto, código de
//cliente, dia y mes. La lectura finaliza con el código de cliente 0. Se sugiere utilizar el módulo leerCompra(). El módulo
//debe retornar un vector donde se almacenen las compras agrupadas por mes. Las compras de cada mes deben quedar
//almacenadas en un árbol binario de búsqueda ordenado por código de producto.
//b) Implementar un módulo recursivo que reciba el vector generado en a) y retorne el mes con mayor cantidad de
//compras.
//c) Implementar un módulo que reciba el vector generado en al, un número de mes y un código de producto, y
//retome si fue comprado o no el producto ingresado en el mes recibido.
program compras;
const
	cod_fin=0;
	max_Mes=12;
type
		rango_dia= 1..31;
		rango_mes=1..max_Mes;
		
		compra=record
			cod_prod:integer;
			cod_cliente:integer;
			dia:rango_dia;
			mes:rango_mes;
		end;
		
		arbol=^nodo;
		nodo=record
			dato:compra;
			HI:arbol;
			HD:arbol;
		end;
		
	vector=array[rango_mes] of arbol;
	
procedure inicializarVector (var v:vector);
var
	i:rango_mes;
begin
	for i := 1 to max_Mes do
		v[i]:=nil;
end;
	
procedure cargarArbol (var v:vector);

procedure leerCompra (var c:compra);
begin
	c.cod_cliente:=random(100);
	if (c.cod_cliente <> cod_fin) then
	begin
		c.cod_prod:=random(100);
		c.dia:=1+random(31-1+1);
		c.mes:=1+random(12-1+1);
	end;
end;

procedure insertarArbol (var a:arbol ; c:compra);
begin	
	if (a = nil) then
	begin
		new(a);
		a^.dato:=c;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else if (c.cod_prod < a^.dato.cod_prod) then
		insertarArbol (a^.HI,c)
		else
			insertarArbol(a^.HD,c);
end;

var
	c:compra;
begin
	leerCompra(c);
	while (c.cod_cliente <> cod_fin) do
	begin
		insertarArbol(v[c.mes],c);
		leerCompra(c);
	end;
end;


procedure imprimirVector (v:vector);
procedure recorrerArbol (a:arbol);
begin
	if (a<>nil) then
	begin
		recorrerArbol(a^.HI);
		writeln('');
		writeln('producto: ',a^.dato.cod_prod);
		writeln('cliente: ',a^.dato.cod_cliente);
		writeln('Dia: ',a^.dato.dia);
		writeln('Mes: ',a^.dato.mes);
		
		recorrerArbol(a^.HD);
	end;
end;

var
	i:rango_mes;
begin
	for i := 1 to max_mes do
	begin
		writeln('[ ----MES ',i,' ---- ]');
		recorrerArbol(v[i]);
	end;
end;

procedure cantCompras (v:vector; var max:integer; var mes:integer; i:integer);

function obtenerCant (a:arbol):integer;
begin
	if (a=nil) then
		obtenerCant:=0
	else
		obtenerCant:=1+obtenerCant(a^.HI)+obtenerCant(a^.HD);
end;
var
	cant:integer;
begin	
	if ( i <= max_mes) then
	begin
		cant:=obtenerCant(v[i]);
		if (cant > max) then 
		begin
			max:=cant;
			mes:=i;
		end;
		cantCompras(v,max,mes,i+1);
	end;
end;

function fueComprado (v:vector; mes,cod:integer):boolean;
function buscarCompra (a:arbol; cod:integer):boolean;
begin
	if (a=nil) then
		buscarCompra:=false
		else
			if (a^.dato.cod_prod = cod) then
				buscarCompra:=true
				else
					if (a^.dato.cod_prod > cod) then
						buscarCompra:=buscarCompra(a^.HI,cod)
						else
							buscarCompra:=buscarCompra(a^.HD,cod)
end;

begin

	fueComprado:=buscarCompra(v[mes],cod);
end;

// PROGRAMA PRINCIPAL
var
	v:vector;
	i:integer;
	max,maxMesCant:integer;
	mesC,codC:integer;
begin	
	randomize;
	inicializarVector(v);
	cargarArbol(v);
	imprimirVector (v);
	{ --- PUNTO B ---}
	i:=1; max:=-1; maxMesCant:=0;
	cantCompras(v,max,maxMesCant,i);
	writeln('');
	writeln('---PUNTO B---');
	writeln('El mes con mayor cantidad de compras es ',maxMesCant, ' con un total de ',max,' compras');
	writeln('-------------');
	{--- PUNTO C ---}
	writeln('Ingresar un mes');readln(mesC);
	writeln('Ingresar un codigo de producto: ');readln(codC);
	writeln('');
	if (mesC > 12) then}
		writeln('El mes ingresado no esta dentro del rango')
		else
			writeln('El producto fue comprado? ',fueComprado(v,mesC,codC));
end.

