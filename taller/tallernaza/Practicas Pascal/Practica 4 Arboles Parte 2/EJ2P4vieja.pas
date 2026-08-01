{
  Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo
necesario para:
i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un
módulo recursivo que retorne dicho socio.
iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe
invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
leídos y retorne la cantidad solicitada.}


Program ImperativoClase3;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		InformarDatosSociosOrdenCreciente (a^.HI);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarDatosSociosOrdenCreciente (a^.HD);
	end;		
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;
//--------------------PRACTICA 4 MODIFICACIONES-----------
procedure Modulo1P4 (a: arbol);
{Retornar el mayor código de socio.}

  function ObtenerMaximo (a: arbol): integer;
  begin
    if (a = nil) 
    then ObtenerMaximo:= -9999
    else if (a^.HI = nil) then ObtenerMaximo:= a^.dato.numero
                          else ObtenerMaximo:= ObtenerMaximo (a^.HD)
  end;
var mayorCodigo: integer;
begin
  writeln;
  writeln ('----- Modulo 1P4 ----->');
  writeln;
  write ('Mayor codigo de socio : ');
  writeln;
  mayorCodigo:= ObtenerMaximo (a);
  if (mayorCodigo = -9999) 
  then writeln ('Arbol vacio')
  else begin
         writeln;
         writeln ('El codigo mayor es ', mayorCodigo); 
         writeln;
       end; 
 end;
 
procedure Modulo2P4 (a: arbol);
{Retornar el menor código de producto.}

  function ObtenerMinimo (a: arbol): integer;
  begin
    if (a = nil) 
    then ObtenerMinimo:= 9999
    else if (a^.HI = nil) then ObtenerMinimo:= a^.dato.numero
                          else ObtenerMinimo:= ObtenerMinimo (a^.HI)
  end;
var menorCodigo: integer;
begin
  writeln;
  writeln ('----- Modulo 2P4 ----->');
  writeln;
  write ('Menor codigo de socio: ');
  writeln;
  menorCodigo:= ObtenerMinimo (a);
  if (menorCodigo = 9999) 
  then writeln ('Arbol vacio')
  else begin
         writeln;
         writeln ('El codigo menor es ', menorCodigo); 
         writeln;
       end; 
 end;

procedure modulo3P4(a:arbol);

  function encontre(a:arbol;socioBuscar:integer):boolean;
  begin
    if (a=nil) then
      encontre:= false
    else begin
      if (a^.dato.numero= socioBuscar) then
        encontre:=true 
      
      else
        encontre:=encontre(a^.HI,socioBuscar) or encontre(a^.HD,socioBuscar);
      end;
  
  end;
var
socioBuscar:integer;
begin
writeln;
  writeln ('----- Modulo 3P4 ----->');
  writeln;
  writeln('Ingrese Num Socio a Buscar');
  readln(socioBuscar);
  if(encontre(a,socioBuscar)) then
    writeln('Se encontro el numero de socio :) ')
  else 
    writeln('No se encontraba el socio :( ' );
end;

procedure Modulo4P4(a:arbol);
  procedure recorridoAcotado (a: arbol; inf, sup: integer;var contar:integer);
  begin
  if (a <> nil) then begin
    if (a^.dato.numero >= inf) then begin
      if (a^.dato.numero <= sup) then begin
        contar:=contar + 1 ;
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
  writeln ('----- Modulo 3P4 ----->');
  writeln;
  writeln('Ingrese Num  1');
  readln(codigo1);
  writeln('Ingrese Num 2 mayor a Num 1');
  readln(codigo2);
  recorridoAcotado(a,codigo1,codigo2,contar);
  writeln('La cantidad de numeros entre los dos valores es:= ', contar);
end;
var a: arbol; 
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  {InformarSociosOrdenDecreciente (a); COMPLETAR}
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  { InformarExistenciaNombreSocio (a); COMPLETAR
    InformarCantidadSocios (a); COMPLETAR
    InformarPromedioDeEdad (a); COMPLETAR
  } 
 
  Modulo1P4(a); 
  Modulo2P4(a); 
  Modulo3P4(a);
  Modulo4P4(a);
End.

