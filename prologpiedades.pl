/*
funtores:
    casa(metrosCuadrados)
    departamento(cantAmbientes)
    loft(añoConstruccion)


*/

%vive(Persona, Propiedad, Barrio).
vive(juan, casa(120), almagro).
vive(nico, departamento(3,2), almagro).
vive(alf, departamento(3,1), almagro).
vive(julian, loft(2000), almagro).
vive(vale, departamento(4,1), flores).
vive(fer, casa(110), flores).

vive(vicky, departamento(4,2), lanus).

barrio(Barrio):- vive(_,_,Barrio).

barrioCopado(Barrio):-
    barrio(Barrio),
    forall(vive(_,Propiedad, Barrio), esCopada(Propiedad)).

esCopada(casa(Metros)):- Metros > 100.
esCopada(departamento(Ambientes, _)):- Ambientes > 3.
esCopada(departamento(_, Banios)):- Banios > 1.
esCopada(loft(AnioDeConstruccion)):- AnioDeConstruccion > 2015.

barrioCaro(Barrio):-
    barrio(Barrio),
    not((vive(_, Propiedad, Barrio), esBarata(Propiedad))).

esBarata(loft(AnioDeConstruccion)):- AnioDeConstruccion < 2005.
esBarata(casa(Metros)):- Metros <  90.
esBarata(departamento(Ambientes,_)):- Ambientes =< 2.

valorPropiedad(juan, 150000).
valorPropiedad(nico, 80000).
valorPropiedad(alf, 75000).
valorPropiedad(julian, 140000).
valorPropiedad(vale, 95000).
valorPropiedad(fer, 60000).

sePuedeComprar(PropiedadesPosibles, PlataDisponible, PlataRestante):-
    findall(Propiedad,precioDe(Propiedad,_), Propiedades),
    sublista(Propiedades, PropiedadesPosibles),
    puedeComprar(PropiedadesPosibles, PlataDisponible, PlataRestante).

puedeComprar(Propiedades, PlataDisponible, PlataRestante):-
    precioTotal(Propiedades, PrecioDePropiedades),
    PlataRestante is PlataDisponible - PrecioDePropiedades,
    PlataRestante >= 0.

precioTotal(Propiedades, Total):-
    findall(Precio, precioDePropiedadEn(Propiedades,_,Precio) , Precios),
    sumlist(Precios, Total).

precioDePropiedadEn(Propiedades, Propiedad, Precio):-
    member(Propiedad, Propiedades), 
    precioDe(Propiedad ,Precio).

precioDe(propiedad(Propiedad, Persona), Valor):-
    vive(Persona, Propiedad,_),
    valorPropiedad(Persona, Valor).

sublista([],[]).
sublista([_|Cola], Sublista):-sublista(Cola, Sublista).
sublista([Cabeza|Cola],[Cabeza|Sublista]):-sublista(Cola, Sublista).
