clear variables;close all;clc;

%% Utilisation de l'ACP pour detecter deux classes

% Creation d'un echantillon contenant deux classes que nous allons
% retrouver via l'ACP
nb_indiv1 = 100;nb_indiv2 = 150;nb_indiv = nb_indiv1+nb_indiv2; 
nb_param = 30;
% Creation de la premiere classe autour de l'element moyen -.5*(1 .... 1)
X1 = randn(nb_indiv1,nb_param);X1 = X1 - 0.5*ones(nb_indiv1,1)*ones(1,nb_param);  
% Creation de la premiere classe autour de l'element moyen + (1 .... 1)
X2 = randn(nb_indiv2,nb_param);X2 = X2 + 1*ones(nb_indiv2,1)*ones(1,nb_param); 
% Creation du tableau des donnees (concatenation des deux classes) 
X = [X1;X2]; 

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X, ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = mean(X);
Xc = X - M;
sigma = (1/length(Xc))*(Xc')*Xc;
[vect,val]=eig(sigma);
[~,indices_tri]=sort(diag(val),'descend');
vect=vect(:,indices_tri);
C=Xc*vect;

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DES INDIVIDUS DE XC SUR LE PREMIER AXE DU REPERE 
% CANONIQUE. LES INDIVIDUS DES DEUX CLASSES DOIVENT ETRE REPRESENTES PAR 
% DEUX COULEURS DIFFERENTES.
% AFFICHER LA PROJECTION DE CES MEMES INDIVIDUS SUR LE PREMIER AXE 
% PRINCIPAL (AVEC A NOUVEAU UNE COULEUR PAR CLASSE).
% COMMENTER.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proj_cano = Xc(:,1);
proj_ppal = C(:,1);
[idx,~] = kmeans(Xc,2);


figure(1), clf, 
subplot(2,1,1)


% Affichage des donnees sur la premiere composante canonique :
% les individus de la premiere classe sont en rouge (p. ex), ceux de la 
% seconde classe sont en bleu
plot(proj_cano(idx ==1),zeros(1,sum(idx == 1)),'r*');hold on 
plot(proj_cano(idx ==2),zeros(1,sum(idx == 2)),'b*');
title('Visualisation des donnees sur le premier axe canonique')

% Affichage des donnees sur la premiere composante principale : (m�me
% code couleur)

subplot(2,1,2)
plot(proj_ppal(idx ==1),zeros(1,sum(idx == 1)),'r*');hold on 
plot(proj_ppal(idx ==2),zeros(1,sum(idx == 2)),'b*');
title('Visualisation des donnees sur le premier axe principal');

%On constate que la projection sur le premier axe principal nous permet de
%distinguer 2 classes contrairement a la projection sur l'axe canonique

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2), clf
A = sum(diag(sigma));
B = (diag(sigma)/A)*100;
stem([1:length(vect)],sort(B,'descend'));
title('Pourcentage d info contenue sur chaque composante ppale -- 2 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

%% Utilisation de l'ACP pour detecter plusieurs classes

% Dans le fichier 'jeu_de_donnees.mat' se trouvent 4 tableaux des donnees 
% d'individus vivant dans le meme espace. Chacun de ces tableaux 
% represente une classe. On concatene ces tableaux en un unique tableau X, 
% et on va chercher combien de composantes principales il faut prendre en 
% compte afin de detecter toutes les classes
load('quatre_classes.mat')
n1 = size(X1,1);n2 = size(X2,1);n3 = size(X3,1);n4 = size(X4,1);
n = n1+n2+n3+n4;
X = [X1;X2;X3;X4];
nb_param = size(X,2);

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = mean(X);
Xc = X - M;
sigma = (1/n)*(Xc')*Xc;
[vect,val]=eig(sigma);
[~,indices_tri]=sort(diag(val),'descend');
vect=vect(:,indices_tri);
C=Xc*vect;

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DE XC SUR :
% - LE PREMIER AXE PRINCIPAL
% - LE DEUXIEME AXE PRINCIPAL
% - LE TROISIEME AXE PRINCIPAL
% EN UTILISANT UNE COULEUR PAR CLASSE.
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES EST-ON CAPABLE DE DETECTER AVEC LA PREMIERE 
% COMPOSANTE, LA DEUXIEME, LA TROISIEME, PUIS LES TROIS ENSEMBLES ?
% NB : VOTRE FIGURE DOIT CORRESPONDRE A LA FIGURE 2(b) DE L'ENONCE.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proj_1 = C(:,1);
proj_2 = C(:,2);
proj_3 = C(:,3);
[idx,~] = kmeans(C,4);

figure(3),clf
subplot(3,1,1)
plot(proj_1(idx == 1),zeros(1,sum(idx == 1)),'r*');hold on
plot(proj_1(idx == 2),zeros(1,sum(idx == 2)),'b*');hold on
plot(proj_1(idx == 3),zeros(1,sum(idx == 3)),'g*');hold on
plot(proj_1(idx == 4),zeros(1,sum(idx == 4)),'m*');
title('1ere composante ppale')

subplot(3,1,2)
plot(proj_2(idx == 1),zeros(1,sum(idx == 1)),'r*');hold on
plot(proj_2(idx == 2),zeros(1,sum(idx == 2)),'b*');hold on
plot(proj_2(idx == 3),zeros(1,sum(idx == 3)),'g*');hold on
plot(proj_2(idx == 4),zeros(1,sum(idx == 4)),'m*');
title('2eme composante ppale')

subplot(3,1,3)
plot(proj_3(idx == 1),zeros(1,sum(idx == 1)),'r*');hold on
plot(proj_3(idx == 2),zeros(1,sum(idx == 2)),'b*');hold on
plot(proj_3(idx == 3),zeros(1,sum(idx == 3)),'g*');hold on
plot(proj_3(idx == 4),zeros(1,sum(idx == 4)),'m*');
title('3eme composante ppale')

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LES DEUX PREMIERES COMPOSANTES PRINCIPALES DE X DANS LE PLAN, 
% PUIS AFFICHER LES TROIS PREMIERES COMPOSANTES PRINCIPALES DE X DANS 
% L'ESPACE. UTILISER UNE COULEUR PAR CLASSE. 
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES PEUT-ON DETECTER DANS LE PLAN ? DANS L'ESPACE ?
% NB : VOS FIGURES DOIVENT CORRESPONDRE AUX FIGURES 2(c) ET (d) DE L'ENONCE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[idx1,~] = kmeans(C,4);
C1 = C(:,1);
C2 = C(:,2);
figure(4), clf, 
grid on 
plot(C1(idx1 == 1),C2(idx1 == 1),'r*');grid on;hold on 
plot(C1(idx1 == 2),C2(idx1 == 2),'b*');grid on;hold on 
plot(C1(idx1 == 3),C2(idx1 == 3),'g*');grid on;hold on 
plot(C1(idx1 == 4),C2(idx1 == 4),'m*');
legend('classe1','classe2','classe3','classe4');
title('Proj. des donnees sur les deux 1ers axes ppaux')

figure(5),clf, 
C3 = C(:,3);
grid on
plot3(C1(idx1 == 1),C2(idx1 == 1),C3(idx1 == 1),'r*');grid on;hold on 
plot3(C1(idx1 == 2),C2(idx1 == 2),C3(idx1 == 2),'b*');grid on;hold on 
plot3(C1(idx1 == 3),C2(idx1 == 3),C3(idx1 == 3),'g*');grid on;hold on 
plot3(C1(idx1 == 4),C2(idx1 == 4),C3(idx1 == 4),'m*');grid on;
title('Proj. des donnees sur 3 1ers axes ppaux')

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6),clf
A = sum(diag(sigma));
B = (diag(sigma)/A)*100;
stem([1:length(vect)],sort(B,'descend'));
title('Pourcentage d info contenue sur chaque composante ppale -- 4 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

%disp(' ** A COMPLETER ** CONSIGNES EN COMMENTAIRE ** ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPARER CETTE FIGURE AVEC LA MEME FIGURE OBTENUE POUR LA CLASSIFICATION
% EN DEUX GROUPES.
%
% QUESTION 5 RAPPORT :
% COMMENTER.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

