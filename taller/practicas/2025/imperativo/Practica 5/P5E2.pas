{2. Una agencia dedicada a la venta de autos ha organizado su stock y, tiene la información de los autos en venta. Implementar un programa que: 
a) Genere la información de los autos (patente, año de fabricación (2015..2024), marca, color y modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos: 
i. Una estructura eficiente para la búsqueda por patente.
 ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben almacenar juntas las patentes y colores de los autos pertenecientes a ella.
 b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la cantidad de autos de dicha marca que posee la agencia. 
  c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.  
  d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con la información de los autos agrupados por año de fabricación. 
  e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el modelo del auto con dicha patente. 
    f) Invoque a unmódulo que reciba el árbol generado en a) ii y una patente y devuelva el color del auto con dicha patente.}
 
 program autos;
 Const
    fin_marca='MMM';
Type
    rango_anios=2015..2024;
    str30=string[30];

    auto=record
        patente:integer;
        anio:rango_anios;
        marca:str30;
        color:str30;
        modelo:str30;
    end;
    
    arbol=^nodo;
    nodo=record
        dato:auto;
        HI:arbol;
        HD:arbol;
    end;
    
    Marca=record
			patente: integer;
			color: str30;
		end;
		
		lista = ^nodoL;
		nodoL = record
			dato: Marca;
			sig: lista;
		end;
		
		regA2 = record
			marca: str30;
			l: lista;
		end;
    
		arbol2=^nodo2;
    nodo2=record
        dato:regA2;
        HI:arbol2;
        HD:arbol2;
    end;
     
  //  vector=array[rango_anios]of listaAutos;

//---------------------------CargarArboles--------------------------//
   
procedure CargarArboles (var a1: arbol; var a2: arbol2);

	procedure LeerAuto (var a: auto);
	begin
		writeln('Ingresar Marca: ');
		readln(a.marca);
		if (a.marca <> fin_marca) then
		begin
			a.patente:= random(151);
			a.anio:= 2015 + random(10);
			writeln('Ingresar Color: ');
			readln(a.color);
			writeln('Ingresar Modelo: ');
			readln(a.modelo);
		end;
	end;

//---------------------------CargarMarca------------------------------------//
	
	procedure CargarMarca (auto: auto; var m: marca);
	begin
		m.patente:= auto.patente;
		m.color:= auto.color;
	end;
	
//---------------------------CargarArbol1-----------------------------------//
	
	procedure CargarArbol1 (var a: arbol; auto: auto);
	begin
		if (a = nil) then
		begin
			new(a);
			a^.dato:= auto;
			a^.hi:= nil;
			a^.hd:= nil;
		end
		else
		if (auto.patente < a^.dato.patente) then
			CargarArbol1(a^.hi, auto)
		else
			CargarArbol1(a^.hd, auto);
	end;
	
	//------------------------------CargarArbol2-------------------------------//
	
	procedure CargarArbol2 (var a: arbol2; m: marca; lMarca: str30);
	
		procedure AgregarAdelante (var l: lista; m: marca);
		var
			nuevo: lista;
			
		begin
			new(nuevo);
			nuevo^.dato:= m;
			nuevo^.sig:= l;
			l:= nuevo;
		end;
//--------------------cargar arbol 2---------------- 
	begin
		if (a = nil) then
		begin
			new(a);
			a^.dato.marca:= lMarca;
			a^.dato.l:= nil;
			AgregarAdelante(a^.dato.l, m);
			a^.hi:= nil;
			a^.hd:= nil;
		end
		else
			if (lMarca = a^.dato.marca) then
					AgregarAdelante(a^.dato.l, m)
			else
				if (lMarca < a^.dato.marca) then	
					CargarArbol2(a^.hi, m, lMarca)
		else
			CargarArbol2(a^.hd, m, lMarca)
	end;
	
	
//--------------------------CargarArboles-----------------------------//	
	
var
	au: auto;
	m: marca;
	
begin
	LeerAuto(au);
	while (au.marca <> fin_marca) do
	begin
		CargarArbol1(a1, au);
		CargarMarca(au, m);
		CargarArbol2(a2, m, au.marca);
		LeerAuto(au);
	end;
end; 

//-------------------------------IMPRIMIR ARBOL-------------------------------------//
procedure imprimirlista(l:lista);
begin
	while(l<>nil) do begin
			writeln ('---------LISTA--------------');
			writeln('la patente es:   ,' ,l^.dato.patente);
	end;
