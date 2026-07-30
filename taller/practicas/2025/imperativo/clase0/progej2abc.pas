//2a),b),c)
program NumAleatorio;
const
	dimF=50;
type
	vector=array[1..dimF] of integer;
	
	procedure cargarvector(min,max:integer; var v:vector; var dimL:integer);
	var
		ale:integer;

	begin	
		randomize;
		dimL:=1;
		ale:=min+random(max-min+1);
		while (dimL<dimF) and (ale <> 0) do begin
			v[dimL]:=ale;
			ale:=min+random(max-min+1);
			dimL:=dimL+1;
		end;
	end;
	
var 
	min,max:integer;
	i,diml:integer;
	vec:vector;
begin
	writeln('Ingresar el minimo');readln(min);
	writeln('Ingresar el maximo');readln(max);
	cargarvector(min,max,vec,dimL);
	for i:= 1 to dimL do 
		writeln(vec[i]);
end.

-------
//con orden inverso
	//for i:=diml downto 1 do 
		//writeln(vec[i]);
//end.
