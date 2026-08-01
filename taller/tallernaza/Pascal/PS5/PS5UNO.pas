{PlayStation Store requiere procesar las compras de sus clientes durante el año 2022

  a)Implementar un modulo que lea compras de videojuegos. De cada videojuego se lee codigo del videojuego, codigo de cliente
  , dia y mes. La lectura finaliza con el codigo de cliente 0. Se sugiere utilizar el modulo leerCompra(). Se deben retornar
  2 estructuras de datos:
    i. Una estructura eficiente para la busqueda por codigo de cliente.
    ii. Otra estructura que almacene la cantidad de compras realizadas en cada mes.
  b)Implementar un módulo que reciba la estructura generada en a) i, un código de cliente, retorne todas las compras querealizo
  dicho cliente.
  c)Implementar un modulo que reciba la estructura generada en a) ii y retorne la misma estructura ordenada por cantidad de mayor a
  menor.
  NOTA: implementar el programa principal, que invoque a los incisos a,b y c. }

program PS5;
const
dimF=12;

type 
compra=record
  videojuego:integer;
  cliente:integer;
  dia:1..31;
  mes:1..12;
end;

compra2=record
  videojuego:integer;
  dia:1..31;
  mes:1..12;
end;
 
lista=^nodo;
nodo=record
  dato:compra2;
  sig:lista;
end;

cli=record
 cliente:integer;
 l:lista;

end;
arbol=^nodoa;
nodoa=record
  datos:cli;
  HI:arbol;
  HD:arbol;
  end;
  
  
vecmes=array[1..dimF] of integer;

//------------------------------------------------------
procedure inivec(var vc:vecmes);
var i:integer;
begin
  for i:= 1 to dimF do 
    vc[i]:=0;
end;
//------------------------------------------------------
procedure leer (var c:compra);
begin
  c.cliente:=random(100);
  if(c.cliente<>0) then begin
    c.dia:=random(31)+1;
    c.mes:=random(12)+1;
    c.videojuego:=random(2000)+1;
  end;
end;
//------------------------------------------------------

procedure insertarOrdenado(var l:lista; c2:compra2);
var nue,ant,act:lista;
begin
  new(nue);
  nue^.dato:=c2;
  act:=l;
  while(act<>nil) and (act^.dato.mes< c2.mes) do begin
    ant:=act;
    act:=nue^.sig;
  end;
  if(act=l) then
    l:=nue
  else
    ant^.sig:=nue;
  nue^.sig := act ;
end;
//------------------------------------------------------
procedure agregaradelante(var l:lista; c2:compra2 );
var nue:lista;
begin
new(nue);
nue^.dato:=c2;
nue^.sig:=l;
l:=nue;
end;
//------------------------------------------------------
procedure agregar(var a:arbol; c:compra);
var
c2:compra2; 
begin
  if (a=nil) then begin
    new(a);
    a^.datos.cliente:=c.cliente;
    a^.datos.l:=nil;
    c2.dia:= c.dia;
    c2.mes:=c.mes;
    c2.videojuego:=c.videojuego;
    //agregaradelante(a^.datos.l, c2);
    insertarOrdenado(a^.datos.l,c2);
    a^.HD:=nil;
    a^.HI:=nil;
  end
  else
    if(a^.datos.cliente=c.cliente) then begin
      c2.dia:= c.dia;
      c2.mes:=c.mes;
      c2.videojuego:=c.videojuego;
      //agregaradelante(a^.datos.l, c2);
      insertarOrdenado(a^.datos.l,c2);
    end
    else 
      if(a^.datos.cliente > c.cliente) then
        agregar(a^.HI,c)
      else agregar(a^.HD,c);
 end;
//------------------------------------------------------
procedure crearabb(var a:arbol; var vc:vecmes);
var c:compra;
begin
  leer (c);
  while(c.cliente<>0) do begin
  agregar(a,c);
  vc[c.mes]:=vc[c.mes]+1;
  leer(c);
  end;
end;

//------------------------------------------------------

procedure puntoB(a:arbol;codB:integer;var cB:lista);
begin
  if (a=nil) then
     cB:=nil
  else  begin
     
     if(a^.datos.cliente =codB) then
        cB:=a^.datos.l
     else
       if(a^.datos.cliente<codB) then 
          puntoB(a^.HD,codB,cB)
       else puntoB(a^.HI,codB,cB);
  end;
end;

//------------------------------------------------------
procedure puntoC(var vc:vecmes); //ordenar pr insercion
var i,j,actual:integer;
begin
  for i:=2 to dimF do begin
     actual:=vc[i];
     j:=i-1;
     while(j>0 )and(vc[j] < actual) do begin
        vc[j+1]:=vc[j];
        j:=j-1;
     end;
     vc[j+1]:=actual;
  end;
end;
//------------------------------------------------------
procedure imprimirPostOrden (a: arbol);

begin

  if (a <> nil) then begin

    imprimirPostOrden(a^.HI);

    imprimirPostOrden(a^.HD);

    writeln (a^.datos.cliente , '|    ', a^.datos.l^.dato.videojuego ,'| videojuego ',
     a^.datos.l^.dato.dia ,' dia |',a^.datos.l^.dato.mes ,' mes|');

  end;

end;
//------------------------------------------------------
procedure imprimirPreOrden (a: arbol);

begin

  if (a <> nil) then begin

    writeln (a^.datos.cliente , '|    ', a^.datos.l^.dato.videojuego ,' videojuego| ',
     a^.datos.l^.dato.dia ,' dia |',a^.datos.l^.dato.mes ,' mes|');

    imprimirPreOrden(a^.HI);

    imprimirPreOrden(a^.HD);

  end;

end;
//------------------------------------------------------
var 
a:arbol; vc:vecmes; codB:integer;cB:lista;
i:integer;
BEGIN
a:=nil;
Randomize;
inivec(vc);
crearabb(a,vc);
write(a^.datos.cliente, ': es  el cliente |', ' ', a^.datos.l^.dato.videojuego ,' :  videojuego |', a^.datos.l^.dato.mes,' : mes |');
writeln();
writeln('-----Punto B---------');
codB:=random(100)+1;
puntoB(a,codB,cB);
if(cB<>nil) then
  writeln('se encontro el cliente ')
else writeln('no estba el cliente ');
writeln('--------------->');
writeln('-----Punto c---------');
puntoC(vc);
writeln(' ');
//comprobacion de que ordena el vector de mayor a menor
for i:=1 to 12 do begin
  writeln('vc pos ' , i ,' : ', vc[i]);
  end;
writeln('---------------->');
writeln (' ');
imprimirPreOrden (a);
//imprimirPostOrden (a);  
END.

