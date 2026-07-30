program empresaLaVeloz;
Const
	cod_fin=0;
Type
	rango_dia= 1..31;
	rango_mes=1..12;
	
	envio=record
		codcliente:integer;
		dia:rango_dia;
		mes:rango_mes;
		codPostal:integer;
		peso:real;
	end;
	
	vector= array[rango_mes]of integer;
	
	regArbol= record
		codPostal:integer;
		vector:vector;
	end;
	
	
		arbol=^nodo;
		nodo=record
			dato:regArbol;
			HI:arbol;
			HD:arbol;
		end;
//-------------------------MODULOS--------------------
procedure cargarArbol(var a:arbol);

procedure leerEnvio(var e:envio);
begin
	e.codCliente:= random(10000);
	if(e.codCliente <> cod_fin)then begin
			e.dia:= 1+random(31);
			e.mes:= 1+ random(12);
			e.codPostal:= random(20);
			e.peso:= random(20000)/ (random(10 )+1);
	end;
end;

procedure inicializarVector(var v:vector);
var
	i:integer;
begin
	for i:= 1 to 12 do
		v[i]:=0;
end;

procedure insertarArbol(var a:arbol; codPostal:integer; mes:integer);
begin
	if(a= nil)then begin
		new(a);
		a^.dato.codPostal:=codPostal;
		inicializarVector(a^.dato.vector);
		a^.dato.vector[mes]:=a^.dato.vector[mes] +1;
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else 
		if(a^.dato.codPostal = codPostal)then
			a^.dato.vector[mes]:=a^.dato.vector[mes] +1
			
		else if(a^.dato.codPostal >codPostal)then
					insertarArbol(a^.HI,codPostal,mes)
					else
						insertarArbol(a^.HD,codPostal,mes);
end;

var
	e:envio;
begin
	leerEnvio(e);
	while(e.codCliente <> cod_fin)do begin
			insertarArbol(a, e.codPostal, e.mes);
			leerEnvio(e);
	end;
end;
//-------------------------------------------
procedure imprimirVector(v:vector);
var
	i:integer;
begin
	for i:= 1 to 12 do 
		writeln('La cantidad de envios del mes:  ' ,i, '  es:  ', v[i]);
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.HI);
		writeln('El codigo postal:    ', a^.dato.codPostal);
		imprimirVector(a^.dato.vector);
		writeln('--------');
		imprimirArbol(a^.HD);
	end;
end;

function recorrerVector(v:vector ;  valor:integer):integer;
var
	i:integer;
	cant:integer;
begin
	cant:=0;
	for i:= 1 to 12 do begin
		if(v[i]> valor)then
				cant:=cant +1;
	end;
	recorrerVector:=cant;
end;

procedure buscarCodigoPostal(a:arbol; codigo:integer; valor:integer; var cant:integer);
begin
	if(a<>nil)then begin
			if(a^.dato.codPostal= codigo)then 
				cant:=(recorrerVector(a^.dato.vector, valor))
			else
				if (a^.dato.codPostal> codigo)then
					buscarCodigoPostal(a^.HI,codigo,valor,cant)
				else
						buscarCodigoPostal(a^.HD,codigo,valor,cant)
	end;
end;


function buscarSinEnvio(v:vector):boolean;
var
	i:integer;
	cantcero:integer;
begin
	cantCero:=0;
	i:=1;
	while(i<=12)and(cantCero<1)do begin
		if(v[i]=0)then
			cantCero:=cantCero+1;
		i:=i +1;
	end;
	buscarSinEnvio:=(cantCero>0);
end;

procedure buscarentrePostales(a:arbol; min, max:integer);
begin
	if(a<>nil)then begin
			if(a^.dato.codPostal>= min)then begin
					if(a^.dato.codPostal<= max)then begin
						if(buscarSinEnvio(a^.dato.vector)) then begin
								buscarentrePostales(a^.HI,min,max);
								writeln('El codigo postal:  ', a^.dato.codPostal,' tuvo al menos un mes sin envios');
								buscarentrePostales(a^.HD,min,max);
						end
						else begin
							buscarentrePostales(a^.HI,min,max);
							writeln('El codigo postal:  ', a^.dato.codPostal, ' tiene envios todos los meses ');
							buscarentrePostales(a^.HI,min,max);
						end;
					end
					else
						buscarentrePostales(a^.HI,min,max)
				end
			else
				buscarentrePostales(a^.HD,min,max);
		end;
end;



//--------------------PROGRAMA PRINCIPAL----
var
	a:arbol;
	cant,codigo,valor:integer;
	rangoA,rangoB:integer;
begin
	a:=nil;
	randomize;
	cargarArbol(a);
	writeln('---------ARBOL-------');
	imprimirArbol(a);
	writeln('Ingrese un codigo:   '); readln(codigo);
	writeln('Ingrese un valor:   '); readln(valor);
	buscarCodigoPostal(a,codigo,valor,cant);
	writeln('La cantidad de meses que superan al valor ingresado:   ', cant);
	
	writeln('Ingrese un rango A:  '); readln(rangoA);
	writeln('Ingrese un rango B:  '); readln(rangoB);
	buscarEntrePostales(a,rangoA,rangoB);
	
	
end.
	
	
