{TURNO D TEMA 2 AEROLINEAS ARG
Aerolíneas Argentinas necesita procesar los pasajes vendidos en 2023. De cada pasaje se conoce el código de vuelo,
código de cliente, código de ciudad destino y monto del pasaje.
  a) Implementar un módulo que lea pasajes,genere y retorne una estructura adecuada para la búsqueda por código
     de ciudad destino, donde para cada código de ciudad destino se almacenan juntos todos los pasajes (código de vuelo,
     código de cliente y monto del pasaje). La lectura finaliza con el monto de pasaje 0. Se sugiere utilizar
     el módulo leerPasaje().
  b) Implementar un módulo que reciba la estructura generada en a) y un código de ciudad destino y retorne todos los
     pasajes hacia esa ciudad destino.
  c) Realizar un módulo que reciba la estructura generada en a) y retorne el código de ciudad de destino con mayor 
     cantidad de pasajes vendidos
Nota: Implementar el programa principal, que invoque a los incisos a,b y c.


}


program parcialAerolineas;
type
pasaje=record
  vuelo:integer;
  cliente:integer;
  destino:integer;
  monto:real;
end;
pasajedos=record
  codvuelo:integer;
  codcliente:integer;
  monTo:real;
end;

lista=^nodo;
nodo=record
 dato:pasajedos;
 sig:lista;
end;

destino=record
  codDestino:integer;
  l:lista;
end;

arbol=^nodoa;
nodoa=record
  datos:destino;
  HI:arbol;
  HD:arbol;
end;
  
//------------------------
procedure leerPasaje(var p:pasaje);
begin
  p.monto:=Random(11);
  if(p.monto<>0) then begin
    p.vuelo:=Random(7000)+1;
    p.cliente:=Random(100)+1;
    p.destino:=Random(50)+1;
  end;
  if(p.monto<>0) then
    writeln('monto: ',p.monto:4:4,' vuelo: ',p.vuelo,' cliente: ',p.cliente,' destino: ',p.destino ,' ','|')
  else writeln(0);
end;

//------------------------
procedure agregarAdelante(var l:lista; p2:pasajedos);
var
nue:lista;
begin
  new(nue);
  nue^.dato:=p2;
  nue^.sig:=l;
  l:=nue;
end;
//------------------------
procedure agregar(var a:arbol;p:pasaje);
var aux:arbol; p2:pasajedos;
begin
  if(a=nil) then begin
    new(aux);
    aux^.datos.codDestino:=p.destino;
    aux^.datos.l:=nil;
    p2.codvuelo:=p.vuelo; 
    p2.codcliente:=p.cliente; 
    p2.monTo:=p.monto;
    agregarAdelante(aux^.datos.l,p2);
    aux^.HI:=nil;
    aux^.HD:=nil;
    a:=aux;
  end
  else 
    if (a^.datos.codDestino = p.destino) then begin
       p2.codvuelo:=p.vuelo; 
       p2.codcliente:=p.cliente; 
       p2.monTo:=p.monto;
       agregarAdelante(a^.datos.l,p2);
    end
    else 
       if(a^.datos.codDestino < p.destino) then
          agregar(a^.HD,p)
       else agregar(a^.HI,p);
  end;
//------------------------
procedure crearabb(var a:arbol);
var p:pasaje;
begin
  leerPasaje(p);
  while(p.monto<>0) do begin
    agregar(a,p);
    leerPasaje(p);
  end;
end;
//------------------------
procedure puntoB(a:arbol; destinoBuscar:integer; var punB:lista);
begin
{if(a=nil) then
  writeln ('arbol vacio')
  else}
    if(a<>nil) then begin
      if(a^.datos.codDestino = destinoBuscar) then 
         punB:=a^.datos.l
      else
         if(a^.datos.codDestino< destinoBuscar) then
           puntoB(a^.HD,destinoBuscar,punB)
         else puntoB(a^.HI,destinoBuscar,punB);    
 end;  
end;
//------------------------
procedure recorrerlista(l:lista; var cant:integer);

begin
  while (l<>nil) do begin
    cant:=cant+1;
    l:=l^.sig;
  end;

end;
//------------------------
procedure puntoC(a:arbol; var codC:integer;var cantmax:integer);
var cant:integer;
begin

if (a<>nil) then begin
  cant:=0;
  puntoC(a^.HI,codC,cantmax);
  recorrerlista(a^.datos.l,cant );
  if(cant>=cantmax) then begin
    cantmax:=cant;
    codC:=a^.datos.codDestino;
  end;
  puntoC(a^.HD,codC,cantmax);
  end;
end;


//------------------------
procedure recorrer(l:lista);
begin
while (l<>nil) do begin
 write ( 'Nodo 1 ');
  writeln ('codvuelo :',l^.dato.codvuelo,' |','codcliente: ',l^.dato.codcliente,'|','monTo: ', l^.dato.monTo:2:2,'|');
  l:=l^.sig;
end;
end;

//------------------------
var
a:arbol;
destinoBuscar:integer; punB:lista;
codC:integer;cantmax:integer;
BEGIN
randomize;	
a:=nil;
crearabb(a);
if(a=nil) then
  writeln('arbol vaci')
  else begin
    writeln ('codigo vuelo primer nodo del padre arbol :  ',a^.datos.l^.dato.codvuelo);	
//------------------------
    destinoBuscar:=random(50)+1;
    writeln ('EL destino a buscar es: ',destinoBuscar);
    writeln(' ');
    punB:=nil;
    puntoB(a,destinoBuscar, punB);
    if(punB<>nil) then begin
      writeln(' se encontro el destino  en el arbol := ', ' ' ,destinoBuscar);
      recorrer(punB);
    end
    else writeln('no se encontraba ese destino, gracias vuelva prontos!!! ');
  

//------------------------
    codc:=0;
    cantmax:=-9999;
    puntoC(a,codC,cantmax);
    writeln('PuntoC: El codigo  de la ciudad que se vendieron más pasajes es : ',codC, ' con viajes := ',cantmax  );
    end;
END.

