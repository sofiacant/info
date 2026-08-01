{
   
   
}


program casadecomidasShinalu;
const dimF=5;
type
  entrega=record
    codComida:integer;
    codCliente:integer;
    categoria:string;
  end;
  
  regA=record
    codComida:integer;
    cant1:integer;
  end;
 arbol=^nodoa;
 nodoa=record
   datos:regA;
   HI:arbol;
   HD:arbol;
 end; 
  regV=record
    nomCategoria:string;
    cant2:integer;
  end;
  vector=array[1..dimF] of regV;
procedure iniv(var v: vector);
begin
  v[1].nomCategoria:= 'Full' ;
  v[1].cant2:=0 ;
  v[2].nomCategoria:= 'Super' ;
  v[2].cant2:=0 ;
  v[3].nomCategoria:= 'Media' ;
  v[3].cant2:=0 ;
  v[4].nomCategoria:= 'Normal' ;
  v[4].cant2:=0 ;
  v[5].nomCategoria:= 'Basica' ;
  v[5].cant2:=0 ;
end;

function obtenerIndice(categoria: string): integer;
begin
  if categoria = 'Full' then obtenerIndice := 1
  else if categoria = 'Super' then obtenerIndice := 2
  else if categoria = 'Media' then obtenerIndice := 3
  else if categoria = 'Normal' then obtenerIndice := 4
  else if categoria = 'Basica' then obtenerIndice := 5
  else obtenerIndice := 0;  { Error, no debería pasar }
end;

procedure leer(var x:entrega);
var 
  v:array[1..5] of string=('Full','Super','Media','Normal','Basica');
begin
  x.codCliente:=random(100);
  if(x.codCliente<>0) then begin
    x.codComida:=random(10)+1;
    x.categoria:=v[random(5)+1];
  end;
end;

procedure agregarA(var a:arbol; x:entrega);
begin
  if(a=nil) then begin
    new(a);
    a^.datos.codComida:=x.codComida;
    a^.datos.cant1:=1;
    a^.HI:=nil;
    a^.HD:=nil;
    writeln(2);
  end
  else begin
    if(a^.datos.codComida = x.codComida) then
       a^.datos.cant1:= a^.datos.cant1 + 1
    else begin
      if(a^.datos.codComida > x.codComida) then
          agregarA(a^.HI,x)
      else 
        agregarA(a^.HD,x);
    end;
  end;
end;

procedure enorden(a:arbol);
begin
  if(a<>nil) then begin
    enorden(a^.HI);
    writeln('codigo comida:= ', a^.datos.codComida, ' | cantidad := ', a^.datos.cant1);
    enorden(a^.HD);
  end;
end;
procedure imprimirV(v:vector);
var i:integer;
begin 
 for i:= 1 to dimF do begin
   writeln('nomCategoria := ',v[i].nomCategoria,' | cantidad := ', v[i].cant2);
 end;
end;
procedure puntoA(var a:arbol;var v:vector);
var x:entrega; cat:integer;
begin
  a:=nil;
  iniv(v);
  leer(x);
  while(x.codCliente<>0) do begin
    cat:=obtenerIndice(x.categoria);
    v[cat].cant2:=v[cat].cant2 + 1;
    agregarA(a,x);
    leer(x);
  end;
  writeln('------------');
  enorden(a);
  writeln('------------');
  imprimirV(v);
  writeln('------------');
end;

function cantidad(a:arbol;codB:integer):integer;
begin
  if(a=nil) then
    cantidad:=0
  else begin
    if(a^.datos.codComida= codB) then
       cantidad:= a^.datos.cant1 {+ cantidad(a^.HI,codB)} + cantidad(a^.HD,codB)
    else begin
      if(a^.datos.codComida< codB) then
        cantidad:=cantidad(a^.HD,codB)
      else 
      cantidad:=cantidad(a^.HI,codB);
    end;
  end;
  
end;
procedure puntoB(a:arbol);
var codB,cantB:integer;
begin
  writeln();
  writeln('PUNTO B');
  codB:=random(10)+1;
  cantB:=cantidad(a,codB);
  writeln('cantidad de entregas con cod:=', codb, '  = ', cantB);
  writeln('-----------');
end;
procedure ordenarV(var v:vector;var maxcat:string);
var i,j:integer;
 aux:regV;
begin 
   for i:= 2 to dimF do begin
     aux:=v[i];
     j:=i-1;
     while(j>0)and (v[j].cant2 > aux.cant2) do begin
        v[j+1]:= v[j];
        j:=j-1;
     end;
     v[j+1]:=aux;
   end;
   maxcat:=v[dimF].nomCategoria ; 
end;

procedure puntoC(var v:vector);
var maxcat:string;
begin
writeln('puntoC');
maxcat:='';
ordenarV(v,maxcat);
imprimirV(V);
writeln();
writeln('La categoria con mas cantidad de entregas es:= ',maxcat);


end;
//------------------------
var a:arbol; v:vector;

BEGIN
	Randomize;
	PuntoA(a,v);
	puntoB(a);
	puntoC(v);
END.

