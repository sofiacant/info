program ej1p3;
Const
	nro_fin=0;
Type
	str20=string[20];
	socio= record
		num:integer;
		nombre:str20;
		edad:integer;
	end;
	arbol=^nodoA;
		nodoA=record
			dato:socio;
			HI:arbol;
			HD:arbol;
		end;
	vNombres:array [0..9] of string = ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
	
	
procedure cargarArbol(var a:arbol);
	
	procedure leerSocio(var s:socio);
	begin
		s.num:=random(100);
		if(s.num<>nro_fin)then begin
			s.nombre:=vNombres[random(10)];
			s.edad:= random( 91);
		end;
	end;
	
	procedure insertarArbol(var a:arbol; s:socio);
	begin
		if(a=nil )then begin
			new(a);
			a^.dato:=s;
			a^.HI:=nil;
			a^.HD:=nil;
		end
		else 
			if( s.num < a^.dato.num)then 
				insertarArbol(a^.HI,s)
			else
				insertarArbol(a^.HD,s);
	end;
	
	var
		s:socio;
	begin
		leerSocio(s);
		while(s.num<>num_fin)do begin
			insertarArbol(a,s)
			leerSocio(S);
		end;
	end;
//-----------------------FIN CARGA DE ARBOL.---------------------

//i. Informar los datos de los socios en orden creciente    por número de socio. 
Procedure informarCreciente(a:arbol ;//in order
begin
	if(a<>nil)then begin
		informarCreciente(a^.HI);
		writeln('Numero: ', a^.dato.num, '\n', ' Nombre: ', a^.dato.nombre, '\n' , ' Edad: ', a^.dato.edad );
		informarCreciente(a^.HD);
	end;
end;

// Informar los datos de los socios en orden decreciente por número de socio. 
procedure informarDecreciente(a:arbol);
begin
	if(a<>nil)then begin
		informarDecreciente(a^.HD);
		writeln('Numero: ', a^.dato.num, '\n', ' Nombre: ', a^.dato.nombre, '\n' , ' Edad: ', a^.dato.edad );
		informarDecreciente(a^.HI);
end;

//iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor. 
//si dice retorne no necesariamente tiene que ser una funcion
procedure informarMayorEdad(a:arbol);
	procedure actualizarMax(var maxEdad,maxNum:integer; edad,num:integer);
	begin
		if(edad>=maxEdad)then begin
			maxEdad:=edad;
			maxNum:=num;
		end;
	end;
	
	procedure buscarMaxEdad(a:arbol; var maxEdad,maxNum:integer);//´preorden
	begin
		if(a<>nil)then begin
			actualizarMax(maxEdad,maxNum,a^.dato.edad,a^.dato.num);
			buscarMaxEdad(a^.HI,maxEdad,maxNum);
			buscarMaxEdad(a^.HD,maxEdad,maxNum);
		end;
	end;
	
var
	maxEdad:integer;
	numMax:integer;
begin
	maxEdad:=-1
	buscarMaxEdad(a,maxEdad,numMax);
	if(maxEdad=-1)then
		writeln('arbol sin elementos')
	else
		writeln)'El socio con mayor edad es:  ', maxEdad);
end;
	
//-------------------------------------
//	iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumentó la edad.
function aumentarEdadSocioImpar(a:arbol):integer;
var
	resto:integer;
begin
	if(a=NIL)then
		aumentarEdadSocioImpar:=0
	else begin
		resto:=a^.dato.edad MOD 2;
		if(resto= 1)then
			a^.dato.edad=	a^.dato.edad+1;
		aumentarEdadSocioImpar:= resto+ aumentarEdadSocioImpar(a^.HI)+aumentarEdadSocioImpar(a^.HD);
	end;
end;

//vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo 
//que reciba el nombre leído y retorne verdadero o falso. 

function busquedaNombre(a:arbol; n:str20):boolean;  //CONSULTAR
begin
	if(a=nil)then 
		busquedaNombre:=false
	else 
		if(a^.dato.nombre= n)then 
			busquedaNombre:=true
		else
			busquedaNombre:= busquedaNombre(a^.HI,n) or   busquedaNombre(a^.HD,n);
end;

//vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad. 
function cantidadSocios(a:arbol):integer;
var
	cant:integer;
begin
	if(a=nil)then
		cantidadSocios:=0
	else 
		cantidadSocios:= 1+ cantidadSocios(a^.HI)+cantidadSocios(a^.HD);
end;

//viii. Informar el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso vii e invocar a un módulo recursivo que 
//retorne la suma de las edades de los socios. 
procedure informarPromedio(a:arbol);
	function edadTotal(a:arbol; total:integer):integer;
	begin
		if(a<>nil)then
			total:=a^.dato.edad+edadTotal(a^.HI,total)+edadTotal(a^.HD,total);
		edadTotal:= TOTAL;
	end;
	
	function edadPromedio(a:arbol):real;
	var
		cant:integer;
	begin
		cant:= cantidadSocios(a);
		total:=0;
		sumaEdades:= edadTotal(a,total);
		if(cant>0)then
			edadProm:= sumaEdades/cant
		else
			edadProm:=0;
	end;

var
	prom:real;
begin
	prom:= edadPromedio(a);
	writeln('Promedio de edad de los socios: ', prom:2:2);

end;






//------------------------------PROGRAMA PRINCIPAL---------------
var
	a:arbol;
	nombre:str30;
begin
	a:=NIL;	
	cargarArbol(a);
	informarCreciente(a);
	writeln('Cantidad de socios impares: ', informarMayorEdad(a));
	writeln('Ingrese un nombre');readln(nombre);
	writeln('Existe el nombre:  ', busquedaNombre(a,nombre));
	writeln('La cantidad de socios es: ', cantidadSocios(a)
end.
