program programa;

const
	corte = 0;

type
	tDias=1..31;

rCompra = record
	codigo: integer;
	dia: tDias;
	cantidad: integer;
	monto: real;
end;

lista = ^nodo;

nodo = record
	dato: rCompra;
	sig: lista;
end;

arbol = ^hoja;

hoja = record
	compra: lista;
	HD: arbol;
	HI: arbol;
end;

procedure leerRegistro (var rc:rCompra );
begin
	//writeln('Cantidad');
	//readln(rc.cantidad);
	rc.cantidad := Random(30);
	if (rc.cantidad <> corte) then
	begin
		//writeln('Codigo');
		//readln(rc.codigo);
		rc.codigo := 1 + Random(99);
		rc.monto := 150.80 + Random(8000);
		rc.dia := 1 + Random(30);
	end
end;

procedure insertaLista(var l:lista; rc:rCompra);
var
	nuevo:lista;
begin
	writeln('Lista ',rc.codigo);
	new(nuevo);
	nuevo^.dato := rc;
	nuevo^.sig := l;
	l := nuevo;
end;

procedure insertarHoja(var a:arbol; rc:rCompra);
begin
	//writeln('Insertar hoja...');
	if (a = nil) then
	begin
		new(a);
		insertaLista(a^.compra,rc);
		a^.HD := nil;
		a^.HI := nil;
	end
	else if (rc.codigo < a^.compra^.dato.codigo) then
		insertarHoja(a^.HI, rc)
	else if (rc.codigo > a^.compra^.dato.codigo) then
		insertarHoja(a^.HD, rc)
	else if (rc.codigo = a^.compra^.dato.codigo) then
		insertaLista(a^.compra, rc)
end;

procedure agregarRegistros(var a:arbol);
var
	rc: rCompra;
begin
	leerRegistro(rc);
	while (rc.cantidad <> corte) do
	begin
		insertarHoja(a, rc);
		leerRegistro(rc);
	end
end;

function buscarCompras (a:arbol; c:integer): arbol;
begin
	writeln('Buscar Compras...');
	if ( a = nil ) then 
		buscarCompras := nil
	else if (c = a^.compra^.dato.codigo) then
		buscarCompras := a
	else if (c < a^.compra^.dato.codigo) then 
		buscarCompras := buscarCompras(a^.HI, c)
	else  
		buscarCompras := buscarCompras(a^.HD, c)
end;

procedure montoCompraMayorCantidad(l:lista; var mCantidad:integer; var mMonto: real);
begin
	writeln(l^.dato.cantidad);
	if (l = nil) then
	begin
		mCantidad := -1;
		mMonto := -1;
	end
	else if (l^.dato.cantidad > mCantidad) then
	begin
			mCantidad := l^.dato.cantidad;
			mMonto := l^.dato.monto;
	end
	else
		montoCompraMayorCantidad(l^.sig, mCantidad, mMonto)
end;

procedure enOrden ( a : arbol );
begin
	if ( a<> nil ) then begin
		enOrden (a^.HI);
		write ('| ',a^.compra^.dato.codigo,' |');
		enOrden (a^.HD);
	end;
end;

var
	a, a2: arbol;
	codigo, mCantidad: integer;
	mMonto: real;
begin
	a := nil;
	agregarRegistros(a);
	enOrden(a);
	writeln();
	writeln('Ingrese código a buscar:');
	readln(codigo);
	a2 := buscarCompras(a, codigo);
	enOrden(a2);
	writeln('saliste del buscar');
	if (a2 <> nil) then
	begin
		montoCompraMayorCantidad(a2^.compra,mCantidad,mMonto);
		writeln('Cantidad Mayor: ',mCantidad,' Monto Mayor: ',mMonto:4:2);
	end
	else
		writeln('No se encontro');
end.
