{3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}

program ej3p3;
Const
	legajo_fin=0;
Type
	regLectura = record
        legajo: integer;
        materia: integer;
        fecha: integer;
        nota: integer;
    end;
    
	finales=record
		cod_materia:integer;
		fecha:integer;
		nota:integer;
	end;
	
	// lista de finales 
	lista=^nodo;
	nodo=record
		dato:finales;
		sig:lista;
	end;
	
	alumno= record
		legajo:integer;
		listaF:lista;
	end;
	
	arbol=^nodoArb;
	nodoArb=record
		dato:alumno;
		HI:arbol;
		HD:arbol;
	end;
	
procedure generarArbol(var a:arbol);	

procedure cargarAlumno (var r:regLectura);
begin
	r.legajo:= random (24);
	if (r.legajo <> legajo_fin) then
	begin
		r.materia:= random (10);
		r.fecha:=random (31)+1;
		r.nota:=random (10)+1;
	end;
end;

procedure cargarRFinales(r:regLectura;var f:finales);
begin
	f.cod_materia:=r.materia;
	f.fecha:=r.fecha;
	f.nota:=r.nota;
end;

procedure agregarAdelante (var l:lista; f:finales);
var
	nue:lista;
begin	
	new(nue);
	nue^.dato:=f;
	nue^.sig:=l;
	l:=nue;
end;
	

procedure insertarArbol(var a:arbol; f:finales ;leg:integer);
begin
	if(a=nil)then begin
		new(a);
		a^.dato.legajo:= leg;
        a^.dato.listaF:= nil;
        agregarAdelante(a^.dato.listaF,f);
		a^.HI:= nil;
        a^.HD:= nil;
    end
    else if(leg > a^.dato.legajo)then
		insertarArbol(a^.HD,f,leg)
		else 
			insertarArbol(a^.HI,f,leg);
	
	if(leg = a^.dato.legajo)then
		agregarAdelante(a^.dato.listaF,f);
end;	
	

	
//-----------variables del generar arbol----------
var
	r:reglectura;
	f:finales;
begin
	cargarAlumno(r);
	while(r.legajo <> legajo_fin) do begin
		cargarRFinales(r,f);
		insertarArbol(a,f,r.legajo);
		cargarAlumno(r);
	end	
end;	


//b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
{procedure alumnosImpar(a:arbol;var cantI:integer);
begin
	if(a<>nil)then begin
		alumnosImpar(a^.HI,cantI);
		if(a^.dato.legajo mod 2 <> 0) then 
			cantI:=cantI + 1;
		alumnosImpar(a^.HD,cantI);
	end;
end;}


function alumnosImpar(a:arbol):integer;
begin
	if(a=nil)then begin
		alumnosImpar:=0;
		else if(a^.dato.legajo mod 2 <> 0) then 
			alumnosImpar:= 1+ alumnosImpar(a^.HI)+alumnosImpar(a^.HD,cantI);
			else 
				alumnosImpar:= alumnosImpar(a^.HI)+alumnosImpar(a^.HD,cantI);
	end;
end;

//c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y 
//su cantidad de finales aprobados (nota mayor o igual a 4).	
procedure recorrerLista(l:listaF);
var
	cantAprob:integer;
begin
	cantAprob:=0;
	while(l<>NIL)do begin
		if(l^.dato.nota >= 4)then
			cantAprob:= 
		

procedure finalesAprobados(a:arbol);
begin
	if(a<>nil)then begin
		recorrerLista(a^.dato.listaF);
		
end;
			
// programa principal	
var
	a:arbol;
	cantI:integer;
	
begin
	a:=nil;
	randomize;
	generarArbol(a);
	cantI:=0;
	alumnosImpar(a,cant);
	//alumnosImpar(a); en funcion
	finalesAprobados(a);
end.
