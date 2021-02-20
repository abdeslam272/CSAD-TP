clear;
close all;

load donnees2;

% Calcul de l'individu moyen :
individu_moyen= mean(X2);

% Centrage des donnees :
X_c_2 = X2 - individu_moyen;

% Calcul de la matrice Sigma_2 (de taille n x n) [voir Annexe 1 pour la nature de Sigma_2] :
Sigma_2 = (X_c_2 * X_c_2')/n ;

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
[W,D] = eig(Sigma_2);

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[v,ind] = sort(diag(D),'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
W = W(:,ind);

% Elimination du dernier vecteur propre de Sigma_2 :
W = W(:,1:end-1);

% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = X_c_2' * W ;
    
% Normalisation des vecteurs propres de Sigma
% [les vecteurs propres de Sigma_2 sont normalisés
% mais le calcul qui donne W, les vecteurs propres de Sigma,
% leur fait perdre cette propriété] :
W(:,1:n-1) = W(:,1:n-1)/norm(W(:,1:n-1));

% matrice de confusion
matrice_confusion = zeros(37,37);

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 15;

% N premieres composantes principales des images d'apprentissage :
n_c_a = X_c_2 * W(:,1:N);

labelA =  numeros_individus';

K = 3;

%pour calculer la matrice de confusion 
for x = 1:37 
    individu = x;
    for y = 1:3
        posture = y;
        chemin = './Images_Projet_2020';
        fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
        Im=importdata(fichier);
        I=rgb2gray(Im);
        I=im2double(I);
        image_test=I(:)';
 
        % N premieres composantes principales de l'image de test :
        n_c_t = (image_test - individu_moyen) * W(:,1:N);

        % Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
        [individu_reconnu,~,~,~] = kppv(n_c_a,n_c_t,labelA,K,nb_postures);

        % matrice confusion
        matrice_confusion(individu,individu_reconnu) = matrice_confusion(individu,individu_reconnu) + 1 ; 
    end	
end

performance = abs(1-trace(matrice_confusion)/(37*3));
