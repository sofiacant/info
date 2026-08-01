{
 
   
   
}


program artezanosParcial;
const dimF=8;
type 
  subMaterial=1..8;
  artesania=record
    DNI:integer;
    codArtesania:integer;
    material:subMaterial;
  end;
  regA=record
    DNI:integer;
    cantA:integer;
  end;
  regV=record
    codMaterial:subMaterial;
    cant:integer;
  end;
  vector=array[subMaterial]of regV;

  vectorN=array[subMaterial] of string ;
  arbol=^nodoa;
  nodoa=record
    datos:regA;
    HI:arbol;
    HD:arbol;
  end;
 procedure inivn(var vn:vectorN);
begin
  vn[1]:='madera' ;
  vn[2]:='yeso' ;
  vn[3]:='ceramica' ;
  vn[4]:= 'vidrio';
  vn[5]:='acero' ;
  vn[6]:='porcelana' ;
  vn[7]:= 'lana';
  vn[8]:='carton' ;
end;
 
  
  
procedure iniv(var v:vector);
var i:integer;
begin
  for i:= 1 to dimF do begin
    v[i].codMaterial:=i;
    v[i].cant:=0;
  end;
end;

procedure leer(var x:artesania);
begin
x.DNI:=random(100);
if(x.DNI<>0) then begin
  x.codArtesania:=random(100);
  x.material:=random(8)+1;
end;
end;

procedure agregarA(var a:arbol; x:artesania);
begin
  if(a=nil) then begin
    new(a);
    a^.datos.DNI:=x.DNI;
    a^.datos.cantA:=1;
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else begin 
    if (a^.datos.DNI = x.DNI) then
        a^.datos.cantA:=a^.datos.cantA+1
    else  begin
      if(x.DNI < a^.datos.DNI) then
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
  writeln('DNI:=',a^.datos.DNI,' | cantidad ' ,a^.datos.cantA);
  writeln();
  enorden(a^.HD);
end;
end;

procedure imprimirv(v:vector);
var i:integer;
begin
 for i:= 1 to dimF do begin
   writeln('codMaterial := ',v[i].codMaterial,' | cantidad := ', v[i].cant);
 end;
end;


procedure puntoA(var a:arbol;var v:vector);
var x:artesania;
begin
  a:=nil;
  leer(x);
  while(x.DNI<>0) do begin
    agregarA(a,x);
    v[x.material].cant:=v[x.material].cant+1;
    leer(x);
  end;
writeln('chequeo datos del arbol'); 
enorden(a);
writeln('chequeo datos del vector');
imprimirv(v);
end;

function cantidad(a:arbol; DNIB:integer):integer;
begin 
if(a=nil) then
  cantidad:=0
else begin
  if (a^.datos.DNI < DNIB) then 
    cantidad:= 1 + cantidad(a^.HI,DNIB) + cantidad(a^.HD,DNIB)
  else
     cantidad:=cantidad(a^.HD,DNIB);
end;
end;


procedure puntoB(a:arbol);
var
 DNIB,cantB:integer;
begin 
  writeln('---------------->');
  writeln('PUNTO B');
  DNIB:=random(100);
  cantB:=cantidad(a,DNIB);
  if(cantB<>0) then
    writeln('total menores adnib= ',cantB)
  else writeln('no hubo menores a dnib');
  
  writeln('---------------->');
end;

procedure ordenarV(var v:vector;vn:vectorN;var nomMax:string);
var
i,j:integer;
aux:regV;
begin 
  for i:= 2 to dimF do begin
    aux:=v[i];
    j:=i-1;
    while (j>0)and(v[j].cant>aux.cant) do begin
      v[j+1]:=v[j];
      j:=j-1;
    end;
    v[j+1]:=aux;
  
  end;
nomMax:=vn[v[dimF].codMaterial];
end;
procedure puntoC(var v:vector; vn:vectorN);
var nomMax:string;
begin
 writeln('---------------->');
 writeln(' PUNTO C');
 ordenarV(v,vn,nomMax);
 writeln('La materia con mayor cantidad de artesanias es:= ', nomMax);
 imprimirv(v);
 writeln('---------------->');
end;
//-------------------

var a:arbol;v:vector;vn:vectorN;

BEGIN
  Randomize;
  inivn(vn);
  iniv(v);
  puntoA(a,v);
  puntoB(a);
  puntoC(v,vn);
END.

