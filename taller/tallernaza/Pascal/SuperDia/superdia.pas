{se lee informacion de las compras realizadas por los clientes a un supermercado en el año 2022. De cada compra se lee
el codigo de cliente, número de mes y monto gastado. La lectura finaliza cuando se lee el cliente con codigo 0.
  a) Realizar un módulo que lea la informacion de las compras y retorne una estructura de datos eficiente para la busqueda
  por codigo de cliente. para cada cliente, esta estructura debe acumular el monto total gastado para cada mes del año 2022.
  se sugiere usar el modulo leercompra();
  b) Realizar un modulo que reciba la estructura generada en a) y un cliente, y retorne el mes con mayor gasto de dicho cliente.
  c) Realizar un modulo que reciba la estructura generada en a) y un número de mes, y retorne la cantidad de clientes 
  que no gastaron nada en dicho mes.
NOTA implementar el programa principal, que invoque los incisos a,b,c.  
   
   
}


program comprasDia;
const dimF=12;

type
sub_mes=1..12;
compra=record
  monto:real;
  cliente:integer;
  mes:sub_mes;
end;

vector=array [sub_mes] of real;

cli=record
  cliente:integer;
  v:vector;
end;

arbol=^nodoa;
nodoa=record
datos:cli;
HI:arbol;
HD:arbol;
end;
//----------------------------------------------
procedure leer(var c:compra);
begin
c.cliente:=random(100);
if (c.cliente<>0) then begin
  c.monto:=random(20000) / (random(10)+1);
  c.mes:=random(12)+1;
end;
end;
//----------------------------------------------
procedure inivec(var v:vector);
var i:integer;
begin
for i:= 1 to dimF do
  v[i]:=0;
end;
//----------------------------------------------
procedure agregar(var a:arbol;c:compra);

begin
 if(a=nil) then begin
   new(a);
   a^.datos.cliente:=c.cliente;
   inivec(a^.datos.v);
   a^.datos.v[c.mes]:= a^.datos.v[c.mes]+c.monto;
   a^.HI:=nil;
   a^.HD:=nil;
 end
 else 
   if(a^.datos.cliente=c.cliente) then 
      a^.datos.v[c.mes]:= a^.datos.v[c.mes]+c.monto
   else 
      if(a^.datos.cliente>c.cliente) then
          agregar(a^.HI,c)
      else agregar(a^.HD,c);

end;
//----------------------------------------------
procedure crearabb(var a:arbol);
var c:compra;
begin
leer(c);
while (c.cliente<>0) do begin
  agregar(a,c);
  leer(c);
end;
end;
//----------------------------------------------
function max(v:vector):integer;
var i,maximodia:integer; maximomonto:real;
begin
  maximomonto:=0;
  for i:=1 to dimF do begin
     if(v[i]>maximomonto) then begin
       maximomonto:=v[i];
       maximodia:=i;
     end;
  
  end;
  max:=maximodia;
end;
//----------------------------------------------
procedure puntoB(a:arbol;cb:integer; var mmax:integer);

begin 
  if (a<>nil) then begin
    puntoB(a^.HI,cb,mmax);
    if(a^.datos.cliente= cb) then 
      mmax:=max(a^.datos.v);
    puntoB(a^.HD,cb,mmax);
  end;

end;
//----------------------------------------------
procedure puntoC(a:arbol; mesC:integer; var cantC:integer);
begin
  if(a<>nil) then begin
    puntoC(a^.HI,mesC,cantC);
    if(a^.datos.v[mesC]=0) then 
      cantC:=cantC+1;
    puntoC(a^.HD,mesC,cantC);  
  
  end;
end;
//----------------------------------------------
{function puntoCF(a:arbol; mesC:integer):integer;
var cant:integer;
begin
  cant:=0;
  if (a=nil) then
    puntoCF:=0
  else begin
    if(a<>nil) then
      if(a^.datos.v[mesC]=0) then 
        cant:=cant+1;
    puntoCF:=cant + puntoCF(a^.HI,mesC) + puntoCF(a^.HD,mesC);
  end;
end;}

function puntoCF(a:arbol; mesC:integer):integer;
begin
  if (a=nil) then
    puntoCF:=0
  else begin
    if(a<>nil) then
      if(a^.datos.v[mesC]=0) then 
         puntoCF:=1 + puntoCF(a^.HI,mesC) + puntoCF(a^.HD,mesC)
      else puntoCF:= puntoCF(a^.HI,mesC) + puntoCF(a^.HD,mesC);
  end;
end;
//----------------------------------------------
procedure enorden(a:arbol);
var i:integer;
begin
 if (a<>nil) then begin
 enorden(a^.HI);
 writeln('cli ',a^.datos.cliente,'| ');
 for i:=1 to dimF do
   writeln('pos ',i,' ',a^.datos.v[i]:2:0,'| ');
   writeln(' '); 
 enorden(a^.HD);  
end;
end;
//----------------------------------------------
//----------------------------------------------
//----------------------------------------------
var 
a:arbol; cb,mmax,cantC,mesC,cF:integer;
BEGIN
	a:=nil;
	crearabb(a);
	writeln (a^.datos.cliente,' | ', a^.datos.v[1]:2:0);
	cb:=random(100)+1;
	mmax:=0;
	puntoB(a,cB,mmax);
	if (mmax<>0) then
	  writeln('mes con mayor gasto del cliente ',cB,' fue de  ', mmax)
	  else writeln(' no se encontraba el cliente a buscar');
	writeln(' ');
	mesC:=random(12)+1;
	cantC:=0;
	puntoC(a,mesC, cantC);
	writeln('CantC:= ',cantc);
	cF:=puntoCF(a,mesC);
	writeln ('resultado de la funcion : ',cF);
	//enorden(a);
	
	write ('FIN');
END.

