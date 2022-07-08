tieneRefugio(catedral,frei,2012).
tieneRefugio(lopez,refugioLopez,1983).
tieneRefugio(tronador,ottoMeiling,2520).

equipaje(juan,[20,2,1]).
equipaje(ana,[16,1,5,8]).
equipaje(julieta,[20]).

quierenIr(tronador,[juan,pedro,ana,sofia]).
quierenIr(lopez,[juan,carlos,julieta]).
quierenIr(lopez,[juan,carlos]).
quierenIr(lopez,[srPerez,sraGarcia,pequenioPereGarcia,pequeniaPerezGarcia]).
quierenIr(catedral,[ana,sofia,juelita]).

%quiereIr(tronador,juan).
%quiereIr(tronador,pedro).
%quiereIr(tronador,ana).
%quiereIr(tronador,sofia).

quiereIr(Montania,Persona):-
    quierenIr(Montania,Grupo),
    member(Persona,Grupo).
   

cuantosQuierenIrJuntos(Montania,Cantidad):-
    quierenIr(Montania,Grupo),
    length(Grupo, Cantidad).
    

%1) companieroDeExcursionAMasDeUnaMontania(Fulano,Mengano).
%2) puedeLlegar(Fulano,Refugio)  
%% kilos que lleva * 50 menor a la altura


