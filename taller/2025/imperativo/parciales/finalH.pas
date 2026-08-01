program finalH;

//-----------------------------------------------------------type-------


type

	sucursal = 1..10;
	
	venta = record
		dni : integer;
		sucursal : sucursal;
		factura : integer;
		monto : real;
	end;
	
	regLista = record
		factura : integer;
		monto : real;
	end;
	
	lista = ^nodoLista;
	
	nodoLista = record
		dato : regLista;
		sig : lista;
	end;
	
	regArbol = record
		dni : integer;
		lis : lista;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato : regArbol;
		hi : arbol;
		hd : arbol;
	end;
	
	vector = array[sucursal] of integer;
	
	
//--------------------------------------------------------incisoA-------
	
	
procedure incisoA(var a : arbol; var v : vector);

	procedure iniciarVector(var v : vector);
		
		var i : integer;
		
		begin
			
			for i := low(sucursal) to high(sucursal) do
				
				v[i] := 0;
			
		end;

	procedure leer(var ven : venta);
		
		begin
			
			ven.dni := random(10);
			writeln('Documento : ', ven.dni);
			
			if (ven.dni <> 0) then begin
			
				ven.sucursal := random(10) + 1;
				writeln('Sucursal : ', ven.sucursal);
				
				ven.factura := random(1000) + 1;
				writeln('Factura : ', ven.factura);
				
				ven.monto := random(2357) * 2.71828;
				writeln('Monto : ', ven.monto : 2 : 2);
				
			end;
			
			writeln;
			
		end;

	procedure cargarLis(var lis : lista; ven : venta);
		
		var nue : lista;
		
		begin
			
			new(nue);
			nue^.dato.factura := ven.factura;
			nue^.dato.monto := ven.monto;
			nue^.sig := lis;
			lis := nue;
			
		end;

	procedure crearNodo(var a : arbol; ven : venta);
		
		begin
			
			if (a = nil) then begin
				
				new(a);
				a^.hi := nil;
				a^.hd := nil;
				a^.dato.dni := ven.dni;
				a^.dato.lis := nil;
				cargarLis(a^.dato.lis, ven);
				
			end
			
			else if (ven.dni > a^.dato.dni) then crearNodo(a^.hd, ven)
			
			else if (ven.dni = a^.dato.dni) then cargarLis(a^.dato.lis, ven)
			
			else crearNodo(a^.hi, ven);
		
		end;

	var ven : venta;

	begin
		
		iniciarVector(v);
		
		leer(ven);
		
		while (ven.dni <> 0) do begin
			
			crearNodo(a, ven);
			
			v[ven.sucursal] := v[ven.sucursal] + 1;
			
			leer(ven);
			
		end;
	
	end;
	
	
//--------------------------------------------------------incisoB-------
	
	
procedure incisoB(a : arbol);
	
	function buscarLis(lis : lista; maux : real): integer;
		
		begin
			
			if (lis <> nil) then begin
			
				if (lis^.dato.monto > maux) then 
						
					buscarLis := 1 + buscarLis(lis^.sig, maux)
					
				else buscarLis := 0 + buscarLis(lis^.sig, maux);
					
			end
			
			else buscarLis := 0;
			
		end;
		
	function buscarAbb(a : arbol; daux : integer; maux : real): integer;
		
		begin
			
			if (a <> nil) then begin
				
				if (a^.dato.dni = daux) then buscarAbb := buscarLis(a^.dato.lis, maux)
					
				else begin
					
					if (daux > a^.dato.dni) then buscarAbb := buscarAbb(a^.hd, daux, maux)
					
					else buscarAbb := buscarAbb(a^.hi, daux, maux);
					
				end;
				
			end
			
			else buscarAbb := 0;
			
		end;
	
	var maux : real; daux : integer;
	
	begin
		
		writeln;
		write('Ingrese dni a buscar : ');
		readln(daux);

		writeln;
		write('Ingrese monto a superar : ');
		readln(maux);

		writeln;
		writeln('Hay ', buscarAbb(a, daux, maux), ' facturas superiores a ', maux : 2 : 2, ' para el dni ', daux);

	end;
	
	
//--------------------------------------------------------incisoC-------
	
	
procedure incisoC(v : vector);
	
	procedure mayor(v : vector; var max, suc : integer; i : integer);
		
		begin
			
			if (i < high(sucursal)) then begin
				
				if (v[i] > max) then begin
					
					max := v[i];
					suc := i;
					
				end;
				
				mayor(v, max, suc, i+1);
				
			end;
			
		end;
	
	var max, suc : integer;
	
	begin
		
		max := -1;
		
		mayor(v, max, suc, low(sucursal));
		
		writeln;
		writeln('La sucursal con mayor ventas es la ', suc);
		
	end;
	
var
	
	a : arbol;
	v : vector;
	
begin

	randomize;
	
	a := nil;
	
	incisoA(a, v);
	
	incisoB(a);

	incisoC(v);

end.
