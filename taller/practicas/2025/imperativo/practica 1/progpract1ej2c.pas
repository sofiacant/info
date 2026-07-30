program ejercicio;
const
    dimF=300;
type

        oficina = record
            codID:integer;
            dni:integer;
            valor:integer;
        end;

        vector=array[1..dimF] of oficina;

    procedure leerOficina (var  o:oficina);
    begin
        readln(o.codID);
    end;

    procedure cargarVector (var v:vector; var dimL:integer);
    var
        o:oficina;
    begin
        dimL:=1;
        leerOficina(o);
        while (dimL <= dimF) and (o.codID <> - 1) do 
        begin
            v[dimL]:=o;
            dimL:=dimL + 1;
            leerOficina(o);
        end;
    end;

    procedure ordenarInsercion (var v:vector ; diml:integer);
    var
        item:integer;
        i,j,pos:integer;
    begin
        for i:= 1 to dimL-1 do 
        begin
            pos:= i;
            for j:= i+1 to diml do
                if (v[j].codID < v[pos].codID) then
                    pos:=j;
                item:=v[pos].codID;
                v[pos].codID:=v[i].codID;
                v[i].codID:=item;
        end;
    end;

var
    v:vector;
    i:integer;
    dimL:integer;
begin
    cargarVector(v,dimL);
    ordenarInsercion(v,dimL);
    for i := 1 to dimL do 
        writeln(v[i].codID);
end.
NUEVO

Enviar mensaje a Sala de estudio 1
