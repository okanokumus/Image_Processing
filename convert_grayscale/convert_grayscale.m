
clc
clear all
close all
A = imread('lena256.png');
figure(1) 
imshow(A)
[m n k]=size(A);
% to crreate I matrix that has only zeros and the same size of A
I=zeros(m,n); 
% converting the data to double
A=double(A);
% intensity (Y) = 0.2989*red + 0.5870*green + 0.1140*blue
for i=1:m
    for j=1:n
        % average
        I(i,j)=(A(i,j,1)+ A(i,j,2) + A(i,j,3))/3;
        % weighted sum
        %I(i,j)=0.2989*A(i,j,1)+ 0.5870*A(i,j,2) + 0.1140*A(i,j,3);
    end
end
I=uint8(I);
figure(2)
subplot(1,2,1),imshow(I)
subplot(1,2,2),imhist(I)
pause
% 1B
% gamma

gamma = 2;
I=double(I);
I = I/max(I(:));
B = I.^gamma;
B = round(255*B);
B=uint8(B);
figure(4)
subplot(1,2,1),imshow(B)
subplot(1,2,2),imhist(B)
title('gamma=2')

gamma = 3;
I = I/max(I(:));
B = I.^gamma;
B = round(255*B);
B=uint8(B);
figure(5)
subplot(1,2,1),imshow(B)
subplot(1,2,2),imhist(B)
title('gamma=3')

gamma = 0.5;
I = I/max(I(:));
B = I.^gamma;
B = round(255*B);
B=uint8(B);
figure(6)
subplot(1,2,1),imshow(B)
subplot(1,2,2),imhist(B)
title('gamma=0.5')

gamma = .2;
I = I/max(I(:));
B = I.^gamma;
B = round(255*B);
B=uint8(B);
figure(7)
subplot(1,2,1),imshow(B)
subplot(1,2,2),imhist(B)
title('gamma=0.2')
pause
close all