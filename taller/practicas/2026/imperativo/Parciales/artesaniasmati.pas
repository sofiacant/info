program parcial;
type
	artesania = record
		id :integer;
		dni:integer;
		materialBase:integer;
	end;
	
	regArbol = record
		dni:integer;
		cantArtesanias:integer; // inicializar en 0
	end;
	arbol = ^nodo;
	nodo = record
		dato:regArbol;
		HI,HD:arbol;
	end;
	
	regVector = record
		codMaterialBase:integer;
		cantArtesanias:integer;	
	end;
	
	vCont = array [1..8]of regVector;
	
	vNombres = array [1..8] of string;
const
	vn : vNombres = ('madera', 'yeso','ceramica','vidrio','acero','porcela','lana','carton');	
	
//MODULOS

procedure inOrden(a:arbol);
begin
	if(a <> nil) then begin
		inOrden(a^.HI);
		writeln(a^.dato.DNI, ' ', a^.dato.cantArtesanias);
		inOrden(a^.HD);
	end;
end;

procedure inicializarVector(var v:vCont);
var
	i:integer;
	reg: regVector;
begin
	for i:= 1 to 8 do begin
		reg.codMaterialBase:= i;
		reg.cantArtesanias:= 0;
		v[i]:= reg;
	end;
end;

procedure leer(var art:artesania);
begin
	art.dni:= random(15);
	if(art.dni<> 0) then begin
		art.id:= random(20)+1;
		art.materialBase:= random(8)+1;
	end;
end;

procedure agregarNodo(var a:arbol; art:artesania);
begin
	if(a = nil)then begin
		new(a);
		a^.dato.dni:= art.dni;
		a^.dato.cantArtesanias:= 1;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else if(a^.dato.dni = art.dni)then
		a^.dato.cantArtesanias:= a^.dato.cantArtesanias + 1
	else if(a^.dato.dni < art.dni)then
		agregarNodo(a^.HD, art)
	else
		agregarNodo(a^.HI,art);
end;

procedure cargarArbol(var a:arbol; var v:vCont);
var
	art:artesania;
begin
	leer(art);
	while(art.dni <> 0)do begin
		agregarNodo(a,art);
		v[art.materialBase].cantArtesanias:= v[art.materialBase].cantArtesanias + 1;
		leer(art);
	end;

end;

function contarDni(a:arbol;dniAux:integer):integer; //10(7,11) 7(nil,nil) 11(nil,nil)dniAux = 11;
begin
	if(a = nil)then 
		contarDni:= 0
	else begin
		if(a^.dato.dni < dniAux)then
			contarDni:= 1 + contarDni(a^.HI,dniAux) + contarDni(a^.HD,dniAux)
		else
			contarDni:= 0 + contarDni(a^.HI,dniAux);
	end;
end;

procedure guardarNombre(v:vCont; var nom:string);
begin
	nom:= vn[v[8].codMaterialBase];
end;

procedure actualizarVector(var v:Vcont; var nom:string);
var
	i,j,pos:integer;
	item:regVector;
begin
	for i:= 1 to 7 do begin
		pos:= i;
		for j:= i+1 to 8 do begin
			if(v[j].cantArtesanias < v[pos].cantArtesanias) then
				pos:= j;
		end;
		item:= v[pos];
		v[pos]:= v[i];
		v[i]:= item;
	end;
	guardarNombre(v,nom);
end;

procedure informarV(v:vCont);
var
	i:integer;
begin
	for i:= 1 to 8 do 
		write(v[i].cantArtesanias,'(',v[i].codMaterialBase,')', ' ');
end;

var
	a:arbol;
	v:vCont;
	dniAux,cantDni:integer; //leer para el inciso B
	nom:string;
begin
	a:=nil;
	inicializarVector(v);
	cargarArbol(a,v);
	inOrden(a);
	//iniciso B
	read(dniAux); //en lo posible menor que 15
	cantDni:= contarDni(a,dniAux);
	writeln('la cantidad de dni de artesanos menores que el dni ', dniAux, ' fue ',cantDni);
	actualizarVector(v,nom);
	informarV(v);
	writeln(nom);
	
end.
	
	
	
	
	
	
	
	
	
	
	
