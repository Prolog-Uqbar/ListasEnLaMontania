tieneRefugio(catedral,frei,2012).
tieneRefugio(lopez,refugioLopez,1983).

tieneRefugio(tronador,ottoMeiling,2520).
tieneRefugio(tronador,lasNubes,2900).
tieneRefugio(tronador,pampaLinda,1000).
tieneRefugio(tronador,limiteConChile,3000).

tramo(ottoMeiling,lasNubes,5).
tramo(pampaLinda,ottoMeiling,10).
tramo(pampaLinda,lasNubes,12).
tramo(lasNubes,limiteConChile,1).
tramo(frei,ottoMeiling,7).

existeCamino(Salida,Llegada):-
    tramo(Salida,Llegada,_).  
    
existeCamino(Salida,Llegada):-
    tramo(UnLugar,Llegada,_),
    existeCamino(Salida,UnLugar).
    
tiempoRecorrido(Salida,Llegada,Tiempo):-
    tramo(Salida,Llegada,Tiempo).  
    
tiempoRecorrido(Salida,Llegada,TiempoTotal):-
    tramo(UnLugar,Llegada,Tiempo),
    tiempoRecorrido(Salida,UnLugar,TiempoParcial),
    TiempoTotal is TiempoParcial + Tiempo.



recorrido(Salida,Llegada,[Salida,Llegada]):-
    tramo(Salida,Llegada,_).  

/*
recorrido(Salida,Llegada,OtraLista):-
    tramo(UnLugar,Llegada,_),
    recorrido(Salida,UnLugar,RecorridoParcial),
    agregaAlFinal(RecorridoParcial,Llegada,OtraLista).

agregaAlFinal(Lista,Elemento,NuevaLista):-
    append(Lista,[Elemento],NuevaLista).
*/
recorrido(Salida, Llegada, [Salida| RecorridoParcial]):-
    tramo(Salida, Intermedio,_),
    recorrido(Intermedio, Llegada, RecorridoParcial).

/*
    existeCamino(Lugar,Nuevo):-
        existeCamino(Lugar,OtroLugar),
        tramo(OtroLugar,Nuevo,_).
    existeCamino(Salida,Llegada):-
        tramo(Salida,Intermedio,_),
        existeCamino(Intermedio,Llegada).  

*/

alturaPromedio(AlturaPromedio):-
    findall( Altura,  tieneRefugio(_,_,Altura),   Alturas),
    promedio(Alturas,AlturaPromedio).

alturaPromedioMontania(Montania,AlturaPromedio):-
    tieneRefugio(Montania,_,_),
    findall( Altura, tieneRefugio(Montania,_,Altura),Alturas),
    promedio(Alturas,AlturaPromedio).


promedio(Lista,Promedio):-
    sum_list(Lista, Sumatoria),
    length(Lista,Cantidad),
    Promedio is Sumatoria / Cantidad.



equipaje(juan,[20,2,1]).
equipaje(ana,[16,1,5,8]).
equipaje(julieta,[20]).
equipaje(pedro,[20,5,6,7]).

quierenIr(tronador,[juan,pedro,ana,sofia]).
quierenIr(lopez,[juan,carlos,julieta]).
quierenIr(lopez,[juan,carlos]).
quierenIr(lopez,[srPerez,sraGarcia,pequenioPereGarcia,pequeniaPerezGarcia]).
quierenIr(catedral,[ana,sofia,juelita]).


quiereIr(Montania,Persona):-
    quierenIr(Montania,Grupo),
    member(Persona,Grupo).
   

cuantosQuierenIrJuntos(Montania,Cantidad):-
    quierenIr(Montania,Grupo),
    length(Grupo, Cantidad).
    
%1) companieroDeExcursionAMasDeUnaMontania(Fulano,Mengano).

/*
companieroDeExcursionAMasDeUnaMontania(Fulano,Mengano):-
    quiereIr(Montania1, Fulano),
    quiereIr(Montania2,Fulano),
    quiereIr(Montania2, Mengano),
    quiereIr(Montania1, Mengano),
    Montania1 \=  Montania2,
    Fulano \= Mengano.
*/
companieroEnMasDeUnaMontania(Fulano, Mengano):-
    companieroDeExcursion(Montania1, Fulano, Mengano),
    companieroDeExcursion(Montania2, Fulano, Mengano),
    Montania1 \= Montania2.

companieroDeExcursion(Montania,Persona1,Persona2):-
    quierenIr(Montania, Grupo1),
    member(Persona1, Grupo1),
    member(Persona2, Grupo1),
    Persona1 \= Persona2.

%2) puedeLlegar(Fulano,Refugio)  

puedeLlegar(Fulano, Refugio):-
    tieneRefugio(_, Refugio, Altura),
    pesoDelEquipaje(Fulano,Peso),
    Peso * 50 < Altura.

pesoDelEquipaje(Fulano, Peso):-
    equipaje(Fulano, Equipo),
    sum_list(Equipo, Peso).


%3) quien es el que lleva mas cosas?

llevaMasCosas(Persona):-
    cantidadCosasQueLLeva(Persona, Cant),
    forall(
        cantidadCosasQueLLeva(_, OtraCant),
        Cant >= OtraCant
    ).

cantidadCosasQueLLeva(Persona, Cant):-
    equipaje(Persona, ListaCosas),
    length(ListaCosas, Cant).

%4) montaniaRepetida(Montania) si
% si existe algun grupo que vaya a esa montania y que en otro momento, todos sus integrantes vuelvan a ir juntos en otra excursion al a misma montania
% 5) promedio altura de los refugios de las montanias

