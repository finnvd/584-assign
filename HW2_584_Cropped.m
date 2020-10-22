clc; clearvars; close all;

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

[U,S,V]=svd(A);

sig=diag(S);
plot(sig,'ko','Linewidth',[1.5])

Ustore(:,:)=U(:,1:3);
eigface=reshape(Ustore(:,1),192,168);
imagesc(eigface);
% 
% B=readimage(imds,64);
% imshow(B);
