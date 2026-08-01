{Correo Argentino desea analizar la información de los paquetes enviados durante 2024. De cada paquete enviado se conoce: 
 código de envio, DNI del emisor, DNI del receptor, cantidad de objetos en el paquete y peso del paquete en gramos. Realice un programa que contenga e invoque a

	a. Un módulo que lea la información de paquetes enviados y retome una estructura con todos los paquetes leídos. La estructura debe ser eficiente para buscar por peso del 
	   paquete en gramos. La lectura finaliza al leer un paquete con codigo de envio 0.

	b. Un modulo que reciba la estructura generada en a) y dos valores y retorne una lista, con todos los paquetes enviados cuyo peso está entre los dos valores recibidos

	c. Un módulo que reciba la estructura generada en a) y retorne toda la información del paquete enviado con mayor cantidad de objetos.}

program CorreoArgentino;
type
	Tpaquetes = record
		codigo_envio : integer;
		DNI_emisor : integer;
		DNI_receptor : integer;
		cant_obj : integer;
		pesoG : real;
	end;
	arbol = ^nodo;
		nodo = record
			dato : Tpaquetes;
			HI : arbol;
			HD : arbol;
		end;
	
	lista = ^nodoL;
		nodoL = record
			dato : Tpaquetes;
			sig : lista;
		end;
	//MODULO A
	procedure LeerPaquete (var p : Tpaquetes);
	begin
		p.codigo_envio := random(20);
		if(p.codigo_envio <> 0) then begin
			p.DNI_emisor := random(9000) + 1000;
			p.DNI_receptor := random(9000) + 1000;
			p.cant_obj := random(30) + 1;
			p.pesoG := random(1000) + 10000;
		end;
	end;
	procedure Insertar (var a : arbol ; dato : Tpaquetes);
	var
		nue : arbol;
	begin
		if(a = nil) then begin
			new(nue);
			nue^.dato := dato;
			nue^.HI := nil;
			nue^.HD := nil;
			a := nue;
		end
		else if (a^.dato.pesoG > dato.pesoG) then 
			Insertar(a^.HI, dato)
		else
			Insertar(a^.HD, dato);
	end;
	procedure CargarArbol (var a : arbol);
	var
		p : Tpaquetes;
	begin
		LeerPaquete(p);
		while(p.codigo_envio <> 0) do begin
			Insertar(a, p);
			LeerPaquete(p);
		end;
	end;
	procedure ImprimirArbol(a : arbol); //para ver si generó correctamente
	begin
		if(a <> nil) then begin
			ImprimirArbol(a^.HI);
			writeln('El codigo de envio es: ', a^.dato.codigo_envio,
					' | El dni del emisor es: ', a^.dato.DNI_emisor,
					' | El dni del receptor es : ', a^.dato.DNI_receptor,
					' | La cantidad de objetos del paquete es de: ', a^.dato.cant_obj,
					' | El peso del paquete es de: ', a^.dato.pesoG:2:2);
			ImprimirArbol(a^.HD);
		end;
	end;
	//Modulo B Un modulo que reciba la estructura generada en a) y dos valores y retorne una lista, con todos los paquetes enviados cuyo peso está entre los dos valores recibidos
	procedure AgregarAdelante (var l : lista ; dato : Tpaquetes);
	var
		nue : lista;
	begin
		new(nue);
		nue^.dato := dato;
		nue^.sig := l;
		l := nue;
	end;
	procedure GenerarLista (a : arbol ; var l : lista ; valor1, valor2 : real);
	begin
		if(a <> nil) then begin
			if((a^.dato.pesoG >= valor1) and (a^.dato.pesoG <= valor2)) then begin
				AgregarAdelante(l, a^.dato);
				GenerarLista(a^.HI, l, valor1, valor2);
				GenerarLista(a^.HD, l, valor1, valor2);
			end
			else if (a^.dato.pesoG < valor1) then
				GenerarLista(a^.HD, l, valor1, valor2)
			else 
				GenerarLista(a^.HI, l, valor1, valor2);	
		end;
	end;
	//MODULO C Un módulo que reciba la estructura generada en a) y retorne toda la información del paquete enviado con mayor cantidad de objetos.
	procedure InformarPaqueteConMayorOB (a : arbol; var maxP : Tpaquetes ; var maxCant: integer);
	begin
		if(a <> nil) then begin
			if (a^.dato.cant_obj > maxCant) then begin
				maxCant := a^.dato.cant_obj;
				maxP := a^.dato;
			end;
			InformarPaqueteConMayorOB(a^.HI, maxP, maxCant);
			InformarPaqueteConMayorOB(a^.HD, maxP, maxCant);
		end;
	end;	
var
	a : arbol; peso1, peso2 : real; l : lista; maxP : Tpaquetes ; maxCant : integer;
begin
	randomize;
	a := nil;
	l := nil;
	CargarArbol(a);
	ImprimirArbol(a);
	writeln('Ingrese un peso: ');
	readln(peso1);
	writeln('Ingrese un peso mayor al anterior: ');
	readln(peso2);
	GenerarLista(a, l, peso1, peso2);
	maxCant := -1;
	InformarPaqueteConMayorOB(a, maxP, maxCant);
	writeln('El paquete con mas objetos es:');
    writeln('Codigo de envio: ', maxP.codigo_envio);
    writeln('DNI emisor: ', maxP.DNI_emisor);
    writeln('DNI receptor: ', maxP.DNI_receptor);
    writeln('Cantidad de objetos: ', maxP.cant_obj);
    writeln('Peso (g): ', maxP.pesoG:2:2);
end.
