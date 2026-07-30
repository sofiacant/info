2. Una agencia dedicada a la venta de autos ha organizado su stock y, tiene la información de los autos en venta. Implementar un programa que: 
a) Genere la información de los autos (patente, año de fabricación (2015..2024), marca, color y modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos: 
i. Una estructura eficiente para la búsqueda por patente.
 ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben almacenar juntas las patentes y colores de los autos pertenecientes a ella.
 b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la cantidad de autos de dicha marca que posee la agencia. 
  c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne la cantidad de autos de dicha marca que posee la agencia.  
  d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con la información de los autos agrupados por año de fabricación. 
  e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el modelo del auto con dicha patente. 
    f) Invoque a unmódulo que reciba el árbol generado en a) ii y una patente y devuelva el color del auto con dicha patente.  
    
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
	
	regMarca=record
		

	
var
	a:arbol;
begin
	a:=nil;
	cargarArbol(a);
end.
