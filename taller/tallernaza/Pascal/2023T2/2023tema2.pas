{Una clinica necesita un sistema para el procesamiento de las atenciones realizadas a los pacientes.
  a) Implementar un módulo que lea información de las atenciones. De cada atención se lee: DNI del paciente,
     número de mes, y código de diagnóstico(1 a 15). La lectura finaliza con el mes 0.Se sugiere utilizar el módulo 
     leeratncion(). El módulo debe retornar dos estructuras de datos:
     i, Una estructura de datos eficiente para la busqueda por codigo de DNI del paciente. Para cada DNI debe almacenarse la 
     cantidad total de atenciones recibidas.
     ii. Otra estructura de datos con la cantidad de atenciones realizadas para cada diagnóstico.
  b) Implementar un módulo que reciba la estructura generada en a)i. dos números de DNI y un valor entero x. Este
     módulo debe retornarla cantidad de pacientes con más de x atenciones cuyos DNI estén entre los 2 números de 
     DNI recibidas.
  c) Iplementar un módulo recursivo que reciba la estructura generada en a)ii. y retorne la cantidad de diagnosticos
     para los cuales la cantidad de atencion fue cero.
NOTA: Implementar el programa principal, que invoque a los incisos a,b y c. En caso de ser necesario,
puede utilizar los módulos que se encuentran a continuación..  
}



program ParcialClinica;
const
dimF=15;
type
ranmes=0..13;
rand=1..15;

atencion=record
dnii:integer;
mes:ranmes;
diagnostico:rand;
end;
persona=record
dni:integer;
cantAtenciones:integer;
end;

arbol=^nodoa;
nodoa=record
 datos:persona;
 HI:arbol;
 HD:arbol;
end;

vectord= array[1..dimF] of integer;
//-------------------------------

procedure leerAtencion(var x:atencion);
begin
 x.mes:=random(13);
 write('|',x.mes, ': mes... |');
 if (x.mes<>0) then begin
   x.dnii:=random(100)+1;
   write(x.dnii,' : dni...');
   x.diagnostico:=random(15)+1;
   write('|',x.diagnostico,': diagnostico ...');
   writeln();
 end;
end;


//-------------------------------

procedure inivec(var vd:vectord );
var i:integer;
begin 
 for i:= 1 to dimF do begin
   vd[i]:= 0;
 end;
end;
//-------------------------------

//-------------------------------
procedure agregarArbol( var a:arbol;x:atencion);

begin

  if (a=nil) then begin 
     new(a);
     a^.datos.dni:=x.dnii;
     a^.datos.cantAtenciones :=1;
     a^.HD:=nil;
     a^.HI:=nil;
     
  end
  else begin
    if(a^.datos.dni = x.dnii) then 
      a^.datos.cantAtenciones:=a^.datos.cantAtenciones+1
    
    else 
      if(a^.datos.dni < x.dnii) then
         agregarArbol(a^.HI,x)
        
      
      else 
         agregarArbol(a^.HD,x);
  end;
end;
//-------------------------------
procedure crearabb(var a:arbol;var vd:vectord);
var x:atencion;
begin
leerAtencion(x);
while (x.mes<>0) do begin
  agregarArbol(a,x);
  vd[x.diagnostico]:= vd[x.diagnostico]+1;
  leerAtencion(x);
end;

end;
//-------------------------------
procedure puntoB(a:arbol;unodni:integer;dosdni:integer; numx:integer;var totalB:integer);
begin
if (a<>nil) then begin
  puntoB(a^.HI,unodni,dosdni,numx,totalB);
  if(a^.datos.cantAtenciones > numx) and (a^.datos.dni>=unodni) and(a^.datos.dni<=dosdni)then begin
     totalB:=totalB+1;
  end;
  puntoB(a^.HD,unodni,dosdni,numx,totalB);
end;
end;

//-------------------------------
function cumple(a:arbol;unodni,dosdni,numx:integer):boolean;
begin
  if(a^.datos.dni>= unodni) and(a^.datos.dni<=dosdni) and (a^.datos.cantAtenciones > numx)then 
    cumple:=true
  else begin
    if(a^.datos.dni>=dosdni) and (a^.datos.dni<= unodni) and (a^.datos.cantAtenciones > numx) then
       cumple:=true
    else cumple:=false;
  end;
 
end;

function puntoB2(a:arbol;unodni,dosdni,numx:integer):integer;
var cant:integer;
begin
cant:=0;
  if (a=nil) then 
     puntoB2:=0
  else begin
    if (a<>nil) then 
      if(cumple(a,unodni,dosdni,numx)) then
         cant:=cant+1;
      puntoB2:=cant+ puntoB2(a^.HI,unodni,dosdni,numx) +puntoB2(a^.HD,unodni,dosdni,numx);
    end;
end;

//--------------------------------
procedure puntoC(vd:vectord; var cantC:integer;dimF:integer);
begin
 if(dimF<>0) then begin 
   if(vd[dimF] = 0 )then begin
      cantC:=cantC+1;
      dimF:=dimF-1;
      puntoC(vd,cantC,dimF);
   end
   else begin 
      dimF:=dimF-1;
      puntoC(vd,cantC,dimF);
      end;
 end;
end;
//-------------------------------

var
vd:vectord; a:arbol;unodni,dosdni,numx,cantC,totalB:integer;
BEGIN
 randomize;
a:=nil;
inivec(vd);
crearabb(a,vd);
//-----------------
unodni:=1;
dosdni:=90;
numx:=1;
totalB:=0;
writeln(' ');
puntoB(a,unodni,dosdni,numx,totalB);
writeln('cantidad de pacientes que superaron ',numx ,' atenciones, entre los dni ',unodni,' y ', dosdni, ' : ',totalB);
totalB:=puntoB2(a,unodni,dosdni,numx);
writeln('function b2:=  ', totalB);
//-----------------
cantC:=0;
puntoC(vd,cantC,dimF);
writeln();
writeln('cantidad total de diagnosticos con valor 0 punto c  := ', cantC);
END.

