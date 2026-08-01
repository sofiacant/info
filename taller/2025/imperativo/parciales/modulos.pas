------------------------------PRACTICA MODULOS------------------- 

function Busqueda desordenada(l:lista; valor:integer):boolean;
var
	ok:boolean;
begin
	ok:=false;
	while(l<> nil)and (ok=false )do begin
		if(    l^.dato.valor = valor)then
			ok:=true
		else
			l:=l^.sig;
	end;
	busquedaDesordenada(ok);
end;


function busquedaOrdenada(l:lista; valor:integer):boolean;
var
	ok:boolean;
begin
	ok:=false;
	while(l<>nil)and (l^.dato.valor <valor)do    {o > en lista descendente}
			l:=l^.sig;
	if(l<>nil)and l^.dato.valor=valor) then
		ok:=true;
	busquedaOrdenada:= ok; 
end;



-------------------------------------------------------ELIMINAR---------------------------------------
procedure eliminar(var l:lista; valor:integer );
var
	act,ant:lista;
begin
	act:=l;
	while(act<>nil)and(act^.dato<>valor)do begin            //mientras actual sea <> de nil y el dato que busco sea distinto
		ant:=act;  																				//ant=act
		act:=act^.sig;																		//avanzo con act
	end;
	if (act<> nil)then begin							si actual no es nil
		if(act=l)then 												si estoy en el primero
		  l:=l^.sig																l es el siguiente
	    else																SI PUDE AVANZAR
			ant^.sig:= act^.sig;											CONECTO EL ANTERIOR CON EL Q LE SIGUE A ACTUAL
		dispose(act);											BORRO EL ACTUAL
	end;
end;


----------------------------------------------eliminar repetido
procedure eliminar(var l:lista; valor:integer );
var
	act,ant:lista;
begin
	act:=l;
	while(act<>nil) do beign
		if(l^.dato.valor <> valor)then begin
			ant:= act;
			act:= act^.sig;
		end
		
		else begin
		
			if(act=l)then begin
			
				l:=l^.sig;
				ant:=l;
			end
			
			else
				ant^.sig:=act^.sig
			dispose(act);
			act:= ant;
		end;
	end;
end;

---------------------------------------------------
procedure agregarAtras(var l,ult:lista; valor:integer);
var
	nue;
begin
	new(nue);
	nue^.dato:=valor;
	nue^.sig:=nil;
	if(l= nil)then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end; 

------------------------


procedure insertarOrdenad(var l:lista; valor:integer;)
var
	nue,ant,act:lista;
begin
	new(nue);
	nue^.dato:=valor;
	act:=l;
	ant.=l;
	while(l<> nil)and (l^.dato.valor < valor)do begin
		ant:=act;
		act:=act^.sig;
	end
	 if(ant=act)then
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;


   ----------------------ORDENAR VECTOR------------------
   SELECCION 
   
   procedure seleccion(var v:vector; diml:integer);
   var
		item:reg;
		i,j;integer;
	begin
		 















