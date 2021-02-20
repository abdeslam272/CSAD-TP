clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 1.0e+01;

% Pourcentage d'information 
per = 0.95;

%random test
individu = randi(37);
posture = randi(6);

chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;


% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
n_c_a = X_c * W(:,1:N);

% N premieres composantes principales de l'image de test :
n_c_t = (image_test - individu_moyen) * W(:,1:N);

K = 3;

labelA = zeros(nb_individus,nb_postures);
for i=1:nb_individus 
    labelA(i,:) = numeros_individus' ; 
end
labelA = labelA(:);

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
[individu_reconnu,postures,min_distance,label] = kppv(n_c_a,n_c_t,labelA,K,nb_postures);

% Affichage du resultat :
if min_distance < s
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end

% Affichage de l'image requête et des K  proches voisins :
figure('Name',"Résultat d'une requête sur une base de visages",'Position',[0.2*L,0.2*H,0.6*L,0.5*H]);
subplot(1,K+1,1);
colormap gray;
imagesc(I); 
axis image;
title("Requête");
for i = 1:K
    subplot(1,K+1,i+1);
    image = [chemin '/' num2str(label(i) + 3) '-' num2str(postures(i)) '.jpg'];
    I=rgb2gray(importdata(image));    
    I=im2double(I);
    imagesc(I);    
    axis image;
    title("Trouvée - choix " + i);
end
