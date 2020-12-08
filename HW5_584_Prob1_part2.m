clc;
close all;
clearvars;

m=10;
A=randn(m);

[V,D]=eigs(A);  %Find with MATLAB function

v=randn(m,1);   %Initial vector guess
iter=20;        %Max number of iterations

for i=0:iter
    sig=(v'*A*v)/(v'*v);
    vh=(A-sig*eye(m,m))\v;
    v=vh/max(vh);
end