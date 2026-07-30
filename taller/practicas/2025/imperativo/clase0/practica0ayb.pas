program ejercicio;
type
    lista=^nodo;
    nodo=record
        dato:integer;
        sig:lista;
    end;

    procedure AgregarAdelante (var l:lista; num:integer);
    var
        nue:lista;
    begin
        new(nue);
        nue^.dato:=num;
        nue^.sig:=l;
        l:=nue;
    end;

    procedure cargarLista (var l:lista);
    var
        ale:integer;
    begin
        randomize;
        repeat
        ale:=100+random(51);
        AgregarAdelante(l,ale);
        until (ale = 120);
    end;

    procedure imprimir (l:lista);
    begin
        while (l<>nil) do
        begin
            writeln(l^.dato);
            l:=l^.sig;
        end;
    end;

var
    l:lista;
begin
    cargarLista(l);
    imprimir(l);
end.

begin
    l:=nil;
    cargarLista(l);
end.
