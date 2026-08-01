program parcialArtesano;
	
	
//-----------------------------------------------------------type-------
	
	
type
	
	rangoCod = 1..8;
	
	artesania = record
		id : integer;
		dni : integer;
		material : rangoCod;
	end;
	
	regArbol = record
		dni : integer;
		cant : integer;
	end;
	
	arbol = ^nodo;
	
	nodo = record
		dato : regArbol;
		hi : arbol;
		hd : arbol;
	end;
		
	regVector = record
		material : integer;
		cant : integer;
	end;
			
	vector = array[rangoCod] of regVector;
		
	nombres = array[rangoCod] of string;
		
const
			
	vNom : nombres = ('Madera', 'Yeso', 'Ceramica', 'Vidrio', 'Acero', 'Porcelana', 'Lana', 'Carton');
		
		
//-------------------------------------------------------imprimir-------
		
	
procedure imprimir(a : arbol; v : vector);
	
	procedure imprimirA(a : arbol);
		
		begin
			
			if (a <> nil) then begin
				
				imprimirA(a^.hi);
				
				writeln;
				writeln('DNI : ', a^.dato.dni);
				writeln('Cantidad : ', a^.dato.cant);
				writeln;
				
				imprimirA(a^.hd);
				
			end; 
			
		end;
		
	procedure imprimirV(v : vector; i : integer);
		
		begin
			
			if (i < 9) then begin
				
				writeln;
				writeln('Codigo de material : ', v[i].material);
				writeln('Cantidad de material : ', v[i].cant);
				writeln;
				
				imprimirV(v, i+1);
				
			end;
			
		end;
	
	begin
		
		writeln;
		writeln('---Arbol---');
		writeln;
		
		imprimirA(a);
		
		writeln;
		writeln('---Vector---');
		writeln;
		
		imprimirV(v, 1);
		
	end;

		
//--------------------------------------------------------incisoA-------


procedure incisoA(var a : arbol; var v : vector);
	
	procedure iniciarVector(var v : vector);
		
		var i : integer;
		
		begin
			
			for i := 1 to 8 do begin
				
				v[i].material := i;
				v[i].cant := 0;
				
			end;
			
		end;

	procedure leer(var aux : artesania);
		
		begin
			
			aux.dni := random(20);
			writeln('Dni : ', aux.dni);
			
			if (aux.dni <> 0) then begin
				
				aux.id := random(100);
				writeln('Identificacion : ', aux.id);
			
				aux.material := random(8) + 1;
				writeln('Codigo de material : ', aux.material);
				
			end;
			
			writeln;
			
		end;

	procedure cargarArbol(var a : arbol; aux : artesania);
	
		begin
			
			if (a = nil) then begin
				
				new(a);
				a^.hi := nil;
				a^.hd := nil;
				a^.dato.dni := aux.dni;
				a^.dato.cant := 1;
				
			end
			
			else if (aux.dni > a^.dato.dni) then cargarArbol(a^.hd, aux)
			
			else if (aux.dni = a^.dato.dni) then a^.dato.cant := a^.dato.cant + 1
			
			else cargarArbol(a^.hi, aux);
			
		end;
			
	var aux : artesania;
			
	begin
	
		iniciarVector(v);
		
		leer(aux);
		
		while (aux.dni <> 0) do begin
			
			cargarArbol(a, aux);

			v[aux.material].cant := v[aux.material].cant + 1;
			
			leer(aux);
			
		end;
	
	end;
	
	
//--------------------------------------------------------incisoB-------
	
	
procedure incisoB(a : arbol);
	
	function buscarAbb(a : arbol; dni : integer): integer;
		
		begin
			
			if (a <> nil) then begin
				
				if (a^.dato.dni < dni) then buscarAbb := 1 + buscarAbb(a^.hi, dni) + buscarAbb(a^.hd, dni)
			
				else buscarAbb := buscarAbb(a^.hi, dni);
				
			end
			
			else buscarAbb := 0;
			
		end;
	
	var dni : integer;
	
	begin
		
		write('Busqueda de inferiores, ingrese dni : ');
		readln(dni);
		
		writeln;
		writeln('Hay ', buscarAbb(a, dni), ' DNI menores a ', dni);
		
	end;
	
procedure incisoC(var v : vector);

	procedure ordenarVector(var v : vector);
	
		var i, j, pos : integer; item : regVector;
		
		begin
			
			for i := 1 to 7 do begin
				
				pos := i;
				
				for j := i+1 to 8 do begin
					
					if (v[j].cant < v[pos].cant) then pos := j;
				
				end;
				
				item := v[pos];
				v[pos] := v[i];
				v[i] := item;
				
			end;
		
		end;
		
	begin
		
		ordenarVector(v);
		
		writeln;
		writeln(vNom[v[8].material], ' es el material con mas cantidad de uso');
		
	end;
	
var
	
	a : arbol;
	v : vector;
		
begin

	randomize; 
	
	a := nil;

	incisoA(a, v);

	//imprimir(a, v);
	
	incisoB(a);

	incisoC(v);

end.
