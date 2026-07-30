{4.- Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
el número 0 (cero).
Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la
próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.}

program ej4p2;
Const
	num_fin=0;

procedure aBinario(var num:integer);
var
	dig:integer;
begin
	if (num<>0)then begin
		if(num < 2)then
			dig:=num
		else begin
			if (num mod 2= 0)then
				writeln(0);
			else
				writeln(1);
			aBinario(num div 2);
		end;
	end;
end;
	
Procedure aBinar	

var
	num:integer;
begin
	writeln('Ingrese un numero para pasarlo a binario ');
	readln(num);
	aBinario(num);
end.
