{parcial  
   polizas emitidas de 2000 a 2023
}


program untitled;
type
 fecha=record
  dia:1..31;
  mes:1..12;
  anio:2000..2023;
 end;
 poliza=record
   Dni:integer;
   sumaAsegurada:real;
   valorCuota:real;
   fechaV:fecha;
 end;

arbol=^nodoa;
nodoa=record
  datos:poliza;
  HI:arbol;
  HD:arbol;
end;
lista=^nodo;
nodo=record
 dato:poliza;
 sig:lista;
end;
veclista=array[2000..2023] of lista;

procedure leerF(var f:fecha);
begin
f.dia:=random(31)+1;
f.mes:=random(12)+1;
f.anio:=random(24)+2000;
end;

procedure leer(var x:poliza);
begin

x.Dni:=random(100)-1;
if(x.Dni<>-1) then begin
  x.sumaAsegurada:=random(1000);
  x.valorCuota:=random(100);
  leerF(x.fechaV);
end;
end;

procedure insertarA(var a:arbol; x:poliza);
begin
 if(a=nil) then begin
   new(a);
   a^.datos:=x;
   a^.HI:=nil;
   a^.HD:=nil;
 end
 else begin
   if(a^.datos.sumaAsegurada > x.sumaAsegurada  ) then
     insertarA(a^.HI,x)
   else insertarA(a^.HD,x);
 end;
end;

procedure puntoA(var a:arbol);
var
  x:poliza;
begin
 a:=nil;
 randomize;
 leer(x);
 while(x.Dni<>-1) do begin
   insertarA(a,x);
   leer(x);
end;
end;

procedure inivl(var vl:veclista);
var i:integer;
begin
  for i:= 2000 to 2023 do begin
    vl[i]:=nil;
  end;
end;

procedure insertarOrdenado(var l:lista; x:poliza );
var
 nue,ant,act:lista;
begin
 new(nue);
 nue^.dato:=x;
 act:=l;
 while(act<>nil) and (act^.dato.dni< x.Dni) do begin
   ant:=act;
   act:=act^.sig;
 end;
 if(act =l) then
    l:=nue
 else
   ant^.sig:=nue;
 nue^.sig:=act;
end;
procedure puntoB(var vl:veclista ; a:arbol; valor:real);
begin
   if(a<> nil) then begin
     if(a^.datos.sumaAsegurada < valor) then begin
        insertarOrdenado(vl[a^.datos.fechaV.anio],a^.datos);
        puntoB(vl,a^.HI,valor);
        PuntoB(vl,a^.HD,valor);
        end
     else 
       puntoB(vl,a^.HD,valor)
  end;
   
end;
 
procedure recorrerlista(l:lista; dniBC:integer; var cantC:integer);
begin
  while (l<>nil) and (l^.dato.Dni <= dniBC)do  begin
    if (l^.dato.Dni= dniBC) then
      cantC:=cantC+1;
    l:=l^.sig;
  end;
end;
procedure puntoC (vl:veclista;dniBC:integer;var cantC:integer);
var i:integer;
begin
  for i:= 2000 to 2023 do begin
    recorrerlista(vl[i],dniBC,cantC);
    
  end;
end;
 
//----------------PP-----------
var
 a:arbol;
 vl:veclista; valor:real;
 i,dniBC,cantC:integer;
BEGIN
    Randomize;
	puntoA(a);
	if(a<>nil) then
	  writeln('Arbol creadoo');
	inivl(vl);
	valor:=random(10000)+1;
	puntoB(vl,a,valor);
	
	for i:=2000 to 2023 do begin
	  if(vl[i]<> nil ) then
	    writeln('lista creada ', i)
	  else writeln('lista no creada ',i);
	  end;
	dniBC:=random(100); 
	cantC:=0; 
    puntoC(vl,dniBC,cantC);
    if(cantC<> 0) then
       writeln('el Dni tenia tantas polizas :) := ', cantC)
    else writeln('el dni no tenia ninguna poliza :c ');
END.

