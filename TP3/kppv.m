function [individu_reconnu,postures,min_distance,label] = kppv(DataA,DataT,labelA,K,nb_postures)
    distance = sum((DataA - DataT).^2,2);
    [~,Ind] = mink(distance,K);
    label = labelA(Ind);
    individu_reconnu = mode(label);
    postures = mod(Ind + 3, nb_postures) + 1;
    min_distance = min(distance);
end