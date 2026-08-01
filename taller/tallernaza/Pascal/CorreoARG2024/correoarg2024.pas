{El correo Argentino necesita procesar los envios entregados durante el mes de julio de 2024. De cada envio se conoce el
 codigo de cliente, dia, codigo postal y peso del paquete
   a) Implementar un modulo que lea envios, genere y retorne un arbol binario de busqueda ordenado por codigo 
 postal, donde para cada codigo postal se almacenen en una lista todos los envios(codigo de cliente, dia y peso del paquete)
 correspondientes. La lectura finaliza con el codigo de cliente 0. se sugiere utilizar el modulo LeerEnvio().
   b) Implementra un modulo que reciba la estructura generada en a) y un codigo postal, y retorne todos los envios de
 dicho codigo postal
   c) Realizar un modulo recursivo que reciba la estructura que retorna el inciso b) y retorne los dos codigos de cliente
correposdientes al envio con mayor y menor peso}



program correoarg;
type 

envio1=record
 codcliente:integer;
 dia:1..30;
 peso:real;
 
 end;

envio =record
codPostal:integer;
codcliente:integer;
dia:1..30;
peso:real;
end;

lista=^nodo;
nodo =record
dato:envio1;
sig:lista;
end;

envioa=record
codPostal:integer;
l:lista;
end;


arbol=^nodoa;
nodoa=record
 datos:envioa;
 HI:arbol;
 HD:arbol;
 end;
 
 
 
procedure leer(var e:envio);
begin
 e.codcliente:=random(1000);
 if (e.codcliente<>0) then begin
    e.dia:=random(30)+1;
    e.peso:=random(2000) / (random(10)+1);
    e.codPostal:=random(10)+1;
 end;
end;

procedure agregaradelante(var l:lista; e1:envio1);
var nue:lista;
begin
 new(nue);
 nue^.dato:=e1;
 nue^.sig:=l;
 l:=nue;
end;
procedure cargoreg(e:envio;var e1:envio1);
begin
    e1.dia:=e.dia;
    e1.peso:=e.peso;
    e1.codcliente:=e.codcliente;
end;
procedure agregar(var a:arbol; e:envio);
var e1:envio1;
begin
  if(a=nil) then begin
    new(a);
    a^.datos.codPostal:=e.codPostal;
    a^.datos.l:=nil;
    cargoreg(e,e1);
    
    agregaradelante(a^.datos.l,e1);
    a^.HD:=nil;
    a^.HI:=nil;
    end
  else
    if(a^.datos.codPostal = e.codPostal) then begin
       cargoreg(e,e1);
       agregaradelante(a^.datos.l,e1)
       end
    else 
      if(a^.datos.codPostal > e.codPostal) then
        agregar(a^.HI,e)
      else agregar(a^.HD,e);
end;

procedure crearabb(var a:arbol);
var e:envio;
begin
  leer(e);
  while (e.codcliente<>0) do begin
    agregar(a,e);
    leer(e);
  end;
end;

procedure puntoB(a:arbol; codBuscar:integer; var punB:lista);
begin
  if(a<>nil) then  begin
    if(a^.datos.codPostal = codBuscar) then 
      punB:=a^.datos.l
    else
      if(a^.datos.codPostal < codBuscar) then
        puntoB(a^.HD,codBuscar,punB)
      else puntoB(a^.HI,codBuscar,punB);    
 end;  
end;
procedure puntoC(punB:lista; var codmax:integer; var codmin:integer;var max:real; var min:real);

begin
  if(punB<>nil) then begin
    if(punB^.dato.peso>= max) then begin
      max:=punB^.dato.peso;
      codmax:=punB^.dato.codcliente;
     end;
    if(punB^.dato.peso<= min) then begin
      min:=punB^.dato.peso;
      codmin:=punB^.dato.codcliente;
    end;
    puntoC(punB^.sig,codmax,codmin,max,min);
   end;
  end;
  
  
  
procedure imprimir(punB:lista);
begin
write ('ĺistaaaaa');
writeln();
while(punB<>nil) do begin
  writeln('             ',punB^.dato.dia, ' dia');
  writeln('             ',punB^.dato.peso:2:0, ' peso');
  writeln('             ',punB^.dato.codcliente, ' cod cliente');
  writeln('------------------');
  punB:=punB^.sig;
end;
end;

procedure enorden(a:arbol);
begin
 if (a<>nil) then begin
   enorden(a^.HI);
   writeln('codP ',a^.datos.codPostal,'| ');
   while (a^.datos.l<>nil) do begin
     writeln('            peso,' ,'',a^.datos.l^.dato.peso:2:0,'| ');
     writeln(' '); 
     a^.datos.l:=a^.datos.l^.sig;
     end;
   enorden(a^.HD);  
end;
end;

//-------------------------------------
var a:arbol;codBuscar:integer;punB:lista;
   codmax,codmin:integer;max,min:real;
BEGIN
    Randomize;
	a:=nil;punB:=nil;
	crearabb(a);
	write(a^.datos.codpostal, ' =cpostal; ',a^.datos.l^.dato.peso:2:0, ' =peso');
	//enorden(a);
	codBuscar:=random(10)+1;
	writeln(codBuscar, ' =codigo a buscar ');
	
	puntoB(a,codBuscar,punB);
	writeln(' ..');
	writeln(' se enconto el cod a buscar ', codBuscar,' :) ');
	imprimir(punB);
	max:=-9999.00;
	min:=99999.00;
	puntoC(punB,codmax,codmin,max,min);
	write ('cod min :=', codmin,' | peso=',min:2:0,'| cod max := ',codmax,' peso:= ',max:2:0 ,'|' );
	
END.

