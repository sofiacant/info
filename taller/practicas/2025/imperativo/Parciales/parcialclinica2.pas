una clinica necesita un sistema para el procesamiento de las atenciones realizadas a los pacientes durante el año 2023.
a) Implementar un módulo que lea Información de las atenciones y retorne un vector donde se almacenen la
atenciones agrupadas por mes. Las atenciones de cada mes deben quedar almacenadas en un árbol binarlo d
búsqueda ord-enado por DNI del paciente y sólo deben almacenarse dni del paciente y código de diagnóstico.
De cada atención se lee: matricula del médico, DNI del paciente, mes y diagnóstico (valor entre Ly P). La lectua
finaliza con matrícula 0.
b) Implementar un módulo recursivo que reciba el vector generado en a) y retorne el mes con mayor cantidad d
atenciones.
c) Implementar un módulo que reciba el vector generado en a) y un DNI de paciente, y retorne si fue atendido
no, el paciente con el DNI ingresado,

program clinica;
Const
	mat_fin=0;
Type   
	rango_diag= 1..5;
	rango_meses=1..12;
	
	atencion= record
		matricula:integer;
		dni:integer;
		mes:integer;
		diagnostico:integer;
	end;
	
	regArbol=record
		dni:integer;
		diag:integer;
	end;
	
	arbol=^nodoA;
		dato:regArbol;
		HI:arbol;
		HD:arbol;
	end;
		
	vector= array [rango_meses] of arbol;

procedure inicializarVector(var v:vector);
var
	i:rango_meses;
begin
	for i:= 1 to 12 do 
		v[i]:=nil;
end;

procedure cargarvector(var  v:vector);

procedure insertarArbol (var a:arbol; rA:regArbol);
begin
	if (a= nil) then
	begin
		new(a);
		a^.dato.dni:=rA.dni;
		a^.dato.diag:=rA.diag;
		a^.HI:=nil;
		a^.HD:=nil; 
	end
	else	
	if (rA.dni < a^.dato.dni) then
		insertarArbol(a^.HI,rA)
		else
			insertarArbol(a^.HD,rA);
end;

procedure cargarRegArbol(ate:atencion; var rA:regArbol);
begin
	rA.dni:= ate.dni;
	rA.diag:=ate.diagnostico;
end;

		
var
	ate:atencion;
	rA:regArbol;
begin
	leerAtencion(ate);
	while (a.matricula <> mat_fin) do
	begin
		cargarRegArbol(ate,rA);
		v[ate.mes]:=insertarArbol(a,ate);
		leerAtencion(ate);
	end;
end;

//b) Implementar un módulo recursivo que reciba el vector generado en a) y retorne el mes con mayor cantidad de atenciones.
function recorrerArbol(a:arbol):integer;
begin
	if(a=nil)then
		recorrerArbol:=0
	else
		recorrerArbol:= 1+ recorrerArbol(a^.hi)+ recorrerArbol(a^.hd)
end;
	

procedure mesMaximo(v:vector; var i, mesMax,cantMax:integer);
var
	cant:integer;
begin
			if(v[i]<= 12 )then begin
				cant:=recorrerArbol(v[i]);
				
				if(cant > cantMax)then begin
					cantMax:=cant;
					mesMax:=i;
				end
				mesMaximo(v, i+1, mesMax, cantMax);
			end;
end;
	
//c) Implementar un módulo que reciba el vector generado en a) y un DNI de paciente, y retorne si fue atendido o no, el paciente con el DNI ingresado,	
function buscarDniEnArbol(a:arbol; dni:integer):boolean;
begin
	if(a= nil)then
		buscarDniEnArbol:= false
	else
		if(a^.dato.dni = dni)then
			buscarDniEnArbol:=true
		else if (dni >a^.dato.dni )then begin
				buscarDniEnArbol(a^.HD,dni);
				buscarDniEnArbol(a^.HI,dni);
			else
				buscarDniEnArbol(a^.HI,dni);
end;
				
			

				
			
			
	



function buscarDni(v:vector; dni:integer):boolean;
begin
			if(v[i]<=12)then begin
				buscarDniEnArbol(v[i],dni);

var
	v:vector;
	i,mesMax,cantMax,dniIn:Integer;
begin
	inicializarVector(v)
	cargarVector(v);
	i:=1;
	mesMax:=-999;
	cantMax:=-999;
	mesMaximo(v,i,mesMax,cantMax);
	writeln('Ingrese un dni a buscar en el arbol:     ');
	readln(dniIn);
	buscardni(v,dni);
end.
	
	
