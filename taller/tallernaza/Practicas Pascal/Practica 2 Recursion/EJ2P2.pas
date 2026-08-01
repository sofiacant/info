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


program Practica1E2;
type
	lista =^nodo;
	nodo = record
		dato:integer;
		sig:lista;
	end;

{PROCESOS---------------------------------------------------------------}
procedure agregarLista(var l:lista; dato: integer);
var
	aux, act : lista;
begin
	new(aux);
    aux^.dato := dato;
    aux^.sig := nil;
    if (l <> nil) then begin
		act:=l;
        while (act^.sig <> nil) do
			act:=act^.sig;
            act^.sig:=aux;
    end
    else
		l:=aux;
end;


procedure CargarLista(var l:lista);
var
	num:integer;
begin
	num:=100 + random(200-100+1);
	if(num <> 100) then begin
		agregarLista(l,num);
		CargarLista(l);
	end;
end;

procedure ImprimirLista(l:lista);
begin
	if(l <> nil) then begin
		writeln('Num: ',l^.dato ,' | ');
		ImprimirLista(l^.sig);
	end;
end;

procedure ImprimirListaInversa(l:lista);
begin
	if(l <> nil) then begin
		ImprimirListaInversa(l^.sig);
		writeln('Num: ',l^.dato,' | ' );
	end;
end;

procedure DevolverMinimo(l:lista; var min:integer);
begin
	if(l<> nil) then begin
		if(l^.dato < min) then 
			min:=l^.dato;
		    DevolverMinimo(l^.sig,min);
	end;
end;
function mismoV(l:lista;valor:integer):boolean;
begin
  if(l<>nil) then begin
    if(l^.dato =valor) then
      mismoV:= true
    else mismoV:=mismoV(l^.sig,valor);
  end
   else
     mismoV:=false;
   
end;
{PROGRAMA PRINCIPAL-----------------------------------------------------}

var 
	l:lista;
	min,valor:integer; 
	encontre:boolean;
BEGIN
	l:=nil;
	Randomize;
	CargarLista(l);{PUNTO A}
	ImprimirLista(l);{PUNTO B}
	writeln('');
	writeln('Lista inversa :');
	ImprimirListaInversa(l);{PUNTO C}
	
	min:=9999;
	DevolverMinimo(l,min);{PUNTO D}
	writeln('Num minimo de la lista: ',min);
	
	{FALTA PUNTO  PORQUE DEBERIA SER UNA FUNCION}
	valor:=100 + random(200-100+1); //min + random (max - min + 1);
	encontre:=mismoV(l,valor);
	if(encontre) then 
	   writeln('esta en la lista') 
	else writeln('no esta en la lista');
END.

