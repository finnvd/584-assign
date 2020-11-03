clc;
clearvars;
close all;

m=10;
n=5;
s=100;

C=zeros(1,s);
x=1:1:s;

for i=1:s
    A=randn(m,n);
    C(i)=cond(A);
    m=m+1;
    n=n+1;
end

plot(x,C);
