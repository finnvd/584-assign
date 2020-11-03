clc;
clearvars;
close all;

dx=0.001;
X=1.92:dx:2.08;

pxa=zeros(size(X));
pxb=pxa;

for i=1:size(X,2)
    x=X(i);
    pxa(i)=x^9-18*x^8+144*x^7-672*x^6+2016*x^5-4032*x^4+5376*x^3-4608*x^2+2304*x-512;
    pxb(i)=(x-2)^9;
end

plot(X,pxa,X,pxb);
legend('Expanded','Unexpanded');