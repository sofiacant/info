program ejercicio;
const
    cod_fin=0;
type
    rango_dia=1..30;
    rango_mes=1..12;

    envio=record
        cod_cliente:integer;
        dia:rango_dia;
        mes:rango_mes;
        cod_postal:integer;
        peso:real;
    end;

    vector=array[rango_mes] of integer;

    regArbol=record
        cod_postal:integer;
        vector:vector;
    end;

    arbol=^nodo;
    nodo=record
        dato:regArbol;
        HI:arbol;
        HD:arbol;
    end;

procedure cargarArbol (var a:arbol);

procedure guardarRegA (e:envio; var regA:regArbol);
procedure incializarVector (var v:vector);
var
    i:rango_mes;
begin
    for i := 1 to 12 do
        v[i]:=0;
end;

begin
    regA.cod_postal:=e.cod_postal;
    incializarVector(regA.vector);
end;

procedure leerEnvio(var e:envio);
begin
    e.cod_cliente:=random(50);
    if (e.cod_cliente= cod_fin)then begin
        e.dia:=1+random(30-1+1);
        e.mes:=1+random(12-1+1);
        e.cod_postal:=random(50);
        e.peso:=random(20000)/(random(10)+1);
    end;
end;

procedure insertarArbol (var a:arbol; regA:regArbol; mes:integer);
begin
    if (a=nil) then
    begin
        new(a);
        a^.dato.cod_postal:=regA.cod_postal;
        a^.dato.vector[mes]:=a^.dato.vector[mes] +1;
        a^.HI:=nil;
        a^.HD:=nil;
    end
    else if (regA.cod_postal = a^.dato.cod_postal) then
        a^.dato.vector[mes]:=a^.dato.vector[mes] +1

        else if (regA.cod_postal < a^.dato.cod_postal) then
            insertarArbol(a^.HI,regA,mes)
            else
                insertarArbol(a^.HD,regA,mes);
end;
var
    e:envio;
    regA:regArbol;
begin
    leerEnvio(e);
    while (e.cod_cliente <> cod_fin) do
    begin
        guardarRegA(e,regA);
        {regA.vector[e.mes]:=regA.vector[e.mes] + 1:}
        insertarArbol(a,regA,e.mes);
        leerEnvio(e);
    end;
end;

// PROGRAMA PRINCIPAL
var
    a:arbol;
begin
    a:=nil;
    randomize;
    cargarArbol(a);
end.
