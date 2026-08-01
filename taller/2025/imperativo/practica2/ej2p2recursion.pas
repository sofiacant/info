{2.- Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}

program ejercicio2recursion;
Const
	min=100;
	max=200;
	num_fin=100;
Type
	
	lista=^nodo;
	nodo= record
		dato:integer;
		sig:lista;
	end;

procedure agregarAdelante(var l:lista; num:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=num;
	nue^.sig:=l; 
	l:=nue;
end;

procedure cargarLista(var l:lista);
var
	num:integer;
begin
	num:= min + random(max-min+1);
	if(num<> num_fin)then begin
		agregarAdelante(l,num);
		cargarLista(l);
	end;
end;

procedure imprimirLista(l:lista);
begin
	if(l<>nil)then begin
		writeln(l^.dato);
		imprimirLista(l^.sig);
	end;
end;

procedure imprimirListaAlReves(l:lista);
begin
	if(l<>nil)then begin	
		imprimirLista(l^.sig);
		writeln(l^.dato);
	end;
end;


function minimoLista(l:lista):integer;
var
	min:integer;
begin
	if(l=nil)then 
			minimoLista:=9999
	else begin
		min:= minimoLista(l^.sig);
		if(l^.dato< min)then 
			minimoLista:=l^.dato
		else
				minimoLista:=min;
	end;
end;

function busquedaValor(l:lista; num:integer):boolean;
begin
	if(l<>nil)then begin
		if(l^.dato=num)then
			busquedaValor:=true
		else
			busquedaValor(l^.sig,num);
	end
	else
		busquedaValor:=false;
end; 


var
	l:lista;
begin
	l:=nil;
	randomize;
	cargarLista(l);
	imprimirlista(l);
	
	writeln('El minimo de la lista es:  ', minimoLista(l)); 
	writeln('El valor se encuentra en la lista: ',busquedaValor(l,30);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

end.
