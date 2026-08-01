{
  3. Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el código de producto con mayor cantidad de unidades vendidas.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
valores recibidos (sin incluir) como parámetros.
   
}


program EJ3P4;
type
 venta=record
   codigoVenta:integer;
   codigoProducto:integer;
   cantidad:integer;
   precioUnitario:real;
 end;
 producto=record
   codigo:integer;
   cantVendida:integer;
   monto:real;
   end;

arbol=^nodoA;
nodoA=record
 datos:producto;
 HI:arbol;
 HD:arbol;
 end;

 
 //------------PROCESOS ----------------
 {De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario.}
procedure leer(var x:venta);
begin 
x.codigoVenta:=random(50)-1;
if(x.codigoVenta<>-1) then begin
  x.codigoProducto:=random(100);
   x.cantidad:=random(100)+1;
   x.precioUnitario:=random(100000);
   end;
end;

procedure asignarProducto(var x1:producto; x:venta);
begin
   x1.codigo:= x.codigoProducto;
   x1.cantVendida:=  x.cantidad;
   x1.monto:= (x.precioUnitario*x.cantidad);
end;
procedure insertarArbol(var a:arbol ; x1: producto);
begin
  if(a=nil) then begin
    new(a);
    a^.datos:=x1;
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else begin
    if(a^.datos.codigo > x1.codigo) then 
       insertarArbol(a^.HI,x1) 
    else insertarArbol(a^.HD,x1);
  end;
end;
{ordenado por código de producto}
procedure cargarA(var a:arbol);
var x:venta; x1:producto;

begin
  a:=nil;
  Randomize;
  leer(x);
  while(x.codigoVenta<>-1) do begin
     asignarProducto(x1,x);
     insertarArbol(a,x1);
     leer(x);
  end;
  
end;
 
 
 procedure ImprimirEnOrden(a:arbol);
 begin
  if(a<>nil) then begin
    ImprimirEnOrden(a^.HI);
    writeln(a^.datos.codigo,' |  ',a^.datos.cantVendida,' | ', a^.datos.monto:2:2);
    ImprimirEnOrden(a^.HD);
 end;
 end;
 
procedure buscarcodMax(a:arbol;var codmax:integer;var unidadesmax:integer);
 begin 
   if(a<>nil) then begin
     buscarcodMax(a^.HI,codmax,unidadesmax);
     if(a^.datos.cantVendida>unidadesmax  ) then begin
       unidadesmax:=a^.datos.cantVendida;
       codmax:=a^.datos.codigo;
     end;
     buscarcodMax(a^.HD,codmax,unidadesmax);
   end;
end;

procedure puntoC(a:arbol);
var
 codmax,unidadesmax:integer;
begin 
   codmax:=-1;
   unidadesmax:=-9999;
   buscarcodMax(a,codmax,unidadesmax);
   
   writeln('El codigo con mas unidades vendidas es:= ',codmax);
end;

function cantidad(a:arbol;codD:integer):integer;
begin
 if(a=nil) then 
   cantidad:=0
 else begin
   if (a^.datos.codigo < codD) then 
      cantidad:= 1 + cantidad(a^.HI,codD) + cantidad(a^.HD, codD)
   else 
     cantidad:=cantidad(a^.HI,codD) ;
  end; 
end;
procedure puntoD(a:arbol);
var
 cantD,codD:integer;
 begin 
   cantD:=0;
   codD:=random(100);
   cantD:=cantidad(a,codD);
   
   writeln('Lacantidad total de codigos que son menores a ',codD , ' es:= ',cantD);
 end;
 
 
procedure puntoE(a:arbol);
  procedure recorridoAcotado (a: arbol; inf, sup: integer;var contar:real);
  begin
  if (a <> nil) then begin
    if (a^.datos.codigo > inf) then begin
      if (a^.datos.codigo < sup) then begin
        contar:=contar + a^.datos.monto ;
        recorridoAcotado(a^.HI, inf, sup,contar);
        recorridoAcotado(a^.HD, inf, sup,contar);
      end
      else 
        recorridoAcotado(a^.HI, inf, sup,contar);
    end
    else 
      recorridoAcotado(a^.HD, inf, sup,contar);
    end;
  end;

var
codigo1,codigo2:integer; contar:real;
begin
writeln;
  contar:=0;
  writeln ('----- Modulo 3P4 ----->');
  writeln;
  writeln('Ingrese Num  1');
  readln(codigo1);
  writeln('Ingrese Num 2 mayor a Num 1');
  readln(codigo2);
  recorridoAcotado(a,codigo1,codigo2,contar);
  writeln('La cantidad total es:= ', contar:4:2);
end;
//-----------PROGRAMA PRINCIPAL---------
VAR
a:arbol;
BEGIN
	cargarA(a);
	ImprimirEnOrden(a);
	puntoC(a);
	puntoD(a);
	puntoE(a);
END.

