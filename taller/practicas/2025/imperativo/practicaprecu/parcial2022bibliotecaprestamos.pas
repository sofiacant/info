La biblioteca del barrio desea procesar la información de los préstamos. De cada préstamo conoce el código de socio (entre 1 y 5000), el código de libro (entre 1 y 30000) y el mes del préstamo.
a) Realizar un módulo que lea la información de los préstamos y retorna una estructura eficiente para la búsqueda
por código de socio. La lectura finaliza al ingresar un préstamo con el código del libro 0. Se sugiere utilizar el
módulo leerRegistro ().
b) Realizar un módulo que reciba la estructura del inciso a) y un código de socio X, y retorne una nueva estructura
agrupada por mes con todos los préstamos realizados a socios cuyo código sea mayor a X.
c) Realizar un módulo recursivo que reciba la estructura generada en el inciso b) y un mes, y retorne la cantidad de
préstamos de dicho mes.

program bibliotecabarrio;
Const
	max_socio=5000;
	max_libro=30000;
	meses=12;
Type
	rango_socios= 1..max_socio;
	rango_libros=1..max_libro;
	rango_meses: 1..meses;
	
	prestamo=record
		codsocio: rango_socios;
		codlibro:rango_libros;
		mes:rango_meses;
	end;
	
	arbol=^nodoArbol
	nodoArbol=record
		
