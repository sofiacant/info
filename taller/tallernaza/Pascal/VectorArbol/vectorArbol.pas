{}


program parcial2024;
const dimF=12;
type 
atencion=record
  matricula:integer;
  dni:integer;
  mes:1..12;
  diagnostico:char;
end;
paciente=record
dni:integer;
diagnostico:char;
end;


arbol=^nodoa;
nodoa=record
 datos:paciente;
 HI:arbol;
 HD:arbol;
end;

vector=array [1 .. dimF] of arbol;
//-------------------------------------
procedure leer(var x:atencion);
var v:array[1..5] of char =('L','M','N','O','P');
begIN
x.matricula:=random(10000);
if(x.matricula<>0) then begin
  x.dni:=random(5000) +1000;
  x.mes:=random(12)+1;
  x.diagnostico:=v[random(5)+1];
  end;
end;
//------------------------------------

procedure inivect(var v:vector);
var 
 i:integer;
begin
for i:=1 to dimF do begin 
    v[i]:=nil;
  end;
end;  

//------------------------------------
procedure agregar(var a:arbol;x:atencion);
begin
    if(a=nil) then begin
      new(a);
      a^.datos.dni:=x.dni;
      a^.datos.diagnostico:=x.diagnostico;
    end
    else 
      if(a^.datos.dni>x.dni) then
         agregar(a^.HI,x)
      else agregar(a^.HD,x);
end;
//------------------------------------
procedure crearvec(var v:vector);
var x:atencion;
begin
  leer(x);
  while(x.matricula<>0) do begin
     agregar(v[x.mes],x);
     leer(x);
  end;
end;

//------------------------------------
function cuentocant(a:arbol):integer;

begin

   if (a=nil) then 
     cuentocant:=0
   else 
      cuentocant:=1 + cuentocant(a^.HI) + cuentocant(a^.HD);
      
 end;

//------------------------------------
procedure puntoB(v:vector; var mes :integer ;var max:integer;dimF:integer);
var cant:integer;
begin
 cant:=0;
  if (dimF<>0) then begin
     puntoB(v,mes,max,dimF-1);
     cant:=cuentocant(v[dimF]);
     if(cant > max) then begin
       max:= cant;
       mes:= dimF;
       end;
       end;
end;
//------------------------------------
function recorrer(a:arbol;dniB:integer):boolean;
begin
  if(a=nil) then
    recorrer:=false
  else 
    if(a^.datos.dni=dniB)then 
      recorrer:=true
    else 
      if (a^.datos.dni> dniB) then
        recorrer(a^.HI,dniB)
      else recorrer(a^.HD,dniB);
end;


function cumple(v:vector; dimF:integer;dniB:integer):boolean;
var
x:boolean;
begin
   if(dimF<>0) then 
      x:=recorrer(v[dimF],dniB);
      if (x=false) then
         cumple(v,dimF-1,dniB)
      else 
         cumple:=x;
   
end;
//-----------------------------


var
  v:vector;  dniB,mes,max:integer;

BEGIN
Randomize;
inivect(v);	
crearvec(v)	;
mes:=0; max:=-9999;
puntoB(v,mes,max,dimF);
writeln('el mes con mas pacientes fue:= ',mes);
dniB:=random(5000)+1000;
if (cumple(v,dimF,dniB)) then
  writeln('se encontraba el dni ', dniB)
else writeln('no se encontraba');
END.

