clear all;close all;clc

%lecture de données
matrice1 = load('eigen1.txt');
matrice2 = load('eigen2.txt');
matrice3 = load('eigen3.txt');
matrice4 = load('eigen4.txt');

%tracé des valeurs propres
figure;
plot(matrice1,'k','LineWidth' ,2);hold on;
plot(matrice2,'m','LineWidth' ,2);hold on;
plot(matrice3,'b','LineWidth' ,2);hold on;
plot(matrice4,'g','LineWidth' ,2);hold on;
legend('type1','type2','type3','type4');
ylabel('valeur propre');












