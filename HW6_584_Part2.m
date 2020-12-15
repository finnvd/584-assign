clc;
clearvars;
close all;

readDigits=500;
number=7;
trainDigits=40;
%Read MNIST label and image files
[imgs labels] = readMNIST("trainimages", "trainlabels", readDigits, 4);

%Vectorize MNIST images and create matrix of vectorized images
A=[];
imgcol=zeros(400,1);
B=zeros(10,readDigits);
for i=1:readDigits
    imgi=imgs(:,:,i);
    B(labels(i)+1,i)=1;
    for j=1:400
        imgcol(j,1)=imgi(j);
    end
    A=[A imgcol];
end

A2=[];
for i=1:readDigits
    if B(number+1,i) == 1
        A2=[A2 A(:,i)];
    else
    end
end

%Find x matrix using solvers
train=A2(:,1:trainDigits);
% test=A2(:,trainDigits+1:length(A2));
label=labels(1:trainDigits).';

B=lasso(train.',label.','Lambda',0.1).';

% test_labels=sign(B*test);

B2=reshape(B,20,20);
pcolor(B2);

function [imgs labels] = readMNIST(imgFile, labelFile, readDigits, offset)
    
    % Read digits
    fid = fopen(imgFile, 'r', 'b');
    header = fread(fid, 1, 'int32');
    if header ~= 2051
        error('Invalid image file header');
    end
    count = fread(fid, 1, 'int32');
    if count < readDigits+offset
        error('Trying to read too many digits');
    end
    
    h = fread(fid, 1, 'int32');
    w = fread(fid, 1, 'int32');
    
    if offset > 0
        fseek(fid, w*h*offset, 'cof');
    end
    
    imgs = zeros([h w readDigits]);
    
    for i=1:readDigits
        for y=1:h
            imgs(y,:,i) = fread(fid, w, 'uint8');
        end
    end
    
    fclose(fid);

    % Read digit labels
    fid = fopen(labelFile, 'r', 'b');
    header = fread(fid, 1, 'int32');
    if header ~= 2049
        error('Invalid label file header');
    end
    count = fread(fid, 1, 'int32');
    if count < readDigits+offset
        error('Trying to read too many digits');
    end
    
    if offset > 0
        fseek(fid, offset, 'cof');
    end
    
    labels = fread(fid, readDigits, 'uint8');
    fclose(fid);
    
    % Calc avg digit and count
    imgs = trimDigits(imgs, 4);
    imgs = normalizePixValue(imgs);
    %[avg num stddev] = getDigitStats(imgs, labels);
    
end

function digits = trimDigits(digitsIn, border)
    dSize = size(digitsIn);
    digits = zeros([dSize(1)-(border*2) dSize(2)-(border*2) dSize(3)]);
    for i=1:dSize(3)
        digits(:,:,i) = digitsIn(border+1:dSize(1)-border, border+1:dSize(2)-border, i);
    end
end

function digits = normalizePixValue(digits)
    digits = double(digits);
    for i=1:size(digits, 3)
        digits(:,:,i) = digits(:,:,i)./255.0;
    end
end