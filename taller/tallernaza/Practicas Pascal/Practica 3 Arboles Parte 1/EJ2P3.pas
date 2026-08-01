{2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado
por código de producto. Cada nodo del árbol debe contener el código de producto y la
lista de las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.
d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
con mayor cantidad de ventas.
  
}


program EJ2P3;

type
  fecha=record
    dia:1..31;
    mes:1..12;
    anio:integer;
    end;
    
  venta=record
    producto:integer;
    f:fecha;
    cantVendida:integer;
    end;
    
  ventatot=record
    producto:integer;
    cantVendida:integer;
    end;
    
  arbol=^nodoa;
  nodoa=record
    datos:venta;
    HI:arbol;
    HD:arbol;
    end;
    
   arbol2=^nodoa2;
  nodoa2=record
    datos:ventatot;
    HI:arbol2;
    HD:arbol2;
    end;
  //PUNTO 3  
   lis_ventas=record
     f:fecha;
     cantVendida:integer;
   end; 
   
  lista=^nodo;
  nodo=record
   dato:lis_ventas;
   sig:lista;
   end;
  regLista=record
   producto:integer;
   l:lista;
  end;  
  arbol3=^nodo3;
  nodo3=record
    datos:reglista;
    HI:arbol3;
    HD:arbol3;
    end;  
//---------------PROCESOS-------
procedure leerF(var f:fecha);
begin
  f.dia:=random(31)+1;
  f.mes:=random(12)+1;
  f.anio:=random(25)+2000;
end;
procedure leer(var x:venta);
begin
  x.producto:=random(101);
  if (x.producto<>0) then begin
    leerF(x.f);
    x.cantVendida:=random(100)+1;
  end;
end;
//-----------------Arbol 1--------------
procedure insertarArbol (var a:arbol;x:venta);

begin
  if(a=nil) then begin
    new(a);
    a^.datos:=x;
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else  begin
    if(a^.datos.producto>x.producto) then
       insertarArbol(a^.HI,x)
    else insertarArbol(a^.HD,x);
  end;
end;

//-----------------Arbol 2--------------
procedure insertarArbol2(var a2:arbol2;x:venta);
begin
  if(a2=nil) then begin
    new(a2);
    a2^.datos.producto:=x.producto;
    a2^.datos.cantVendida:=x.cantVendida;
    a2^.HI:=nil;
    a2^.HD:=nil;
  end
  else  begin 
    if(a2^.datos.producto=x.producto) then
       a2^.datos.cantVendida:=a2^.datos.cantVendida + x.cantVendida
    
    else 
      if (a2^.datos.producto>x.producto) then
         insertarArbol2(a2^.HI,x)
      else 
        insertarArbol2(a2^.HD,x);
    
  end;
end;

//-----------------Arbol 3--------------
procedure agregaratras(var l:lista;x:venta);
var 
nue:lista; xx:lis_ventas;
begin
  xx.f:=x.f;
  xx.cantVendida:=x.cantVendida;
  new(nue);
  nue^.dato:= xx;
  nue^.sig:=l;
  l:=nue;
end;
procedure insertarArbol3(var a3:arbol3;x:venta);

begin
  if(a3=nil) then begin
    new(a3);
    a3^.datos.producto:=x.producto;
    a3^.datos.l:=nil;
    agregaratras(a3^.datos.l,x);
  end
  else begin
    if(a3^.datos.producto= x.producto) then
       agregaratras(a3^.datos.l,x)
    else
      if(a3^.datos.producto > x.producto) then
         insertarArbol3(a3^.HI,x)
      else insertarArbol3(a3^.HD,x);
  end;
end;
procedure crearArboles (var a:arbol; var a2:arbol2; var a3:arbol3);
var
x:venta;
begin
  Randomize;
  a:=nil;
  a2:=nil;
  a3:=nil;
  leer(x);
  while(x.producto<>0) do begin
    insertarArbol (a,x);
    insertarArbol2(a2,x);
    insertarArbol3(a3,x);
    leer(x);
  end;
end;


procedure imprimirInOrden (a: arbol);
begin

  if (a <> nil) then begin

    imprimirInOrden(a^.HI);

    writeln (a^.datos.producto, '  =prod  ');
    writeln (a^.datos.f.dia,' dia |',a^.datos.f.mes,' mes |',a^.datos.f.anio,' anio ');
    writeln (a^.datos.cantVendida, ' cantidad vendida ');
    imprimirInOrden(a^.HD);

  end;

