2. Escribir un programa que: a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
 Para cada venta generar código de producto, fecha y cantidad de unidades vendidas.
  Finalizar con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
   i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto. Los códigos repetidos van a la derecha. 
   ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. 
   Cada nodo del árbol debe contener el código de producto y la cantidad total de unidades vendidas. 
   iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe
    contener el código de producto y la lista de las ventas realizadas del producto. Nota: El módulo debe retornar TRES árboles. 
    b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad total de productos vendidos en la fecha recibida.
     c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto con mayor cantidad total de unidades vendidas. 
     c. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto con mayor cantidad de ventas. 
     
     
 program ej2p3;
 Const
	cod_fin=0;
Type
  str30=string[30];
  
  regVentas=record
    cod:integer;
    fecha:str30;
    cantVentas:integer;
  end;
  
  arbol=^nodo;
  nodo=record
    dato:regVentas;
    HI:arbol;
    HD:arbol;
  end;
  
  regArbolII=record
    cod:integer;
    cant:integer;
  end;
  
  arbolII=^nodoII;
  nodoarbolII= record
    dato:regArbolII;
    HI:arbolII;
    HD:arbolII;
  end;
  
//----------------------------------------------------------
procedure cargarArbol(var a:arbol);

  procedure leerVentas(var rv:regVentas);
  begin
    writeln('Ingrese un codigo de producto');
    if(rv.cod<>codFin)then begin
      writeln('Ingrese la fecha de venta de producto');
      readln(rv.fecha);
      writeln('Ingrese un codigo de producto');
      readln(rv.cantVentas);
    end;
  
  procedure insertarArbol(var a:arbol; rv:regVentas);
  var 
    nue:arbol;
  begin
    if(a=NIL)then begin
      new(nue);
      a^.dato:=rv;
      a^.HI:=NIL;
      a^.HD:=NIL;
    end;
    else begin
      if(nue^.dato.cod < a^.dato.cod)then
        insertarArbol(a^.HI, rv)
      else
        insertarArbol(a^.HD, rv);
    end;
  end;
  
  
var 
  rv:regVentas;
begin
  leerVentas(rv);
  while(rv.cod<> cod_fin)do begin
    insertarArbol(a);
    leerVentas(v);
  end;
end;




//---------------PROGRAMA PRINCIPAL--------
var 
  a:arbol;
begin
  a:=NIL;
  cargarArbol(a);
end.
