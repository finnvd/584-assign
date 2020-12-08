clc;
clearvars;
close all;

m=10;
A=randn(m);     %Create matrix

[V,D]=eigs(A);  %Find with MATLAB function

v=randn(m,1);   %Initial vector guess
iter=30;        %Max number of iterations

for i=1:iter
    Av=A*v;
    lam=v'*Av;
    v=Av/norm(Av);
end

v=Av/lam;