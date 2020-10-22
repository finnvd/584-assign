clc; clearvars; close all;

imds=imageDatastore('C:\Users\Finn\Documents\MATLAB\584\yalefaces','FileExtensions','.jpeg','IncludeSubfolders',1);

A=[];
imgcol=zeros(9600,1);
for i=1:100
    imgi=readimage(imds,i);
    img=imresize(imgi, [80 120]);
    for j=1:9600
        imgcol(j,1)=img(j);
    end
    A=[A imgcol];
end

[U,S,V]=svd(A);

figure(1);
sig=diag(S);
plot(sig,'ko','Linewidth',[1.5])

figure(2);
Ustore(:,:)=U(:,1:3);
eigface=reshape(Ustore(:,3),80,120);
imagesc(eigface);
% 
% B=readimage(imds,64);
% imshow(B);