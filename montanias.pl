tieneRefugio(catedral,frei).
tieneRefugio(lopez,refugioLopez).
tieneRefugio(tronador,ottoMeiling).

quierenIr(tronador,[juan,pedro,ana,sofia]).
quierenIr(lopez,[juan,carlos,julieta]).
quierenIr(lopez,[srPerez,sraGarcia,pequenioPereGarcia,pequeniaPerezGarcia]).

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
    



