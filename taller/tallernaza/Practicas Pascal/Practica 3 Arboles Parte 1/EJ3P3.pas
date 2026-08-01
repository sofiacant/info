{
   3. Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado. 
}


program EJ3P3;
type
fecha=record
  dia:1..31;
  mes:1..12;
  anio:integer;
end;

finales=record
  legajo:integer;
  codMateria:1..32;
  f:fecha; 
  nota:1..10;
end;

reg_finales=record
  codMateria:1..32;
  f:fecha; 
  nota:1..10;
end;

listaF=^nodo;
nodo=record
 dato:reg_finales;
 sig:listaF;
end;
 regA=record
  legajo:integer;
  l:listaF
end;
arbol=^nodoa;
nodoa=record
  datos:regA;
  HI:arbol;
  HD:arbol;
end;
regP=record
  legajo:integer;
  prom:real;
end;
listaProm=^nodo2;
nodo2=record
dato:regP;
sig:listaProm;
end;
//-------------PROCESOS
procedure leerF(var f:fecha);
begin
  f.dia:=random(31)+1;
  f.mes:=random(12)+1;
  f.anio:=random(25)+2000;
end;
procedure leer(var x:finales);
begin
  x.legajo:=random(101);
  if (x.legajo<>0) then begin
    leerF(x.f);
    x.codMateria:=random(35)+1;
    x.nota:=random(10)+1;
  end;
end;
procedure agregarAtras(var l:listaF;x:finales);
var
nue:listaF;
begin
  new(nue);
  nue^.dato.f:=x.f;
  nue^.dato.codMateria:=x.codMateria;
  nue^.dato.nota:=x.nota;
  nue^.sig:=l;
  l:=nue;
end;

procedure insertarArbol(var a:arbol; x:finales);
begin
  if (a=nil) then begin
    new(a); 
    a^.datos.legajo:=x.legajo;
    a^.datos.l:=nil;
    agregarAtras(a^.datos.l,x);
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else begin
    if(a^.datos.legajo= x.legajo) then 
      agregarAtras(a^.datos.l,x)
    else
      if(a^.datos.legajo> x.legajo) then
         insertarArbol(a^.HI,x)
      else insertarArbol(a^.HD,x);
  end;
 end;



procedure crearArbol(var a:arbol);
var
x:finales;
begin
  leer(x);
  while(x.legajo<>0)do begin
    insertarArbol(a,x);
    leer(x);
  end;

end;

function buscarImpar(a:arbol):integer;
begin
  if (a = nil) then
      buscarImpar := 0
  else  begin
    if((a^.datos.legajo mod 2)=1) then
      buscarImpar:= 1 + buscarImpar(a^.HI) + buscarImpar(a^.HD) 
    else 
      buscarImpar:= buscarImpar(a^.HI)+buscarImpar(a^.HD);
  end;  
end; 


function cantF(l:listaF):integer;
var tot:integer;
begin
  tot:=0;
  while(l<>nil) do begin 
    if(l^.dato.nota >= 4 ) then
      tot:=tot+1;
    l:=l^.sig;
  end;
 cantF:=tot;
end;

procedure finalesA(a:arbol);

begin
  if(a<> nil) then begin
    finalesA(a^.HI);
    writeln('legajo ', a^.datos.legajo);
    writeln('finales aprobados ', cantF(a^.datos.l));
    finalesA(a^.HD);
end;
end;

{c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado. 
}
procedure agregarLP(var lP:listaProm; leg:integer; promtot:real);
var 
nue:listaProm;
begin
new(nue);
nue^.dato.legajo:=  leg ;
nue^.dato.prom:=promtot;
nue^.sig:=lP;
lP:=nue;
end;

function calcularprom(l:listaF):real;
var
pro:real; cant:integer;
begin
pro:=0; cant:=0;
  while(l<>nil) do begin
    cant:=cant+1;
    pro:=pro+l^.dato.nota;
    l:=l^.sig; 
  end;
  calcularprom:=pro/cant;
end;


procedure PuntoC(a:arbol;valor:real;var lP:listaProm);
var
promtot:real;
begin
  if(a<>nil) then begin
    PuntoC(a^.HI,valor,lP);
    promtot:=calcularprom(a^.datos.l);
    if(promtot>valor) then
      agregarLP(lP,a^.datos.legajo,promtot);
    PuntoC(a^.HD,valor,lP);
  end;

end;
procedure imprimirLP(lP:listaProm);
begin
while(lP<>nil) do begin
  writeln('legajo: ',lP^.dato.legajo,' | promedio ', lP^.dato.prom:2:2 );
  
  lP:=lP^.sig;
end;
end;
//-------------PROGRAMA PRINCIPAL
var 
a:arbol;
valor:real; lP:listaProm;
BEGIN

	crearArbol(a);
	writeln('alumnos con legajo impar = ',buscarImpar(a));
	finalesA(a);
    
    lP:=nil;
    writeln('Ingrese promedio para comparar!! ');
    read(valor);
    PuntoC(a,valor,lP);
    imprimirLP(lP);
END.

