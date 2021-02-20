clear all
close all

% Choix des images parmi les 37 individus et 6 postures faciales :
numeros_individus = 1:37;
numeros_postures = 1;

% Chargement et conversion des images
chemin = './Images_Projet_2020';
X2=[];
for i=numeros_individus
     for j=numeros_postures
         fichier = [chemin '/' num2str(i+3) '-' num2str(j) '.jpg'];
         Im=importdata(fichier);
         I=rgb2gray(Im);
         I=im2double(I);
         X2=[X2;I(:)'];
    end
end

% Nombre de lignes n de X (nombre d'images selectionnees) :
 nb_individus = length(numeros_individus);
 nb_postures = length(numeros_postures);
 n = nb_individus*nb_postures;
 
 % Dimensions des images
nb_lignes= 480;
nb_colonnes = 640;
p = nb_lignes*nb_colonnes;

save donnees2