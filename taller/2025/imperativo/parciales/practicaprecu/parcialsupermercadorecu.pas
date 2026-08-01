//El supermercado Consumo necesita un sistema para procesar la información de sus ventas. De cada venta se conoce:
//DNI de cliente, código de sucursal (1 a 10), número de factura y monto.
//a) Implementár un módulo que lea información de las ventas (la lectura finaliza al ingresar código de cliente 0 y
//retorne:
//i) Una estructura de datos eficiente para la búsqueda por DNI de cliente. Para cada DNI debe almacenarse una lista
//de todas sus compras (número de factura y monto).
//ii) Una estructura de datos que almacene la cantidad de ventas de cada sucursal.
//b) Realizar un módulo que reciba la estructura generada en el inciso a) i, un monto y un DNI. El módulo debe retornar
//la cantidad de facturas cuyo monto es inferior al monto ingresado para el DNI ingresado.
//c) Realizar un módulo recursivo que reciba la estructura generada en inciso a)ii y un valor entero y retorne si existe o
//no una sucursal con cantidad de ventas igual al valor recibido.
//NOTA: Implementar el programa principal, que invoque a los incisos a, b y c. En caso de ser necesario, puede utilizar los
//módulos que se encuentran a continuación.

program parcialsupermercadorepasorecu;
Const
	max_cod= 10;
	cod_fin=0;
Type
	rango_cod= 1..max_cod
	venta= record
		dnicli: integer;
		cod_suc= rango_cod;
		factura:integer;
		monto:real;
	end;
	
	regLista=record
		factura:integer;
		monto:real;
	end;
	
	lista=^nodoLista;
	nodoLista= record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		dni:integer;
		listaCompra:lista;
	end;
	
	arbol=^nodoArbol;
	nodoArbol=record
		dato:regArbol;
		hi: arbol;
		hd:arbol;
	end;
	
	procedure leerVentas(var v:venta);
	begin
		readln(v.dnicli);
		if(dnicli<>cod_fin)then begin
			readln(v.cod_suc);
			readln(v.factura);
			readln(v.monto);
		end;
	end;

procedure cargarArbol(var a:arbol);

procedure leerVentas(var v:ventas);
begin
	v.dni:=random(100);
	if(v.dni <> cod_fin)then begin
		v.codSuc:= 1+ random(11);
		v.factura:= 1+ random(200);
		v.monto:= random(20000) / (random(10)+1);
	end;
end;


			
		