end;

procedure imprimirInOrden2 (a2: arbol2);

begin

  if (a2 <> nil) then begin

    imprimirInOrden2(a2^.HI);

    writeln (a2^.datos.producto, '  prod  | ',a2^.datos.cantVendida,' Cant total vendida');
    
    imprimirInOrden2(a2^.HD);

  end;

end;


procedure imprimirlista(l:lista);
begin
  while (l<>nil) do begin
    writeln('cant vendida  ',l^.dato.cantVendida);
    writeln(l^.dato.f.dia,' dia |',l^.dato.f.mes,' mes |',l^.dato.f.anio,' anio ');
    l:=l^.sig;
    end;
end;
procedure imprimirInOrden3 (a3: arbol3);

begin

  if (a3 <> nil) then begin

    imprimirInOrden3(a3^.HI);

    writeln (a3^.datos.producto, '  prod  ');
    writeln ('Lista ');
    Imprimirlista(a3^.datos.l);
    writeln();
    imprimirInOrden3(a3^.HD);

  end;

end;
function buscar(a: arbol; fBuscar: fecha): integer;
begin
  if (a = nil) then
    buscar := 0  { Caso base: árbol vacío }
  else begin
    if (a^.datos.f.dia = fBuscar.dia) and 
       (a^.datos.f.mes = fBuscar.mes) and 
       (a^.datos.f.anio = fBuscar.anio) then
      buscar := 1 + buscar(a^.HI, fBuscar) + buscar(a^.HD, fBuscar)
    else
      buscar := buscar(a^.HI, fBuscar) + buscar(a^.HD, fBuscar);
  end;
end;


procedure buscarFecha(a:arbol;var cantPB:integer);
var 
fBuscar:fecha;
begin
  fBuscar.dia:=random(31)+1;
  fBuscar.mes:=random(12)+1;
  fBuscar.anio:=random(25)+2000;
  writeln('dia: ',fBuscar.dia,' | mes: ',fBuscar.mes,' | anio: ',fBuscar.anio);
  cantPB:=buscar(a,fBuscar);
  

end;


procedure maximoPC(a2:arbol2;var codigoPC:integer; var maxPC:integer);
begin
  if (a2<> nil) then begin
    maximoPC(a2^.HI,codigoPC,maxPC);
    if(a2^.datos.cantVendida> maxPC) then begin
      maxPC:=a2^.datos.cantVendida;
      codigoPC:=a2^.datos.producto;
    end;
    maximoPC(a2^.HD,codigoPC,maxPC);
  end;
end;

function contarPD(l:lista):integer;
var cant:integer;
begin
  cant:=0;
  while(l<>nil) do begin
    cant:=cant+1;
    l:=l^.sig; 
  end;
  contarPD:=cant;
end;
procedure maximoPD(a3:arbol3;var codigoPD:integer;var maxPD:integer);
var m:integer;
begin

if(a3<>nil) then begin
  maximoPD(a3^.HI,codigoPD,maxPD);
  m:=contarPD(a3^.datos.l);
  if(m > maxPD) then begin
    maxPD:=m;
    codigoPD:=a3^.datos.producto;
  end;
  maximoPD(a3^.HD,codigoPD,maxPD);
end;


 end;


//--------------PROGRAMA PRINCIPAL-----
var 
a:arbol; a2:arbol2; a3:arbol3;
cantPB,codigoPC,maxPC,CodigoPD,maxPD:integer;
BEGIN
   crearArboles(a,a2,a3);
  
   writeln('ARBOL 1 ');
   imprimirInOrden (a);
   writeln('ARBOL 2 ');
   imprimirInOrden2 (a2);
   writeln('ARBOL 3 ');
   imprimirInOrden3 (a3);
   
   cantPB:=0;
   buscarFecha(a,cantPB);
   writeln('El tot de prod vendidos en la fecha a buscar son := ', cantPB);
   
   codigoPC:=0;
   maxPC:=-999;
   maximoPC(a2,codigoPC,maxPC);
   writeln('El codigo de producto con mas unidades vendidas es := ',codigoPC ,' | unidades ',codigoPC );


  codigoPD:=0;
  maxPD:=-999;
  maximoPD(a3,codigoPD,maxPD);
  writeln('El codigo de producto con mayor cantidad de ventas es: ',codigoPD, ' | con ',maxPD, ' ventas ');
END.

