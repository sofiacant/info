{La feria del libro necesita un sistema para obtener estadisticas sobre los libros presentados.
 a) Implementar un modulos que lea informacion de los libros. De cada libro se conoce: ISBN, codigo del autor, y
   codigo de genero(1: literario, 2: filosofia, 3 : biologia, 4: arte, 5: computacion, 6: medicina, 7:ingenieria). 
   La lectura finaliza con el valor 0 para el ISBN. el modulo debe retornar dos estructuras.. 
 i. Un arbol binario de busqueda ordenado por codigo de autor.Para cada codigo debe almacenarse la cantidad de
    libros correspondientes al codigo 
 ii. Un vector que almacene para cada genero, el codigo del genero y la cantidad de libros del genero
 
 B) Implementar un mopdulo que reciba el vector generado en a). Lo ordene por cantidad de libros de Mayor a menor 
    y retorne el nonmbre del genero con mayor cantidad de libros.
 c) Implementar un modulo que reciba al arbol generado en a) y dos codigos. El modulo debe retornar la cantidad
    total de libros correspondientes a los codigos de autores entre los dos codigos ingresados(incluidos ambos)
    
 NOTA: implementar el programa principal , que invoque a los incisosn a,b y c.}


program qq;
const
dimF=7;
type 
rango1=1..7;

reg1=record
isbn:integer;
codautor:integer;
codgen:rango1;
end;

vecgen=array[1..dimF] of string ;

reg3=record
codg:rango1;
cantlibros:integer;
end;

vector1=array[rango1] of reg3;

reg2=record
codautor:integer;
cant:integer;
end;

arbol=^nodoa;
nodoa=record
datos:reg2;
HI:arbol;
HD:arbol;
end;


//------------------------------------
procedure leer(var x:reg1);
begin
 x.isbn:=random(1000);
 if(x.isbn<>0) then begin
    x.codautor:=random(300)+1;
    x.codgen:=random(7)+1;
 end;
end;
//------------------------------------
procedure inivec1(var v1:vector1);
var i:integer;
begin
  for i:= 1 to dimF do begin
    v1[i].codg:=i;
    v1[i].cantlibros:=0;
end;
end;
procedure inivecgen(var vg:vecgen);
begin
 vg[1]:=('literario');
 vg[2]:=('filosofia');
 vg[3]:=('biologis');
 vg[4]:=('arte');
 vg[5]:=('computacion');
 vg[6]:=('medicina');
 vg[7]:=('ingenieria');
 end;
//------------------------------------
procedure agregar(var a:arbol; x:reg1);

begin
  if(a=nil) then begin
    new(a);
    a^.datos.codautor:=x.codautor;
    a^.datos.cant:=1;
    a^.HD:=nil;
    a^.HI:=nil;
  end
  else 
    if(a^.datos.codautor=x.codautor) then
      a^.datos.cant:=a^.datos.cant+1
    else 
      if(a^.datos.codautor> x.codautor) then
        agregar(a^.HI,x)
      else agregar(a^.HD,x);
      

end;
//------------------------------------
procedure crearabb(var a:arbol;var v1:vector1);
var x:reg1;
begin
  leer(x);
  while(x.isbn<>0) do begin
    agregar(a,x);
    v1[x.codgen].cantlibros:=v1[x.codgen].cantlibros+1;
    leer(x);
  end;
end;
//------------------------------------
procedure puntoB(var v1:vector1; vg:vecgen; var nn:string);
var
 i,j:integer; actual:reg3;
begin
 for i:=2 to dimF do begin
   actual.cantlibros:=v1[i].cantlibros;
   actual.codg:=v1[i].codg;
   j:=i-1;
   while(j>0) and (v1[j].cantlibros< actual.cantlibros) do begin
     v1[j+1]:=v1[j];
     j:=j-1;
   end;
  v1[j+1]:=actual
 end;
 nn:=vg[v1[1].codg];

end;
   
//------------------------------------
{function puntoC(a:arbol;cod1:integer;cod2:integer):integer;
begin
  if(a=nil) then
    puntoC:=0
  else 
    if(a^.datos.codautor>=cod1) and (a^.datos.codautor<=cod2) then
      puntoC:=1+puntoC(a^.HI,cod1,cod2) + puntoC(a^.HD,cod1,cod2)
    else 
      puntoc:= puntoC(a^.HI,cod1,cod2) + puntoC(a^.HD,cod1,cod2);

end;}
//------------------------------------
procedure recorridoAcotado (a: arbol; inf, sup: integer; var total:integer);
begin
  total:=0;
  if (a <> nil) then begin
    if (a^.datos.codautor >= inf) then begin
      if (a^.datos.codautor <= sup) then begin
        total:=total+1;
        recorridoAcotado(a^.hi, inf, sup,total);
        recorridoAcotado(a^.hd, inf, sup,total);
      end
      else 
        recorridoAcotado(a^.hi, inf, sup,total);
    end
    else
      recorridoAcotado(a^.hd, inf, sup,total);
    end;
  end;
//------------------------------------
var 
a:arbol; v1:vector1; vg:vecgen;nn:string; cod1,cod2:integer; total:integer;i:integer;
BEGIN
	Randomize;
	inivec1(v1);
	inivecgen(vg);
	crearabb(a,v1);
	writeln( v1[1].cantlibros);
	puntoB(v1,vg,nn);
	writeln('codigo con mas libros', nn);
	writeln('ingrese cod1 entre 1..300 ' );
	readln(cod1);
	writeln('ingrese cod2 entre mayor a cod1 ', cod1 );
	readln(cod2);
	writeln (cod2);
	
	{total:=puntoC(a,cod1,cod2);}
	recorridoAcotado(a,cod1,cod2,total);
	writeln('PUNTOC cantidad de libros entre esos dos cod:= ',total);
	
	for i:= 1to dimF do begin
	  writeln(v1[i].codg, ' codg| ',v1[i].cantlibros,' cantlibros |');
	  end;
 END. 

