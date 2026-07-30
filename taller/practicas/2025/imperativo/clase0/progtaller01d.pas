//Modifique el programa para que imprima N números aleatorios en el rango (A,B), 
//donde N, A y B son números enteros que se leen por teclado.
program ProgramaNumAleatorio;
var 
	n:integer;
	a:integer;
	b:integer;
	i, ale:integer;
	
	
	procedure imprimir(a,b,n:integer);
	begin
	 for i:= 1 to N do begin
		ale:= A + random (B-A+1); {devuelve un valor aleatorio en el intervalo 0 a 99}

		writeln ('El numero aleatorio generado es: ', ale);
	 end;
	end;
	
begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
     writeln('Ingrese un numero para el limite inferior'); readln(a);
     writeln('Ingrese un numero para el limite superior');readln(b);
     writeln('Ingrese un numero para la cantidad de veces que se imprima un numero random');readln(n);
     
     imprimir(a,b,n);
     
    
	 writeln ('Presione cualquier tecla para finalizar');
     readln;
end.
