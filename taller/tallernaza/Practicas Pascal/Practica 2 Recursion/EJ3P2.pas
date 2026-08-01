{
3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a
300 y menores a 1550 (incluidos ambos).
b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior) .
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se
encuentra en el vector.
   
}


program ejer3;

const
  dimF=20;
  min=300;
  max=1550;
type
  vector=array[1 .. dimF] of integer;
  
//-------------PROCESOS
procedure cargarV(var v:vector);


  procedure CargarVectorRecursivo (var v: vector;i:integer);
  var valor: integer;
  begin
    valor:= min + random (max - min + 1);
    if (i <= 20 ) then begin
       i:=i+1;
       v[i]:= valor;
       CargarVectorRecursivo (v,i);
         end;
  end;

var i:integer;
begin
  i:=0;
  CargarVectorRecursivo(v,i);
end;

procedure ImprimirVector (v: vector);
var
   i: integer;
begin
     for i:= 1 to dimF do
         write ('----');
     writeln;
     write (' ');
     for i:= 1 to dimF do begin
        write(v[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimF do
         write ('----');
     writeln;
     writeln;
End;  

procedure insercion(var v:vector);
var
i,j,actual:integer;

begin
for i := 2 to dimF do begin
  actual:=v[i];
  j:=i-1;
  while (j>0) and (v[j] >actual) do begin
    v[j+1]:=v[j];
    j:=j-1;
  end;
  v[j+1]:=actual;
end;
end;

procedure busquedaDicotomica(v: vector; ini, fin: integer; dato: integer; var pos: integer);
begin
  if (ini > fin) then writeln('El numero ingresado no se encuentra en el vector')
  else begin
    pos := (ini + fin) div 2;
    if (v[pos] = dato) then writeln('El numero ingresado se encuentra en la posicion ', pos, ' del vector.')
    else begin
      if (dato < v[pos]) then begin
        fin := pos - 1;
      end
      else ini := pos + 1;
      busquedaDicotomica(v, ini, fin, dato, pos);
    end;
  end;
end;
//-----------PROGRAMA PRINCIPAL
var
v:vector;
ini,fin,dato,pos:integer ;
BEGIN
Randomize;
cargarV(v);	
ImprimirVector (v);	
insercion(v);
ImprimirVector (v);
ini:=1;
fin:=dimF;
dato:=min + random (max - min + 1);
writeln(dato);
busquedaDicotomica(v,ini,fin,dato,pos);

END.

