{
   Un supermercado quiere llevar un registro de todas sus ventas, de cada venta se lee el codigo, dni del cliente, 
   suscursal en la que compró (1..5) y monto gastado, la lectura se detiene con el código de venta 0, se pide:

   A- crear una estructura eficiente para la busqueda por dni de cliente, de cada cliente se guarda el monto gastado en cada sucursal

   B-un módulo que reciba la estructura generada en A y un número de sucursal y 
    retorne la cantidad de clientes que no gastaron nada en la sucursal

   C-un modulo que reciba la estructura generara en A y un dni y retorne el monto total general gastado por dicho dni 
     (es decir, la suma de los montos de todas las sucursales)


   
   
}


program ParcialRedictadoSupermercados;
const
  dimF=5;
type

rangov= 1..dimF;

venta=record
  codigo:integer;
  dniCliente:integer;
  sucursal:rangov;
  monto:real;
end;

vecgastos=array[rangov] of real;

reg1=record
 dniCliente:integer;
 v:vecGastos;
 end;
 
 arbol=^nodoa;
 nodoA=record
   datos:reg1;
   HI:arbol;
   HD:arbol;
 end;
 



procedure cargoV(var v:vecGastos);
var i:integer;
begin
  for i:= 1 to dimF do
    v[i]:=0;
end;

procedure leer(var x:venta);
begin
  x.codigo:=random(100);
  if(x.codigo<>0) then begin
    x.dniCliente:=random(10);
    x.sucursal:=random(5)+1;
    x.monto:=random(100000);
  end;
end;
 
procedure agregarA(var a:arbol;  x:venta);
begin
if (a=nil) then begin
  new(a);
  a^.datos.dniCliente:=x.dniCliente;
  cargov(a^.datos.v);
  a^.datos.v[x.sucursal]:=x.monto;
  a^.HI:=nil;
  a^.HD:=nil;
  //writeln(1);
end
else begin
  if(a^.datos.dniCliente = x.dniCliente) then begin
     a^.datos.v[x.sucursal]:= a^.datos.v[x.sucursal] + x.monto;
    // writeln(2);
  end
  else begin
     if(a^.datos.dniCliente > x.dniCliente) then begin
       // writeln(3);
        agregarA(a^.HI,x);
     end
     else begin
        //writeln(4);
        agregarA(a^.HD,x);  
     end;
  end; 
end;
end;

procedure puntoA(var a:arbol);
var
 x:venta; 
 begin 
 leer(x);
 while(x.codigo<>0) do begin
   agregarA(a,x);
   leer(x);
 end;

end;

procedure puntoB(a:arbol;sucB:rangov; var cantB:integer);
begin
  if (a<>nil) then begin
    puntoB(a^.HI,sucB,cantB);
    if(a^.datos.v[sucB] = 0) then
      cantB:=cantB+1;
    puntoB(a^.HD,sucB,cantB)
  
  end;

end;

function sumador(v:vecGastos):real;
var i:integer; tot:real;
begin
  tot:=0;
  for i:=1 to dimF do begin
     //writeln('pos',i, ' ', v[i]:2:2);
     tot:=tot + v[i];
     end;
  sumador := tot;
end;

function PuntoC(a:arbol;dniC:integer):real;
begin
  if(a=nil) then 
    puntoC:=0
  else begin
    if(a^.datos.dniCliente=dniC) then 
       puntoC:=sumador(a^.datos.v)
    else 
      if(a^.datos.dniCliente<dniC) then begin
         puntoC:=PuntoC(a^.HI,dniC);
         puntoC:=PuntoC(a^.HD,dniC);
      end
      else 
        puntoC:=PuntoC(a^.HD,dniC);
  end;
end;
    

procedure enorden(a:arbol);
var i:integer;
begin
if(a<>nil) then begin
  enorden(a^.HI);
  writeln('dni:= ', a^.datos.dniCliente,' | vector :');
  for i:= 1 to dimF do
    writeln('gasto := ',a^.datos.v[i]:2:2);
  writeln();
  enorden(a^.HD);
  
  end;
end;
//----------------PP------
var a:arbol;
sucB:rangov; cantB,dniC:integer; montoC:real;
BEGIN
	Randomize;
	a:=nil;
	PuntoA(a);
	if(a<>nil) then
	  writeln('Arbol creadoo');
	  
	writeln('punto B ');
	sucB:=random(5)+1; 
	cantB:=0; 
	puntoB(a,sucB,cantB);
	writeln ('cantB = ', cantB);
	writeln('----------------->');
	enorden(a);
	writeln('----------------->');
	writeln('punto c ');
	dniC:=random(10);
	writeln('dniC:= ',dniC);
	montoC:=puntoC(a,dniC);
	if (montoC=0.00 ) then
	   writeln(' No se encontraba ese cliente ')
	else 
	  writeln('el total gastado es:= ', montoC:4:2);
	writeln('----------------->');
END.

