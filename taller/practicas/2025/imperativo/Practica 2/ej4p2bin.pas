{4.- Realizar un programa que lea números y que utilice un módulo recursivo que escriba el 
equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa 
el número 0 (cero).  
Ayuda:  Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2. 
¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la 
próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111. }

program ejercicio;

procedure convertirNum (var num:integer;var total:integer);
var
	dig:integer;
begin
	dig := num mod 2;
	total:= (total*10)+dig;
	num := num div 2;
	if (num <> 0) then begin
		convertirNum(num,total);
		writeln(total);
	end;
end;	

function invertir (total:integer):integer;
var
	dig,inv:integer;
begin
	inv:=0;
	while (total <> 0) do
	begin
	dig:=total mod 10;
	inv:= (inv*10)+dig;
	total:= total div 10;
	end;
	invertir:=inv;
end;
	
	

var
	num,total:integer;
begin
	readln(num);

	while (num <> 0) do begin  
		total:=0;
		writeln('Numero en binario: '); convertirNum(num,total);
		writeln(invertir(total));
		readln(num);
	end;
	
end.
