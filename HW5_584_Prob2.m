clc;
close all;
clearvars;

imds=imageDatastore('C:\Users\Finn\Documents\MATLAB\584\CroppedYale','FileExtensions',{'.pgm'},'IncludeSubfolders',1);

A=[];
imgcol=zeros(32256,1);
for i=1:120
    img=readimage(imds,i);
    for j=1:32256
        imgcol(j,1)=img(j);
    end
    A=[A imgcol];
end

B=A.';
C=B*A;

v=randn(120,1);   %Initial vector guess
iter=20;        %Max number of iterations

for i=1:iter
    Cv=C*v;
    lam=v'*Cv;
    v=Cv/norm(Cv);
end

[U,S,V]=svd(C);
v=Cv/lam;