clc;
close all;
clearvars;

m=10;
A=randn(m);
A = A - tril(A,-1) + triu(A,1)';

[V,D]=eigs(A);  %Find with MATLAB function

v=(rand(m,1)+i*rand(m,1));   %Initial vector guess
iter=20;        %Max number of iterations

for i=0:iter
    sig=(v'*A*v)/(v'*v);
    vh=(A-sig*eye(m,m))\v;
    v=vh/max(vh);
end