end;


procedure ImprimirArbol1 (a: arbol);
begin
	if (a <> nil) then
	begin
		writeln('------------------ARBOL 1-----------------------------------------------');
		writeln(a^.dato.marca);
		ImprimirArbol1(a^.hi);
		ImprimirArbol1(a^.hd);
	end;
end;

procedure ImprimirArbol2 (a: arbol2);
begin
	if (a <> nil) then
	begin
		writeln('------------------ARBOL 2-----------------------------------------------');
		writeln(a^.dato.marca);
		imprimirlista(a^.dato.l);
		ImprimirArbol2(a^.hi);
		ImprimirArbol2(a^.hd);
	end;
end;

{b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.}
function RecorrerArbol_b (a: arbol; m: str30): integer;
begin
	if (a = nil) then
		RecorrerArbol_b:= 0
	else
		if (a^.dato.marca = m) then
			RecorrerArbol_b:= 1 + RecorrerArbol_b(a^.hi, m) + RecorrerArbol_b(a^.hd, m)
		else
			RecorrerArbol_b:= RecorrerArbol_b(a^.hi, m) + RecorrerArbol_b(a^.hd, m);
end;

// c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.
function cantLista(l:lista):integer;
var
	cantl:integer;
begin
	cantl:=0;
	while(l<>nil)do begin
		cantl:=cantl+1;
		l:=l^.sig;
	end;
	cantLista:=cantl;
end;

function cantautosarbolII(a:arbol2;n:str30):integer;

begin
	if(a=nil)then
		cantautosarbolII:=0
	else if(a^.dato.marca = n)then 
				cantautosarbolII:= cantLista(a^.dato.l)+ cantautosarbolII(a^.hi,n)+ cantautosarbolII(a^.hd,n)
			else
				cantautosarbolII:=cantautosarbolII(a^.hi,n)+cantautosarbolII(a^.hd,n)
end;
		
// d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con la información de los autos agrupados por año de fabricación.
// e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el modelo del auto con dicha patente.  patente:integer;
{        anio:rango_anios;
        marca:str30;
        color:str30;
        modelo:str30;}

procedure modeloAuto(a:arbol; pat:integer; var modelo:str30);
begin
	if(a<>nil)then begin
		if(a^.dato.patente=pat)then begin
			modelo:=a^.dato.modelo;
			modeloAuto(a^.HI,pat,modelo);
			modeloAuto(a^.HD,pat,modelo);
		end;
	end;
end;	

//  f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el color del auto con dicha patente.       arbol con marca y l, l tiene patente y color
procedure recorrerLista(l:lista; pat:integer; var paten:str30; var color:str30);
begin
	while (l<>nil)and(paten <> 'DDD')do begin
		if(l^.dato.patente = pat)then begin
			color:=l^.dato.color;
			paten:=l^.dato.patente;
		end
		else
			l:=l^.sig;
	end;
end;
					

procedure colorAuto(a:arbol2; pat:integer;var paten:str30; var color:str30);

begin
	if(a<>nil)then 
		recorrerLista(a^.dato.l,pat,color,paten);
	else if(pat<>paten)then begin
		colorAuto(a^.hi, pat,color);
		colorAuto(a^.hd, pat,color);
	  end;
end;
	
				




//--------------------------ProgramaPrincipal------------------------//	
var
    a1: arbol;
    a2: arbol2;
    n,modelo,paten: str30;
    pat:integer;
    
begin
		randomize;
    a1:=nil;
    a2:= nil;
    CargarArboles(a1, a2);
		ImprimirArbol1(a1);	
		writeln('Ingrese Marca Especifica');
		writeln('------------------------------------------');
		readln(n);
		writeln('la cantidad de autos en el arbol 1 de esa marca es:   ', RecorrerArbol_b(a1, n));
		writeln('Ingrese Marca Especifica  '); readln(n);
		writeln('la cantidad de autos en el arbol 2 de esa marca es:   ', cantautosarbolII(a2,n));
		
		writeln('Ingrese una patente:   '); readln(pat);
		modeloAuto(a1, pat , modelo);
		if(a1^.dato.l= nil )then
			writeln('no se encontro dicha patente');
		else
			writeln('el modelo de esa patente es:   ',modelo);
		paten:='DDD';
		colorauto(a2,pat,color,paten);
end.
