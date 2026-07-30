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
        actual:integer;
        i,j:integer;
    begin
            for i := 2 to dimL do
            begin
                actual:=v[i].codID;
                j:=i-1;
                while (j > 0) and (v[j].codID>actual) do
                begin
                    v[j+1]:=v[j];
                    j:=j-1;
                end;
                v[j+1].codID:=actual;
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
