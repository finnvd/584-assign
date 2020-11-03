clc;
close all;
clearvars;

m=6;
n=5;
e=0.001:0.001:0.1;
C=zeros(1,100);

for i=1:100
    A=randn(m,n);
    B=A(:,1);
    B=B+e(i)*rand(m,1);
    A=cat(2,A,B);
    C(i)=cond(A);
end
plot(e,C)