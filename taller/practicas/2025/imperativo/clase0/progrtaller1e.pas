//e) Modifique el programa para que imprima números aleatorios en el rango (A,B) hasta que se genere un valor igual a F, el cual no debe imprimirse. 
//F, A y B son números enteros que se leen por teclado.

program ProgramaNumAleatorio;
var 
	f:integer;
	a:integer;
	b:integer;
	ale:integer;
begin
     randomize; {Elige una semilla distinta cada vez que se ejecuta el programa.}
                {La semilla sirve para generar series de números aleatorios distintos.}
                {Sin la llamada al procedimiento randomize, en todas las ejecuciones
                 del programa se elige siempre la misma serie de números aleatorios.}
     readln(a);
    
     readln(b);
     readln(f);
     ale:= A + random (B-A+1); {devuelve un valor aleatorio en el intervalo 0 a 99}
	while( ale <> f) do begin
		writeln ('El numero aleatorio generado es: ', ale);			
		ale:= A + random (B-A+1); {devuelve un valor aleatorio en el intervalo 0 a 99}
	end;	
	writeln ('Presione cualquier tecla para finalizar');
    readln;
end.
