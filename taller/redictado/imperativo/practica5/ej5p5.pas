 program ej5p5;
 Const
	cod_fin=0;
Type
	rango_mes=1..12;
	compra=record
		codvj:integer;
		cod_cli:integer;
		mes:rango_mes;
	end;
	
	regLista=record
		cod_cli:integer;
		mes:rango_mes;
	end;
	
	lista=^nodoL;
	nodoL=record
		dato:regLista;
		sig:lista;
	end;
	
	regArbol=record
		codvj:integer;
		lista:lista;
	end;
	
	arbol=^nodoA;
	nodoA= record
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
//-----------------------------------------------FIN TYPE--------------------------

//-------------------------------------------CARGA DEL ARBOL-----------------
procedure cargarArbol(var a:arbol);

	procedure leerCompra(var c:compra);
	begin
		
		c.cod_cli:= random(100);
		if(c.cod_cli<> cod_fin)then begin
			c.codvj:= random(100);
			c.mes:=1+ random(12);
		end;
	end;
	
	procedure cargarReg(c:compra; var rl:regLista);
	begin
		rl.cod_cli:=c.cod_cli;
		rl.mes:=c.mes;
	end;
	
	procedure agregarAdelante(var l:lista; rl:regLista);
	var
		nue:lista;
	begin
		new(nue);
		nue^.dato:=rl;
		nue^.sig:= l;
		l:=nue;
	end;
	
	procedure insertarArbol(var a:arbol; codvj:integer; rl:regLista); 
	begin
		if(a=nil)then begin
			new(a);
			a^.dato.codvj:= codvj;
			a^.dato.lista:=NIL;
			a^.HI:= NIL;
			a^.HD:= NIL;
			agregarAdelante(a^.dato.lista,rl);
		end
		else begin
			if(codvj < a^.dato.codvj)then
				insertarArbol(a^.HI, codvj,rl)
			else
				if(codvj= a^.dato.codvj)then
					agregarAdelante(a^.dato.lista,rl)
				else
					insertarArbol(a^.HD,codvj,rl)
		end;
	end;

//------------------------------------------
var
	c:compra;
	rl:regLista;
begin
	leerCompra(c);
	while(c.cod_cli <> cod_fin)do begin
		cargarReg(c,rl);
		insertarArbol(a, c.codvj, rl);
		leerCompra(c);
	end;
end;
//--------------------------------------------FIN CARGA


//.....................IMPRESION DEL ARBOL....................................
procedure imprimirLista(l:lista);
begin
	while(l<> nil)do begin
			writeln('El codigo de cliente es:   ',l^.dato.cod_Cli);
			writeln('El mes es:    ',l^.dato.mes);
			writeln('--------------------------------------------------');
			l:=l^.sig;
		end;
end;


procedure imprimirArbol(a:arbol);
begin
	if(a<> nil)then begin
		imprimirArbol(a^.HI);
		writeln('El codigo de videojuego:   ',a^.dato.codvj);
		writeln('Lista:  ');
		imprimirLista(a^.dato.lista);
		imprimirArbol(a^.HD);
	end;
end;






//-------------------INCISO B y C-------------------------------------
procedure incisobyc(a:arbol);

	function listaCompras(a:arbol; cod:integer):lista;
	begin
		if(a=nil)then
			listaCompras:=nil
		else begin
			if(a^.dato.codvj = cod)then
				listaCompras:= a^.dato.lista
			else
				if(cod <a^.dato.codvj )then
					listaCompras:= listaCompras(a^.HI,cod)
				else
					listaCompras:= listaCompras(a^.HD,cod)
		end;
	end;	
	
	
	procedure imprimirListaB(l:lista);
	begin
		while(l<> nil)do begin
			writeln('El codigo de cliente es:   ',l^.dato.cod_Cli);
			writeln('El mes es:    ',l^.dato.mes);
			writeln('--------------------------------------------------');
			l:=l^.sig;
		end;
	end;
			
///.------------------------------INCISO C--------------

	function incisoC(l:lista; mes:Integer):integer;
	begin
		if(l=nil)then
			incisoC:=0
		else begin
			if(l^.dato.mes = mes)then
				incisoC:= 1+ incisoC(l^.sig, mes)
			else
				incisoC:=incisoC(l^.sig,mes);
		end;
	end;

var
	cod,mes:integer;
	lb:lista;
begin
	writeln('Ingrese un codigo de videojuego');
	readln(cod);
	lb:= listaCompras(a,cod);
	imprimirListaB(lb);
	writeln('Ingrese un mes: '); readln(mes);
	writeln('La cantidad de clientes que hay en ', mes, ' es: ', incisoC(lb,mes));

end;
	



//---------------------------------PROGRAMA PRINCIPAL----------------------------------
var
	a:arbol;
begin
	a:=NIL;
	randomize;
	cargarArbol(a);
	imprimirArbol(a);
	incisobyc(a);
end.



