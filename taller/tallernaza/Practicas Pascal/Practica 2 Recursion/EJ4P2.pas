{
 Desafío…
4.- Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
el número 0 (cero).
Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la
próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.
   
}


program Ejer4;
uses 
  SysUtils;
function devolverBinario(num:integer):string;
begin 
  if (num=0) then
    devolverBinario:='0'
  else
    if (num=1) then
       devolverBinario:='1'
    else
      devolverBinario:= devolverBinario(num div 2)+ IntToStr(num mod 2);
      
 end;


var
num:integer;
BEGIN
	read(num);
	while (num<>-1) do begin
	    write('Su equvalente en vinario es:= ',devolverBinario(num));
        writeln();
        read (num);
    end;
END.

