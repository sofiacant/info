program netflix;
const
dimF=8;
type
ran1=1..8;
pelicula=record
  codP:integer;
  codG:ran1;
  puntaje:real;
  end;
  
lista=^nodo;
nodo=record
 dato:pelicula;
 sig:lista;
 end;  
punteros=record
pri,ult:lista;
end;
 
vecpelis=array[ran1] of punteros;

//------------------------------------

procedure leer(var a:pelicula);
begin
write('ingrese codigo pelicula ');
read(a.codP);
if(a.codP<>-1) then begin
  write('ingrese codigo de genero ');
  read(a.codG);
  write('ingrese puntaje de la pelicula ');
  read(a.puntaje);
end;
end;
//-----------------------------------

procedure inivec(var v:vecpelis);
var i:integer;
begin
 for i:= 1 to dimF do begin
   v[i].pri:=nil;
   v[i].ult:=nil;
 end;

end;
//-----------------------------------

procedure agregaratras(var l:lista;var ult:lista; a:pelicula);
var
nue:lista;
begin
new (nue);
nue^.dato:=a;
nue^.sig:=nil;

if(l=nil) then
  l:=nue
  else
  ult^.sig:=nue;  
ult:=nue;

end;
//-----------------------------------

procedure cargarvec(var v:vecpelis);
var
a:pelicula;
begin
  
  leer(a);
  while (a.codP<>-1) do begin
    agregaratras(v[a.codG].pri,v[a.codG].ult , a );
    leer(a);
  end;

end;

//-----------------------------------------------------------------
var 
v:vecpelis; i:integer;
BEGIN
inivec(v);
cargarvec(v);	
//todo bien por ahora

for i:= 1 to dimF do begin
  while(v[i].pri<>nil) do begin
    writeln(v[i].pri^.dato.codP );
    v[i].pri:=v[i].pri^.sig;
  end;
  end;
END.

