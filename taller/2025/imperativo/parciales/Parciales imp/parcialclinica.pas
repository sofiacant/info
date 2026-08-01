{Una clínica necesita un sistema para el procesamiento de las atenciones realizadas a los pacientes en julio de 2024.
a) Implementar un módulo que lea información de las atenciones. De cada atención se lee: matrícula del médico, DNI del paciente, día y diagnóstico (valor entre A y F). La lectura finaliza con DNI = 0. 
Se sugiere utilizar el módulo leerAtención().
 El módulo debe retornar dos estructuras: i. Un árbol binario de búsqueda ordenado por matrícula del médico. Para cada matrícula de médico debe almacenarse la cantidad de atenciones realizadas. 
ii. Un vector que almacene por cada diagnóstico posible el tipo del género y  la lista de los DNI de pacientes atendidos con ese diagnóstico.
b) Implementar un módulo que reciba el árbol generado en a) y una matrícula y retorne la cantidad total de atenciones realizadas por los médicos con matrícula superior a la matrícula ingresada.
c) Realizar un módulo recursivo que reciba el vector generado en a) y retorne el diagnóstico con mayor cantidad de pacientes atendidos.
NOTA: Implementar el programa principal, que invoque a los incisos a, b y c. En caso de ser necesario, puede utilizar los módulos que se encuentran a continuación.}

program clinica;
Const
	dni_fin=0;
	dimF=6;
Type
	rangoDiag=1..dimF;
	atencion=record
		matricula:integer;
		dni:integer;
		dia:integer;
		diag:integer;
	end;
	
	regArbol=record
		matri:integer;
		cantAt:integer;
	end;
		
	arbol=^nodoA;
	nodoA=record
			dato:regArbol;
			HI:arbol;
			HD:arbol;
	end;
		
		listadni=^nodol;
			nodol=record
				dato: integer;
				sig:listadni;
			end;
	
	
	vector=array[rangoDiag]of listadni;
///--------------------------------------------------------CARGAR ARBOL----------------------------------------------------------
procedure cargarArbol(var a:arbol);
	procedure leerAtencion(var at:atencion);
	begin
		at.dni:= random(101);
		if(at.dni <>dni_fin)then begin
			at.matricula:=2000 +random(1000); 
			at.dia:=1+random(31);
			at.diag:=1+ random(6);
		end;
	end;
	
	
	procedure insertarArbol(var a:arbol; rA:regArbol );
	begin
		if(a=nil)then begin
			new(a);
			a^.dato.matri:=rA.matri;
			a^.dato.cantAt:=rA.cantAt;
			a^.HI:=NIL;
			a^.HD:=NIL;
		end
		else
			if(rA.matri = a^.dato.matri)then
				a^.dato.cantAt:=a^.dato.cantAt+1
			
			else if(rA.matri < a^.dato.matri)then 
					insertarArbol(a^.HI,rA)
					else
						insertarArbol(a^.HD,rA)
end;	
			
//Un vector que almacene por cada diagnóstico posible el tipo del género y  la lista de los DNI de pacientes atendidos con ese diagnóstico.	
procedure agregarAdelante(var l:listadni; dni:integer);
var
	nue:listadni;
begin
	new(nue);
	nue^.dato:=dni;
	nue^.sig:=l;
	l:=nue;
end;


		
//------------------------------------------------------------------CARGA DE ARBOL----------------------------------------
var
	at:atencion;
	rA:regArbol;
	v:vector;

begin
	 leerAtencion(at);
	 while(at.dni<> dni_fin)do begin
			rA.matri:=at.matricula;
			rA.cantAt:=1;
			insertarArbol(a,rA);
			agregarAdelante(v[at.diag],at.dni);
			leerAtencion(at);
		end;
end;
	
procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		writeln('---------------Arbol----------------');
		writeln('La matricula es:   ',a^.dato.matri);
		writeln('La cantidad de atenciones es  :   ',a^.dato.cantAt);
		imprimirArbol(a^.HI);
		imprimirArbol(a^.HD);
	end;
end;

procedure inicializarVectorListas(var v:vector);
var
	i:rangoDiag;
begin
	for i:=1 to 6 do 
		v[i]:=NIL;
end;

procedure imprimirLista (l: listadni);
begin
	while( l <> nil) do begin
		writeln ('dni:   ', l^.dato);
		l:=l^.sig;
	end;
end;

procedure imprimirVector (v: vector);
var i: integer;
begin
	for i:= 1 to dimF do begin
		writeln ('El diagnostico ', i , ' contiene a las personas con dni:'); 
		imprimirLista (v[i]);
	end;
end;


//b Implementar un módulo que reciba el árbol generado en a)
 //y una matrícula y retorne la cantidad total de atenciones realizadas por los médicos con matrícula superior a la matrícula ingresada.
 function cantidadTotal(a:arbol ; m:integer): integer;
 begin
	if(a=nil)then
		cantidadTotal:= 0
	else
		if(a^.dato.matri > m)then
			cantidadTotal:= 1+ cantidadTotal(a^.HI,m)+ cantidadTotal(a^.HD,m)
		else
			cantidadTotal:=cantidadTotal(a^.HD,m);
end;

//c) Realizar un módulo recursivo que reciba el vector generado en a) y retorne el diagnóstico con mayor cantidad de pacientes atendidos.

function contabilizar(l:listaDni):integer;
begin
	if(l=nil)then
		contabilizar:=0
	else
		contabilizar:= 1+ contabilizar(l^.sig);
end;

procedure maxCantidad(v:vector ; dim:integer;var maxCant, maxCod:integer );
var
	cant:integer;
begin
	if (dim<=6)then begin
		maxCantidad(v,dim+1,maxCant,maxCod);
		cant:=(contabilizar(v[dim]));
		if(cant>MaxCant)then begin
			maxCant:=cant;
			maxCod:=dim;
		end;
	end;
end;
	
var
	a:arbol;
	v:vector;
	m:integer;
	dim,maxCant,maxCod:integer;
	incisob:integer;

begin
	a:=nil;
	randomize;
	inicializarVectorListas(v);
	cargarArbol(a);
	imprimirArbol(a);
	imprimirVector(v);
	writeln('Ingrese una matricula');  readln(m);
	incisob:=(cantidadTotal(a,m));
	writeln('la cantidad total de atenciones realizadas es: ' ,incisob);
	dim:=1;
	maxCant:=-9999;
	maxCod:=-9999;
	maxCantidad(v,dim,maxCant,maxCod);
	writeln('El diagnostico con mayor cantidad de pacientes atendidos es :  ',maxCod, ' con una cantidad de :  ',maxCant)
end.
