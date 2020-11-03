clc;
close all;
clearvars;

A=randn(30,15);
cond=cond(A);

[Q1,R1]=qr(A);

[m,n] = size(A);

Q2=eye(m);

for k = 1:n
    % Find the HH reflector
    z = A(k:m,k);
    v = [ -sign(z(1))*norm(z) - z(1); -z(2:end) ];
    v = v / sqrt(v'*v);   % remoce v'*v in den
    
    % Apply the HH reflection to each column of A and Q
    for j = 1:n
        A(k:m,j) = A(k:m,j) - v*( 2*(v'*A(k:m,j)) );
    end
    for j = 1:m
        Q2(k:m,j) = Q2(k:m,j) - v*( 2*(v'*Q2(k:m,j)) );
    end       
end

Q2 = Q2';
R2 = triu(A);  % exact triangularity
