{3. PlayStation Store requiere procesar las compras realizadas por sus clientes durante el año 2023. 1a) Implementar un módulo que lea compras de videojuegos. 
De cada compra se lee código del videojuego, código de cliente y mes. La lectura finaliza con el código de cliente 0. Se sugiere utilizar el módulo leerCompra().
 El módulo debe retornar un árbol binario de búsqueda ordenado por código de videojuego. 
 En el árbol, para cada código de videojuego debe almacenarse una lista con código de cliente y mes perteneciente a cada compra.
b) Implementar un módulo que reciba el árbol generado en a) y un código de videojuego. El módulo debe retornar la lista de las compras de ese videojuego.
c) Implementar un módulo recursivo que reciba la lista generada en b) y un mes. El módulo debe retorne la cantidad de clientes que compraron en el mes ingresado.
NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.}

program ejercicioDos;
type
	compra=record
		cod_juego:integer;
		cod_cliente:integer;
		mes:integer;
	end;
	
	reg_lista=record
		cod_cliente:integer;
		mes:integer;
	end;
	
	lista=^nodo_lista;
	nodo_lista=record
		dato:reg_lista;
		sig:lista;
	end;
	
		cliente=record
		cod_juego:integer;
		lista:lista;
	end;
		
	arbol=^nodo;
	nodo=record
		dato:cliente;
		HI:arbol;
		HD:arbol;
	end;

procedure agregarAdelante(var l:lista; reg:reg_lista );
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=reg;
	nue^.sig:=l;
	l:=nue;
end;
	
procedure cargarArbol (var a:arbol);

procedure leerCompra( var c:compra);
begin
	c.cod_cliente:=random(20);
	if (c.cod_cliente <> 0) then begin
		c.cod_juego:=random(100);
		c.mes:=1+random(12);
	end;
end;


procedure generarNodo (var a:arbol; cod_juego:integer; reg:reg_lista);
begin
	if (a=nil) then
	begin
		new(a);
		a^.dato.cod_juego:=cod_juego;
		a^.dato.lista:=nil;
		agregarAdelante (a^.dato.lista,reg);
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else
		if (cod_juego=a^.dato.cod_juego) then
			agregarAdelante (a^.dato.lista,reg)
			else		
			if (cod_juego < a^.dato.cod_juego) then
				generarNodo(a^.HI,cod_juego,reg)
				else
					generarNodo(a^.HD,cod_juego,reg);
end;

procedure cargarReg (var reg:reg_lista; cli,mes:integer);
begin
	reg.cod_cliente:=cli;
	reg.mes:=mes;
end;

var
	c:compra;
	reg:reg_lista;
begin
	leerCompra(c);
	while (c.cod_cliente <> 0) do 
	begin
		cargarReg(reg,c.cod_cliente,c.mes);
		generarNodo(a,c.cod_juego,reg);
		leerCompra(c);
	end;
end;

procedure imprimirLista (l:lista);
begin
writeln('-LISTA:');
	while (l<>nil ) do begin
		writeln('cliente: ',l^.dato.cod_cliente);
		writeln('mes: ',l^.dato.mes);
		l:=l^.sig;
	end;
end;

procedure imprimirListaB (l:lista);
begin
	while (l<>nil ) do begin
		writeln('-----------------------LISTA B------------------------');
		writeln('cliente: ',l^.dato.cod_cliente);
		writeln('mes: ',l^.dato.mes);
		l:=l^.sig;
	end;
end;


procedure imprimir (a:arbol);
begin
	if (a<>nil) then begin
		imprimir(a^.HI);
		writeln('----------------');
		writeln('Codigo de juego: ',a^.dato.cod_juego);
		imprimirLista(a^.dato.lista);
		imprimir(a^.HD);
	end
end;



//b) Implementar un módulo que reciba el árbol generado en a) y un código de videojuego. El módulo debe retornar la lista de las compras de ese videojuego.

procedure retornarListavj(a:arbol; codIn:integer; var lb:lista);

begin
	if(a<>nil)then
		if(a^.dato.cod_juego = codIn)then
			//cargarLista(a^.dato.lista,lb)
			lb:=a^.dato.lista
		else if(codIn < a^.dato.cod_juego  )then
			retornarListavj(a^.HI, codIn, lb)
			else
				retornarListavj(a^.HD, codIn, lb);
		end;

		
//c) Implementar un módulo recursivo que reciba la lista generada en b) y un mes. El módulo debe retorne la cantidad de clientes que compraron en el mes ingresado.
function cantClientesb(l:lista; mes:integer):integer;
var
	cant:integer;
begin
	if(l=nil)then
		cantClientesb:=0
	else begin
	   cant:=cantClientesb(l^.sig,mes);
	   if(l^.dato.mes= mes)then
				cant:= cant+1;
		cantClientesb:=cant;
		{if(l^.dato.mes= mes)then
				cantClientesb:= 1+ cantClientesb(l^.sig,mes)
		else
			cantClientesb:=cantClientesb(l^.sig,mes);}
	end;
end;

//--------------------------------PROGRAMA PRINCIPAL----------------------
var
	a:arbol;
	codIn,mes,cantCli:integer;
	listab:lista;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	imprimir (a);
	writeln('Ingrese un codigo de videojuego');readln(codIn);
	retornarListavj(a,codIn,listab);
	imprimirlistaB(listab);
	cantCli:=0;
	writeln('Ingrese un mes: ');readln(mes);
	if (listab = nil)then
		writeln('la lista esta vacia')
	else begin	
		cantCli:= (cantClientesb(listab,mes));
		writeln('la cantidad de clientes de la listab es:   ',cantCli);
	end;
end.
