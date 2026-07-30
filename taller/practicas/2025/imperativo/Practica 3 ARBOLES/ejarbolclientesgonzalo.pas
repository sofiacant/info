{Un sistema de gestión de correos electrónicos desea manejar los correos
recibidos por cada cliente. De cada cliente conoce su código (1..1000), dirección
de email y la cantidad de correos sin leer.
Realizar un programa que invoque a módulos para:
- Leer y almacenar los clientes en una estructura de datos eficiente para la
búsqueda por código de cliente. La lectura finaliza al ingresar el cliente
1000.
- Leer un código de cliente e informar la cantidad de correos sin leer
- Imprimir todos los códigos de cliente de mayor a menor
- Leer una dirección de correo e informar si existe un cliente con esa dirección.
}
program arboldeclientes;
Const
	maxCod=1000;
type
	rango_cod=1.. maxCod;

cliente = record
	cod : integer;
	email : string;
	sin_leer: integer;
end;

arbol = ^nodo;
nodo = record
	dato : cliente;
	hd : arbol;
	hi : arbol;
end;

procedure leerCliente(var c:cliente);
begin
	writeln('Ingrese el codigo del cliente');readln(c.cod);
	writeln('Ingrese el email del cliente');readln(c.email);
	writeln('Ingrese la cantidad de msj sin leer del cliente');readln(c.sin_leer);


procedure agregarArbol(var a:arbol; c:cliente);
begin
	if(a=nil)then begin
		new(a);
		a^.dato:=c;
		HI:=NIL;
		HD:=NIL;
	end
	else begin
		if (a^.dato.cod > c.cod)then
			agregarArbol(a^.HI,c)
		else
			agregarArbol(a^.HD,c);
	end


procedure almacenarClientes(var a:arbol);
var
	c:cliente;
begin
	repeat
		leerCliente(c);
		agregar(a,c);
	until(c.cod=1000);
end;

function cantidadCorreosSinLeer(cod:rango_cod; a:arbol):integer;
begin
	if(a=nil)then 
		cantidadCorreosSinLeer:=-1;
	else begin
		if(a^.dato.cod= cod)then
			cantidadCorreosSinLeer:=a^.dato.sin_leer
		else if(a^.dato.cod> cod) then
			cantidadCorreosSinLeer:= cantidadCorreosSinLeer(cod,a^.HI)
		else
			cantidadCorreosSinLeer:= cantidadCorreosSinLeer(cod,a^.HD);
	end;
end;
		
	
		
procedure imprimirMayorAMenor(a:arbol); //imprimo der,nodoact,izq
begin
	if(a<>nil)then BEGIN
		imprimirMayorAMenor(a^.hd);
		writeln(a^dato.cod);
		imprimirMayorAMenor(a^.hi);
	end;
		
end;

function existeEmail(a:arbol;email:string):boolean
var
	existe:boolean;
begin
	if(a=nil)then
		existeEmail:=false
	else
		if(a^.dato.email=email)then
			existeEmail:=true;
		else begin
			existe:= existeEmail(a^.hi,email);
			if (not existe) then
				existe:= existeEmail(a^.hd,email);
			existeEmail:=existe;
		end;
end;
 

var
	a:arbol;
	cod:rango_cod;
	email:string;
begin
	almacenarClientes(a);
	writeln('Ingrese un codigo');readln(cod);
	writeln(cantidadCorreosSinLeer(cod,a));
	imprimirMayorAMenor(a);
	writeln('ingrese una direccion para ver si existe');readln(email);
	if (existeEmail(a,email))then
		writeln('el email existe')
	else
		writeln('el email no existe')
end.
