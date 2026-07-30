program ej3p1;
const
  codFin = -1;
  max_gen = 8;
type
  rango_gen = 1..max_gen;
  
  pelicula = record
    cod: integer;
    cod_gen: rango_gen;
    puntaje: real;
  end;
  
  lista = ^nodo;
  nodo = record
    dato: pelicula;
    sig: lista;
  end;
  
  vectorPeliculas = array[rango_gen] of lista;
  vectorGeneros = array[rango_gen] of pelicula; // Ahora guarda el registro completo

procedure cargarVectorP(var vp: vectorPeliculas);
  procedure leerPelicula(var p: pelicula);
  begin
    write('Codigo de pelicula: '); readln(p.cod);
    if (p.cod <> codFin) then begin
      write('Genero (1-8): '); readln(p.cod_gen);
      write('Puntaje: '); readln(p.puntaje);
    end;
  end;

  procedure agregarAtras(var l, ult: lista; p: pelicula);
  var nue: lista;
  begin
    new(nue); nue^.dato := p; nue^.sig := nil;
    if (l = nil) then l := nue
    else ult^.sig := nue;
    ult := nue;
  end;

var
  p: pelicula;
  vUlt: vectorPeliculas;
  i: rango_gen;
begin
  for i := 1 to max_gen do begin
    vp[i] := nil;
    vUlt[i] := nil; // ¡IMPORTANTE! Inicializar punteros de control
  end;
  
  leerPelicula(p);
  while (p.cod <> codFin) do begin
    agregarAtras(vp[p.cod_gen], vUlt[p.cod_gen], p);
    leerPelicula(p);
  end;
end;

function obtenerMaxPuntaje(l: lista): pelicula;
var
  pMax: pelicula;
begin
  pMax.puntaje := -1;
  pMax.cod := -1; 
  while (l <> nil) do begin
    if (l^.dato.puntaje > pMax.puntaje) then
      pMax := l^.dato;
    l := l^.sig;
  end;
  obtenerMaxPuntaje := pMax;
end;

procedure procesarVector(vp: vectorPeliculas; var vg: vectorGeneros);
var i: rango_gen;
begin
  for i := 1 to max_gen do
    vg[i] := obtenerMaxPuntaje(vp[i]);
end;

procedure ordenarVector(var vg: vectorGeneros);
var
  i, j, pos: integer;
  item: pelicula;
begin
  for i := 1 to max_gen - 1 do begin
    pos := i;
    for j := i + 1 to max_gen do
      if (vg[j].puntaje < vg[pos].puntaje) then pos := j;
    
    item := vg[pos];
    vg[pos] := vg[i];
    vg[i] := item;
  end;
end;

procedure mostrarMaxMin(vg: vectorGeneros);
begin
  // Como el vector ESTÁ ORDENADO por puntaje de menor a mayor:
  // El primero es el mínimo y el último es el máximo.
  writeln('Pelicula con menor puntaje: ', vg[1].cod, ' (Puntaje: ', vg[1].puntaje:0:2, ')');
  writeln('Pelicula con mayor puntaje: ', vg[max_gen].cod, ' (Puntaje: ', vg[max_gen].puntaje:0:2, ')');
end;

var
  vp: vectorPeliculas;
  vg: vectorGeneros;
begin
  cargarVectorP(vp);
  procesarVector(vp, vg);
  ordenarVector(vg);
  mostrarMaxMin(vg);
  readln;
end.
