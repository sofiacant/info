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

    function buscarElemento (l:lista; x:integer):boolean;
    var
        esta:boolean;
    begin
        esta:=false;
        while (l<>nil) and (not esta) do
        begin
            if (l^.dato = x) then
                esta:=true;
            l:=l^.sig;
        end;
        buscarElemento:=esta;
    end;

var
    l:lista;
    x:integer;
begin
    cargarLista(l);
    imprimir(l);
    readln(x);
    writeln('esta?: ',buscarElemento(l,x));
end.
