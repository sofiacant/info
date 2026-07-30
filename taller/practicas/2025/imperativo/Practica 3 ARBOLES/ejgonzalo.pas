program ejgon;
Const
	max_codigo=1000;
	cod_fin=0;
Type
	rango_codigo=1..max_codigo;
	
	mensajes=record
		dirEmisor:string;
		fechaEnvio:string;
		asunto:string;
		texto:string;
		leido:boolean;
	end;
	
		
	cliente=record
		codigo:rango_codigo;
		email:string;
	end;
	
	msjLeido=record 
		msj:mensajes;
		cli:cliente;
	end;
	
	listaMsj=^nodo;
	nodo=record
		  dato:Mensajes;
		  sig:listaMsj;
	end;
	
	datoCliente= record
		cli: cliente;
		mensajes=lista;
		
	arbol=^nodoA
	nodoA=record
		dato:datoCliente;
		HI:arbol;
		HD:arbol;
	end;

procedure leerMensaje(var m:mensajeLeido);
var
	i:integer;
begin
	readln(m.cli.codigo);
	readln(m.cli.email);
	readln(m.mensaje.dirEmisor);
	readln(m.mensaje.fechaEnvio);
	readln(m.mensaje.asunto);
	readln(m.mensaje.texto);
	readln(i);
	writeln('ingrese 1 para indicar que fue leido')
	m.msj.leido:=(i=1);
end;

procedure insertarArbol(var a:arbol; m:mensajeLeido);
begin
	if(a=nil)then begin
		new(a);
		a^.dato.cli:=m.cli;
		a^.dato.mensajes:=lista;
		agregarAdelante(a^.dato.mensajes,m.mensaje);
		a^.hd:=nil;
		a^.hi:=nil;
	end;
	else begin
		if(a^.dato= m.cli.cod)then
			agregarAdelante(a^.dato.mensajes,m.mensaje)
		else
			if(a^.dato.cod>m.cli.cod)then
			agregar(a^hi,m)
		else
			agregar(a^hd,m);
	end;
end;

function cantidadCorreosSinLeer(cod:rango_Cod; a:arbol):integer
var
	retorno:integer;
begin
	if(a=nil)then
		retorno:=-1;
	else begin
		if (a^.dato.cod = cod)then
			retorno:= a^.dato.sin_leer; aca llamo a un modulo funcion y le paso la lista
		else if(a^.dato.cod > cod)then
			retorno:= cantidadCorreosSinLeer(cod,a^.hi)
			else
				retorno:= cantidadCorreosSinLeer(cod,a^.hd);
	end;
	cantidadCorreosSinLeer_=retorno;
end;



function contarCorreosDesdeDireccion(a:arbol;dir:string):integer;
begin
	if(a=nil)then
		contarCorreosDesdeDireccion:=0;
	else begin
		contarCorreosDesdeDireccion:= contarSinDesdeDir(a^.dato.dir) +
				contarCorreosDesdeDireccion(a^.hi,dir)+
				contarCorreosDesdeDireccion(a^.hd,dir);
	end;
end;
