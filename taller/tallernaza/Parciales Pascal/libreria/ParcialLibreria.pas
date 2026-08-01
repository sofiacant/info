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

program parcialFeriaLibro;
const
 dimF=7;
type
 rango1=1..dimF;
 libros=record
   ISBN:integer;
   codigoAutor:integer;
   codigoGenero:rango1;
 end;
 regA=record
  codigoAutor:integer;
  cantLibros:integer;
 end;
 regV=record
   codigoGenero:rango1;
   cantLibros:integer;
 end;
 arbol=^nodoa;
 nodoa=record
   datos:regA;
   HI:arbol;
   HD:arbol;
 end;
 vector=array[rango1] of regV;
 vgen=array[rango1] of string;
//-------------PuntoA---------- 
procedure iniV(var v:vector);
var i:integer;
begin
for i:=1 to dimF do begin
  v[i].codigoGenero:=i;
  v[i].cantLibros:=0;
end;
end;

procedure iniVG(var vg:vgen);
begin
vg[1]:='literario';
vg[2]:='filosofia';
vg[3]:='biologia';
vg[4]:='arte';
vg[5]:='computacion';
vg[6]:='medicina';
vg[7]:='ingenieria';
end;

procedure leer(var x:libros);
begin
x.ISBN:=random(100);
if(x.ISBN<>0) then begin
  x.codigoGenero:=random(7)+1;
  x.codigoAutor:=random(20)+1;
end;
end;

procedure insertararbol(var a:arbol;x:libros);

begin
if(a=nil) then begin
  new(a);
  a^.datos.codigoAutor:=x.codigoAutor;
  a^.datos.cantLibros:=1;
  a^.HI:=nil;
  a^.HD:=nil;
end
else begin
  if(a^.datos.codigoAutor=x.codigoAutor) then
    a^.datos.cantLibros:=a^.datos.cantLibros+1
  else begin
    if(a^.datos.codigoAutor > x.codigoAutor) then
      insertararbol(a^.HI,x)
    else
      insertararbol(a^.HD,x);
end;
end;

end;

procedure puntoA(var a:arbol; var v:vector);
var
x:libros;
begin
  a:=nil;
  Randomize;
  iniV(v);
  leer(x);
 while(x.ISBN<>0) do begin
   v[x.codigoGenero].cantLibros:=v[x.codigoGenero].cantLibros+1;
   Insertararbol(a,x);
   leer(x);
 end;
 writeln ('----- Modulo A ----->');
end;
procedure imprimirA(a:arbol);
begin
	if(a<>nil) then begin
		imprimirA(a^.HI);
		writeln('codigo de autor: ',a^.datos.codigoAutor,', cantidad de libros: ',a^.datos.cantLibros);
		imprimirA(a^.HD);
	end;
end;
procedure imprimir(a:arbol; v:vector);
var i:integer;
begin
   writeln('Vectooooor');
	for i:= 1 to dimF do 
	writeln('codigo de genero: ',v[i].codigoGenero,', cantidad de libros: ',v[i].cantLibros);
	
    writeln();
    writeln('Arboooool');
    imprimirA(a);
end;

procedure ordenarV(var v:vector;var posmax:rango1);
var
i,j:integer; aux:regV;
begin
for i:= 2 to dimF do begin
  j:=i-1;
  aux:=v[i];
  while(j>0) and (v[j].cantLibros < aux.cantLibros) do begin
    v[j + 1] := v[j];
    j := j - 1;
  end;
  v[j + 1] := aux;
end;

posmax:= v[1].codigoGenero;
end;

procedure puntoB(var v:vector);
var vg:vgen;posmax:rango1;
begin
iniVG(vg);
ordenarV(v,posmax);
writeln ('----- Modulo B ----->');
writeln('nombre del genero con mas libros := ', vg[posmax]);
end;

procedure puntoC(a:arbol);
procedure recorridoAcotado (a: arbol; inf, sup: integer;var contar:integer);
  begin
  if (a <> nil) then begin
    if (a^.datos.codigoAutor >= inf) then begin
      if (a^.datos.codigoAutor <= sup) then begin
        contar:=contar + a^.datos.cantLibros ;
        recorridoAcotado(a^.HI, inf, sup,contar);
        recorridoAcotado(a^.HD, inf, sup,contar);
      end
      else 
        recorridoAcotado(a^.HI, inf, sup,contar);
    end
    else 
      recorridoAcotado(a^.HD, inf, sup,contar);
    end;
  end;

var
codigo1,codigo2,contar:integer;
begin
writeln;
  contar:=0;
  writeln ('----- Modulo C ----->');
  writeln;
  writeln('Ingrese Num  1');
  readln(codigo1);
  writeln('Ingrese Num 2 mayor a Num 1');
  readln(codigo2);
  recorridoAcotado(a,codigo1,codigo2,contar);
  writeln('La cantidad de Libros de los autore  entre los dos valores es:= ', contar);
end;



var
 a:arbol; v:vector;
 
BEGIN
	PuntoA(a,v);
	imprimir(a,v);
	puntoB(v);
	puntoC(a);
END.

