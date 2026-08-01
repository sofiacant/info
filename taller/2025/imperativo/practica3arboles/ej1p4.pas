{Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente.
    ii. Informar los datos de los socios en orden decreciente.
     iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.

}

Program ImperativoClase3;

type 
	rangoEdad = 12..100;
	
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
 
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }     
procedure GenerarArbol (var a: arbol);

  Procedure CargarSocio (var s: socio);
  var 
	vNombres:array [0..9] of string = ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)then begin
       s.nombre:= vNombres[random(10)];
       s.edad:= 12 + random (79);
    end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil)then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
    end
    else if (elem.numero < a^.dato.numero)then 
		InsertarElemento(a^.HI, elem)
    else 
		InsertarElemento(a^.HD, elem); 
  end;

var 
	unSocio: socio;												//variable del proceso ppal general arbol
Begin
	writeln ('----- Ingreso de socios y armado del arbol ----->');
	a:= nil;
	CargarSocio (unSocio);
	while (unSocio.numero <> 0)do begin
		InsertarElemento (a, unSocio);
		CargarSocio (unSocio);
	end;
	writeln ('//////////////////////////////////////////////////////////');
end;																			//final de modulo generar arbol

procedure InformarSociosOrdenCreciente (a: arbol); 																			//modulo externo
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
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 InformarDatosSociosOrdenCreciente (a);
end;


procedure InformarSociosOrdenDecreciente (a:arbol);
begin
	if(a<>nil)then begin
		InformarSociosOrdenDecreciente(a^.HD)
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarSociosOrdenDecreciente(a^.HI);
	end;
end;
		

procedure InformarNumeroSocioConMasEdad (a: arbol);																//proceso externo
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; edad, nroSocio : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := edad;
		maxElem := nroSocio;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad, maxNum, a^.dato.edad,  a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad, maxNum);
		  numeroMasEdad(a^.hd, maxEdad, maxNum);
	   end; 
	end;

var 
	maxEdad, maxNum: integer;
begin
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) then 
	writeln ('Arbol sin elementos')
  else 
      writeln ('Numero de socio con mas edad: ', maxNum);
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var 
	resto: integer;
  begin
     if (a = nil) then 
		AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then 
				a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
     end;  
  end;

begin

  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln ('//////////////////////////////////////////////////////////');
end;

{vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.}
function  InformarExistenciaNombreSocio (a:arbol):boolean





var
	
begin
	readln()

end;



var a: arbol; 
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  InformarSociosOrdenDecreciente (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  
  InformarExistenciaNombreSocio (a); COMPLETAR
    InformarCantidadSocios (a); COMPLETAR
    InformarPromedioDeEdad (a); COMPLETAR
  }   
End.
