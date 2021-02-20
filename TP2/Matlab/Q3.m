clear variables;clc
eps = 1e-5;

%generation de la matrice A
n = 100; m = 10; %on veut m valeurs propres
A = 5*randn(n,n);

% Point de depart de l'algorithme (matrix V):
V = ones(n,m);
V = V/norm(V);

cv = false;
iv1 = 0;  % pour compter le nombre d'iterations effectuees
t_v1 =  cputime; % pour calculer le temps d execution de l'algo
err1 = 0; % residu de la norme du vecteur propre. On sort de la boucle 

beta = (V')*A*V;
while(~cv)
    y = A*V;
    V = y/norm(y);
    beta_old = beta;
    beta = V'*A*V;
    iv1 = iv1+1;
    err1 = norm(beta-beta_old)/norm(beta_old);
    cv = err1<eps;
end
t_v1 = cputime-t_v1;

%est ce que V converge vers les eignvectors :
[vl,ol] = eig(A);




