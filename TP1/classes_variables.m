clear variables
close all

% chargement du jeu de donn�es
load('dataset.mat')

%CALCULE DELA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
M = mean(X);
Xc = X - M;
sigma = (1/length(X))*(Xc')*Xc;
[vect,val]=eig(sigma);
[~,indices_tri]=sort(diag(val),'descend');
vect=vect(:,indices_tri);
C=Xc*vect;
C = C';

%rng(0,'twister'); %pour la reproduction
[~,centre] = kmeans(C,6);
[idx,~] = kmeans(C,6,'start',centre);
C1 = C(:,1);
C2 = C(:,2);
C3 = C(:,3);

figure(1), clf, 
grid on 

plot(C1(idx == 1),C2(idx == 1),'r.');grid on;hold on;
plot(C1(idx == 2),C2(idx == 2),'k.');grid on;hold on;
plot(C1(idx == 3),C2(idx == 3),'c.');grid on;hold on;
plot(C1(idx == 4),C2(idx == 4),'g.');grid on;hold on;
plot(C1(idx == 5),C2(idx == 5),'y.');grid on;hold on;
plot(C1(idx == 6),C2(idx == 6),'m.');grid on;hold on;
plot(centre(:,1),centre(:,2),'b+','linewidth',3);grid on;
title('Proj. des donnees sur les deux 1ers axes ppaux');



figure(5),clf, 
C3 = C(:,3);
grid on
plot3(C1(idx == 1),C2(idx == 1),C3(idx == 1),'r.');grid on;hold on 
plot3(C1(idx == 2),C2(idx == 2),C3(idx == 2),'k.');grid on;hold on 
plot3(C1(idx == 3),C2(idx == 3),C3(idx == 3),'c.');grid on;hold on 
plot3(C1(idx == 4),C2(idx == 4),C3(idx == 4),'g.');grid on;hold on
plot3(C1(idx == 5),C2(idx == 5),C3(idx == 5),'y.');grid on;hold on
plot3(C1(idx == 6),C2(idx == 6),C3(idx == 6),'m.');grid on;hold on 
title('Proj. des donnees sur 3 1ers axes ppaux')